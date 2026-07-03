package package_23
{
   import flash.events.*;
   import flash.net.*;
   
   public class Guilds extends PlayersTabListHolder
   {
       
      
      private var m:PlayersTabListGraphic;
      
      private var superLoader:SuperLoader;
      
      private var sortMode:String = "gpToday";
      
      private var sortOrder:String = "desc";
      
      public function Guilds()
      {
         this.m = new PlayersTabListGraphic();
         this.superLoader = new SuperLoader(true,SuperLoader.j);
         super(this.m.listHolder);
         this.m.gotoAndStop("guilds");
         addChild(this.m);
         this.m.name_bt.addEventListener(MouseEvent.CLICK,this.clickNameButton,false,0,true);
         this.m.active_bt.addEventListener(MouseEvent.CLICK,this.clickActiveButton,false,0,true);
         this.m.gp_bt.addEventListener(MouseEvent.CLICK,this.clickGPButton,false,0,true);
         this.load();
      }
      
      private function clickNameButton(param1:MouseEvent) : *
      {
         this.sortGuildsBy("guildName");
      }
      
      private function clickActiveButton(param1:MouseEvent) : *
      {
         this.sortGuildsBy("activeMembers");
      }
      
      private function clickGPButton(param1:MouseEvent) : *
      {
         this.sortGuildsBy("gpToday");
      }
      
      private function sortGuildsBy(param1:String = null) : *
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         if(param1 != this.sortMode || param1 == null)
         {
            this.sortMode = param1 != null ? param1 : String(this.sortMode);
            if(this.sortMode == "guildName")
            {
               this.sortOrder = "asc";
               super.sortOn(this.sortMode,Array.CASEINSENSITIVE);
            }
            else
            {
               this.sortOrder = "desc";
               _loc2_ = String(this.sortMode);
               _loc3_ = this.sortMode == "gpToday" ? "activeMembers" : "gpToday";
               super.numSort([_loc2_,_loc3_],this.sortOrder);
            }
         }
         else if(param1 == this.sortMode)
         {
            this.sortOrder = this.sortOrder == "desc" ? "asc" : "desc";
            if(this.sortMode == "guildName")
            {
               _loc4_ = this.sortOrder == "desc" ? 3 : 1;
               super.sortOn(this.sortMode,_loc4_);
            }
            else
            {
               _loc2_ = String(this.sortMode);
               _loc3_ = this.sortMode == "gpToday" ? "activeMembers" : "gpToday";
               super.numSort([_loc2_,_loc3_],this.sortOrder);
            }
         }
      }
      
      private function load() : *
      {
         var _loc1_:URLRequest = new URLRequest(Main.baseURL + "/guilds_top.php");
         this.superLoader.addEventListener(SuperLoader.d,this.populateList,false,0,true);
         this.superLoader.addEventListener(SuperLoader.e,hideLoadingGraphic,false,0,true);
         this.superLoader.load(_loc1_);
         this.sortGuildsBy();
      }
      
      private function populateList(param1:Event) : *
      {
         var _loc2_:Object = null;
         var _loc3_:PlayersTabGuildListItem = null;
         for each(_loc2_ in this.superLoader.parsedData.guilds)
         {
            _loc3_ = new PlayersTabGuildListItem(_loc2_.guild_name,_loc2_.guild_id,_loc2_.active_count,_loc2_.gp_today);
            method_179(_loc3_);
         }
         hideLoadingGraphic();
      }
      
      override public function remove() : *
      {
         this.superLoader.removeEventListener(SuperLoader.d,this.populateList);
         this.m.name_bt.removeEventListener(MouseEvent.CLICK,this.clickNameButton);
         this.m.active_bt.removeEventListener(MouseEvent.CLICK,this.clickActiveButton);
         this.m.gp_bt.removeEventListener(MouseEvent.CLICK,this.clickGPButton);
         super.remove();
      }
   }
}
