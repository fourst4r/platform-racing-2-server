package package_6
{
   import com.adobe.crypto.*;
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.geom.Point;
   import flash.net.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import package_4.*;
   import package_8.*;
   import package_9.*;
   import com.jiggmin.data.RaceReconnectController;
   import sounds.*;
   
   public class Game extends Course
   {
       
      
      private var superLoader:SuperLoader;
      
      private var quitButton:QuitButton;
      
      private var cm:CommandHandler;
      
      private var spectatePicker:SpectatePicker;
      
      protected var drawingInfo:DrawingInfo;
      
      public var prize:Object;
      
      private var luxPop:LuxPopup;
      
      private var levelHash:String = "8p_bypass";
      
      private var specialEvent:SpecialEvent;
      
      private var var_634:Array;
      
      public var var_202:FinishedPage;
      
      public var var_463:Array;
      
      public var var_452:int;
      
      public var var_465:int;
      
      public var var_347:int;
      
      private var hatCountdown:uint;

      private var reconnectMode:Boolean = false;

      private var reconnectApplyingSnapshot:Boolean = false;
      
      public function Game(param1:String, param2:int)
      {
         this.superLoader = new SuperLoader(false);
         this.cm = CommandHandler.commandHandler;
         this.var_634 = new Array();
         this.var_463 = new Array();
         super();
         this.courseID = param1;
         this.version = param2;
         this.quitButton = new QuitButton(this);
         this.specialEvent = new SpecialEvent(Main.stage,this);
         Egg.method_333(0);
      }
      
      override public function initialize() : *
      {
         Main.stage.frameRate = Settings.getValue(Settings.FPS_30,false) ? 30 : 27;
         this.chatBox = new RaceChat();
         this.chatBox.x = -271;
         this.chatBox.y = 49;
         holder.addChild(this.chatBox);
         this.drawingInfo = new DrawingInfo();
         this.drawingInfo.x = -273;
         this.drawingInfo.y = -104;
         holder.addChild(this.drawingInfo);
         holder.addChild(this.quitButton);
         this.cm.defineCommand("createRemoteCharacter",this.createRemoteCharacter);
         this.cm.defineCommand("createLocalCharacter",this.createLocalCharacter);
         this.cm.defineCommand("award",this.award);
         this.cm.defineCommand("setExpGain",this.setExpGain);
         this.cm.defineCommand("setLuxGain",this.setLuxGain);
         this.cm.defineCommand("setPrize",this.setPrize);
         this.cm.defineCommand("cancelPrize",this.cancelPrize);
         this.cm.defineCommand("winPrize",this.winPrize);
         this.cm.defineCommand("cowboyMode",this.cowboyMode);
         this.cm.defineCommand("happyHour",this.happyHour);
         this.cm.defineCommand("setEggSeed",setEggSeed);
         this.cm.defineCommand("addEggs",addEggs);
         this.cm.defineCommand("superBooster",this.superBooster);
         this.cm.defineCommand("maybeReturnHatToStart",this.maybeReturnHatToStart);
         this.cm.defineCommand("startHatCountdown",this.startHatCountdown);
         this.cm.defineCommand("forceQuit",this.quitGame);
         super.initialize();
         this.getLevelData();
      }
      
      protected function initSpectate() : *
      {
         this.spectatePicker = new SpectatePicker();
         this.spectatePicker.x = -265;
         this.spectatePicker.y = 30;
         this.spectatePicker.scaleX = this.spectatePicker.scaleY = 0.9;
         holder.addChild(this.spectatePicker);
         this.toggleSpectatePossible(true);
      }
      
      override protected function toggleSpectatePossible(param1:Boolean) : *
      {
         if(param1 && !this.suppressAutoSpectate)
         {
            super.changeSpectate(-1);
         }
         if (this.spectatePicker != null)
            this.spectatePicker.toggleVisibility(param1);
         super.toggleSpectatePossible(param1);
      }
      
      override protected function onSpectateKeyPress(param1:Event) : *
      {
         if(this.freeCamManual)
         {
            return;
         }
         if(!(Main.stage.focus is TextField) && (Keys.isPressed(Keyboard.DOWN) || Keys.isPressed(altCtrl.down) || Keys.isPressed(Keyboard.UP) || Keys.isPressed(altCtrl.up) || Keys.isPressed(Keyboard.LEFT) || Keys.isPressed(altCtrl.left) || Keys.isPressed(Keyboard.RIGHT) || Keys.isPressed(altCtrl.right)))
         {
            this.spectatePicker.stopSpectating();
            super.onSpectateKeyPress(param1);
         }
      }
      
      override protected function onCountdownFinish(param1:Event) : *
      {
         if(PrizePopup.instance != null)
         {
            PrizePopup.instance.startFadeOut();
         }
         super.onCountdownFinish(param1);
      }
      
      private function getLevelData() : *
      {
         var levelsURL = this.courseID.indexOf("8p_") == 0 ? Main.levelsURL : Main.phLevelsURL;
         var _loc1_:URLRequest = new URLRequest(levelsURL + "/" + courseID + ".txt?version=" + version);
         this.superLoader.addEventListener(Event.COMPLETE,this.loadHandler,false,0,true);
         this.superLoader.load(_loc1_);
      }
      
      private function loadHandler(param1:Event) : *
      {
         var _loc7_:URLVariables = null;
         this.superLoader.removeEventListener(Event.COMPLETE,this.loadHandler);
         var _loc2_:String = String(param1.target.data);
         var _loc3_:int = _loc2_.length - 32;
         var _loc4_:String = _loc2_.substr(_loc3_);
         var _loc5_:String = _loc2_.substr(0,_loc3_);
         var _loc6_:String;
         /*if((_loc6_ = String(MD5.hash(version.toString() + courseID.toString() + _loc5_ + Env.LEVEL_SALT_2))) != _loc4_)
         {
            new MessagePopup("Error: The course did not download correctly.");
         }
         else*/ if(_loc5_ == "")
         {
            new MessagePopup("Error: The course did not load.");
         }
         else
         {
            this.superLoader.remove();
            this.superLoader = null;
            _loc5_ = validateSaveString(_loc5_);
            // This is actually non-negligible. 800ms for Basilisk, so let's not do it 
            // for the 2nd time this function.
            // this.levelHash = MD5.hash(_loc5_ + courseID + version + Env.LEVEL_HASH_SALT);
            _loc7_ = new URLVariables(_loc5_);
            setVariables(_loc7_);
            this.initSpectate();
         }
      }
      
      override public function beginRace(param1:Array) : *
      {
         this.drawingInfo.clear();
         super.beginRace(param1);
      }
      
      public function award(param1:Array) : *
      {
         this.var_463.push(param1);
         if(this.var_202 != null)
         {
            this.var_202.award(param1);
         }
      }
      
      public function setExpGain(param1:Array) : *
      {
         this.var_452 = int(param1[0]);
         this.var_465 = int(param1[1]);
         this.var_347 = int(param1[2]);
         this.finish();
         this.method_196();
         if(this.var_202 != null)
         {
            this.var_202.setExpGain(this.var_452,this.var_465,this.var_347);
         }
      }
      
      public function setLuxGain(param1:Array) : *
      {
         this.luxPop = new LuxPopup(int(param1[0]));
      }
      
      public function setPrize(param1:Array) : *
      {
         this.prize = JSON.parse(param1[0]);
         new PrizePopup(this.prize.type,this.prize.id,this.prize.name,this.prize.desc,this.prize.universal,false);
      }
      
      public function cancelPrize(param1:Array) : *
      {
         this.prize = null;
         new PrizePopup("cancel",0,"Prize Cancelled",param1[0]);
      }
      
      public function winPrize(param1:Array) : *
      {
         this.prize = JSON.parse(param1[0]);
         new PrizePopup(this.prize.type,this.prize.id,this.prize.name,this.prize.desc,this.prize.universal,true);
         if(Main.instance.kongAPI != null && this.prize.type == "hat")
         {
            Main.instance.kongAPI.stats.submit(this.prize.name,1);
         }
      }
      
      public function cowboyMode(param1:Array) : *
      {
         addChild(new CowboyMode());
      }
      
      public function happyHour(param1:Array) : *
      {
         addChild(new HappyHour());
      }
      
      private function superBooster(param1:Array) : *
      {
         var _loc2_:int = int(param1[0]);
         var _loc3_:Character = playerArray[_loc2_];
         if(_loc3_ != null)
         {
            _loc3_.method_576();
         }
      }
      
      private function maybeReturnHatToStart(param1:Array) : *
      {
         var _loc3_:Point = null;
         var _loc4_:int = 0;
         var _loc2_:Hat = looseHats[int(param1[0])];
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getPos();
            _loc4_ = _loc2_.getRot();
            _loc3_ = Data.method_9(_loc3_.x,_loc3_.y,_loc4_);
            if(_loc3_.y > blockBackground.maxY + 500 && _loc4_ == 0 || _loc3_.y < blockBackground.minY - 500 && Math.abs(_loc4_) == 180 || _loc3_.x > blockBackground.maxX + 500 && _loc4_ == 90 || _loc3_.x < blockBackground.minX - 500 && _loc4_ == -90)
            {
               this.returnHatToStart(_loc2_);
            }
         }
      }
      
      private function returnHatToStart(param1:Hat) : *
      {
         var _loc2_:Object = param1.getInfo();
         param1.remove();
         if(_loc2_.id < startPosArray.length)
         {
            new Hat(startPosArray[_loc2_.id].x,startPosArray[_loc2_.id].y,0,_loc2_.num,_loc2_.color,_loc2_.color2,_loc2_.id);
         }
      }
      
      private function startHatCountdown(param1:Array = null) : *
      {
         this.cm.defineCommand("cancelHatCountdown",this.cancelHatCountdown);
         this.hatCountdown = setInterval(this.checkHatCountdown,1000);
      }
      
      private function checkHatCountdown() : *
      {
         Main.socket.write("check_hat_countdown`");
      }
      
      private function cancelHatCountdown(param1:Array = null) : *
      {
         this.cm.defineCommand("cancelHatCountdown",null);
         clearInterval(this.hatCountdown);
      }
      
      private function createRemoteCharacter(param1:Array) : *
      {
          var _loc2_:int = int(param1[0]);
          var _loc3_:String = String(param1[1]);
         var _loc4_:Number = Number(param1[2]);
         var _loc5_:Number = Number(param1[3]);
         var _loc6_:Number = Number(param1[4]);
         var _loc7_:Number = Number(param1[5]);
         var _loc8_:Number = Number(param1[6]);
         var _loc9_:Number = Number(param1[7]);
         var _loc10_:Number = Number(param1[8]);
         var _loc11_:Number = Number(param1[9]);
         var _loc12_:Number = Number(param1[10]);
         var _loc13_:Number = Number(param1[11]);
          var _loc14_:Number = Number(param1[12]);
          var _loc15_:Number = Number(param1[13]);
          var _loc16_:String = String(param1[14]);
          var _loc19_:Point = null;
          var _loc18_:Character = playerArray[_loc2_];
          if(_loc18_ != null)
          {
             _loc18_.remove();
          }
          var _loc17_:RemoteCharacter;
          (_loc17_ = new RemoteCharacter(_loc2_,miniMap.getDot(),_loc3_,_loc8_,_loc9_,_loc10_,_loc11_,_loc16_)).setColors(_loc4_,_loc12_,_loc5_,_loc13_,_loc6_,_loc14_,_loc7_,_loc15_);
          playerArray[_loc2_] = _loc17_;
          if(!this.countdownFinished)
          {
             this.drawingInfo.method_138(_loc3_,_loc2_);
          }
          _loc19_ = this.startPosArray[_loc2_ % 4] != null ? this.startPosArray[_loc2_ % 4] : new Point();
          if(_loc19_ != null)
          {
             _loc17_.setPos(_loc19_.x,_loc19_.y);
             this.frontBackground.addChild(_loc17_);
          }
      }
      
      private function createLocalCharacter(param1:Array) : *
      {
         var _loc2_:int = int(param1[0]);
         var _loc3_:Number = Number(param1[1]);
         var _loc4_:Number = Number(param1[2]);
         var _loc5_:Number = Number(param1[3]);
         var _loc6_:Number = Number(param1[4]);
         var _loc7_:Number = Number(param1[5]);
         var _loc8_:Number = Number(param1[6]);
         var _loc9_:Number = Number(param1[7]);
         var _loc10_:Number = Number(param1[8]);
         var _loc11_:Number = Number(param1[9]);
         var _loc12_:Number = Number(param1[10]);
         var _loc13_:Number = Number(param1[11]);
         var _loc14_:Number = Number(param1[12]);
         var _loc15_:Number = Number(param1[13]);
         var _loc16_:Number = Number(param1[14]);
         var _loc17_:Number = Number(param1[15]);
         var _loc18_:String = String(param1[16]);
         var _loc19_:LocalCharacter;
         (_loc19_ = new LocalCharacter(_loc2_,this,blockBackground,miniMap.getDot(),itemDisplay,Number(gravity),_loc3_,_loc4_,_loc5_,_loc10_,_loc11_,_loc12_,_loc13_,_loc18_)).setColors(_loc6_,_loc14_,_loc7_,_loc15_,_loc8_,_loc16_,_loc9_,_loc17_);
         playerArray[_loc2_] = _loc19_;
         if(!this.countdownFinished)
         {
            this.drawingInfo.method_138(Main.loggedInAs,_loc2_);
         }
         var_9 = _loc19_;
         positionPlayersAtStart();
      }
      
      override public function collectEgg(param1:int) : *
      {
         if(this.gameMode == "egg")
         {
            Main.socket.write("grab_egg`" + param1);
         }
      }
      
      public function method_196() : *
      {
         if(this.var_202 == null)
         {
            this.method_185();
            this.quitButton.stopGlow();
            this.var_202 = new FinishedPage(this);
         }
      }
      
      override protected function endIntro() : *
      {
         Main.socket.write("finish_drawing`" + this.levelHash + "`" + this.gameMode + "`" + this.getFinishBlockPositions() + "`" + finishBlocks.length + "`" + cowboyChance + "`" + badHats.join(","));
         super.endIntro();
      }
      
      private function getFinishBlockPositions() : String
      {
         return finishBlocks.length > 5 ? "all" : JSON.stringify(finishBlocks);
      }
      
      override public function outOfTimeHandler() : *
      {
         this.cancelHatCountdown();
         if(this.gameMode == Modes.egg)
         {
            this.finish();
            this.method_196();
         }
         else
         {
            this.quitGame();
         }
      }
      
      override public function finish(param1:int = -1, param2:int = 0, param3:int = 0) : *
      {
         if(!playerDone)
         {
            // capture local finish frame count once when finishing a race
            if (this.framesCounting)
            {
               this.localFinishFrames = this.raceFrames;
               this.framesCounting = this.gameMode == Modes.obj; // obj should keep counting in case this wasn't the last objective
            }

            // note we are canonicalising to 30fps here for fairness
            var canonMs = this.localFinishFrames * (1000 / 30.0);
            
            if(this.gameMode == Modes.obj)
            {
               if(param1 != -1)
               {
                  miniMap.removeFinish(param2,param3);
                  Main.socket.write("objective_reached`" + param1 + "`" + param2 + "`" + param3 + "`" + canonMs);
               }
            }
            else
            {
               Main.socket.write("finish_race`" + param1 + "`" + param2 + "`" + param3 + "`" + canonMs);
               if(this.gameMode != Modes.hat)
               {
                  this.quitButton.startGlow();
                  this.method_185();
                  this.method_682();
                  timer.pause();
               }
            }
            SoundEffects.playSound(new VictorySound(),1 * (Settings.soundLevel / 100));
         }
      }
      
      public function quitGame(param1:Array = null) : *
      {
         if(this.reconnectMode)
         {
            RaceReconnectController.leaveRace();
            return;
         }
         if(!playerDone)
         {
            if(this.gameMode == Modes.dm)
            {
               this.finish();
            }
            else
            {
               Main.socket.write("quit_race`");
            }
         }
         this.method_185();
         this.method_196();
      }
      
      private function method_682() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(var_9 != null)
         {
            _loc1_ = 1;
            while(_loc1_ <= 4)
            {
               if(var_9["hat" + _loc1_] <= 1)
               {
                  break;
               }
               _loc1_++;
            }
            _loc2_ = _loc1_ - 1;
            if(Main.instance.kongAPI != null)
            {
               Main.instance.kongAPI.stats.submit("Hat Finish",_loc2_);
            }
         }
      }
      
      private function method_185() : *
      {
         if(!playerDone)
         {
            playerDone = true;
            if(var_9 != null)
            {
               var_9.beginRemove();
            }
            this.toggleSpectatePossible(true);
            super.toggleKeyScroll(true);
            Main.stage.focus = Main.stage;
         }
      }
      
      public function isDonePlaying() : Boolean
      {
         return playerDone;
      }

      public function canReconnectRace() : Boolean
      {
         return !playerDone && this.var_9 != null;
      }

      public function isReconnectModeActive() : Boolean
      {
         return this.reconnectMode;
      }

      public function getCourseVersion() : int
      {
         return this.version;
      }

      public function enterReconnectMode() : void
      {
         this.reconnectMode = true;
         if(this.var_9 != null)
         {
            this.var_9.setReconnectPaused(true);
         }
         if(this.chatBox != null)
         {
            this.chatBox.receiveSystemMessage(["Connection lost. Reconnect to continue this race."]);
         }
      }

      public function abortReconnectResume() : void
      {
         this.reconnectMode = false;
         if(this.var_9 != null)
         {
            this.var_9.setReconnectPaused(false);
         }
      }

      public function finishReconnectResume() : void
      {
         this.reconnectMode = false;
         if(this.var_9 != null)
         {
            this.var_9.rebindSocket();
            this.var_9.setReconnectPaused(false);
         }
      }

      public function matchesReconnectDescriptor(param1:Object) : Boolean
      {
         // The server validates the resume payload before sending snapshot/events.
         // Be permissive here so client-side bookkeeping drift does not abort reconnects.
         return param1 != null;
      }

      public function buildReconnectResumePayload() : Object
      {
         var _loc1_:Object = this.var_9 != null ? this.var_9.getPos() : {
            "x":0,
            "y":0
         };
         var _loc2_:Object = this.var_9 != null ? this.var_9.getStats() : {
            "speed":0,
            "acceleration":0,
            "jumping":0
         };
         return {
            "course_id":this.getCourseID(),
            "level_version":this.version,
            "client_last_seen_packet_num":CommandHandler.commandHandler.sendNum,
            "disconnect_time_ms":new Date().time,
            "local_player":{
               "x":_loc1_.x,
               "y":_loc1_.y,
               "rotation":this.var_9 != null ? this.var_9.rotation : 0,
               "state":this.var_9 != null ? this.var_9.state : "",
               "stats":_loc2_,
               "local_finish_frames":this.localFinishFrames,
               "game_mode":this.gameMode
            },
            "consumed_blocks":[]
         };
      }

      public function applyReconnectSnapshot(param1:Object) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Character = null;
         if(param1 == null)
         {
            return false;
         }
         this.reconnectApplyingSnapshot = true;
         _loc2_ = [];
         if(param1.players != null)
         {
            for each(_loc3_ in param1.players)
            {
               if(_loc3_ == null || _loc3_.temp_id == null)
               {
                  continue;
               }
               _loc2_.push(int(_loc3_.temp_id));
               if(int(_loc3_.user_id) == Main.userId)
               {
                  continue;
               }
               _loc5_ = this.playerArray[int(_loc3_.temp_id)];
               if(_loc5_ != null)
               {
                  _loc5_.remove();
                  delete this.playerArray[int(_loc3_.temp_id)];
               }
               if(_loc3_.packets != null)
               {
                  for each(_loc4_ in _loc3_.packets)
                  {
                     if(_loc4_ != null && _loc4_ != "")
                     {
                        this.cm.dispatchPacketPayload(String(_loc4_));
                     }
                  }
               }
            }
         }
         this.removePlayersMissingFromSnapshot(_loc2_);
         if(param1.packets != null)
         {
            for each(_loc4_ in param1.packets)
            {
               if(_loc4_ != null && _loc4_ != "")
               {
                  this.cm.dispatchPacketPayload(String(_loc4_));
               }
            }
         }
         if(param1.finish_times_packet != null && param1.finish_times_packet != "")
         {
            this.cm.dispatchPacketPayload(String(param1.finish_times_packet));
         }
         this.reconnectApplyingSnapshot = false;
         return true;
      }

      public function applyReconnectEvents(param1:Array) : void
      {
         var _loc2_:Object = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            if(_loc2_ != null && _loc2_.payload != null)
            {
               this.cm.dispatchPacketPayload(String(_loc2_.payload));
            }
         }
      }

      private function removePlayersMissingFromSnapshot(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Character = null;
         while(_loc2_ < this.playerArray.length)
         {
            _loc3_ = this.playerArray[_loc2_];
            if(_loc3_ != null && !(_loc3_ is LocalCharacter) && param1.indexOf(_loc2_) == -1)
            {
               _loc3_.remove();
               delete this.playerArray[_loc2_];
            }
            _loc2_++;
         }
      }
      
      override public function remove() : *
      {
         RaceReconnectController.clearForGame(this);
         this.framesCounting = false;
         this.cm.defineCommand("createRemoteCharacter",null);
         this.cm.defineCommand("createLocalCharacter",null);
         this.cm.defineCommand("award",null);
         this.cm.defineCommand("setExpGain",null);
         this.cm.defineCommand("setLuxGain",null);
         this.cm.defineCommand("setPrize",null);
         this.cm.defineCommand("cancelPrize",null);
         this.cm.defineCommand("winPrize",null);
         this.cm.defineCommand("cowboyMode",null);
         this.cm.defineCommand("setEggSeed",null);
         this.cm.defineCommand("addEggs",null);
         this.cm.defineCommand("superBooster",null);
         this.cm.defineCommand("maybeReturnHatToStart",null);
         this.cm.defineCommand("startHatCountdown",null);
         this.cm.defineCommand("forceQuit",null);
         removeEventListener(Event.ENTER_FRAME,maybeEndIntro);
         removeEventListener(Event.ENTER_FRAME,cameraFollowPlayer);
         removeEventListener(Event.ENTER_FRAME,keyScroll);
         if(this.drawingInfo != null)
         {
            this.drawingInfo.remove();
            this.drawingInfo = null;
         }
         if(this.spectatePicker != null)
         {
            this.spectatePicker.remove();
            this.spectatePicker = null;
         }
         if(this.superLoader != null)
         {
            this.superLoader.removeEventListener(Event.COMPLETE,this.loadHandler);
            this.superLoader.remove();
            this.superLoader = null;
         }
         this.prize = null;
         if(PrizePopup.instance !== null)
         {
            PrizePopup.instance.startFadeOut();
         }
         if(PlaceArtifact.instance !== null)
         {
            PlaceArtifact.instance.startFadeOut();
         }
         if(this.luxPop != null)
         {
            this.luxPop.remove();
            this.luxPop = null;
         }
         this.quitButton.remove();
         this.chatBox.remove();
         this.specialEvent.remove();
         this.specialEvent = null;
         this.cancelHatCountdown();
         super.remove();
      }
   }
}
