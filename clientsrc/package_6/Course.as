package package_6
{
   import background.*;
   import blocks.*;
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.URLVariables;
   import flash.ui.Keyboard;
   import flash.text.TextField;
   import Keys;
   import package_8.*;
   import package_9.*;
   import page.GamePage;
   import sounds.*;
   
   public class Course extends GamePage
   {
      
      
      public static var course:Course;
       
      
      protected var courseID:String;
      
      protected var version:int;
      
      public var startPosArray:Array;
      
      public var finishBlocks:Array;
      
      public var teleportBlocks:Object;
      
      public var playerArray:Array;
      
      public var var_9:LocalCharacter;
      
      public var playerSpectating:Character;
      
      protected var holder:Sprite;
      
      public var timer:CourseTimer;
      
      public var statsDisplay:StatsDisplay;
      
      protected var miniMap:MiniMap;
      
      protected var itemDisplay:ItemDisplay;
      
      protected var canSpectate:Boolean = false;

      protected var suppressAutoSpectate:Boolean = false;

      protected var freeCamManual:Boolean = false;

      public var chatBox:RaceChat;
      
      public var musicSelection:MusicSelection;
      
      protected var countdown:CountdownGraphic;
      
      protected var hearts:Hearts;
      
      protected var bg:class_10;
      
      public var bg1:DrawableBackground;
      
      protected var bg2:DrawableBackground;
      
      protected var bg3:DrawableBackground;
      
      protected var bg4:DrawableBackground;
      
   protected var bg5:DrawableBackground;
      
   public var blockBackground:Map;
      
      public var effectBackground:EffectBackground;
      
      public var frontBackground:Background;
      
      public var backBackground:Background;
      
      protected var var_689:Number = 0;
      
   protected var var_678:Number = 0;
      
   private var rotateDirection:String;
      
   private var varsSet:Boolean = false;
      
   public var countdownFinished:Boolean = false;
      
      protected var playerDone:Boolean = false;
      
      public var looseHats:Array;

     // Frame counting for local player
     public var raceFrames:int = 0;
     public var framesCounting:Boolean = false;
     public var localFinishFrames:int = -1;

      public function get isSpectating():Boolean {
         return this.canSpectate;
      }
      
      public function Course()
      {
         this.startPosArray = new Array();
         this.finishBlocks = new Array();
         this.teleportBlocks = new Object();
         this.playerArray = new Array();
         this.holder = new Sprite();
         this.miniMap = new MiniMap();
         this.itemDisplay = new ItemDisplay();
         this.musicSelection = new MusicSelection();
         this.looseHats = [];
         super();
         FinishBlock.var_228 = 0;
      }
      
      override public function initialize() : *
      {
         super.initialize();
         Course.course = this;
         Main.stage.addEventListener(Event.ACTIVATE,this.onStageActivate,false,0,true);
         Main.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onSpectateToggle,false,0,true);
         Main.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.preventRaceTabFocus,true,1000,true);
         Main.stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE,this.preventRaceTabFocus,true,1000,true);
         Main.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDown,false,0,true);
         addChild(this.holder);
         this.timer = new CourseTimer(this);
         this.timer.x = 215;
         this.timer.y = -198;
         this.timer.mouseChildren = this.timer.mouseEnabled = false;
         this.holder.addChild(this.timer);
         this.statsDisplay = new StatsDisplay(this);
         this.statsDisplay.x = 215;
         this.statsDisplay.y = -166;
         this.statsDisplay.addEventListener(MouseEvent.MOUSE_OVER,this.statsDisplay.onMouse,false,0,true);
         this.statsDisplay.addEventListener(MouseEvent.MOUSE_OUT,this.statsDisplay.onMouse,false,0,true);
         this.statsDisplay.mouseChildren = false;
         this.holder.addChild(this.statsDisplay);
         this.miniMap.x = -195;
         this.miniMap.y = -198;
         this.holder.addChild(this.miniMap);
         this.itemDisplay.x = -273;
         this.itemDisplay.y = -198;
         this.itemDisplay.mouseChildren = this.itemDisplay.mouseEnabled = false;
         this.holder.addChild(this.itemDisplay);
         this.musicSelection.x = -71;
         this.musicSelection.y = 162;
         this.holder.addChild(this.musicSelection);
         this.hearts = new Hearts();
         this.hearts.x = 240;
         this.hearts.y = -141;
         this.hearts.visible = false;
         this.hearts.mouseChildren = this.hearts.mouseEnabled = false;
         this.holder.addChild(this.hearts);
         Main.stage.focus = Main.stage;
         addEventListener(Event.ENTER_FRAME,this.maybeEndIntro);
         CommandHandler.commandHandler.defineCommand("beginRace",this.beginRace);
         this.attachBackgrounds();
      }
      
      public function addStartPos(param1:int, param2:Point) : *
      {
         this.startPosArray[param1] = param2;
         this.positionPlayersAtStart();
      }
      
      protected function positionPlayersAtStart() : *
      {
         var _loc1_:int = 0;
         var _loc2_:Point = null;
         var _loc3_:Character = null;
         while(_loc1_ < this.playerArray.length)
         {
            _loc2_ = this.getStartPos(_loc1_);
            if(_loc2_ != null)
            {
               _loc3_ = this.playerArray[_loc1_];
               if(_loc3_ != null)
               {
                  _loc3_.setPos(_loc2_.x,_loc2_.y);
                  this.frontBackground.addChild(_loc3_);
               }
            }
            _loc1_++;
         }
      }
      
      private function getStartPos(param1:int) : Point
      {
         param1 = Main.server.tournament == 1 ? 0 : param1;
         return this.startPosArray[param1 % 4] != null ? this.startPosArray[param1 % 4] : new Point();
      }
      
      public function setEggSeed(param1:Array) : *
      {
         Egg.method_333(int(param1[0]));
      }
      
      public function addEggs(param1:Array) : *
      {
         var _loc2_:int = 0;
         if(this.gameMode == "egg")
         {
            _loc2_ = int(param1[0]);
            while(_loc2_ > 0)
            {
               new Egg();
               _loc2_--;
            }
         }
      }
      
      public function collectEgg(param1:int) : *
      {
      }
      
      public function setLife(param1:int) : *
      {
         if(this.gameMode == "deathmatch")
         {
            this.hearts.visible = true;
            this.hearts.method_798(param1);
         }
      }
      
      public function method_842() : int
      {
         return this.hearts.method_758();
      }
      
      override public function setGameMode(param1:String) : *
      {
         param1 = param1 === "eggs" ? "egg" : param1;
         super.setGameMode(param1);
         if(param1 == "deathmatch")
         {
            this.setLife(3);
         }
      }
      
      public function getCourseID() : String
      {
         return this.courseID;
      }

      override public function startDrawing(param1:Background) : *
      {
         var wasDrawing:Boolean = this.drawing;
         super.startDrawing(param1);
         if(!wasDrawing && !this.countdownFinished && !this.playerDone)
         {
            this.toggleKeyScroll(true);
         }
      }
      
      protected function maybeEndIntro(param1:Event) : *
      {
         if(Boolean(this.varsSet) && var_133.length <= 0)
         {
            this.endIntro();
         }
      }
      
      protected function endIntro() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.maybeEndIntro);
      }

      private function onSpectateToggle(e:KeyboardEvent) : void
      {
         if(e.keyCode != Keyboard.P)
         {
            return;
         }
         if(Main.stage.focus == RaceChat.textBox)
         {
            return;
         }
         if(Main.stage.focus is TextField)
         {
            Main.stage.focus = Main.stage;
         }
         if(this.canSpectate)
         {
            this.freeCamManual = false;
            this.toggleSpectatePossible(false);
            this.updateCameraMode();
         }
         else
         {
            Main.stage.focus = Main.stage;
            this.freeCamManual = true;
            this.suppressAutoSpectate = true;
            this.toggleSpectatePossible(true);
            this.suppressAutoSpectate = false;
            this.playerSpectating = null;
            this.updateCameraMode();
         }
      }
      
      protected function cameraFollowPlayer(param1:Event) : *
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:Character = this.playerSpectating == null ? this.var_9 : this.playerSpectating;
         if(_loc2_ != null)
         {
            _loc3_ = -_loc2_.x;
            _loc4_ = -_loc2_.y + 45;
            _loc5_ = _loc3_ - posX;
            _loc6_ = _loc4_ - posY;
            posX += _loc5_ * 0.5;
            posY += _loc6_ * 0.4;
            this.setPos(posX,posY);
         }
         if(this.canSpectate)
         {
            this.onSpectateKeyPress(param1);
         }
      }

      protected function toggleSpectatePossible(param1:Boolean) : *
      {
         if(this.canSpectate == param1)
         {
            return;
         }
         this.canSpectate = param1;
         this.playerSpectating = null;
         if (this.canSpectate)
         {
            addEventListener(Event.ENTER_FRAME, this.handleSpectateZoom, false, 0, true);
         }
         else
         {
            removeEventListener(Event.ENTER_FRAME, this.handleSpectateZoom);
            // Reset zoom to normal when exiting spectate
            this.setZoom(1);
         }
      }
      
      public function changeSpectate(param1:int) : *
      {
         if(param1 == -1)
         {
            this.playerSpectating = this.findFirstSpectatable();
            if(this.drawing && !this.countdownFinished && !this.playerDone)
            {
               return;
            }
            if(this.playerSpectating != null)
            {
               this.freeCamManual = false;
            }
            this.updateCameraMode();
            return;
         }
         if(this.playerSpectating != null && param1 == this.playerSpectating.tempID)
         {
            return;
         }
         this.playerSpectating = this.playerArray[param1];
         if(this.drawing && !this.countdownFinished && !this.playerDone)
         {
            return;
         }
         if(this.playerSpectating != null)
         {
            this.freeCamManual = false;
         }
         this.updateCameraMode();
      }

      private function findFirstSpectatable() : Character
      {
         var _loc1_:int = 0;
         if(this.playerSpectating != null)
         {
            return this.playerSpectating;
         }
         _loc1_ = 0;
         while(_loc1_ < this.playerArray.length)
         {
            if(this.playerArray[_loc1_] != null)
            {
               return this.playerArray[_loc1_];
            }
            _loc1_++;
         }
         if(this.var_9 != null)
         {
            return this.var_9;
         }
         return null;
      }
      
      protected function onSpectateKeyPress(param1:Event) : *
      {
         this.changeSpectate(-1);
      }

      protected function activateManualFreeCam() : void
      {
         Main.stage.focus = Main.stage;
         this.freeCamManual = true;
         this.playerSpectating = null;
         this.updateCameraMode();
      }

      private function handleSpectateZoom(e:Event):void
      {
         if (!this.canSpectate) return;
         if (Main.stage.focus is TextField) return;
         var step:Number = 0.25;
         var newZoom:Number = this.zoom;
         var changed:Boolean = false;
         if (Keys.justPressed(Keyboard.MINUS) || Keys.justPressed(Keyboard.NUMPAD_SUBTRACT))
         {
            newZoom = Math.max(0.25, this.zoom - step);
            changed = true;
         }
         if (Keys.justPressed(Keyboard.EQUAL) || Keys.justPressed(Keyboard.NUMPAD_ADD))
         {
            newZoom = Math.min(1, this.zoom + step);
            changed = true;
         }
         if (changed)
         {
            this.setZoom(newZoom);
         }
      }
      
      protected function toggleKeyScroll(param1:Boolean) : *
      {
         if(!param1 && this.drawing && !this.countdownFinished && !this.playerDone)
         {
            return;
         }
         removeEventListener(Event.ENTER_FRAME,keyScroll);
         removeEventListener(Event.ENTER_FRAME,this.cameraFollowPlayer);
         if(param1)
         {
            removeEventListener(Event.ENTER_FRAME,this.cameraFollowPlayer);
            addEventListener(Event.ENTER_FRAME,keyScroll,false,0,true);
         }
         else if(param1 === false)
         {
            removeEventListener(Event.ENTER_FRAME,keyScroll);
            addEventListener(Event.ENTER_FRAME,this.cameraFollowPlayer,false,0,true);
         }
      }

      protected function shouldFreeCam() : Boolean
      {
         return this.drawing || this.freeCamManual;
      }

      protected function updateCameraMode() : void
      {
         this.toggleKeyScroll(this.shouldFreeCam());
      }

      private function onStageActivate(event:Event) : void
      {
         if(Main.stage.focus is TextField)
         {
            return;
         }
         Main.stage.focus = Main.stage;
      }

      private function onStageMouseDown(event:MouseEvent) : void
      {
         if(event.target is TextField)
         {
            return;
         }
         Main.stage.focus = Main.stage;
      }

      private function preventRaceTabFocus(param1:*) : void
      {
         if(param1.keyCode != Keyboard.TAB)
         {
            return;
         }
         param1.preventDefault();
         param1.stopImmediatePropagation();
         Main.stage.focus = Main.stage;
      }
      
      public function beginRace(param1:Array) : *
      {
         removeEventListener(Event.ENTER_FRAME,this.maybeEndIntro);
         if(!this.playerDone)
         {
            this.freeCamManual = false;
            this.toggleSpectatePossible(false);
            this.updateCameraMode();
         }
         setZoom(1);
         // reset frame counters and start counting from countdown start
         this.raceFrames = 0;
         this.framesCounting = true;
         this.localFinishFrames = -1;
         // ensure our frame counter is ticking during the race
         addEventListener(Event.ENTER_FRAME, this.onRaceEnterFrame, false, 0, true);
         this.timer.init();
         this.countdown = new CountdownGraphic();
         this.countdown.addEventListener("count",this.onCountdownCount,false,0,true);
         this.countdown.addEventListener("finish",this.onCountdownFinish,false,0,true);
         addChild(this.countdown);
         if(this.var_9 != null)
         {
            var _loc2_:Object = this.var_9.getPos();
            Main.socket.write("exact_pos`" + _loc2_.x + "`" + _loc2_.y);
            if(this.var_9.var_4.getBool(Character.JUMP_START))
            {
               this.var_9.init();
            }
         }
      }
      
      protected function onCountdownCount(param1:Event) : *
      {
         SoundEffects.playSound(new ReadySound(),0.4 * (Settings.soundLevel / 100));
      }
      
      protected function onCountdownFinish(param1:Event) : *
      {
         SoundEffects.playSound(new GoSound(),0.5 * (Settings.soundLevel / 100));
         if(this.var_9 != null)
         {
            this.var_9.init();
         }
         this.blockBackground.method_578();
         this.countdownFinished = true;
         // keep counting; frames started at countdown start
      }
      
      override public function setVariables(param1:URLVariables) : *
      {
         this.varsSet = true;
         super.setVariables(param1);
      }
      
      override public function setMaxTime(param1:String) : *
      {
         if(param1 == 999 && this.updatedTime < 1358640000)
         {
            param1 = "0";
         }
         super.setMaxTime(param1);
         this.timer.setTime(Number(param1));
      }
      
      override public function setGravity(param1:String) : *
      {
         var _loc2_:Number = Number(param1);
         super.setGravity(_loc2_);
         if(this.var_9 != null)
         {
            this.var_9.setGravity(_loc2_);
         }
      }
      
      override protected function attachBackgrounds() : *
      {
         this.bg = new class_10(this);
         this.bg1 = new DrawableBackground(this);
         this.bg2 = new DrawableBackground(this);
         this.bg3 = new DrawableBackground(this);
         this.bg4 = new DrawableBackground(this);
         this.bg5 = new DrawableBackground(this);
         this.backBackground = new Background(this);
         this.blockBackground = new Map(this.miniMap,this);
         this.frontBackground = new Background(this);
         this.effectBackground = new EffectBackground(this);
         this.bg1.setScale(1);
         this.bg2.setScale(0.5);
         this.bg3.setScale(0.25);
         this.bg4.setScale(1);
         this.bg5.setScale(2);
         var_14.addChild(this.bg);
         var_14.addChild(this.bg3);
         var_14.addChild(this.bg2);
         var_14.addChild(this.bg1);
         var_14.addChild(this.backBackground);
         var_14.addChild(this.blockBackground);
         var_14.addChild(this.frontBackground);
         var_14.addChild(this.effectBackground);
         var_14.addChild(this.bg4);
         var_14.addChild(this.bg5);
         this.setColor(12303325);
      }
      
      override protected function removeBackgrounds() : *
      {
         if(this.bg != null)
         {
            this.bg.remove();
         }
         if(this.bg1 != null)
         {
            this.bg1.remove();
         }
         if(this.bg2 != null)
         {
            this.bg2.remove();
         }
         if(this.bg3 != null)
         {
            this.bg3.remove();
         }
         if(this.bg4 != null)
         {
            this.bg4.remove();
         }
         if(this.bg5 != null)
         {
            this.bg5.remove();
         }
         if(this.blockBackground != null)
         {
            this.blockBackground.remove();
         }
         if(this.effectBackground != null)
         {
            this.effectBackground.remove();
         }
         if(this.frontBackground != null)
         {
            this.frontBackground.remove();
         }
         if(this.backBackground != null)
         {
            this.backBackground.remove();
         }
         this.bg = null;
         this.bg1 = null;
         this.bg2 = null;
         this.bg3 = null;
         this.bg4 = null;
         this.bg5 = null;
         this.blockBackground = null;
         this.effectBackground = null;
         this.frontBackground = null;
         this.backBackground = null;
      }
      
      override public function setPos(param1:Number, param2:Number) : *
      {
         if(this.bg1 != null)
         {
            this.bg1.setPos(param1,param2);
         }
         if(this.bg2 != null)
         {
            this.bg2.setPos(param1,param2);
         }
         if(this.bg3 != null)
         {
            this.bg3.setPos(param1,param2);
         }
         if(this.bg4 != null)
         {
            this.bg4.setPos(param1,param2);
         }
         if(this.bg5 != null)
         {
            this.bg5.setPos(param1,param2);
         }
         if(this.blockBackground != null)
         {
            this.blockBackground.setPos(param1,param2);
         }
         if(this.effectBackground != null)
         {
            this.effectBackground.setPos(param1,param2);
         }
         if(this.frontBackground != null)
         {
            this.frontBackground.setPos(param1,param2);
         }
         if(this.backBackground != null)
         {
            this.backBackground.setPos(param1,param2);
         }
      }
      
      override public function setColor(param1:Number = 0) : *
      {
         if(this.bg != null)
         {
            this.bg.setColor(param1);
         }
         if(this.bg1 != null)
         {
            this.bg1.setColor(param1);
         }
         if(this.bg2 != null)
         {
            this.bg2.setColor(param1);
         }
         if(this.bg3 != null)
         {
            this.bg3.setColor(param1);
         }
         if(this.bg4 != null)
         {
            this.bg4.setColor(param1);
         }
         if(this.bg5 != null)
         {
            this.bg5.setColor(param1);
         }
         if(this.blockBackground != null)
         {
            this.blockBackground.setColor(param1);
         }
         if(this.effectBackground != null)
         {
            this.effectBackground.setColor(param1);
         }
         if(this.frontBackground != null)
         {
            this.frontBackground.setColor(param1);
         }
         if(this.backBackground != null)
         {
            this.backBackground.setColor(param1);
         }
      }
      
      override public function setSaveString(param1:String) : *
      {
         var _loc2_:Array = param1.split("`");
         this.setColor(Number(_loc2_[0]));
         this.blockBackground.setSaveString(_loc2_[1]);
         this.bg1.setSaveString(_loc2_[5] + "," + _loc2_[2],false);
         this.bg2.setSaveString(_loc2_[6] + "," + _loc2_[3],false);
         this.bg3.setSaveString(_loc2_[7] + "," + _loc2_[4],false);
         this.bg4.setSaveString(_loc2_[11] + "," + _loc2_[9],false);
         this.bg5.setSaveString(_loc2_[12] + "," + _loc2_[10],false);
         this.bg.setSaveString(_loc2_[8],false);
      }
      
      override public function setSong(param1:String) : *
      {
         super.setSong(param1);
         this.musicSelection.setSong(param1);
      }
      
      override protected function glideToScale(param1:Event) : *
      {
         super.glideToScale(param1);
         this.bg.scaleX = this.bg.scaleY = this.holder.scaleX = this.holder.scaleY = 1 / scale;
      }
      
      public function startRotate(param1:String) : *
      {
         this.rotateDirection = param1;
         addEventListener(Event.ENTER_FRAME,this.rotate);
         this.bg1.method_86();
         this.bg2.method_86();
         this.bg3.method_86();
         this.bg4.method_86();
         this.bg5.method_86();
         Main.stage.quality = StageQuality.LOW;
      }
      
      private function rotate(param1:Event) : *
      {
         var _loc2_:* = false;
         var _loc4_:Character = null;
         var _loc3_:Number = 3;
         if(this.rotateDirection == "right")
         {
            rotation += _loc3_;
            _loc2_ = rotation >= 90;
         }
         else
         {
            rotation -= _loc3_;
            _loc2_ = rotation <= -90;
         }
         if(_loc2_)
         {
            rotation = 0;
            this.bg.rotation = 0;
            this.bg1.method_74();
            this.bg2.method_74();
            this.bg3.method_74();
            this.bg4.method_74();
            this.bg5.method_74();
            Main.stage.quality = StageQuality.HIGH;
            if(this.rotateDirection == "right")
            {
               this.blockBackground.rotation = this.bg1.rotation = this.bg2.rotation = this.bg3.rotation = this.bg4.rotation = this.bg5.rotation = this.bg5.rotation + 90;
               this.miniMap.rotate(this.blockBackground.rotation);
            }
            else
            {
               this.blockBackground.rotation = this.bg1.rotation = this.bg2.rotation = this.bg3.rotation = this.bg4.rotation = this.bg5.rotation = this.bg5.rotation - 90;
               this.miniMap.rotate(this.blockBackground.rotation);
            }
            for each(_loc4_ in this.playerArray)
            {
               if(_loc4_ != null)
               {
                  _loc4_.rotate(this.rotateDirection);
               }
            }
            this.cameraFollowPlayer(new Event(Event.ENTER_FRAME));
            removeEventListener(Event.ENTER_FRAME,this.rotate);
         }
         this.bg.rotation = this.holder.rotation = -rotation;
         if(this.var_9 != null)
         {
            this.var_9.setRotation(-rotation);
         }
      }
      
      public function outOfTimeHandler() : *
      {
      }
      
      public function finish(param1:int = -1, param2:int = 0, param3:int = 0) : *
      {
      }
      
      override public function remove() : *
      {
         var _loc1_:Character = null;
         removeEventListener(Event.ENTER_FRAME,this.onRaceEnterFrame);
         CommandHandler.commandHandler.defineCommand("beginRace",null);
         removeEventListener(Event.ENTER_FRAME,this.maybeEndIntro);
         removeEventListener(Event.ENTER_FRAME,this.rotate);
         removeEventListener(Event.ENTER_FRAME,this.cameraFollowPlayer);
         Main.stage.removeEventListener(Event.ACTIVATE,this.onStageActivate);
         Main.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onSpectateToggle);
         Main.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.preventRaceTabFocus,true);
         Main.stage.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE,this.preventRaceTabFocus,true);
         Main.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDown);
         if(this.timer != null)
         {
            this.timer.remove();
            this.timer = null;
         }
         if(this.statsDisplay != null)
         {
            this.statsDisplay.remove();
            this.statsDisplay = null;
         }
         if(this.countdown != null)
         {
            this.countdown.removeEventListener("count",this.onCountdownCount);
            this.countdown.removeEventListener("finish",this.onCountdownFinish);
            if(this.countdown.parent != null)
            {
               this.countdown.parent.removeChild(this.countdown);
            }
            this.countdown.stop();
            this.countdown = null;
         }
         if (this.musicSelection != null)
         {
            this.musicSelection.remove();
            this.musicSelection = null;
         }
         if (this.miniMap != null)
         {
            this.miniMap.remove();
            this.miniMap = null;
         }
         if (this.hearts != null)
         {
            this.hearts.remove();
            this.hearts = null;
         }
         this.itemDisplay = null;
         Course.course = null;
         for each(_loc1_ in this.playerArray)
         {
            if(_loc1_ != null)
            {
               _loc1_.remove();
            }
         }
         this.playerArray = null;
         this.startPosArray = null;
         super.remove();
      }

      protected function onRaceEnterFrame(param1:Event) : *
      {
         if (this.framesCounting && !this.playerDone)
         {
            this.raceFrames++;
         }
      }
   }
}
