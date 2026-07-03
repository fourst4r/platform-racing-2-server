package lobby
{
   import com.jiggmin.data.*;
   import package_18.*;
   import package_21.*;
   import package_23.*;
   import ui.*;
   
   public class LobbyLeft extends LobbySide
   {
       
      
      public function LobbyLeft()
      {
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         x = y = 3;
         var _loc1_:LobbyTab = new LobbyTab(this.changeTabChat,"Chat");
         var _loc2_:LobbyTab = new LobbyTab(this.changeTabPMs,"PMs");
         var _loc3_:LobbyTab = new LobbyTab(this.changeTabPlayers,"Players");
         var _loc4_:LobbyTab = new LobbyTab(this.changeTabAccount,"Account");
         if(Main.group > 0)
         {
            _loc5_ = new Array(_loc1_,_loc2_,_loc3_,_loc4_);
            _loc6_ = 3;
         }
         else
         {
            _loc5_ = new Array(_loc1_,_loc3_,_loc4_);
            _loc6_ = 2;
         }
         super(_loc5_,"lobbyLeft",_loc6_,194,394);
         UnreadNotif.addNotifContainer(_loc2_);
      }
      
      private function changeTabChat() : *
      {
         changePage(new ChatInstance());
      }
      
      private function changeTabPMs() : *
      {
         changePage(new Messages());
      }
      
      private function changeTabPlayers() : *
      {
         changePage(new PlayersTab());
      }
      
      private function changeTabAccount() : *
      {
         changePage(new AccountInfo());
      }
      
      override public function remove() : *
      {
         super.remove();
      }
   }
}
