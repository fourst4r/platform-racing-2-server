package package_15
{
   import flash.events.Event;
   import flash.net.*;
   import package_4.UploadingPopup;
   
   public class DeletingLevelPopup extends UploadingPopup
   {
       
      
      public function DeletingLevelPopup(param1:String)
      {
         super();
         m.textBox.text = "Deleting level...";
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.level_id = param1;
         var _loc3_:URLRequest = new URLRequest(Main.baseURL + "/delete_level.php");
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         loader = new SuperLoader(true,"json");
         loader.addEventListener(SuperLoader.d,this.onComplete,false,0,true);
         loader.load(_loc3_);
      }
      
      override protected function onComplete(param1:Event) : *
      {
         new GetLevels();
         super.onComplete(param1);
         super.parsedDataHandler(param1);
      }
   }
}
