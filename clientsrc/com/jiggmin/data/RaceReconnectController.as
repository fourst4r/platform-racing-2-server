package com.jiggmin.data
{
   import com.hurlant.util.Base64;
   import flash.utils.ByteArray;
   import flash.events.Event;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import lobby.Lobby;
   import menu.ConnectingPopup;
   import menu.LoginPage;
   import menu.LoggingInPopup;
   import package_6.Game;
   import package_6.RaceReconnectOverlay;
   import replay.ReplayCourse;

   public class RaceReconnectController
   {
      private static var activeGame:Game = null;
      private static var overlay:RaceReconnectOverlay = null;
      private static var pendingLoginPopup:LoggingInPopup = null;
      private static var resumeDescriptor:Object = null;
      private static var resumeTimeout:uint = 0;
      private static var reconnectAttempt:Boolean = false;
      private static var waitingForResume:Boolean = false;

      public function RaceReconnectController()
      {
         super();
      }

      public static function isActive() : Boolean
      {
         return getTrackedGame() != null;
      }

      public static function isInputBlocked() : Boolean
      {
         activeGame = getTrackedGame();
         return activeGame != null && activeGame.isReconnectModeActive();
      }

      public static function handleSocketClosed(socket:PR2Socket, event:Event) : Boolean
      {
         var currentPage:* = Main.pageHolder != null ? Main.pageHolder.getCurrentPage() : null;
         var game:Game = currentPage as Game;
         activeGame = getTrackedGame();
         if(game == null || currentPage is ReplayCourse)
         {
            return false;
         }
         if(!game.canReconnectRace())
         {
            return false;
         }
         if(activeGame == null)
         {
            activeGame = game;
            activeGame.enterReconnectMode();
            ensureOverlay();
            overlay.setStatus("Disconnected from server.",true);
            reconnectAttempt = false;
            waitingForResume = false;
            resumeDescriptor = null;
            return true;
         }
         if(activeGame == game)
         {
            reconnectAttempt = false;
            waitingForResume = false;
            clearResumeTimeout();
            if(pendingLoginPopup != null)
            {
               pendingLoginPopup.startFadeOut();
               pendingLoginPopup = null;
            }
            ensureOverlay();
            overlay.setStatus("Reconnect failed.",true);
            return true;
         }
         return false;
      }

      public static function handleSocketError() : Boolean
      {
         if(!isActive())
         {
            return false;
         }
         reconnectAttempt = false;
         waitingForResume = false;
         clearResumeTimeout();
         ensureOverlay();
         overlay.setStatus("Reconnect failed.",true);
         return true;
      }

      public static function requestReconnect() : void
      {
         activeGame = getTrackedGame();
         if(activeGame == null || reconnectAttempt)
         {
            return;
         }
         reconnectAttempt = true;
         waitingForResume = false;
         resumeDescriptor = null;
         ensureOverlay();
         overlay.setStatus("Reconnecting...",false);
         new ConnectingPopup(true);
      }

      public static function beginReconnectLogin(popup:LoggingInPopup) : Boolean
      {
         activeGame = getTrackedGame();
         if(activeGame == null)
         {
            return false;
         }
         pendingLoginPopup = popup;
         waitingForResume = true;
         reconnectAttempt = true;
         if(resumeDescriptor != null)
         {
            sendResumeState();
            return true;
         }
         clearResumeTimeout();
         resumeTimeout = setTimeout(onResumeTimeout,5000);
         return true;
      }

      public static function handleResumeRace(data:Array) : void
      {
         if(data == null || data.length <= 0)
         {
            return;
         }
         try
         {
            resumeDescriptor = JSON.parse(String(data[0]));
         }
         catch(e:Error)
         {
            abortToLobby("Unable to resume race.");
            return;
         }
         if(waitingForResume && getTrackedGame() != null)
         {
            sendResumeState();
         }
      }

      public static function handleResumeRaceSnapshot(data:Array) : void
      {
         var game:Game = null;
         var snapshot:Object = null;
         var snapshotPayload:String = null;
         game = getTrackedGame();
         if(game == null || data == null || data.length <= 0)
         {
            return;
         }
         try
         {
            snapshotPayload = decodeResumePayload(String(data[0]));
            snapshot = JSON.parse(snapshotPayload);
         }
         catch(e:Error)
         {
            abortToLobby("Unable to sync race state.");
            return;
         }
         if(!game.applyReconnectSnapshot(snapshot))
         {
            abortToLobby("This reconnect does not match the cached race.");
         }
      }

      public static function handleResumeRaceEvents(data:Array) : void
      {
         var game:Game = null;
         var events:Array = null;
         var eventsPayload:String = null;
         game = getTrackedGame();
         if(game == null || data == null || data.length <= 0)
         {
            return;
         }
         try
         {
            eventsPayload = decodeResumePayload(String(data[0]));
            events = JSON.parse(eventsPayload) as Array;
         }
         catch(e:Error)
         {
            abortToLobby("Unable to replay missed race events.");
            return;
         }
         game.applyReconnectEvents(events);
         game.finishReconnectResume();
         if(pendingLoginPopup != null)
         {
            pendingLoginPopup.startFadeOut();
            pendingLoginPopup = null;
         }
         if(overlay != null)
         {
            overlay.startFadeOut();
            overlay = null;
         }
         reconnectAttempt = false;
         waitingForResume = false;
         resumeDescriptor = null;
         clearResumeTimeout();
         activeGame = null;
      }

      public static function handleResumeRaceRejected(data:Array) : void
      {
         var message:String = "Reconnect expired.";
         if(data != null && data.length > 0 && data[0] != null && data[0] != "")
         {
            message = String(data[0]);
         }
         abortToLobby(message);
      }

      public static function leaveRace() : void
      {
         clearResumeTimeout();
         resumeDescriptor = null;
         reconnectAttempt = false;
         waitingForResume = false;
         pendingLoginPopup = null;
         if(overlay != null)
         {
            overlay.startFadeOut();
            overlay = null;
         }
         if(Main.socket != null)
         {
            Main.socket.remove();
         }
         if(Main.pageHolder != null)
         {
            Main.pageHolder.changePage(new LoginPage());
         }
         activeGame = null;
      }

      public static function clearForGame(game:Game) : void
      {
         if(activeGame !== game)
         {
            return;
         }
         clearResumeTimeout();
         reconnectAttempt = false;
         waitingForResume = false;
         resumeDescriptor = null;
         pendingLoginPopup = null;
         if(overlay != null)
         {
            overlay.remove();
            overlay = null;
         }
         activeGame = null;
      }

      public static function onReconnectLoginFailed() : void
      {
         reconnectAttempt = false;
         waitingForResume = false;
         clearResumeTimeout();
         ensureOverlay();
         overlay.setStatus("Reconnect failed.",true);
      }

      private static function sendResumeState() : void
      {
         var game:Game = getTrackedGame();
         if(game == null || resumeDescriptor == null)
         {
            return;
         }
         clearResumeTimeout();
         if(!game.matchesReconnectDescriptor(resumeDescriptor))
         {
            abortToLobby("This reconnect does not match the cached race.");
            return;
         }
         ensureOverlay();
         overlay.setStatus("Synchronizing race...",false);
         Main.socket.write("resume_race_state`" + JSON.stringify(game.buildReconnectResumePayload()));
      }

      private static function onResumeTimeout() : void
      {
         abortToLobby("Reconnect was not available for this race.");
      }

      private static function abortToLobby(message:String) : void
      {
         clearResumeTimeout();
         reconnectAttempt = false;
         waitingForResume = false;
         resumeDescriptor = null;
         activeGame = getTrackedGame();
         if(activeGame != null)
         {
            activeGame.abortReconnectResume();
         }
         if(pendingLoginPopup != null)
         {
            pendingLoginPopup.startFadeOut();
            pendingLoginPopup = null;
         }
         if(Main.socket != null && Main.socket.connected)
         {
            Main.socket.write("set_game_room`none");
         }
         if(overlay != null)
         {
            overlay.startFadeOut();
            overlay = null;
         }
         if(Main.pageHolder != null)
         {
            Main.pageHolder.changePage(new Lobby());
         }
         activeGame = null;
      }

      private static function ensureOverlay() : void
      {
         if(overlay == null)
         {
            overlay = new RaceReconnectOverlay();
         }
      }

      private static function clearResumeTimeout() : void
      {
         if(resumeTimeout != 0)
         {
            clearTimeout(resumeTimeout);
            resumeTimeout = 0;
         }
      }

      private static function getTrackedGame() : Game
      {
         var currentPage:* = null;
         if(activeGame == null)
         {
            return null;
         }
         if(Main.pageHolder == null)
         {
            return activeGame;
         }
         currentPage = Main.pageHolder.getCurrentPage();
         if(currentPage !== activeGame || currentPage is ReplayCourse)
         {
            activeGame = null;
         }
         return activeGame;
      }

      private static function decodeResumePayload(payload:String) : String
      {
         var bytes:ByteArray = null;
         if(payload == null)
         {
            return null;
         }
         if(payload.length > 0 && payload.charAt(0) == "{")
         {
            return payload;
         }
         if(payload.length > 0 && payload.charAt(0) == "[")
         {
            return payload;
         }
         bytes = Base64.decodeToByteArray(payload);
         bytes.position = 0;
         return bytes.readUTFBytes(bytes.length);
      }
   }
}
