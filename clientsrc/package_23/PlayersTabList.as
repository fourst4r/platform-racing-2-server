package package_23
{
   import flash.events.*;
   import flash.utils.*;
   
   public class PlayersTabList extends PlayersTabListHolder
   {
       
      
      private var m:PlayersTabListGraphic;
      
      private var names:Array;
      
      private var sortInterval:uint;
      
      private var sortMode:String = "rank";
      
      private var sortOrder:String = "desc";
      
      private var updateSort:Boolean = false;
      
      public function PlayersTabList()
      {
         this.m = new PlayersTabListGraphic();
         this.names = new Array();
         addChild(this.m);
         super(this.m.listHolder);
         this.m.name_bt.addEventListener(MouseEvent.CLICK,this.clickName,false,0,true);
         this.m.rank_bt.addEventListener(MouseEvent.CLICK,this.clickRank,false,0,true);
         this.m.hats_bt.addEventListener(MouseEvent.CLICK,this.clickHats,false,0,true);
         this.sortInterval = setInterval(this.sortListener,500);
      }
      
      private function clickName(param1:MouseEvent) : *
      {
         this.sortPlayersBy("userName");
      }
      
      private function clickRank(param1:MouseEvent) : *
      {
         this.sortPlayersBy("rank");
      }
      
      private function clickHats(param1:MouseEvent) : *
      {
         this.sortPlayersBy("hats");
      }
      
      protected function method_138(param1:String, param2:String, param3:Number, param4:int, param5:String = "") : *
      {
         if(this.names.indexOf(param1) > -1)
         {
            return;
         }
         this.names.push(param1);
         var _loc6_:PlayersTabListItemInfo = new PlayersTabListItemInfo(param1,param2,param3,param4,param5);
         super.method_179(_loc6_);
         this.updateSort = true;
      }
      
      private function sortListener() : *
      {
         if(this.updateSort)
         {
            this.updateSort = false;
            this.sortPlayersBy();
         }
      }
      
      private function sortPlayersBy(param1:String = null) : *
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         if(param1 != this.sortMode || param1 == null)
         {
            this.sortMode = param1 != null ? param1 : String(this.sortMode);
            if(this.sortMode == "userName")
            {
               this.sortOrder = "asc";
               super.sortOn(this.sortMode,Array.CASEINSENSITIVE);
            }
            else
            {
               this.sortOrder = "desc";
               _loc2_ = String(this.sortMode);
               _loc3_ = this.sortMode == "rank" ? "hats" : "rank";
               super.numSort([_loc2_,_loc3_],this.sortOrder);
            }
         }
         else if(param1 == this.sortMode)
         {
            this.sortOrder = this.sortOrder == "desc" ? "asc" : "desc";
            if(this.sortMode == "userName")
            {
               _loc4_ = this.sortOrder == "desc" ? 3 : 1;
               super.sortOn(this.sortMode,_loc4_);
            }
            else
            {
               _loc2_ = String(this.sortMode);
               _loc3_ = this.sortMode == "rank" ? "hats" : "rank";
               super.numSort([_loc2_,_loc3_],this.sortOrder);
            }
         }
      }
      
      override public function remove() : *
      {
         clearInterval(this.sortInterval);
         this.m.name_bt.removeEventListener(MouseEvent.CLICK,this.clickName);
         this.m.rank_bt.removeEventListener(MouseEvent.CLICK,this.clickRank);
         this.m.hats_bt.removeEventListener(MouseEvent.CLICK,this.clickHats);
         super.remove();
      }
   }
}
