package com.jiggmin.data
{
   import com.hurlant.crypto.hash.*;
   import com.hurlant.util.*;
   import flash.events.*;
   import menu.*;
   import replay.ReplayManager;
   import package_18.*;
   import package_22.*;
   import package_4.*;
   import package_6.*;
   
   public class CommandHandler
   {
      
      public static var commandHandler:CommandHandler;
       
      
      private var EOL:String;
      
      private var inBuffer:String = "";
      
      private var commands:Object;
      
      private var md5:MD5;
      
      public var sendNum:int = -1;
      
      public function CommandHandler()
      {
         this.EOL = String.fromCharCode(4);
         this.commands = new Object();
         this.md5 = new MD5();
         super();
         CommandHandler.commandHandler = this;
         this.defineCommand("message",this.message);
         this.defineCommand("setRank",this.setRank);
         this.defineCommand("setGroup",this.setGroup);
         this.defineCommand("startGame",this.startGame);
         this.defineCommand("resend",this.resend);
         this.defineCommand("pmNotify",this.pmNotify);
         this.defineCommand("becomeSpecialUser",this.becomeSpecialUser);
         this.defineCommand("becomePrizer",this.becomePrizer);
         this.defineCommand("demotePrizer",this.demotePrizer);
         this.defineCommand("becomeTempMod",this.becomeTempMod);
         this.defineCommand("becomeTrialMod",this.becomeTrialMod);
         this.defineCommand("becomeFullMod",this.becomeFullMod);
         this.defineCommand("demoteMod",this.demoteMod);
         this.defineCommand("areYouHuman",this.areYouHuman);
         this.defineCommand("tournamentMode",this.tournamentMode);
         this.defineCommand("guildChange",this.guildChange);
         this.defineCommand("setServerOwner",this.setServerOwner);
         this.defineCommand("wearingHat",this.wearingHat);
         this.defineCommand("resumeRace",RaceReconnectController.handleResumeRace);
         this.defineCommand("resumeRaceSnapshot",RaceReconnectController.handleResumeRaceSnapshot);
         this.defineCommand("resumeRaceEvents",RaceReconnectController.handleResumeRaceEvents);
         this.defineCommand("resumeRaceRejected",RaceReconnectController.handleResumeRaceRejected);
      }
      
      public function addText(param1:String) : *
      {
         var _loc3_:String = null;
         this.inBuffer += param1;
         var _loc2_:Number = Number(this.inBuffer.indexOf(this.EOL));
         while(_loc2_ != -1)
         {
            _loc3_ = String(this.inBuffer.substring(0,_loc2_));
            this.inBuffer = this.inBuffer.substr(_loc2_ + 1);
            if(Main.testing == true)
            {
               trace("Read: " + _loc3_);
            }
            this.handleResponse(_loc3_);
            _loc2_ = Number(this.inBuffer.indexOf(this.EOL));
         }
      }
      
      private function handleResponse(param1:String) : *
      {
         var _loc2_:Array = param1.split("`");
         var _loc3_:String = String(_loc2_[0]);
         var _loc4_:int = int(_loc2_[1]);
         var _loc5_:String = String(_loc2_[2]);
         _loc2_.splice(0,3);
         var _loc6_:String = class_4.method_310(Main.server.server_id) + _loc4_ + "`" + _loc5_ + "`" + _loc2_.join("`");
         var _loc7_:String;
         if((_loc7_ = String(Hex.fromArray(this.md5.hash(Hex.toArray(Hex.fromString(_loc6_)))).substr(0,3))) == _loc3_ && _loc4_ > this.sendNum)
         {
            this.sendNum = _loc4_;
            if(this.commands[_loc5_] != null)
            {
               this.commands[_loc5_](_loc2_);
            }
         }
      }

      public function dispatchDirect(param1:String, param2:Array) : Boolean
      {
         if(!ReplayManager.isActive)
         {
            return false;
         }
         var _loc3_:Function = this.commands[param1];
         if(_loc3_ != null)
         {
            _loc3_(param2);
            return true;
         }
         return false;
      }

      public function dispatchDirectUnsafe(param1:String, param2:Array) : Boolean
      {
         var _loc3_:Function = this.commands[param1];
         if(_loc3_ != null)
         {
            _loc3_(param2);
            return true;
         }
         return false;
      }

      public function dispatchPacketPayload(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         if(param1 == null || param1.length == 0)
         {
            return false;
         }
         _loc2_ = param1.split("`");
         if(_loc2_.length == 0)
         {
            return false;
         }
         _loc3_ = String(_loc2_.shift());
         return this.dispatchDirectUnsafe(_loc3_,_loc2_);
      }

      public function dispatchManyDirect(param1:Array) : int
      {
         if(!ReplayManager.isActive || param1 == null)
         {
            return 0;
         }
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            var _loc4_:Object = param1[_loc3_];
            if(_loc4_ != null && _loc4_.cmd != null)
            {
               if(this.dispatchDirect(String(_loc4_.cmd),_loc4_.args as Array))
               {
                  _loc2_++;
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function defineCommand(param1:String, param2:Function) : *
      {
         this.commands[param1] = param2;
      }
      
      public function resend(param1:Array) : *
      {
         if(Main.socket.sendNum < int(param1[0]))
         {
            Main.socket.close();
         }
      }
      
      private function message(param1:Array) : *
      {
         new MessagePopup(param1[0]);
      }
      
      private function startGame(param1:Array) : *
      {
         if(replay.ReplayManager.isActive)
         {
            return;
         }
         var _loc2_:String = (param1[0]);
         if(Main.filledSlotCourseID == _loc2_)
         {
            Main.pageHolder.changePage(new Game(_loc2_,Main.filledSlotCourseVersion));
         }
      }
      
      private function setRank(param1:Array) : *
      {
         var _loc2_:int = int(param1[0]);
         class_33.setNumber("userRank",_loc2_);
         if(Main.instance.kongAPI != null)
         {
            Main.instance.kongAPI.stats.submit("Rank",_loc2_);
         }
      }
      
      private function setGroup(param1:Array) : *
      {
         Main.group = param1[0];
      }
      
      private function pmNotify(param1:Array) : *
      {
         UnreadNotif.notifyUser(int(param1[0]));
      }
      
      private function becomeSpecialUser(param1:Array) : *
      {
         Main.isSpecialUser = true;
      }
      
      private function becomePrizer(param1:Array) : *
      {
         Main.isPrizer = true;
      }
      
      private function demotePrizer(param1:Array) : *
      {
         Main.isPrizer = false;
      }
      
      private function becomeTempMod(param1:Array) : *
      {
         Main.group = 1;
         Main.isTempMod = true;
         Main.isTrialMod = false;
      }
      
      private function becomeTrialMod(param1:Array) : *
      {
         Main.group = 2;
         Main.isTempMod = false;
         Main.isTrialMod = true;
      }
      
      private function becomeFullMod(param1:Array) : *
      {
         Main.group = 2;
         Main.isTempMod = false;
         Main.isTrialMod = false;
      }
      
      private function demoteMod(param1:Array) : *
      {
         Main.group = 1;
         Main.isTempMod = false;
         Main.isTrialMod = false;
      }
      
      private function areYouHuman(param1:Array) : *
      {
         new CatCaptcha();
      }
      
      private function tournamentMode(param1:Array) : *
      {
         Main.server.tournament = Boolean(int(param1[0]));
      }
      
      private function guildChange(param1:Array) : *
      {
         var _loc2_:Object = JSON.parse(param1[0]);
         Main.guild = _loc2_.guild_id;
         Main.guildName = _loc2_.guild_name;
         Main.guildOwner = _loc2_.is_owner;
         Main.instance.dispatchEvent(new Event(Main.accountChange));
      }
      
      private function setServerOwner(param1:Array) : *
      {
         Main.server.server_owner = int(param1[0]);
      }
      
      private function wearingHat(param1:Array) : *
      {
         AccountInfo.currentHat = int(param1[0]);
         if(LevelListing.levelListing != null)
         {
            LevelListing.levelListing.dispatchEvent(new Event("testLevelAccess"));
         }
      }
   }
}
