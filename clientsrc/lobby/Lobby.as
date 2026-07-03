package lobby
{
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import levelEditor.*;
   import menu.*;
   import package_17.*;
   import package_4.*;
   import page.Page;
   
   public class Lobby extends Page
   {
      
      public static var var_516:Boolean = false;
      
      public static var lobbyEntrances:int = 0;
       
      
      private var left:LobbyLeft;
      
      private var right:LobbyRight;
      
      private var m:LobbyGraphic;
      
      private var hover:HoverPopup;
      
      private var bottom_bts:LobbyBottomButtonsGraphic;
      
      public function Lobby()
      {
         this.m = new LobbyGraphic();
         super();
      }
      
      override public function initialize() : *
      {
         this.left = new LobbyLeft();
         this.right = new LobbyRight();
         addChild(this.m);
         addChild(this.left);
         addChild(this.right);
         if(Settings.musicLevel > 0)
         {
            Main.noodleTown.startPlaying();
         }
         Main.noodleTown.setTargetVolume(0.6 * (Settings.musicLevel / 100));
         Main.stage.quality = StageQuality.HIGH;
         this.bottom_bts = new LobbyBottomButtonsGraphic();
         this.bottom_bts.gotoAndStop(Main.group > 0 ? "kongregateSite" : "sponsoredSite");
         this.bottom_bts.logoutButton.addEventListener(MouseEvent.CLICK,this.clickLogout,false,0,true);
         this.bottom_bts.levelEditorButton.addEventListener(MouseEvent.CLICK,this.clickLE,false,0,true);
         this.bottom_bts.moreGamesButton.addEventListener(MouseEvent.CLICK,this.clickKong,false,0,true);
         this.bottom_bts.optionsButton.addEventListener(MouseEvent.CLICK,this.clickOptions,false,0,true);
         this.bottom_bts.vaultButton.addEventListener(MouseEvent.CLICK,this.clickStore,false,0,true);
         this.bottom_bts.creditsButton.addEventListener(MouseEvent.CLICK,this.clickCredits,false,0,true);
         this.bottom_bts.moreGamesButton.addEventListener(MouseEvent.MOUSE_OVER,this.hoverKong,false,0,true);
         this.bottom_bts.moreGamesButton.addEventListener(MouseEvent.MOUSE_OUT,this.hoverOutKong,false,0,true);
         addChild(this.bottom_bts);
      }
      
      private function clickLogout(param1:MouseEvent = null) : *
      {
         var _loc2_:URLVariables = null;
         var _loc3_:URLRequest = null;
         var _loc4_:SuperLoader = null;
         if(Main.isTempMod && Main.server.guild_id == 0)
         {
            if(param1 != null)
            {
               new ConfirmPopup(this.clickLogout,"You\'re currently a temporary moderator. Logging out will automatically demote you back to a member. Do you really want to proceed?");
               return;
            }
            new MessagePopup("You are now logged out. If you haven\'t already done so, please notify a member of the staff team that you\'ve ended your moderation session.");
         }
         if(!Main.remember)
         {
            _loc2_ = new URLVariables();
            _loc3_ = new URLRequest(Main.baseURL + "/logout.php");
            _loc3_.data = _loc2_;
            _loc3_.method = URLRequestMethod.POST;
            (_loc4_ = new SuperLoader(true,SuperLoader.j)).load(_loc3_);
         }
         Main.clearUserData();
         Main.pageHolder.changePage(new LoginPage());
         Main.socket.close();
      }
      
      private function clickLE(param1:MouseEvent = null) : *
      {
         if(Main.isTempMod && Main.server.guild_id == 0)
         {
            if(param1 != null)
            {
               new ConfirmPopup(this.clickLE,"You\'re currently a temporary moderator. Entering the level editor will log you out, which will automatically demote you back to a member. Do you really want to proceed?");
               return;
            }
            new MessagePopup("You are now logged out. If you haven\'t already done so, please notify a member of the staff team that you\'ve ended your moderation session.");
         }
         var _loc2_:Boolean = !Main.isTempMod && !Main.isTrialMod && Main.group >= 2;
         Main.pageHolder.changePage(new LevelEditor(null,_loc2_));
         Main.socket.close();
      }
      
      private function clickKong(param1:MouseEvent) : *
      {
         navigateToURL(new URLRequest("http://www.kongregate.com/games/jiggmin/platform-racing-2/?gamereferral=platformracing2"),"_blank");
      }
      
      private function clickOptions(param1:MouseEvent) : *
      {
         new OptionsPopup();
      }
      
      private function clickStore(param1:MouseEvent) : *
      {
         new StorePopup();
      }
      
      private function clickCredits(param1:MouseEvent) : *
      {
         new CreditsPopup();
      }
      
      private function hoverKong(param1:MouseEvent) : *
      {
         this.hover = new HoverPopup("Kong Hat","Players from Kongregate automatically get a hat that doubles guild points won in each race!",this.bottom_bts.moreGamesButton);
      }
      
      private function hoverOutKong(param1:MouseEvent) : *
      {
         this.hover.remove();
         this.hover = null;
      }
      
      override public function remove() : *
      {
         this.bottom_bts.logoutButton.removeEventListener(MouseEvent.CLICK,this.clickLogout);
         this.bottom_bts.levelEditorButton.removeEventListener(MouseEvent.CLICK,this.clickLE);
         this.bottom_bts.moreGamesButton.removeEventListener(MouseEvent.CLICK,this.clickKong);
         this.bottom_bts.optionsButton.removeEventListener(MouseEvent.CLICK,this.clickOptions);
         this.bottom_bts.vaultButton.removeEventListener(MouseEvent.CLICK,this.clickStore);
         this.bottom_bts.creditsButton.removeEventListener(MouseEvent.CLICK,this.clickCredits);
         this.bottom_bts.moreGamesButton.removeEventListener(MouseEvent.MOUSE_OVER,this.hoverKong);
         this.bottom_bts.moreGamesButton.removeEventListener(MouseEvent.MOUSE_OUT,this.hoverOutKong);
         removeChild(this.bottom_bts);
         this.bottom_bts = null;
         this.left.remove();
         this.right.remove();
         removeChild(this.m);
         this.m = null;
         this.left = null;
         this.right = null;
         if(this.hover != null)
         {
            this.hover.remove();
            this.hover = null;
         }
         Main.noodleTown.setTargetVolume(0);
         super.remove();
      }
   }
}
