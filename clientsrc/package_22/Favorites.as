package package_22
{
   import flash.net.*;
   
   public class Favorites extends LevelListing
   {
       
      
      public function Favorites()
      {
         super();
         mode = "favorites";
         setDataSourcesUsed(true, false);
         this.requestCourses();
      }
      
      override protected function requestCourses() : *
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.user_id = Main.userId;
         _loc1_.page = pageNum;
         var _loc2_:URLRequest = new URLRequest(Main.levelsURL.substr(0,-7) + "/favorite_levels_get.php");
         _loc2_.method = URLRequestMethod.POST;
         _loc2_.data = _loc1_;
         superLoader.load(_loc2_);
         loadingGraphic.visible = true;
      }
   }
}
