package com.jiggmin.data
{
   import flash.events.*;
   import package_4.*;
   
   public class HTMLNameMaker
   {
       
      
      private var array:Array;
      
      public function HTMLNameMaker()
      {
         this.array = new Array();
         super();
      }
      
      public function makeName(userName:String, groupInfo:String, displayName:String = "", sourceIs8P:Boolean = false) : String
      {
         var _loc7_:String = null;
         var _loc4_:Array = groupInfo.split(",");
         var _loc5_:int = int(_loc4_[0]);
         var _loc6_:String = !_loc4_[1] ? null : String(_loc4_[1]);
         if(_loc5_ === 1)
         {
            if(_loc6_ == 1)
            {
               _loc7_ = "BC9055";
            }
            else
            {
               _loc7_ = "047B7B";
            }
         }
         else if(_loc5_ === 2)
         {
            if(_loc6_ == 0)
            {
               _loc7_ = "006400";
            }
            else if(_loc6_ == 1)
            {
               _loc7_ = "0092FF";
            }
            else
            {
               _loc7_ = "1C369F";
            }
         }
         else if(_loc5_ === 3)
         {
            _loc7_ = "870A6F";
         }
         else
         {
            _loc7_ = "676666";
         }
         if(_loc6_ === "*")
         {
            _loc7_ = "83C141";
         }
         // different color name to differentiate an 8p level
         if(sourceIs8P)
         {
            _loc7_ = "bc5555";
         }
         if(displayName == "")
         {
            displayName = userName;
         }
         userName = String(Data.cleanHTML(userName));
         displayName = String(Data.cleanHTML(displayName));
         return "<u><font color=\"#" + _loc7_ + "\"><a href=\"event:user`" + groupInfo + "`" + userName + "`0`" + int(sourceIs8P) + "\">" + displayName + "</a></font></u>";
      }
      
      public function makeGuild(param1:String, param2:int) : String
      {
         param1 = String(Data.escapeString(param1));
         return "<u><font color=\"#0000FF\"><a href=\"event:guild`" + param2 + "\">" + param1 + "</a></font></u>";
      }
      
      public function makeLevel(param1:String, param2:int) : String
      {
         param1 = String(Data.escapeString(param1));
         return "<u><font color=\"#0000FF\"><a href=\"event:level`" + param2 + "\">" + param1 + "</a></font></u>";
      }
      
      public function makeLink(param1:String, param2:String) : String
      {
         param1 = String(Data.escapeString(param1));
         param2 = String(encodeURI(Data.escapeString(param2)));
         return "<u><font color=\"#0000FF\"><a href=\"event:url`" + param2 + "\">" + param1 + "</a></font></u>";
      }
      
      public function listenForLink(param1:*) : *
      {
         this.array.push(param1);
         param1.addEventListener(TextEvent.LINK,this.clickLink,false,0,true);
      }
      
      private function clickLink(param1:TextEvent) : *
      {
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Boolean = false;
         var _loc8_:* = undefined;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = "";
         var _loc13_:Boolean = false;
         var _loc3_:Array = param1.text.split("`");
         var _loc4_:String;
         if((_loc4_ = String(_loc3_[0])) == "user")
         {
            _loc5_ = String(_loc3_[1]);
            _loc6_ = String(_loc3_[2]);
            _loc7_ = _loc3_.length > 3 && Boolean(int(_loc3_[3]));
            _loc13_ = _loc3_.length > 4 && Boolean(int(_loc3_[4]));
            if(_loc5_.indexOf(",") != -1)
            {
               _loc8_ = _loc5_.split(",");
               if(_loc8_.length > 1)
               {
                  _loc12_ = String(_loc8_[1]);
               }
               _loc5_ = String(int(_loc8_[0]));
            }
            _loc13_ = _loc13_ || this.is8PUserId(_loc12_);
            if(_loc5_ > 0 || _loc7_ || _loc13_)
            {
               new PlayerPopup(_loc6_,_loc13_);
            }
            else
            {
               new PlayerGuestPopup(_loc6_);
            }
         }
         else if(_loc4_ == "guild")
         {
            _loc2_ = int(_loc3_[1]);
            new GuildPopup(_loc2_);
         }
         else if(_loc4_ == "invite")
         {
            _loc2_ = int(_loc3_[1]);
            new GuildJoinPopup(_loc2_);
         }
         else if(_loc4_ == "level")
         {
            _loc9_ = int(_loc3_[1]);
            new LevelInfoPopup(_loc9_);
         }
         else if(_loc4_ == "url")
         {
            _loc10_ = String(_loc3_[1]);
            new ExternalLinkPopup(_loc10_);
         }
         else if(_loc4_ == "discordverify")
         {
            _loc11_ = String(_loc3_[1]);
            new DiscordVerificationPopup(_loc11_);
         }
      }

      private function is8PUserId(userId:String) : Boolean
      {
         return userId != null && userId.indexOf("8p_") == 0;
      }
      
      public function remove() : *
      {
         var _loc3_:* = undefined;
         var _loc1_:int = int(this.array.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.array[_loc2_];
            if(_loc3_ != null)
            {
               _loc3_.removeEventListener(TextEvent.LINK,this.clickLink);
               _loc3_ = null;
            }
            _loc2_++;
         }
         this.array = null;
      }
   }
}
