package package_4
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.net.*;
   
   public class LevelReportPopup extends Popup
   {
       
      
      private var levelId:int = 0;
      
      private var version:int = 0;
      
      private var m:LevelReportPopupGraphic;
      
      public function LevelReportPopup(param1:String, param2:int = 0)
      {
         this.m = new LevelReportPopupGraphic();
         super();
         this.levelId = param1;
         this.version = param2;
         this.m.report_bt.addEventListener(MouseEvent.CLICK,this.clickReport);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel);
         addChild(this.m);
      }
      
      private function clickReport(param1:MouseEvent) : *
      {
         if(this.m.reasonBox.text == null || Data.trimWhitespace(this.m.reasonBox.text) == "")
         {
            new MessagePopup("Error: Oops, you forgot to write the reason for your report!");
            return;
         }
         new ConfirmPopup(this.confirmReport,"Are you sure you want to report this level to the moderators? If it contains something inappropriate or mean, then please do report this level.");
      }
      
      private function confirmReport() : *
      {
         if(LevelInfoPopup.instance != null)
         {
            LevelInfoPopup.instance.startFadeOut();
         }
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.level_id = this.levelId;
         _loc1_.version = this.version;
         _loc1_.reason = this.m.reasonBox.text;
         var _loc2_:URLRequest = new URLRequest(Main.baseURL + "/level_report.php");
         _loc2_.method = URLRequestMethod.POST;
         _loc2_.data = _loc1_;
         new UploadingPopup(_loc2_,"json","Reporting level...");
         startFadeOut();
      }
      
      private function clickCancel(param1:*) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.m.report_bt.removeEventListener(MouseEvent.CLICK,this.clickReport);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         super.remove();
      }
   }
}
