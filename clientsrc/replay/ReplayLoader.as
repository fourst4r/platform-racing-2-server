package replay
{
   import com.hurlant.util.Base64;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import flash.utils.getTimer;
   import Main;

   public class ReplayLoader
   {
      private var onComplete:Function;
      private var onError:Function;
      private var loader:URLLoader;

      public function ReplayLoader()
      {
      }

      public function loadById(param1:String, param2:Function, param3:Function) : void
      {
         this.disposeLoader();
         this.onComplete = param2;
         this.onError = param3;
         this.loader = new URLLoader();
         this.loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.loader.addEventListener(Event.COMPLETE,this.handleComplete,false,0,true);
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.handleError,false,0,true);
         var vars:URLVariables = new URLVariables();
         vars.id = param1;
         if(Main.token != null && Main.token.length > 0)
         {
            vars.token = Main.token;
         }
         var request:URLRequest = new URLRequest(Main.baseURL + "/replays_get.php");
         request.method = URLRequestMethod.GET;
         request.data = vars;
         this.loader.load(request);
      }

      public static function parseBytes(raw:*) : ReplayData
      {
         var loader:ReplayLoader = new ReplayLoader();
         var bytes:ByteArray = loader.normalizeBytes(raw);
         return loader.parseReplay(bytes);
      }

      private function handleComplete(param1:Event) : void
      {
         var data:ReplayData = null;
         try
         {
            var raw:* = this.loader.data;
            var bytes:ByteArray = this.normalizeBytes(raw);
            data = this.parseReplay(bytes);
         }
         catch(error:Error)
         {
            handleError(new IOErrorEvent(IOErrorEvent.IO_ERROR,false,false,error.message));
            return;
         }
         this.dispatchSuccess(data);
      }

      private function handleError(param1:IOErrorEvent) : void
      {
         if(this.onError != null)
         {
            this.onError(param1);
         }
         this.disposeLoader();
      }

      private function dispatchSuccess(param1:ReplayData) : void
      {
         if(this.onComplete != null)
         {
            this.onComplete(param1);
         }
         this.disposeLoader();
      }

      private function disposeLoader() : void
      {
         if(this.loader != null)
         {
            this.loader.removeEventListener(Event.COMPLETE,this.handleComplete);
            this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.handleError);
            this.loader = null;
         }
      }

      private function normalizeBytes(raw:*):ByteArray
      {
         var bytes:ByteArray = new ByteArray();
         if(raw is ByteArray)
         {
            var src:ByteArray = raw as ByteArray;
            src.position = 0;
            bytes.writeBytes(src);
            bytes.position = 0;
         }
         else if(raw is String)
         {
            bytes.writeMultiByte(String(raw),"iso-8859-1");
            bytes.position = 0;
         }
         else
         {
            throw new Error("Unsupported replay payload type: " + typeof raw);
         }
         if(bytes.bytesAvailable >= 4)
         {
            var magic:String = bytes.readUTFBytes(4);
            bytes.position = 0;
            if(magic != "PR2R")
            {
               try
               {
                  bytes.uncompress();
                  bytes.position = 0;
                  if(bytes.bytesAvailable < 4 || bytes.readUTFBytes(4) != "PR2R")
                  {
                     throw new Error("Invalid replay magic after decompress.");
                  }
                  bytes.position = 0;
               }
               catch(decompError:Error)
               {
                  throw new Error("Replay stream not recognized (" + decompError.message + ")");
               }
            }
         }
         return bytes;
      }

      private function parseReplay(param1:ByteArray) : ReplayData
      {
         if(param1 == null)
         {
            throw new Error("Empty replay data.");
         }
         param1.position = 0;
         param1.endian = Endian.BIG_ENDIAN;
         if(param1.bytesAvailable < 6)
         {
            throw new Error("Invalid replay header.");
         }
         var magic:String = param1.readUTFBytes(4);
         if(magic != "PR2R")
         {
            throw new Error("Invalid replay magic.");
         }
         var version:int = param1.readUnsignedByte();
         var flags:int = param1.readUnsignedByte(); // reserved
         var headerLength:uint = param1.readUnsignedInt();
         if(param1.bytesAvailable < headerLength)
         {
            throw new Error("Replay header truncated.");
         }
         var headerBytes:ByteArray = new ByteArray();
         param1.readBytes(headerBytes,0,headerLength);
         headerBytes.position = 0;
         var headerJSON:String = headerBytes.readUTFBytes(headerBytes.length);
         var meta:Object = JSON.parse(headerJSON);
         var replayData:ReplayData = new ReplayData();
         replayData.meta = meta;
         // Remaining bytes contain the packet stream, compressed with zlib.
         var body:ByteArray = new ByteArray();
         if(param1.bytesAvailable > 0)
         {
            param1.readBytes(body,0,param1.bytesAvailable);
         }
         body.position = 0;
         // Packet stream is compressed via PHP 'zlib.deflate' (raw DEFLATE).
         // Use explicit 'deflate' algorithm; fall back to 'zlib' if needed.
         var rawCopy:ByteArray = new ByteArray();
         rawCopy.writeBytes(body,0,body.length);
         rawCopy.position = 0;
         try
         {
            body.uncompress("deflate");
         }
         catch(decompError:Error)
         {
            // Try zlib header variant as a fallback
            body = rawCopy;
            body.position = 0;
            body.uncompress();
         }
         body.position = 0;
         var absoluteTime:int = 0;
         while(body.bytesAvailable > 0)
         {
            var delta:int = this.readUVarint(body);
            var payloadLen:int = this.readUVarint(body);
            if(payloadLen > body.bytesAvailable)
            {
               throw new Error("Replay payload truncated.");
            }
            var payload:String = body.readUTFBytes(payloadLen);
            absoluteTime += delta;
            replayData.events.push(new ReplayEvent(delta,absoluteTime,payload));
         }
         replayData.totalDuration = absoluteTime;
         replayData.levelText = this.decodeLevel(meta);
         return replayData;
      }

      private function decodeLevel(param1:Object) : String
      {
         if(param1 == null || param1.level == null)
         {
            return "";
         }
         var level:Object = param1.level;
         if(level.data_b64 == null)
         {
            return "";
         }
         var dataBytes:ByteArray = Base64.decodeToByteArray(level.data_b64);
         dataBytes.position = 0;
         if(level.compression == "zlib")
         {
            dataBytes.uncompress();
         }
         dataBytes.position = 0;
         return dataBytes.readUTFBytes(dataBytes.length);
      }

      private function readUVarint(param1:ByteArray) : int
      {
         var value:int = 0;
         var shift:int = 0;
         while(true)
         {
            if(param1.bytesAvailable <= 0)
            {
               throw new Error("Unexpected end of stream.");
            }
            var b:int = param1.readUnsignedByte();
            value |= (b & 127) << shift;
            if((b & 128) == 0)
            {
               break;
            }
            shift += 7;
         }
         return value;
      }
   }
}

