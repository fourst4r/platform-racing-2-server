package menu
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.net.*;
   import lobby.*;
   import package_18.*;
   import package_4.Popup;
   
   public class LoggingInPopup extends Popup
   {
       
      
      private var loader:SuperLoader;
      
      private var m:LoggingInPopupGraphic;
      
      private var socketOK:Boolean = false;
      
      private var httpOK:Boolean = false;
      
      private var socket:PR2Socket;

      private var reconnectMode:Boolean = false;
      
      public function LoggingInPopup(param1:String, param2:Boolean = false)
      {
         this.loader = new SuperLoader(true,SuperLoader.j);
         this.m = new LoggingInPopupGraphic();
         super();
         this.reconnectMode = param2;
         this.socket = Main.socket;
         this.socket.addEventListener(Event.CLOSE,this.onError,false,0,true);
         CommandHandler.commandHandler.defineCommand("loginSuccessful",this.loginSuccessful);
         CommandHandler.commandHandler.defineCommand("loginFailure",this.loginFailure);
         var _loc2_:Object = new Object();
         _loc2_.user_name = Main.userName;
         _loc2_.user_pass = Main.userPass;
         _loc2_.build = Main.build;
         _loc2_.server = Main.server;
         _loc2_.domain = Main.domain;
         _loc2_.remember = Main.remember;
         _loc2_.login_id = int(param1);
         _loc2_.award_kong = Main.awardKongNextLogin;
         var _loc3_:String = JSON.stringify(_loc2_);
         var _loc4_:Encryptor;
         (_loc4_ = new Encryptor()).setKey(Env.LOGIN_KEY);
         _loc4_.setIV(Env.LOGIN_IV);
         var _loc5_:String = _loc4_.encrypt(_loc3_);
         var _loc6_:URLVariables;
         (_loc6_ = new URLVariables()).i = _loc5_;
         _loc6_.build = Main.build;
         var _loc7_:URLRequest;
         (_loc7_ = new URLRequest(Main.baseURL + "/login.php")).data = _loc6_;
         _loc7_.method = URLRequestMethod.POST;
         this.loader.addEventListener(SuperLoader.d,this.onHttpSuccess,false,0,true);
         this.loader.addEventListener(SuperLoader.e,this.onError,false,0,true);
         this.loader.load(_loc7_);
         Main.awardKongNextLogin = false;
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose);
         addChild(this.m);
      }
      
      public function loginSuccessful(param1:Array) : *
      {
         Main.group = int(param1[0]);
         Main.loggedInAs = param1[1];
         this.socketOK = true;
         this.maybeSwitchToLobby();
      }
      
      private function onHttpSuccess(param1:Event) : *
      {
         var _loc2_:Object = null;
         _loc2_ = this.loader.parsedData;
         Main.userId = _loc2_.userId;
         Main.hasEmail = _loc2_.email;
         Main.token = _loc2_.token;
         Main.guild = _loc2_.guild;
         Main.guildOwner = _loc2_.guildOwner;
         Main.guildName = _loc2_.guildName;
         Main.emblem = _loc2_.emblem;
         Main.favoriteLevels = _loc2_.favoriteLevels;
         Main.lastAuthTime.setTime(_loc2_.time);
         UnreadNotif.setLastRead(_loc2_.lastRead);
         UnreadNotif.notifyUser(_loc2_.lastRecv);
         this.httpOK = true;
         this.maybeSwitchToLobby();
      }
      
      private function onError(param1:Event) : *
      {
         var _loc2_:Object = null;
         startFadeOut();
         Main.socket.remove();
         if(this.reconnectMode)
         {
            RaceReconnectController.onReconnectLoginFailed();
            return;
         }
         try
         {
            _loc2_ = JSON.parse(param1.target.data);
            if("resetToken" in _loc2_ && Boolean(_loc2_.resetToken))
            {
               SavedAccounts.deleteAccount(Main.token,"token");
            }
         }
         catch(e:Error)
         {
         }
         Main.clearUserData();
      }
      
      private function maybeSwitchToLobby() : *
      {
         if(Boolean(this.socketOK) && Boolean(this.httpOK))
         {
            if(Main.remember)
            {
               SavedAccounts.add(Main.loggedInAs,Main.token);
            }
            Settings.init(Main.loggedInAs);
            Presets.load();
            if(this.reconnectMode && RaceReconnectController.beginReconnectLogin(this))
            {
               return;
            }
            Main.pageHolder.changePage(new Lobby());
            startFadeOut();
         }
      }
      
      private function clickClose(param1:MouseEvent) : *
      {
         startFadeOut();
         Main.socket.remove();
      }
      
      public function loginFailure(param1:Array) : *
      {
         if(this.reconnectMode)
         {
            RaceReconnectController.onReconnectLoginFailed();
         }
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.socket.removeEventListener(Event.CLOSE,this.onError);
         this.socket = null;
         CommandHandler.commandHandler.defineCommand("loginSuccessful",null);
         CommandHandler.commandHandler.defineCommand("loginFailure",null);
         this.loader.removeEventListener(SuperLoader.d,this.onHttpSuccess);
         this.loader.removeEventListener(SuperLoader.e,this.onError);
         this.loader.remove();
         this.m.close_bt.removeEventListener(MouseEvent.CLICK,this.clickClose);
         super.remove();
      }
   }
}
