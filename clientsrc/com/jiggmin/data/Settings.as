package com.jiggmin.data
{
   import flash.net.*;
   
   public class Settings
   {
      public static const PRESETS:String = "presets";
      public static const DISABLED_SONGS:String = "disabledSongs";
      public static const MUSIC_VOLUME:String = "musicLevel";
      public static const SOUND_VOLUME:String = "soundLevel";
      public static const DRAW_ART:String = "drawArt";
      public static const ART_LOSSLESS_QUALITY:String = "losslessQuality";
      public static const FPS_30:String = "fps30";
      public static const ALTERNATE_CONTROLS:String = "altCtrl";
      public static const LE_TEST_STATS:String = "leTestStats";
      public static const LE_TEST_HAT:String = "leTestHat";
      public static const HQ_REPLAYS:String = "hqReplays";
      public static const SHOW_HIDDEN_REPLAYS:String = "showHiddenReplays";
      
      public static const DEFAULT_ALT_CONTROLS:Object = {
         "up":87,
         "right":68,
         "down":83,
         "left":65,
         "item":73
      };
      
      public static const DEFAULT_LE_TEST_STATS:Object = {
         "speed":50,
         "acceleration":50,
         "jumping":50
      };
      
      private static const SETTINGS:Array = [
         PRESETS,
         DISABLED_SONGS,
         MUSIC_VOLUME,
         SOUND_VOLUME,
         DRAW_ART,
         ART_LOSSLESS_QUALITY,
         FPS_30,
         ALTERNATE_CONTROLS,
         LE_TEST_STATS,
         LE_TEST_HAT,
         HQ_REPLAYS,
         SHOW_HIDDEN_REPLAYS
      ];
      
      private static var presets:Object = null;
      public static var disabledSongs:Array = [];
      public static var musicLevel:int = 100;
      public static var soundLevel:int = 100;
      private static var drawArt:Boolean = true;
      private static var losslessQuality:Boolean = false;
      private static var filterSwears:Boolean = true;
      
      private static var altCtrl:Object = {
         "up":87,
         "right":68,
         "down":83,
         "left":65,
         "item":73
      };
      
      private static var leTestStats:Object = {
         "speed":50,
         "acceleration":50,
         "jumping":50
      };
      
      private static var leTestHat:int = 2;
      private static var hqReplays:Boolean = true;
      private static var showHiddenReplays:Boolean = false;
      private static var userName:String;
      private static var dataArr:Object;
      
      public static function init(param1:String = "") : *
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         userName = "pr2_" + param1.replace(/\W+/g,"");
         dataArr = new Object();
         var _loc2_:SharedObject = SharedObject.getLocal(userName);
         for(_loc3_ in _loc2_.data)
         {
            Settings[_loc3_] = dataArr[_loc3_] = _loc2_.data[_loc3_];
         }
         for(_loc4_ in SETTINGS)
         {
            if(dataArr[_loc4_] == null && Settings[_loc4_] != null)
            {
               dataArr[_loc4_] = Settings[_loc4_];
            }
         }
      }
      
      public static function clear() : *
      {
         userName = null;
         dataArr = null;
      }
      
      private static function handleControls(param1:Object) : *
      {
         var _loc3_:String = null;
         if(!canSaveCookie())
         {
            return;
         }
         var _loc2_:SharedObject = SharedObject.getLocal(userName);
         _loc2_.data.altCtrl = _loc2_.data.altCtrl == null ? DEFAULT_ALT_CONTROLS : _loc2_.data.altCtrl;
         for(_loc3_ in param1)
         {
            _loc2_.data.altCtrl[_loc3_] = altCtrl[_loc3_] = dataArr.altCtrl[_loc3_] = param1[_loc3_];
         }
         _loc2_.flush();
      }
      
      private static function handleStats(param1:Object) : *
      {
         var _loc3_:String = null;
         if(!canSaveCookie())
         {
            return;
         }
         var _loc2_:SharedObject = SharedObject.getLocal(userName);
         _loc2_.data.leTestStats = _loc2_.data.leTestStats == null ? DEFAULT_LE_TEST_STATS : _loc2_.data.leTestStats;
         for(_loc3_ in param1)
         {
            _loc2_.data.leTestStats[_loc3_] = leTestStats[_loc3_] = dataArr.leTestStats[_loc3_] = param1[_loc3_];
         }
         _loc2_.flush();
      }
      
      public static function isNameSet() : Boolean
      {
         return userName != null;
      }
      
      private static function canSaveCookie() : Boolean
      {
         var cookie:SharedObject = null;
         try
         {
            cookie = SharedObject.getLocal(userName);
            cookie.flush();
         }
         catch(e:Error)
         {
            return false;
         }
         return isNameSet();
      }
      
      public static function setValue(param1:String, param2:*) : *
      {
         var _loc3_:SharedObject = null;
         if(param1 == ALTERNATE_CONTROLS)
         {
            handleControls(param2);
         }
         else if(param1 == LE_TEST_STATS)
         {
            handleStats(param2);
         }
         else if(dataArr[param1] != param2 || Settings[param1] != param2)
         {
            Settings[param1] = dataArr[param1] = param2;
            if(canSaveCookie())
            {
               _loc3_ = SharedObject.getLocal(userName);
               _loc3_.data[param1] = param2;
               _loc3_.flush();
            }
         }
      }
      
      public static function getValue(param1:String, param2:* = null) : *
      {
         if(dataArr[param1] == null || Settings[param1] == null)
         {
            if(dataArr[param1] == null && Settings[param1] != null)
            {
               dataArr[param1] = Settings[param1];
            }
            else if(Settings[param1] == null && dataArr[param1] != null)
            {
               Settings[param1] = dataArr[param1];
            }
         }
         if(dataArr[param1] == null)
         {
            Settings[param1] = dataArr[param1] = param2;
         }
         return dataArr[param1];
      }
   }
}
