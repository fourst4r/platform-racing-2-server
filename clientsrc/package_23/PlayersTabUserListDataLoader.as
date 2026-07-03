package package_23
{
   import flash.events.*;
   import flash.net.*;
   
   public class PlayersTabUserListDataLoader extends PlayersTabList
   {
       
      
      private var superLoader:SuperLoader;
      
      public function PlayersTabUserListDataLoader(param1:String)
      {
         this.superLoader = new SuperLoader(true,SuperLoader.j);
         super();
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.mode = param1;
         var _loc3_:URLRequest = new URLRequest(Main.baseURL + "/user_list_get.php");
         _loc3_.data = _loc2_;
         this.superLoader.load(_loc3_);
         this.superLoader.addEventListener(Event.COMPLETE,this.populateList);
      }
      
      private function populateList(param1:Event) : *
      {
         var _loc3_:Object = null;
         var _loc2_:Array = this.superLoader.parsedData.users;
         for each(_loc3_ in _loc2_)
         {
            method_138(_loc3_.name,_loc3_.group,_loc3_.rank,_loc3_.hats,_loc3_.status);
         }
         hideLoadingGraphic();
      }
      
      override public function remove() : *
      {
         this.superLoader.removeEventListener(Event.COMPLETE,this.populateList);
         super.remove();
      }
   }
}
