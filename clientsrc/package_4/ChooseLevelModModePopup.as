package package_4
{
   import flash.events.*;
   import flash.net.*;
   
   public class ChooseLevelModModePopup extends Popup
   {
       
      
      private var levelId:String;
      
      private var uploading:UploadingPopup;
      
      private var m:ChooseLevelModModePopupGraphic;
      
      public function ChooseLevelModModePopup(param1:String)
      {
         this.m = new ChooseLevelModModePopupGraphic();
         super();
         this.levelId = param1;
         this.m.unpublish_bt.addEventListener(MouseEvent.CLICK,this.clickUnpublish,false,0,true);
         this.m.restrict_bt.addEventListener(MouseEvent.CLICK,this.clickRestrict,false,0,true);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel,false,0,true);
         addChild(this.m);
      }
      
      private function clickUnpublish(param1:MouseEvent) : *
      {
         var e:MouseEvent = param1;
         new ConfirmPopup(function():*
         {
            confirmAction("unpublish");
         },"Are you sure you want to unpublish this level? The author will need to re-publish it from their account.");
      }
      
      private function clickRestrict(param1:MouseEvent) : *
      {
         var e:MouseEvent = param1;
         new ConfirmPopup(function():*
         {
            confirmAction("restrict");
         },"Are you sure you want to restrict this level? The level will remain playable but will not appear in any level lists except Search and Favorites.");
      }
      
      private function confirmAction(param1:String = "unpublish") : *
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.level_id = this.levelId;
         _loc2_.action = param1;
         var _loc3_:URLRequest = new URLRequest(Main.baseURL + "/level_moderate.php");
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         this.uploading = new UploadingPopup(_loc3_,"json",param1 == "restrict" ? "Restricting level..." : "Unpublishing level...");
         this.uploading.addEventListener(SuperLoader.d,this.returnAction,false,0,true);
      }
      
      private function returnAction(param1:*) : *
      {
         if(this.uploading.parsedData.success === true)
         {
            if(LevelInfoPopup.instance != null)
            {
               LevelInfoPopup.instance.startFadeOut();
            }
            startFadeOut();
         }
      }
      
      private function clickCancel(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         if(this.uploading != null)
         {
            this.uploading.removeEventListener(SuperLoader.d,this.returnAction);
            this.uploading.startFadeOut();
            this.uploading = null;
         }
         this.m.unpublish_bt.removeEventListener(MouseEvent.CLICK,this.clickUnpublish);
         this.m.restrict_bt.removeEventListener(MouseEvent.CLICK,this.clickRestrict);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         super.remove();
      }
   }
}
