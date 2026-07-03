package package_4
{
   import flash.events.*;
   import flash.net.URLRequest;
   import ui.*;
   
   public class UploadingPopup extends Popup
   {
       
      
      protected var loader:SuperLoader;
      
      private var progressBar:ProgressBar;
      
      protected var m:UploadingPopupGraphic;
      
      public var data:String;
      
      public var parsedData:Object;
      
      public function UploadingPopup(param1:URLRequest = null, param2:String = "url", param3:String = "Uploading...", param4:Boolean = true)
      {
         this.progressBar = new ProgressBar();
         this.m = new UploadingPopupGraphic();
         super();
         this.loader = new SuperLoader(true,param2,param4);
         this.m.textBox.text = param3;
         addChild(this.m);
         addChild(this.progressBar);
         this.progressBar.x = -100;
         this.progressBar.y = -5;
         this.loader.addEventListener(ProgressEvent.PROGRESS,this.onProgress,false,0,true);
         this.loader.addEventListener(Event.COMPLETE,this.onComplete,false,0,true);
         this.loader.addEventListener(SuperLoader.d,this.parsedDataHandler,false,0,true);
         this.loader.addEventListener(SuperLoader.e,this.errorHandler,false,0,true);
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler,false,0,true);
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose,false,0,true);
         if(param1 != null)
         {
            this.loader.load(param1);
         }
      }
      
      protected function onComplete(param1:Event) : *
      {
         this.progressBar.incProgress(1);
         this.data = param1.target.data;
         dispatchEvent(param1);
      }
      
      protected function parsedDataHandler(param1:Event) : *
      {
         this.parsedData = this.loader.parsedData;
         dispatchEvent(param1);
         startFadeOut();
      }
      
      protected function errorHandler(param1:Event) : *
      {
         dispatchEvent(param1);
         startFadeOut();
      }
      
      protected function onProgress(param1:ProgressEvent) : *
      {
         this.progressBar.incProgress(param1.bytesLoaded / param1.bytesTotal);
      }
      
      private function clickClose(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         if(this.loader != null)
         {
            this.loader.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
            this.loader.removeEventListener(Event.COMPLETE,this.onComplete);
            this.loader.removeEventListener(SuperLoader.d,this.parsedDataHandler);
            this.loader.removeEventListener(SuperLoader.e,this.clickClose);
            this.loader.remove();
            this.loader = null;
         }
         this.m.close_bt.removeEventListener(MouseEvent.CLICK,this.clickClose);
         this.progressBar.remove();
         super.remove();
      }
   }
}
