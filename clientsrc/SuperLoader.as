package
{
   import com.adobe.crypto.*;
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import package_4.*;
   
   public class SuperLoader extends URLLoader
   {
      
      public static const j:String = "json";
      
      public static const u:String = "url";
      
      public static const d:String = "parsedData";
      
      public static const e:String = "anyError";
       
      
      public var useRandomNum:Boolean;
      
      public var parsedData:Object;
      
      private var readMode:String;
      
      private var toURL:String;
      
      private var autoEchoMessage:Boolean = true;
      
      public function SuperLoader(param1:Boolean = true, param2:String = "url", param3:Boolean = true)
      {
         super();
         this.useRandomNum = param1;
         this.readMode = param2;
         this.autoEchoMessage = param3;
         addEventListener(IOErrorEvent.IO_ERROR,this.IOErrorHandler);
         addEventListener(Event.COMPLETE,this.onComplete);
         addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
      }
      
      override public function load(param1:URLRequest) : void
      {
         var rand:int = 0;
         var timestamp:int = 0;
         var encryptor:Encryptor = null;
         var request:URLRequest = param1;
         this.toURL = request.url;
         if(this.useRandomNum)
         {
            rand = int(Math.random() * 10000000);
            if(request.data is URLVariables)
            {
               if(Main.beta)
               {
                  request.data.beta = 1;
               }
               request.data.rand = rand;
               request.data.token = Main.token;
            }
            else
            {
               request.url += request.url.indexOf("?") != -1 ? "&" : "?";
               request.url = request.url + (Main.beta ? "beta=1&" : "") + "rand=" + rand + "&token=" + Main.token;
            }
            if(Capabilities.playerType == "StandAlone" && Security.sandboxType === Security.LOCAL_TRUSTED)
            {
               timestamp = int(Data.getTimestamp());
               encryptor = new Encryptor();
               encryptor.setKey(Env.URL_PASS_KEY);
               encryptor.setIV(Env.URL_PASS_IV);
               request.requestHeaders.push(new URLRequestHeader("Request-Destination",encryptor.encrypt("remote_" + timestamp + "_" + MD5.hash(timestamp + "_" + Env.URL_PASS_SALT + "_" + Main.build + "_" + Capabilities.version.split(" ")[1]))));
            }
         }
         try
         {
            super.load(request);
         }
         catch(error:SecurityErrorEvent)
         {
            new MessagePopup("SuperLoader::load - A SecurityError has occurred.");
            dispatchEvent(new Event(e));
         }
      }
      
      private function onComplete(param1:Event) : *
      {
         var event:Event = param1;
         if(data != "")
         {
            if(Main.testing == true)
            {
               trace("HTTP Response: " + data);
            }
            try
            {
               if(this.readMode == u)
               {
                  this.parsedData = new URLVariables(data);
               }
               if(this.readMode == j)
               {
                  this.parsedData = JSON.parse(data);
               }
               if(this.parsedData.message != null && Boolean(this.autoEchoMessage))
               {
                  new MessagePopup(this.parsedData.message);
               }
               if(!this.parsedData.hasOwnProperty("error") && (this.parsedData.hasOwnProperty("success") ? this.parsedData.success : true))
               {
                  dispatchEvent(new Event(d));
               }
               else
               {
                  new MessagePopup("Error: " + (this.parsedData.hasOwnProperty("error") ? this.parsedData.error : (Main.testing || Main.beta ? "An error occurred with no error message.\n\ndata: " + data : "An unknown error occurred. I suspect evil aliens.")));
                  dispatchEvent(new Event(e));
               }
            }
            catch(error:Error)
            {
               new MessagePopup("Error: The loaded data was not in the expected format. \n\nlocation: SuperLoader::onComplete \nreadMode: " + readMode + "\ndata: " + data + (Main.testing || Main.beta ? "\n\n-- DEBUG MODE (Flash Stack) --\n\n" + error.getStackTrace() : ""));
               dispatchEvent(new Event(e));
            }
         }
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : *
      {
         new MessagePopup("Error: A security error occurred. :(");
         dispatchEvent(new Event(param1));
      }
      
      private function IOErrorHandler(param1:ErrorEvent) : *
      {
         var _loc2_:String = null;
         if(param1.text.indexOf("Error #") == 0)
         {
            _loc2_ = param1.text.substring(0,param1.text.indexOf(":"));
            param1.text = param1.text.substring(param1.text.indexOf(":"));
         }
         else
         {
            _loc2_ = "Error: ";
         }
         if(this.toURL.indexOf("server_status_2.txt") == -1)
         {
            new MessagePopup(_loc2_ + param1.text);
         }
         dispatchEvent(new Event(e));
      }
      
      public function remove() : *
      {
         removeEventListener(IOErrorEvent.IO_ERROR,this.IOErrorHandler);
         removeEventListener(Event.COMPLETE,this.onComplete);
         removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
      }
   }
}
