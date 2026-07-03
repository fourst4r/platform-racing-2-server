package package_22
{
   import com.jiggmin.data.*;
   import flash.utils.*;
   import ui.*;
   
   public class Campaign extends LevelListing
   {
      
      public static var campaignPage:int;
       
      
      public function Campaign()
      {
         super();
         mode = "campaign";
         setDataSourcesUsed(false, true);
         var _loc1_:int = int(Main.server.server_id);
         var _loc2_:int = Main.lastAuthTime.getDay();
         Campaign.campaignPage = this.pageNum = (_loc1_ + _loc2_) % 6 + 1;
         var _loc3_:Array = Memory.memory["campaignInfo" + Campaign.campaignPage];
         if(_loc3_ != null)
         {
            clearTimeout(var_280);
            var_280 = setTimeout(this.showCourses,250,_loc3_);
         }
         else
         {
            requestCourses();
         }
         removeChild(pageNavigation);
         pageNavigation = new PageNavigation(this,"vertical",Campaign.campaignPage,6,283);
         pageNavigation.x = 328;
         pageNavigation.y = 26;
         addChild(pageNavigation);
      }
      
      override protected function showCourses(param1:Array) : *
      {
         Memory.memory["campaignInfo" + Campaign.campaignPage] = param1;
         super.showCourses(param1);
      }
   }
}
