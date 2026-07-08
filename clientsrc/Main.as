package
{
   import blocks.*;
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.*;
   import flash.net.*;
   import flash.system.*;
   import flash.ui.*;
   import menu.*;
   import page.*;
   import sounds.*;
   import ui.*;
   
   public class Main extends Sprite
   {
      
      private static var initialized:Boolean = false;
      
      private static const clientWidth:int = 550;
      
      public static const clientHeight:int = 400;
      
      public static const accountChange:String = "accountChange";
      
      public static const beta:Boolean = false;
      
      public static const testing:Boolean = true;
      
      public static const build:String = "29-oct-2023-v168_2_1";
      
      public static const version:String = "9";
      
      // public static const productionBaseURL:String = "http://trapwork.org";
      public static const productionBaseURL:String = "http://localhost";
      public static const productionPr2HubURL:String = "https://pr2hub.com";
      
      public static var baseURL:String = productionBaseURL;
      public static var basePr2HubURL:String = productionPr2HubURL;
      
      public static var levelsURL:String = productionBaseURL + "/levels";
      public static var phLevelsURL:String = productionPr2HubURL + "/levels";
      
      public static var stage:Stage;
      
      public static var instance:Main;
      
      public static var token:String = "";
      
      public static var loggedInAs:String = "";
      
      public static var userName:String = "";
      
      public static var userPass:String = "";
      
      public static var remember:Boolean = false;
      
      public static var group:int = 0;
      
      public static var isSpecialUser:Boolean = false;
      
      public static var isTempMod:Boolean = false;
      
      public static var isTrialMod:Boolean = false;
      
      public static var isPrizer:Boolean = false;
      
      public static var hasEmail:Boolean = false;
      
      public static var awardKongNextLogin:Boolean = false;
      
      public static var userId:int = 0;
      
      public static var guild:int = 0;
      
      public static var guildOwner:int = 0;
      
      public static var guildName:String = "";
      
      public static var emblem:String = "";
      
      public static var favoriteLevels:Array = new Array();
      
      public static var lastAuthTime:Time = new Time();
      
      public static var server:Object;
      
      public static var commandHandler:CommandHandler = new CommandHandler();
      
      public static var socket:PR2Socket;
      
      public static var noodleTown:NoodleTown = new NoodleTown();
      
      public static var pageHolder:PageHolder;
      
      public static var muteButton:MuteButton = new MuteButton();
      
      public static var filledSlotCourseID:String;
      
      public static var filledSlotCourseVersion:int;
      
      public static var stats:SWFStats;
      
      public static var bitmapArray:Array = new Array();
      
      public static var var_184:int = 0;
      
      public static var blockArray:Array = new Array();
      
      public static var siteMode:String = "kongregate";
      
      public static var domain:String;
      
      private static var url:String;
      
      private static var protocol:String;
       
      
      public var kongAPI:*;
      
      public var betaLoader:Boolean;
      
      public function Main()
      {
         super();
         this.hideContextMenu();
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
      }
      
      public static function clearUserData() : *
      {
         Main.loggedInAs = "";
         Main.group = 0;
         Main.userId = 0;
         Main.hasEmail = false;
         Main.hasAnt = false;
         Main.token = "";
         Main.remember = false;
         Main.guild = 0;
         Main.guildOwner = 0;
         Main.guildName = "";
         Main.emblem = "";
      }
      
      public static function traceExt(param1:*) : *
      {
         trace(param1);
         if(ExternalInterface.available == true && beta == true)
         {
            ExternalInterface.call("console.log","Flash traceExt: " + param1);
         }
      }
      
      private function init(param1:Event = null) : *
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.init);
         Main.betaLoader = !!LoaderInfo(root.loaderInfo).parameters.hasOwnProperty("betaLoader") ? Boolean(int(LoaderInfo(root.loaderInfo).parameters.betaLoader)) : false;
         // if(Main.testing || (parent != stage && !Main.initialized && ((Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn") && Security.sandboxType == Security.REMOTE) || Capabilities.playerType == "StandAlone" && Security.sandboxType == Security.LOCAL_TRUSTED) && (Main.betaLoader && Main.beta || !Main.betaLoader && !Main.beta))
         {
            Main.initialized = true;
            Main.stage = stage;
            Main.instance = this;
            this.determineSite();
            Blocks.init();
            Parts.makeParts();
            Keys.initialize(stage);
            CustomCursor.stageRef = stage;
            CheckServers.activate();
            SavedAccounts.init();
            GpNotification.init(stage);
            class_4.init();
            stats = new SWFStats();
            stage.frameRate = 27;
            Security.loadPolicyFile(baseURL + "/crossdomain.xml");
            Security.allowDomain("kongregate.com");
            muteButton.x = 504;
            muteButton.y = 380;
            muteButton.doToggle(Main.testing);
            pageHolder = new PageHolder(new IntroPage());
            addChild(pageHolder);
            addChild(new Doughnut());
            addChild(muteButton);
         }
      }
      
      private function hideContextMenu() : *
      {
         var _loc1_:ContextMenu = new ContextMenu();
         _loc1_.hideBuiltInItems();
         contextMenu = _loc1_;
      }
      
      private function determineSite() : *
      {
         var _loc0_:String = null;
         var _loc2_:Number = NaN;
         var _loc1_:String = "local";
         url = stage.loaderInfo.url;
         protocol = url.substr(0,url.indexOf(":"));
         if(protocol == "http" || protocol == "https")
         {
            _loc2_ = Number(url.indexOf("//"));
            _loc1_ = String(url.substr(_loc2_ + 2,url.indexOf("/",_loc2_ + 2) - _loc2_ - 2));
            _loc1_ = _loc1_.toLowerCase();
            if(_loc1_.indexOf("www.") != -1)
            {
               _loc1_ = _loc1_.substr(_loc1_.indexOf("www.") + 4,_loc1_.length);
            }
         }
         Main.domain = _loc1_;
         _loc0_ = this.getRequestOrigin();
         if(this.useCurrentOriginForApi(_loc1_) && _loc0_ != null)
         {
            Main.baseURL = _loc0_;
         }
         else
         {
            Main.baseURL = productionBaseURL;
         }
         Main.basePr2HubURL = productionPr2HubURL;
         Main.levelsURL = Main.baseURL + "/levels";
         Main.phLevelsURL = Main.basePr2HubURL + "/levels";
         if(Main.domain.indexOf("bubblebox.com") != -1 || Main.domain.indexOf("2games.com") != -1)
         {
            Main.siteMode = "bubbleBox";
         }
         else if(Main.domain.indexOf("armorgames.com") != -1)
         {
            Main.siteMode = "armorGames";
         }
         else if(Main.domain.indexOf("sparkworkz.com") != -1 || Main.domain.indexOf("inxile-entertainment.com") != -1)
         {
            Main.siteMode = "inXile";
         }
         else
         {
            Main.siteMode = "kongregate";
         }
      }
      
      private function getRequestOrigin() : String
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(protocol != "http" && protocol != "https")
         {
            return null;
         }
         _loc1_ = Number(url.indexOf("//"));
         _loc2_ = Number(url.indexOf("/",_loc1_ + 2));
         if(_loc1_ == -1)
         {
            return null;
         }
         if(_loc2_ == -1)
         {
            return url;
         }
         return url.substr(0,_loc2_);
      }
      
      private function useCurrentOriginForApi(param1:String) : Boolean
      {
         return param1 == "local" || param1.indexOf("localhost") == 0 || param1.indexOf("127.0.0.1") == 0 || param1.indexOf("::1") != -1 || param1.indexOf("pr2hub.com") != -1 || param1.indexOf("trapwork.org") != -1 || param1.indexOf("bestestgameserver.ddns.net") == 0;
      }
      
      private function getKongApiOnTesting() : *
      {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         var _loc4_:Loader = null;
         if(Main.siteMode == "kongregate" && Main.domain == "local" && Main.kongAPI == null && stage == parent)
         {
            _loc1_ = LoaderInfo(root.loaderInfo).parameters;
            _loc2_ = String(String(_loc1_.kongregate_api_path) || "http://www.kongregate.com/flash/API_AS3_Local.swf");
            Security.allowDomain(_loc2_);
            _loc3_ = new URLRequest(_loc2_);
            (_loc4_ = new Loader()).contentLoaderInfo.addEventListener(Event.COMPLETE,this.receiveKongAPI);
            _loc4_.load(_loc3_);
            this.addChild(_loc4_);
         }
      }
      
      private function receiveKongAPI(param1:Event) : *
      {
         var _loc2_:* = param1.target.content;
         Main.instance.kongAPI = _loc2_;
         Main.instance.kongAPI.services.connect();
         Security.allowDomain(Main.instance.kongAPI.loaderInfo.url);
      }
   }
}
