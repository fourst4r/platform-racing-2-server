package replay
{
   import com.jiggmin.data.CommandHandler;
   import flash.net.URLVariables;
   import package_6.Course;
   import package_6.SpectatePicker;
   import package_6.DrawingInfo;
   import package_8.RemoteCharacter;
   import package_8.Character;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import Keys;
   import com.jiggmin.data.Data;

   public class ReplayCourse extends Course
   {
      private var cm:CommandHandler;
      private var spectatePicker:SpectatePicker;
      private var isPrepared:Boolean = false;
      private var drawingInfo:DrawingInfo;
      private var autoFollow:Boolean = true;
      private var participantStatsByName:Object = null;

      public function ReplayCourse(param1:String, param2:int)
      {
         super();
         this.courseID = param1;
         this.version = param2;
         this.cm = CommandHandler.commandHandler;
      }

      override public function initialize() : *
      {
         super.initialize();
         this.registerReplayCommands();
         this.autoFollow = true;
         if(this.chatBox != null)
         {
            this.chatBox.visible = false;
            this.chatBox.mouseEnabled = false;
            this.chatBox.mouseChildren = false;
         }
         if(this.musicSelection != null)
         {
            this.musicSelection.visible = false;
            this.musicSelection.mouseEnabled = false;
            this.musicSelection.mouseChildren = false;
         }
         if(this.itemDisplay != null)
         {
            this.itemDisplay.visible = false;
         }
         if(this.hearts != null)
         {
            this.hearts.visible = false;
         }
         this.drawingInfo = new DrawingInfo();
         this.drawingInfo.x = -273;
         this.drawingInfo.y = -104;
         holder.addChild(this.drawingInfo);
         if(this.musicSelection != null)
         {
            this.musicSelection.visible = false;
         }
      }

      private function registerReplayCommands() : void
      {
         this.cm.defineCommand("createRemoteCharacter",this.handleCreateRemoteCharacter);
         this.cm.defineCommand("createLocalCharacter",this.handleCreateLocalCharacter);
      }

      private function handleCreateLocalCharacter(args:Array) : void
      {
         this.handleCreateRemoteCharacter(args);
      }

      private function handleCreateRemoteCharacter(args:Array) : void
      {
         var tempId:int = int(args[0]);
         var name:String = String(args[1]);
         var hatColor:Number = Number(args[2]);
         var headColor:Number = Number(args[3]);
         var bodyColor:Number = Number(args[4]);
         var feetColor:Number = Number(args[5]);
         var hat:int = int(args[6]);
         var head:int = int(args[7]);
         var body:int = int(args[8]);
         var feet:int = int(args[9]);
         var hatColor2:Number = Number(args[10]);
         var headColor2:Number = Number(args[11]);
         var bodyColor2:Number = Number(args[12]);
         var feetColor2:Number = Number(args[13]);
         var group:String = String(args[14]);
         var existing:Character = this.playerArray[tempId];
         var wasSpectated:Boolean = this.playerSpectating === existing;
         if(existing != null)
         {
            existing.remove();
         }
         var character:RemoteCharacter = new RemoteCharacter(tempId,this.miniMap.getDot(),name,hat,head,body,feet,group);
         character.setColors(hatColor,hatColor2,headColor,headColor2,bodyColor,bodyColor2,feetColor,feetColor2);
         this.playerArray[tempId] = character;
         if(wasSpectated)
         {
            this.playerSpectating = character;
         }
         if(this.drawingInfo != null)
         {
            this.drawingInfo.method_138(name,tempId);
         }
         this.positionPlayersAtStart();
         if(this.playerSpectating == null && this.autoFollow)
         {
            this.changeSpectate(tempId);
            // Ensure camera follow is active even if beginRace hasn't fired yet
            this.toggleKeyScroll(false);
         }
         this.updateSpectatedStats();
      }

      public function prepareReplayLevel(levelData:String, meta:Object) : void
      {
         if(this.isPrepared)
         {
            return;
         }
         var sanitized:String = validateSaveString(levelData);
         var vars:URLVariables = new URLVariables(sanitized);
         setVariables(vars);
         // TODO: This meta is wrong, it will always say the mode is 'race'. Gotta investigate.
         // if(meta != null)
         // {
         //    if(meta.hasOwnProperty("title"))
         //    {
         //       this.title = String(meta.title);
         //    }
         //    if(meta.hasOwnProperty("note"))
         //    {
         //       this.note = String(meta.note);
         //    }
         //    if(meta.hasOwnProperty("song"))
         //    {
         //       this.setSong(String(meta.song));
         //    }
         //    if(meta.hasOwnProperty("mode"))
         //    {
         //       this.setGameMode(String(meta.mode));
         //    }
         //    if(meta.hasOwnProperty("gravity"))
         //    {
         //       this.setGravity(String(meta.gravity));
         //    }
         //    if(meta.hasOwnProperty("max_time"))
         //    {
         //       this.setMaxTime(String(meta.max_time));
         //    }
         //    if(meta.hasOwnProperty("items"))
         //    {
         //       this.setItems(String(meta.items));
         //    }
         //    if(meta.hasOwnProperty("badHats"))
         //    {
         //       this.setBadHats(String(meta.badHats));
         //    }
         //    if(meta.hasOwnProperty("cowboyChance"))
         //    {
         //       this.setCowboyChance(String(meta.cowboyChance));
         //    }
         // }
         this.buildSpectatePicker();
         this.playerSpectating = null;
         this.isPrepared = true;
         this.updateSpectatedStats();
      }

      private function buildSpectatePicker() : void
      {
         if(this.spectatePicker != null)
         {
            return;
         }
         this.spectatePicker = new SpectatePicker();
         this.spectatePicker.x = -265;
         this.spectatePicker.y = 30;
         this.spectatePicker.scaleX = this.spectatePicker.scaleY = 0.9;
         holder.addChild(this.spectatePicker);
         this.toggleSpectatePossible(true);
      }

      public function ensureCameraFollow() : void
      {
         if(this.playerSpectating != null)
         {
            // Attach camera follow loop explicitly
            this.toggleKeyScroll(false);
         }
      }

      public function setParticipantStats(participants:Array) : void
      {
         if(participants == null)
         {
            this.participantStatsByName = null;
            this.updateSpectatedStats();
            return;
         }
         var statsMap:Object = {};
         for each (var entry:Object in participants)
         {
            if(entry == null)
            {
               continue;
            }
            var username:String = entry.username != null ? String(entry.username) : "";
            if(username == "")
            {
               continue;
            }
            var stats:Object = this.extractParticipantStats(entry);
            if(stats != null)
            {
               statsMap[username] = stats;
            }
         }
         this.participantStatsByName = statsMap;
         this.updateSpectatedStats();
      }

      private function extractParticipantStats(entry:Object) : Object
      {
         if(entry == null)
         {
            return null;
         }
         var speed:* = entry.speed;
         var accel:* = entry.accel != null ? entry.accel : entry.acceleration;
         var jump:* = entry.jump != null ? entry.jump : entry.jumping;
         if(entry.stats != null)
         {
            if(speed == null && entry.stats.speed != null)
            {
               speed = entry.stats.speed;
            }
            if(accel == null)
            {
               if(entry.stats.accel != null)
               {
                  accel = entry.stats.accel;
               }
               else if(entry.stats.acceleration != null)
               {
                  accel = entry.stats.acceleration;
               }
            }
            if(jump == null)
            {
               if(entry.stats.jump != null)
               {
                  jump = entry.stats.jump;
               }
               else if(entry.stats.jumping != null)
               {
                  jump = entry.stats.jumping;
               }
            }
         }
         if(speed == null && accel == null && jump == null)
         {
            return null;
         }
         var speedVal:* = speed != null ? Data.numLimit(int(speed),0,100) : null;
         var accelVal:* = accel != null ? Data.numLimit(int(accel),0,100) : null;
         var jumpVal:* = jump != null ? Data.numLimit(int(jump),0,100) : null;
         return {
            "speed": speedVal,
            "accel": accelVal,
            "jump": jumpVal
         };
      }

      private function updateSpectatedStats() : void
      {
         if(this.statsDisplay == null)
         {
            return;
         }
         var stats:Object = this.getSpectatedStats();
         if(stats == null)
         {
            this.statsDisplay.setStatsText("--","--","--");
            return;
         }
         var speedText:String = stats.speed != null ? String(stats.speed) : "--";
         var accelText:String = stats.accel != null ? String(stats.accel) : "--";
         var jumpText:String = stats.jump != null ? String(stats.jump) : "--";
         this.statsDisplay.setStatsText(speedText,accelText,jumpText);
      }

      private function getSpectatedStats() : Object
      {
         if(this.participantStatsByName == null)
         {
            return null;
         }
         var target:Character = this.playerSpectating;
         if(target == null)
         {
            return null;
         }
         var name:String = target.getName();
         return name != null ? this.participantStatsByName[name] : null;
      }

      public function get hudContainer() : Sprite
      {
         return holder;
      }

      override public function beginRace(param1:Array) : *
      {
         removeEventListener(Event.ENTER_FRAME,this.maybeEndIntro);
         if(!this.playerDone)
         {
            this.toggleKeyScroll(false);
         }
         setZoom(1);
         this.raceFrames = 0;
         this.framesCounting = true;
         this.localFinishFrames = -1;
         addEventListener(Event.ENTER_FRAME,this.onRaceEnterFrame,false,0,true);
         if(this.timer != null)
         {
            this.timer.init();
         }
         this.countdown = new CountdownGraphic();
         this.countdown.addEventListener("count",this.onCountdownCount,false,0,true);
         this.countdown.addEventListener("finish",this.onCountdownFinish,false,0,true);
         addChild(this.countdown);
         if(this.var_9 != null)
         {
            this.var_9.init();
         }
         this.ensureAutoSpectating();
      }

      override protected function onSpectateKeyPress(param1:Event) : *
      {
         if(Main.stage.focus is TextField)
         {
            return;
         }
         var keyPressed:Boolean = Keys.isPressed(Keyboard.DOWN) || Keys.isPressed(this.altCtrl.down) || Keys.isPressed(Keyboard.UP) || Keys.isPressed(this.altCtrl.up) || Keys.isPressed(Keyboard.LEFT) || Keys.isPressed(this.altCtrl.left) || Keys.isPressed(Keyboard.RIGHT) || Keys.isPressed(this.altCtrl.right);
         if(keyPressed)
         {
            this.autoFollow = false;
            if(this.spectatePicker != null)
            {
               this.spectatePicker.stopSpectating();
            }
            this.activateManualFreeCam();
            return;
         }
         if(this.playerSpectating == null && this.autoFollow && this.playerArray != null)
         {
            this.ensureAutoSpectating();
         }
      }

      override protected function toggleSpectatePossible(possible:Boolean) : *
      {
         super.changeSpectate(-1);
         if(this.spectatePicker != null)
         {
            this.spectatePicker.toggleVisibility(possible);
         }
         if(possible)
         {
            this.autoFollow = true;
         }
         super.toggleSpectatePossible(possible);
         this.updateSpectatedStats();
      }

      override public function changeSpectate(playerID:int) : *
      {
         if(playerID >= 0)
         {
            this.autoFollow = true;
            super.changeSpectate(playerID);
            this.updateSpectatedStats();
            return;
         }
         if(playerID == -1)
         {
            if(this.var_9 == null)
            {
               this.autoFollow = true;
               if(this.playerSpectating == null)
               {
                  this.ensureAutoSpectating();
               }
               this.updateSpectatedStats();
               return;
            }
            this.autoFollow = false;
         }
         super.changeSpectate(playerID);
         this.updateSpectatedStats();
      }

      override protected function cameraFollowPlayer(e:Event) : *
      {
         if(this.autoFollow && this.playerSpectating == null)
         {
            this.ensureAutoSpectating();
         }
         super.cameraFollowPlayer(e);
      }

      private function ensureAutoSpectating() : void
      {
         if(!this.autoFollow || this.playerArray == null)
         {
            return;
         }
         for(var i:int = 0; i < this.playerArray.length; i++)
         {
            if(this.playerArray[i] != null)
            {
               super.changeSpectate(i);
               this.autoFollow = true;
               this.updateSpectatedStats();
               return;
            }
         }
         this.updateSpectatedStats();
      }

      override public function remove() : *
      {
         this.cm.defineCommand("createRemoteCharacter",null);
         this.cm.defineCommand("createLocalCharacter",null);
         if(this.spectatePicker != null)
         {
            this.spectatePicker.remove();
            this.spectatePicker = null;
         }
         if(this.drawingInfo != null)
         {
            this.drawingInfo.remove();
            this.drawingInfo = null;
         }
         this.participantStatsByName = null;
         super.remove();
      }
   }
}
