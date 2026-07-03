package package_15
{
   import flash.events.*;
   import levelEditor.*;
   import ui.class_229;
   
   public class GetLevelReports extends GetLevels
   {
       
      
      public function GetLevelReports()
      {
         super("/levels_get_reported.php");
         m.titleBox.text = "-- Reported Levels --";
         m.delete_bt.label = "Handle";
      }
      
      override protected function onComplete(param1:Event) : *
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:GetReportedLevelsPopupItem = null;
         if(param1.target.data != "")
         {
            _loc2_ = this.loader.parsedData.levels;
            for each(_loc3_ in _loc2_)
            {
               _loc4_ = new GetReportedLevelsPopupItem(_loc3_);
               this.method_455(_loc4_);
            }
         }
         this.hideLoadingGraphic();
      }
      
      override protected function loadListing(param1:class_229) : *
      {
         var _loc2_:GetReportedLevelsPopupItem = GetReportedLevelsPopupItem(param1);
         new LoadingLevelPopup(_loc2_.level.level_id,_loc2_.level.version,true);
         startFadeOut();
      }
      
      override protected function deleteListing(param1:class_229) : *
      {
         new HandleLevelReportPopup(this,param1.level);
      }
      
      override public function remove() : *
      {
         this.loader.removeEventListener(Event.COMPLETE,this.onComplete);
         this.loader.remove();
         super.remove();
      }
   }
}
