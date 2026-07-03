package ui
{
   import com.jcward.workers.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class EmblemLoader extends Sprite
   {
      
      public static const BEGIN_LOADING:String = "BEGIN_LOADING";
      
      public static const FINISH_LOADING:String = "FINISH_LOADING";
       
      
      private var eWidth:int;
      
      private var eHeight:int;
      
      private var file:FileReference;
      
      private var loader:Loader;
      
      private var superLoader:SuperLoader;
      
      private var bitmap:Bitmap;
      
      private var bitmapData:BitmapData;
      
      private var defaultColor:int = 16777215;
      
      private var encoder:JPEGEncoder;
      
      private var uploadURL:String;
      
      private var imgDirURL:String;
      
      private var fileName:String;
      
      private var loading:Boolean = false;
      
      public function EmblemLoader(param1:int, param2:int, param3:String, param4:String)
      {
         super();
         this.eWidth = param1;
         this.eHeight = param2;
         this.uploadURL = param3;
         this.imgDirURL = param4;
         this.file = new FileReference();
         this.file.addEventListener(Event.SELECT,this.fileSelected,false,0,true);
         this.file.addEventListener(Event.COMPLETE,this.fileComplete,false,0,true);
         this.loader = new Loader();
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.drawAndUpload,false,0,true);
         this.superLoader = new SuperLoader(true,SuperLoader.j);
         this.superLoader.addEventListener(SuperLoader.d,this.gotFileName,false,0,true);
         this.superLoader.addEventListener(SuperLoader.e,this.fileNameError,false,0,true);
         this.bitmapData = new BitmapData(this.eWidth,this.eHeight,false);
         this.makeDefault();
         this.bitmap = new Bitmap(this.bitmapData);
         this.bitmap.smoothing = true;
         addChild(this.bitmap);
         this.encoder = new JPEGEncoder(90);
      }
      
      public function openBrowse() : *
      {
         this.file.browse([new FileFilter("Images","*.jpg;*.jpeg;*.gif;*.png;*.JPG;*.JPEG;*.GIF;*.PNG")]);
      }
      
      public function getImage(param1:String) : *
      {
         this.fileName = param1;
         this.loader.load(new URLRequest(this.imgDirURL + this.fileName));
      }
      
      public function getFileName() : String
      {
         return this.fileName;
      }
      
      public function isLoading() : Boolean
      {
         return this.loading;
      }
      
      private function fileSelected(param1:Event) : *
      {
         this.file.load();
      }
      
      private function fileComplete(param1:Event) : *
      {
         this.loader.loadBytes(this.file.data);
      }
      
      private function drawAndUpload(param1:Event) : *
      {
         this.drawImage();
         if(this.fileName != null && this.fileName != "" && this.loader.contentLoaderInfo.url.indexOf(this.fileName) == -1)
         {
            this.uploadImage();
         }
      }
      
      private function uploadImage() : *
      {
         var _loc1_:URLRequest = null;
         if(!this.loading)
         {
            dispatchEvent(new Event(EmblemLoader.BEGIN_LOADING));
            this.loading = true;
            _loc1_ = new URLRequest(this.uploadURL);
            _loc1_.requestHeaders.push(new URLRequestHeader("Content-type","application/octet-stream"));
            _loc1_.method = URLRequestMethod.POST;
            _loc1_.data = this.encoder.encode(this.bitmapData);
            this.superLoader.load(_loc1_);
         }
      }
      
      private function gotFileName(param1:Event) : *
      {
         this.loading = false;
         this.fileName = this.superLoader.parsedData.filename;
         dispatchEvent(new Event(EmblemLoader.FINISH_LOADING));
      }
      
      private function fileNameError(param1:Event) : *
      {
         this.loading = false;
         dispatchEvent(new Event(EmblemLoader.FINISH_LOADING));
      }
      
      private function drawImage() : *
      {
         var _loc1_:Number = 1;
         var _loc2_:Number = 1;
         var _loc3_:Number = 1;
         if(this.loader.width > this.eWidth)
         {
            _loc1_ = this.eWidth / this.loader.width;
         }
         if(this.loader.height > this.eHeight)
         {
            _loc2_ = this.eHeight / this.loader.height;
         }
         if(_loc1_ < _loc2_)
         {
            _loc3_ = _loc1_;
         }
         else
         {
            _loc3_ = _loc2_;
         }
         var _loc4_:int = int(Math.round((this.eWidth - this.loader.width * _loc3_) / 2));
         var _loc5_:int = int(Math.round((this.eHeight - this.loader.height * _loc3_) / 2));
         var _loc6_:Matrix;
         (_loc6_ = new Matrix()).createBox(_loc3_,_loc3_,0,_loc4_,_loc5_);
         this.makeDefault();
         this.bitmapData.draw(this.loader,_loc6_,null,null,null,true);
      }
      
      private function makeDefault() : *
      {
         this.bitmapData.fillRect(new Rectangle(0,0,this.bitmapData.width,this.bitmapData.height),this.defaultColor);
      }
      
      public function remove() : *
      {
         this.file.removeEventListener(Event.SELECT,this.fileSelected);
         this.file.removeEventListener(Event.COMPLETE,this.fileComplete);
         this.file = null;
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.drawAndUpload);
         this.loader = null;
         this.bitmapData.dispose();
         this.bitmapData = null;
         removeChild(this.bitmap);
         this.bitmap = null;
         this.superLoader.remove();
         this.superLoader.removeEventListener(SuperLoader.d,this.gotFileName);
         this.superLoader.removeEventListener(SuperLoader.e,this.fileNameError);
         this.superLoader = null;
         this.encoder = null;
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}
