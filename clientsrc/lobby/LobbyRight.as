package lobby
{
   import package_22.*;
   import ui.*;
   
   public class LobbyRight extends LobbySide
   {
      
      public static var lobbyRight:LobbyRight;
       
      
      private var campaignTab:LobbyTab;
      
      private var atbTab:LobbyTab;
      
      private var wbTab:LobbyTab;
      
      private var newTab:LobbyTab;
      
      private var searchTab:LobbyTab;
      
      private var favsTab:LobbyTab;
      
      public function LobbyRight()
      {
         this.campaignTab = new LobbyTab(this.clickCampaign,"Campaign");
         this.atbTab = new LobbyTab(this.clickBest,"All Time Best");
         this.wbTab = new LobbyTab(this.clickBestWeek,"Week\'s Best");
         this.newTab = new LobbyTab(this.clickNew,"Newest");
         this.searchTab = new LobbyTab(this.clickSearch,"Search");
         this.favsTab = new LobbyTab(this.clickFavs,"♥");
         LobbyRight.lobbyRight = this;
         x = 200;
         y = 3;
         var _loc1_:Array = [this.campaignTab,this.atbTab,this.wbTab,this.newTab,this.searchTab];
         if(Main.group >= 1)
         {
            _loc1_.push(this.favsTab);
         }
         super(_loc1_,"lobbyRight",0,347,356);
         if(Main.testing)
         {
            this.lookupUser("bIs1999");
         }
      }
      
      private function clickCampaign() : *
      {
         changePage(new Campaign());
      }
      
      private function clickBest() : *
      {
         changePage(new Best());
      }
      
      private function clickBestWeek() : *
      {
         changePage(new BestWeek());
      }
      
      private function clickNew() : *
      {
         changePage(new Newest());
      }
      
      private function clickSearch() : *
      {
         changePage(new Search());
      }
      
      private function clickFavs() : *
      {
         changePage(new Favorites());
      }
      
      public function lookupUser(param1:String = "") : *
      {
         this.searchTab.select();
         changePage(new Search(param1));
      }
      
      public function lookupLevel(param1:String = "") : *
      {
         this.searchTab.select();
         changePage(new Search(param1,"id"));
      }
      
      override public function remove() : *
      {
         LobbyRight.lobbyRight = null;
         this.campaignTab = this.atbTab = this.wbTab = this.newTab = this.searchTab = this.favsTab = null;
         super.remove();
      }
   }
}
