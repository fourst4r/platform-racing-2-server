package replay
{
   import com.jiggmin.data.CommandHandler;
   import com.jiggmin.data.PR2Socket;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import lobby.Lobby;
   import package_4.LevelInfoPopup;
   import package_8.Character;
   import page.Page;
   import Main;

   public class ReplaySession
   {
      private var data:ReplayData;
      private var course:ReplayCourse;
      private var feeder:ReplayCommandFeeder;
      private var player:ReplayPlayer;
      private var hud:ReplayHUD;
      private var socket:ReplaySocket;
      private var previousSocket:PR2Socket;
      private var levelIdentifier:String;
      private var isPR2Hub:Boolean;
      private var allowLevelInfo:Boolean = true;
      private var hudListenerAttached:Boolean = false;
      private var keyListenerAttached:Boolean = false;

      public function ReplaySession()
      {
      }

      public function start(replayData:ReplayData, levelId:String, isPr2Hub:Boolean, allowLevelInfo:Boolean) : void
      {
         this.data = replayData;
         this.levelIdentifier = levelId;
         this.isPR2Hub = isPr2Hub;
         this.allowLevelInfo = allowLevelInfo;
         var version:int = 1;
         if(replayData.meta != null && replayData.meta.level_version != null)
         {
            version = int(replayData.meta.level_version);
         }
         var courseId:String = levelId;
         if(!isPr2Hub && levelId.indexOf("8p_") != 0)
         {
            courseId = "8p_" + levelId;
         }
         // Create the playback components and swap the socket early to avoid
         // any late server messages switching the page back to a live Game.
         this.feeder = new ReplayCommandFeeder();
         this.player = new ReplayPlayer(replayData.events,this.feeder,this.handlePlaybackComplete);
         this.socket = new ReplaySocket(this.player);
         this.previousSocket = Main.socket;
         Main.socket = this.socket;
         CommandHandler.commandHandler.sendNum = -1;

         this.course = new ReplayCourse(courseId,version);
         Main.pageHolder.changePage(this.course);
         this.course.prepareReplayLevel(replayData.levelText,replayData.meta);
         if(replayData.meta != null && replayData.meta.participants is Array)
         {
            this.course.setParticipantStats(replayData.meta.participants as Array);
         }
         try
         {
            ReplayTrajectories.build(replayData.events);
         }
         catch(e:*)
         {
            // If trajectory precompute fails, continue with event-driven playback
         }
         if(this.course.musicSelection != null)
         {
            this.course.musicSelection.visible = false;
         }
         this.player.reset();
         ReplayTrajectories.resetAllCursors();
         this.player.primeInitialEvents();
         this.hud = new ReplayHUD(this);
         this.hud.x = -250;
         this.hud.y = 150;
         this.course.hudContainer.addChild(this.hud);
         this.attachHudUpdater();
         this.attachKeyListener();
         // Pick an initial spectate target and ensure camera follow loop is active
         this.course.changeSpectate(-1);
         this.course.ensureCameraFollow();
         this.player.play();
         this.refreshHud();
      }

      public function togglePlay() : void
      {
         this.player.togglePlay();
         this.refreshHud();
      }

      public function cycleSpeed() : void
      {
         this.player.cycleSpeed();
         this.refreshHud();
      }

      public function requestExit() : void
      {
         ReplayManager.stop();
      }

      public function stepForward() : void
      {
         this.player.stepForward();
         this.refreshHud();
      }

      public function refreshHud() : void
      {
         if(this.hud != null)
         {
            this.hud.refreshState(this.player.isPlaying,this.player.currentSpeed);
            this.hud.refreshTime(this.player.currentTimeMs,this.player.totalDuration);
         }
      }

      private function handlePlaybackComplete() : void
      {
         this.refreshHud();
      }

      private function attachHudUpdater() : void
      {
         if(!this.hudListenerAttached)
         {
            Main.stage.addEventListener(Event.ENTER_FRAME,this.onHudFrame,false,0,true);
            this.hudListenerAttached = true;
         }
      }

      private function detachHudUpdater() : void
      {
         if(this.hudListenerAttached)
         {
            Main.stage.removeEventListener(Event.ENTER_FRAME,this.onHudFrame);
            this.hudListenerAttached = false;
         }
      }

      private function attachKeyListener() : void
      {
         if(!this.keyListenerAttached)
         {
            Main.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,0,true);
            this.keyListenerAttached = true;
         }
      }

      private function detachKeyListener() : void
      {
         if(this.keyListenerAttached)
         {
            Main.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
            this.keyListenerAttached = false;
         }
      }

      private function onHudFrame(param1:Event) : void
      {
         this.refreshHud();
      }

      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(Main.stage.focus != Main.stage)
         {
            return;
         }
         if(param1.keyCode == Keyboard.SPACE)
         {
            this.togglePlay();
         }
         else if(param1.keyCode == Keyboard.COMMA)
         {
            if(!this.player.isPlaying)
            {
               this.stepForward();
            }
         }
         else if(param1.keyCode == Keyboard.RIGHT_BRACKET || param1.keyCode == Keyboard.LEFT_BRACKET)
         {
            this.cycleSpeed();
         }
         else if(param1.keyCode == Keyboard.ESCAPE)
         {
            this.requestExit();
         }
      }

      public function stop() : void
      {
         this.detachHudUpdater();
         this.detachKeyListener();
         if(this.hud != null && this.hud.parent != null)
         {
            this.hud.parent.removeChild(this.hud);
         }
         if(this.hud != null)
         {
            this.hud.dispose();
         }
         this.hud = null;
         if(this.player != null)
         {
            this.player.pause();
            this.player.dispose();
            this.player = null;
         }
         ReplayTrajectories.clear();
         if(Main.socket === this.socket)
         {
            Main.socket = this.previousSocket;
         }
         this.socket = null;
         this.feeder = null;
         this.data = null;
      }

      public function reopenLevelInfo() : void
      {
         Main.pageHolder.changePage(new Lobby());
         if(!this.allowLevelInfo)
         {
            return;
         }
         var levelId:String = this.levelIdentifier;
         new LevelInfoPopup(levelId);
      }

      public function getCurrentCourse() : ReplayCourse
      {
         return this.course;
      }

      public function disposeCourse() : void
      {
         if(this.course != null)
         {
            this.course.remove();
            this.course = null;
         }
      }
   }
}



