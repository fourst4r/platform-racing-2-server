package package_15
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.net.*;
   import levelEditor.*;
   import package_4.*;
   import ui.class_229;
   
   public class GetLevels extends GetLevelsPopup
   {
       
      
      protected var dataURL:String = "/levels_get.php";
      
      protected var loader:SuperLoader;
      
      public function GetLevels(param1:String = null)
      {
         this.loader = new SuperLoader(true,SuperLoader.j);
         super();
         m.titleBox.text = "-- My Levels --";
         this.dataURL = param1 != null ? param1 : String(this.dataURL);
         this.var_454 = 18;
         var _loc2_:URLRequest = new URLRequest(Main.baseURL + this.dataURL);
         _loc2_.data = new URLVariables();
         _loc2_.method = URLRequestMethod.POST;
         this.loader.addEventListener(Event.COMPLETE,this.onComplete,false,0,true);
         this.loader.load(_loc2_);
      }
      
      protected function onComplete(param1:Event) : *
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:GetLevelsPopupItem = null;
         if(param1.target.data != "")
         {
            _loc2_ = this.loader.parsedData.levels;
            for each(_loc3_ in _loc2_)
            {
               _loc4_ = new GetLevelsPopupItem(_loc3_);
               this.method_455(_loc4_);
            }
         }
         this.hideLoadingGraphic();
      }
      
      override protected function loadListing(param1:class_229) : *
      {
         var _loc2_:GetLevelsPopupItem = GetLevelsPopupItem(param1);
         new LoadingLevelPopup(_loc2_.level.level_id,_loc2_.level.version);
         startFadeOut();
      }
      
      override protected function deleteListing(param1:class_229) : *
      {
         var _loc2_:GetLevelsPopupItem = GetLevelsPopupItem(param1);
         new ConfirmPopup(this.confirmDelete,"Are you sure you want to delete \"" + Data.escapeString(_loc2_.level.title) + "\"?");
      }
      
      public function confirmDelete() : *
      {
         var _loc1_:GetLevelsPopupItem = GetLevelsPopupItem(this.getSelected());
         new DeletingLevelPopup(_loc1_.level.level_id);
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.loader.removeEventListener(Event.COMPLETE,this.onComplete);
         this.loader.remove();
         super.remove();
      }
   }
}
