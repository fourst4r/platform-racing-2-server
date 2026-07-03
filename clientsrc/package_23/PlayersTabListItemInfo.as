package package_23
{
   public class PlayersTabListItemInfo extends PlayersTabListItem
   {
       
      
      public var userName:String;
      
      public var rank:int;
      
      public var hats:int;
      
      public function PlayersTabListItemInfo(param1:String, param2:String, param3:int, param4:int, param5:String)
      {
         var _loc6_:String = null;
         super();
         if(param5 != "")
         {
            _loc6_ = htmlNameMaker.makeName(param1,param2,param1 + " (" + param5 + ")",true);
         }
         else
         {
            _loc6_ = htmlNameMaker.makeName(param1,param2,"",true);
         }
         m.nameBox.htmlText = _loc6_;
         m.rankBox.text = param3.toString();
         m.hatBox.text = param4.toString();
         this.userName = param1;
         this.rank = param3;
         this.hats = param4;
      }
   }
}
