package package_18
{
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   import package_22.*;
   import package_4.*;
   import package_8.*;
   import page.Page;
   import ui.*;
   
   public class AccountInfo extends Page
   {
      
      public static const SET_MANUAL_PART:String = "manualPart";
      
      public static var currentHat:int;
      
      public static var partToSet:Array;
       
      
      private var character:Character;
      
      private var statsSelect:StatsSelect;
      
      private var playerDisplay:PlayerDisplay;
      
      private var stageRef:Stage;
      
      private var m:AccountInfoGraphic;
      
      private var rankTokensUsed:int = 0;
      
      private var rankTokensAvailable:int = 0;
      
      private var rank:int = 0;
      
      private var guildName:GuildName;
      
      private var var_510:int = 65;
      
      private var var_635:int = 95;
      
      private var customizeInfo:String;
      
      private var loadoutsHover:HoverPopup;
      
      private var loadoutsHoverTimer:uint;
      
      public function AccountInfo()
      {
         this.stageRef = Main.stage;
         this.m = new AccountInfoGraphic();
         super();
         CommandHandler.commandHandler.defineCommand("setCustomizeInfo",this.setCustomizeInfo);
         Main.socket.write("get_customize_info`");
         Main.instance.addEventListener(Main.accountChange,this.getCustomizeInfo,false,0,true);
         Main.instance.addEventListener(SET_MANUAL_PART,this.update,false,0,true);
         Main.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler,false,0,true);
         Main.stage.focus = Main.stage;
      }
      
      public function setCustomizeInfo(param1:Array) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Array = null;
         var _loc11_:Array = null;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc17_:int = 0;
         var _loc23_:Array = null;
         var _loc24_:Array = null;
         var _loc25_:Boolean = false;
         _loc2_ = int(param1[0]);
         _loc3_ = int(param1[1]);
         _loc4_ = int(param1[2]);
         _loc5_ = int(param1[3]);
         _loc6_ = int(param1[4]);
         _loc7_ = int(param1[5]);
         var _loc8_:int = int(param1[6]);
         _loc9_ = int(param1[7]);
         _loc10_ = this.parsePartArray(param1[8]);
         _loc11_ = this.parsePartArray(param1[9]);
         _loc12_ = this.parsePartArray(param1[10]);
         _loc13_ = this.parsePartArray(param1[11]);
         var _loc14_:int = int(param1[12]);
         var _loc15_:int = int(param1[13]);
         var _loc16_:int = int(param1[14]);
         this.rank = int(param1[15]);
         this.rankTokensUsed = int(param1[16]);
         this.rankTokensAvailable = int(param1[17]);
         _loc17_ = int(param1[18]);
         var _loc18_:int = int(param1[19]);
         var _loc19_:int = int(param1[20]);
         var _loc20_:int = int(param1[21]);
         var _loc21_:Array = this.parsePartArray(param1[22]);
         var _loc22_:Array = this.parsePartArray(param1[23]);
         _loc23_ = this.parsePartArray(param1[24]);
         _loc24_ = this.parsePartArray(param1[25]);
         _loc25_ = Boolean(int(param1[26]));
         this.m.nameBox.htmlText = "Welcome, <b>" + Data.escapeString(Main.loggedInAs) + "</b>";
         this.m.hatBox.htmlText = "Hats: <b>" + (_loc10_.length - 1) + "</b>";
         class_33.setNumber("userRank",this.rank);
         LevelListing.levelListing.dispatchEvent(new Event("testLevelAccess"));
         this.updateRankText();
         this.reset();
         if(Main.guild == 0)
         {
            this.m.guildBox.htmlText = "Guild: <b>none</b>";
         }
         else
         {
            this.m.guildBox.htmlText = "Guild: ";
            this.guildName = new GuildName(Main.guild,Main.guildName,Main.emblem,true);
            this.guildName.makeWidth(145);
            this.guildName.x = 40;
            this.guildName.y = 54;
            this.m.addChild(this.guildName);
         }
         this.character = new Character(_loc6_,_loc7_,_loc8_,_loc9_);
         var _loc26_:Sprite;
         (_loc26_ = new Sprite()).addChild(this.character);
         _loc26_.x = 80;
         _loc26_.y = 140 + 42;
         _loc26_.scaleX = _loc26_.scaleY = 1.5;
         addChild(_loc26_);
         var _loc27_:int = _loc25_ ? 300 : int(150 + this.rank);
         this.statsSelect = new StatsSelect(_loc27_,_loc14_,_loc15_,_loc16_,null);
         this.statsSelect.x = 20;
         this.statsSelect.y = 207;
         addChild(this.statsSelect);
         this.playerDisplay = new PlayerDisplay(this.character,_loc10_,_loc11_,_loc12_,_loc13_,_loc6_,_loc7_,_loc8_,_loc9_,_loc2_,_loc3_,_loc4_,_loc5_,_loc21_,_loc22_,_loc23_,_loc24_,_loc17_,_loc18_,_loc19_,_loc20_);
         this.playerDisplay.x = 23;
         this.playerDisplay.y = 58 + 37;
         addChild(this.playerDisplay);
         this.m.rankTokenUp_bt.buttonMode = true;
         this.m.rankTokenUp_bt.useHandCursor = true;
         this.m.rankTokenUp_bt.addEventListener(MouseEvent.CLICK,this.clickRankTokenUp,false,0,true);
         this.m.rankTokenDown_bt.buttonMode = true;
         this.m.rankTokenDown_bt.useHandCursor = true;
         this.m.rankTokenDown_bt.addEventListener(MouseEvent.CLICK,this.clickRankTokenDown,false,0,true);
         this.m.loadouts_bt.addEventListener(MouseEvent.CLICK,this.loadoutsMouseEvent,false,0,true);
         this.m.loadouts_bt.addEventListener(MouseEvent.MOUSE_OVER,this.loadoutsMouseEvent,false,0,true);
         this.m.loadouts_bt.addEventListener(MouseEvent.MOUSE_OUT,this.loadoutsMouseEvent,false,0,true);
         this.updatePosRankTokenButtons();
         this.stageRef.addEventListener(MouseEvent.MOUSE_UP,this.update,false,0,true);
         addChild(this.m);
      }
      
      private function parsePartArray(param1:String) : Array
      {
         if(param1 != null && param1 != "")
         {
            return param1.split(",");
         }
         return new Array();
      }
      
      private function updatePosRankTokenButtons() : *
      {
         var _loc1_:int = this.rankTokensAvailable - this.rankTokensUsed;
         this.m.rankTokenUp_bt.visible = false;
         this.m.rankTokenDown_bt.visible = false;
         if(_loc1_ > 0)
         {
            this.m.rankTokenUp_bt.visible = true;
            this.m.rankTokenUp_bt.textBox.text = _loc1_.toString();
            this.m.rankTokenUp_bt.x = this.var_510;
         }
         if(this.rankTokensUsed > 0)
         {
            this.m.rankTokenDown_bt.visible = true;
            this.m.rankTokenDown_bt.arrow.rotation = 180;
            this.m.rankTokenDown_bt.textBox.text = this.rankTokensUsed.toString();
            if(this.m.rankTokenUp_bt.visible)
            {
               this.m.rankTokenDown_bt.x = this.var_635;
            }
            else
            {
               this.m.rankTokenDown_bt.x = this.var_510;
            }
         }
      }
      
      private function updateRankText() : *
      {
         this.m.rankBox.htmlText = "Rank: <b>" + this.rank + "</b>";
      }
      
      private function update(param1:Event) : *
      {
         var _loc2_:Character = this.character;
         var _loc3_:int = partToSet.length == 2 && partToSet[0] == "hat" ? int(partToSet[1]) : _loc2_.hat1;
         var _loc4_:int = partToSet.length == 2 && partToSet[0] == "head" ? int(partToSet[1]) : _loc2_.head;
         var _loc5_:int = partToSet.length == 2 && partToSet[0] == "body" ? int(partToSet[1]) : _loc2_.body;
         var _loc6_:int = partToSet.length == 2 && partToSet[0] == "feet" ? int(partToSet[1]) : _loc2_.feet;
         var _loc7_:String = _loc2_.hat1Color + "`" + _loc2_.headColor + "`" + _loc2_.bodyColor + "`" + _loc2_.feetColor + "`" + _loc2_.hat1Color2 + "`" + _loc2_.headColor2 + "`" + _loc2_.bodyColor2 + "`" + _loc2_.feetColor2 + "`" + _loc3_ + "`" + _loc4_ + "`" + _loc5_ + "`" + _loc6_;
         var _loc8_:String;
         if((_loc8_ = "set_customize_info`" + _loc7_ + "`" + this.statsSelect.getInfoStr()) != this.customizeInfo)
         {
            Main.socket.write(_loc8_);
            this.customizeInfo = _loc8_;
         }
         if(param1.type == SET_MANUAL_PART)
         {
            this.getCustomizeInfo(param1);
         }
      }
      
      private function clickRankTokenUp(param1:MouseEvent) : *
      {
         if(this.rankTokensUsed < this.rankTokensAvailable)
         {
            ++this.rankTokensUsed;
            ++this.rank;
            Main.socket.write("use_rank_token`");
            Main.socket.write("get_customize_info`");
         }
         this.updateRankText();
         this.updatePosRankTokenButtons();
      }
      
      private function clickRankTokenDown(param1:MouseEvent) : *
      {
         if(this.rankTokensUsed > 0)
         {
            --this.rankTokensUsed;
            --this.rank;
            Main.socket.write("unuse_rank_token`");
            Main.socket.write("get_customize_info`");
         }
         this.updateRankText();
         this.updatePosRankTokenButtons();
      }
      
      private function keyDownHandler(param1:KeyboardEvent, param2:Boolean = false) : *
      {
         var presetNum:int;
         var preset:Preset = null;
         var e:KeyboardEvent = param1;
         var confirmed:Boolean = param2;
         if(Popup.getOpen().length > 0 && !confirmed || e.target is TextField && e.target.selectable || CourseMenu.instance != null)
         {
            e.preventDefault();
            return;
         }
         presetNum = -1;
         if(e.keyCode >= 48 && e.keyCode <= 57 || e.keyCode >= 96 && e.keyCode <= 105)
         {
            presetNum = e.keyCode % 48;
            presetNum = presetNum == 0 ? 10 : presetNum;
            if(!confirmed)
            {
               preset = Presets.getPreset(presetNum);
               new OutfitPopup(function():*
               {
                  keyDownHandler(e,true);
               },preset.getOutfitFormat(),"Are you sure you want to apply this loadout? This will clear your current stats and character style.");
               return;
            }
         }
         if(presetNum != -1)
         {
            preset = Presets.getPreset(presetNum);
            Presets.apply(preset,this.character,this.statsSelect,this.playerDisplay);
         }
      }
      
      private function loadoutsMouseEvent(param1:MouseEvent = null) : *
      {
         if(this.loadoutsHover != null)
         {
            this.loadoutsHover.remove();
            this.loadoutsHover = null;
         }
         clearTimeout(this.loadoutsHoverTimer);
         if(param1 == null)
         {
            this.loadoutsHover = new HoverPopup("Loadouts","Save up to " + Presets.NUM_PRESETS + " of your favorite styles. Use the numbers on your keyboard for quick switching.",this.m.loadouts_bt);
            this.loadoutsHover.x += this.loadoutsHover.width + 27.5;
         }
         if(param1 == null || param1.type == MouseEvent.MOUSE_OUT)
         {
            return;
         }
         if(param1.type == MouseEvent.CLICK)
         {
            new LoadoutsPopup(this.character,this.statsSelect,this.playerDisplay);
         }
         else if(param1.type == MouseEvent.MOUSE_OVER)
         {
            this.loadoutsHoverTimer = setTimeout(this.loadoutsMouseEvent,500);
         }
      }
      
      private function reset() : *
      {
         partToSet = [];
         if(this.character != null)
         {
            this.statsSelect.remove();
            this.playerDisplay.remove();
            this.character.remove();
            this.character = null;
            this.playerDisplay = null;
            this.statsSelect = null;
         }
         if(this.guildName != null)
         {
            this.guildName.remove();
            this.guildName = null;
         }
         this.loadoutsMouseEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
      }
      
      private function getCustomizeInfo(param1:Event) : *
      {
         this.reset();
         Main.socket.write("get_customize_info`");
      }
      
      override public function remove() : *
      {
         clearTimeout(this.loadoutsHoverTimer);
         Main.instance.removeEventListener(Main.accountChange,this.getCustomizeInfo);
         Main.instance.removeEventListener(SET_MANUAL_PART,this.update);
         Main.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         this.m.rankTokenUp_bt.removeEventListener(MouseEvent.CLICK,this.clickRankTokenUp);
         this.m.rankTokenDown_bt.removeEventListener(MouseEvent.CLICK,this.clickRankTokenDown);
         this.m.loadouts_bt.removeEventListener(MouseEvent.CLICK,this.loadoutsMouseEvent);
         this.m.loadouts_bt.removeEventListener(MouseEvent.MOUSE_OVER,this.loadoutsMouseEvent);
         this.m.loadouts_bt.removeEventListener(MouseEvent.MOUSE_OUT,this.loadoutsMouseEvent);
         this.stageRef.removeEventListener(MouseEvent.MOUSE_UP,this.update);
         CommandHandler.commandHandler.defineCommand("setCustomizeInfo",null);
         this.reset();
         super.remove();
      }
   }
}
