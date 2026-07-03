package replay
{
   import flash.events.IOErrorEvent;
   import flash.events.Event;
   import flash.net.FileFilter;
   import flash.net.FileReference;
   import package_4.LevelInfoPopup;
   import package_4.MessagePopup;

   public class ReplayManager
   {
      public static var isActive:Boolean = false;

      private static var loader:ReplayLoader;
      private static var currentSession:ReplaySession;
      private static var pendingReplayId:String;
      private static var pendingLevelId:String;
      private static var pendingIsPr2Hub:Boolean;
      private static var pendingAllowLevelInfo:Boolean = true;
      private static var loading:Boolean = false;
      private static var fileRef:FileReference;

      public function ReplayManager()
      {
      }

      public static function playReplay(param1:String, param2:String, param3:Boolean) : void
      {
         if(loading)
         {
            return;
         }
         if(isActive)
         {
            stop(false);
         }
         loading = true;
         pendingReplayId = param1;
         pendingLevelId = param2;
         pendingIsPr2Hub = param3;
         pendingAllowLevelInfo = true;
         loader = new ReplayLoader();
         loader.loadById(param1,onReplayLoaded,onReplayError);
      }

      public static function promptReplayFile() : void
      {
         if(loading)
         {
            return;
         }
         if(isActive)
         {
            stop(false);
         }
         loading = true;
         pendingAllowLevelInfo = false;
         fileRef = new FileReference();
         fileRef.addEventListener(Event.SELECT,onReplayFileSelected,false,0,true);
         fileRef.addEventListener(Event.CANCEL,onReplayFileCanceled,false,0,true);
         fileRef.addEventListener(Event.COMPLETE,onReplayFileLoaded,false,0,true);
         fileRef.addEventListener(IOErrorEvent.IO_ERROR,onReplayFileError,false,0,true);
         fileRef.browse([new FileFilter("Replay Files","*.pr2r"), new FileFilter("All Files","*.*")]);
      }

      private static function onReplayLoaded(param1:ReplayData) : void
      {
         loading = false;
         if(param1 == null)
         {
            new MessagePopup("Failed to parse replay.");
            return;
         }
         if(pendingLevelId == null || pendingLevelId == "")
         {
            pendingLevelId = resolveLevelId(param1.meta);
            if(pendingLevelId != null && pendingLevelId != "")
            {
               pendingIsPr2Hub = pendingLevelId.indexOf("8p_") != 0;
            }
         }
         startReplayFromData(param1,pendingLevelId,pendingIsPr2Hub,pendingAllowLevelInfo);
      }

      private static function onReplayError(param1:IOErrorEvent) : void
      {
         loading = false;
         new MessagePopup("Unable to load replay. " + (param1 != null ? param1.text : ""));
      }

      private static function onReplayFileSelected(param1:Event) : void
      {
         if(fileRef != null)
         {
            fileRef.load();
         }
      }

      private static function onReplayFileLoaded(param1:Event) : void
      {
         loading = false;
         var data:ReplayData = null;
         try
         {
            data = ReplayLoader.parseBytes(fileRef.data);
         }
         catch(error:Error)
         {
            new MessagePopup("Unable to read replay file. " + error.message);
            cleanupFileRef();
            return;
         }
         cleanupFileRef();
         var levelId:String = resolveLevelId(data != null ? data.meta : null);
         var isPr2Hub:Boolean = levelId != null && levelId.indexOf("8p_") != 0;
         startReplayFromData(data,levelId,isPr2Hub,false);
      }

      private static function onReplayFileError(param1:IOErrorEvent) : void
      {
         loading = false;
         cleanupFileRef();
         new MessagePopup("Unable to read replay file. " + (param1 != null ? param1.text : ""));
      }

      private static function onReplayFileCanceled(param1:Event) : void
      {
         loading = false;
         cleanupFileRef();
      }

      private static function cleanupFileRef() : void
      {
         if(fileRef != null)
         {
            try
            {
               fileRef.removeEventListener(Event.SELECT,onReplayFileSelected);
               fileRef.removeEventListener(Event.CANCEL,onReplayFileCanceled);
               fileRef.removeEventListener(Event.COMPLETE,onReplayFileLoaded);
               fileRef.removeEventListener(IOErrorEvent.IO_ERROR,onReplayFileError);
            }
            catch(error:Error) {}
            fileRef = null;
         }
      }

      private static function startReplayFromData(replayData:ReplayData, levelId:String, isPr2Hub:Boolean, allowLevelInfo:Boolean) : void
      {
         if(replayData == null)
         {
            new MessagePopup("Failed to parse replay.");
            return;
         }
         if(levelId == null || levelId == "")
         {
            new MessagePopup("Replay is missing level information.");
            return;
         }
         if(LevelInfoPopup.instance != null)
         {
            LevelInfoPopup.instance.startFadeOut();
         }
         isActive = true;
         currentSession = new ReplaySession();
         currentSession.start(replayData,levelId,isPr2Hub,allowLevelInfo);
      }

      private static function resolveLevelId(param1:Object) : String
      {
         if(param1 == null)
         {
            return "";
         }
         if(param1.level_id != null)
         {
            return String(param1.level_id);
         }
         if(param1.levelId != null)
         {
            return String(param1.levelId);
         }
         if(param1.level != null)
         {
            if(param1.level.level_id != null)
            {
               return String(param1.level.level_id);
            }
            if(param1.level.id != null)
            {
               return String(param1.level.id);
            }
         }
         return "";
      }

      public static function stop(param1:Boolean = true) : void
      {
         if(!isActive && !loading)
         {
            return;
         }
         loading = false;
         cleanupFileRef();
         if(currentSession != null)
         {
            currentSession.stop();
            currentSession.disposeCourse();
            if(param1)
            {
               currentSession.reopenLevelInfo();
            }
            currentSession = null;
         }
         if(loader != null)
         {
            loader = null;
         }
         isActive = false;
      }
   }
}

