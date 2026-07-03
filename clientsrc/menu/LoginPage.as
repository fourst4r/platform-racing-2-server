package menu
{
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.*;
   import page.Page;
   import ui.*;
   
   public class LoginPage extends Page
   {
       
      
      private var m:LoginPageGraphic;
      
      private var buttons:Array;
      
      private var posX:Number = 275;
      
      private var posY:Number = 228;
      
      private var showHideInterval:uint;
      
      public function LoginPage()
      {
         this.m = new LoginPageGraphic();
         this.buttons = new Array();
         super();
         Settings.clear();
         addChild(this.m);
         this.addToMenu(new LoginPageMenuButton("Log In",this.clickLogIn));
         this.addToMenu(new LoginPageMenuButton("Play as Guest",this.clickGuest));
         this.addToMenu(new LoginPageMenuButton("Create Account",this.clickCreateAccount));
         this.addToMenu(new LoginPageMenuButton("Instructions",this.clickInstructions));
         this.addToMenu(new LoginPageMenuButton("Credits",this.clickCredits));
         this.m.kongLogo.visible = false;
         this.m.bubbleBoxLogo.visible = false;
         this.m.armorGamesLogo.visible = false;
         if(Main.siteMode == "kongregate")
         {
            this.m.kongLogo.visible = true;
            this.m.kongLogo.addEventListener(MouseEvent.CLICK,this.clickKong,false,0,true);
         }
         else if(Main.siteMode == "bubbleBox")
         {
            this.m.bubbleBoxLogo.visible = true;
         }
         else if(Main.siteMode == "armorGames")
         {
            this.m.armorGamesLogo.visible = true;
         }
         this.m.loggedInAs.visible = false;
         CheckServers.activate();
      }
      
      override public function initialize() : *
      {
         if(Settings.musicLevel > 0)
         {
            Main.noodleTown.startPlaying();
            Main.noodleTown.setTargetVolume(1 * (Settings.musicLevel / 100));
         }
         Main.stage.quality = StageQuality.HIGH;
         Main.userPass = "";
         Main.group = 0;
         class_33.setNumber("userRank",0);
         super.initialize();
      }
      
      private function addToMenu(param1:LoginPageMenuButton) : *
      {
         this.buttons.push(param1);
         param1.x = this.posX;
         param1.y = this.posY;
         addChild(param1);
         this.posY += 22;
      }
      
      public function clickLogIn(param1:MouseEvent) : *
      {
         class_33.setNumber("userRank",-1);
         if(SavedAccounts.getAll().length > 0)
         {
            Main.userName = "";
            Main.userPass = "";
            new ServerSelectPopup(false);
         }
         else
         {
            new LoginPopup();
         }
      }
      
      public function clickGuest(param1:MouseEvent) : *
      {
         Main.userName = "Guest";
         Main.userPass = "";
         Main.remember = false;
         class_33.setNumber("userRank",0);
         new ServerSelectPopup(true);
      }
      
      public function clickCreateAccount(param1:MouseEvent) : *
      {
         new CreateAccountPopup();
      }
      
      public function clickInstructions(param1:MouseEvent) : *
      {
         navigateToURL(new URLRequest(Main.baseURL + "/instructions.php"),"_blank");
      }
      
      public function clickCredits(param1:MouseEvent) : *
      {
         new CreditsPopup();
      }
      
      private function clickKong(param1:MouseEvent) : *
      {
         navigateToURL(new URLRequest("https://discord.gg/h4HpbfAPBw"),"_blank");
      }
      
      override public function remove() : *
      {
         var _loc1_:LoginPageMenuButton = null;
         this.m.kongLogo.removeEventListener(MouseEvent.CLICK,this.clickKong);
         clearInterval(this.showHideInterval);
         for each(_loc1_ in this.buttons)
         {
            _loc1_.remove();
            _loc1_ = null;
         }
         this.buttons = new Array();
         this.buttons = null;
         this.m.bg.bg1.stop();
         this.m.bg.bg2.stop();
         this.m.bg.bg3.stop();
         removeChild(this.m);
         this.m = null;
         CheckServers.deactivate();
         super.remove();
      }
   }
}
