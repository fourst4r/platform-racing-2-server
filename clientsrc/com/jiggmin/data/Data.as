package com.jiggmin.data
{
   import com.hurlant.crypto.hash.*;
   import com.hurlant.util.*;
   import flash.display.DisplayObject;
   import flash.geom.*;
   import flash.globalization.*;
   
   public class Data
   {
      
      public static const RAD_DEG:Number = 180 / Math.PI;
      
      public static const DEG_RAD:Number = Math.PI / 180;
      
      public static var md5:MD5 = new MD5();
      
      public static var df:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT,DateTimeStyle.MEDIUM,DateTimeStyle.NONE);
      
      private static var groupColors:Array = [["676666"],["047B7B","BC9055"],["006400","0092FF","1C369F"],["870A6F"]];
      
      private static var modGroupColors:Array = new Array("#006400","#0092FF","#1C369F");
      
      private static var damnArray:Array = new Array("dang","dingy-goo","condemnation");
      
      private static var fuckArray:Array = new Array("fooey","fingilly","funk-master","freak monster","jiminy cricket");
      
      private static var shitArray:Array = new Array("shoot","shewet");
      
      private static var niggaArray:Array = new Array("someone cooler than me","ladies magnet","cooler race");
      
      private static var bitchArray:Array = new Array("cooler gender","female dog");
       
      
      public function Data()
      {
         super();
      }
      
      public static function aOrAn(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc2_:String = "a";
         if(param1 != null && param1.length > 0)
         {
            _loc3_ = param1.charAt(0).toLowerCase();
            if(_loc3_ == "a" || _loc3_ == "e" || _loc3_ == "i" || _loc3_ == "o" || _loc3_ == "u")
            {
               _loc2_ = "an";
            }
         }
         return _loc2_;
      }
      
      public static function ucfirst(param1:String) : *
      {
         return param1.substr(0,1).toUpperCase() + param1.substr(1,param1.length).toLowerCase();
      }
      
      public static function getMS() : Number
      {
         var _loc1_:Date = new Date();
         return _loc1_.time;
      }
      
      public static function getTimestamp() : Number
      {
         return Math.round(getMS() / 1000);
      }
      
      public static function formatNumber(param1:Number) : String
      {
         var _loc4_:String = null;
         var _loc2_:String = param1.toString();
         var _loc3_:String = "";
         while(_loc2_.length > 3)
         {
            _loc4_ = _loc2_.substr(-3);
            _loc2_ = _loc2_.substr(0,_loc2_.length - 3);
            _loc3_ = "," + _loc4_ + _loc3_;
         }
         if(_loc2_.length > 0)
         {
            _loc3_ = _loc2_ + _loc3_;
         }
         return _loc3_;
      }
      
      public static function hash(param1:String) : String
      {
         return Hex.fromArray(Data.md5.hash(Hex.toArray(Hex.fromString(param1))));
      }
      
      public static function getDateStr(param1:Number) : String
      {
         var _loc2_:Date = new Date(param1);
         var _loc3_:String = String(Data.getMonthStr(_loc2_.month));
         return _loc3_ + " " + _loc2_.date;
      }
      
      private static function getMonthStr(param1:int) : String
      {
         var _loc2_:Array = new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
         return _loc2_[param1];
      }
      
      public static function getShortDateStr(param1:Number) : *
      {
         var _loc2_:Date = new Date(param1 * 1000);
         return _loc2_.date + "/" + Data.getMonthStr(_loc2_.month) + "/" + _loc2_.getFullYear();
      }
      
      public static function getDateTimeStr(param1:Number, param2:Array = null) : String
      {
         var _loc3_:Date = new Date(param1 * 1000);
         if(param2 != null && param2.length == 2)
         {
            df.setDateTimeStyles(param2[0],param2[1]);
            if(df.lastOperationStatus != LastOperationStatus.NO_ERROR)
            {
               df.setDateTimeStyles(DateTimeStyle.MEDIUM,DateTimeStyle.NONE);
               param2 = null;
            }
         }
         var _loc4_:String = df.format(_loc3_);
         if(param2 != null)
         {
            df.setDateTimeStyles(DateTimeStyle.MEDIUM,DateTimeStyle.NONE);
         }
         return _loc4_;
      }
      
      public static function getLocale() : *
      {
         return df.actualLocaleIDName;
      }
      
      public static function formatTime(param1:Number, param2:String = "seconds") : String
      {
         var _loc3_:Number = Math.floor(param1 / 60);
         var _loc4_:Number = Math.floor(param1 % 60);
         var _loc5_:Number = Math.round(param1 % 1 * 100);
         var _loc6_:String = String(Data.padString(1,"0",_loc3_.toString()));
         var _loc7_:String = String(Data.padString(2,"0",_loc4_.toString()));
         var _loc8_:String = String(Data.padString(2,"0",_loc5_.toString()));
         var _loc9_:String = _loc6_ + ":" + _loc7_;
         if(param2 == "decimal")
         {
            _loc9_ = _loc9_ + "." + _loc8_;
         }
         return _loc9_;
      }
      
      public static function padString(param1:Number, param2:String, param3:String) : String
      {
         while(param3.length < param1)
         {
            param3 = param2 + param3;
         }
         return param3;
      }
      
      public static function escapeAndFilterString(param1:String) : String
      {
         if(param1 != null)
         {
            param1 = String(Data.trimWhitespace(param1));
            param1 = String(Data.cleanHTML(param1));
            param1 = String(Data.filterSwears(param1));
         }
         return param1;
      }
      
      public static function escapeString(param1:String, param2:Boolean = false) : String
      {
         param1 = String(Data.trimWhitespace(param1,param2));
         return String(Data.cleanHTML(param1));
      }
      
      public static function cleanHTML(param1:String) : String
      {
         param1 = param1.replace(/&/gi,"&amp;");
         param1 = param1.replace(/>/gi,"&gt;");
         param1 = param1.replace(/</gi,"&lt;");
         param1 = param1.replace(/'/gi,"&apos;");
         return param1.replace(/"/gi,"&quot;");
      }
      
      public static function trimWhitespace(param1:String, param2:Boolean = false) : String
      {
         param1 = param1 == null ? "" : param1;
         param1 = param1.replace(/^\s+|\s+$/g,"");
         return param2 ? param1.replace(/(\t|\f)/gi," ") : param1.replace(/(\t|\n|\r|\v|\f)/gi," ");
      }
      
      public static function filterSwears(param1:String) : String
      {
         param1 = param1.replace(/damn/gi,Data.randArrayKey(Data.damnArray));
         param1 = param1.replace(/fuck/gi,Data.randArrayKey(Data.fuckArray));
         param1 = param1.replace(/\b(nig(?:g(?:a|er)?)?(?:s)?)\b/gi,Data.randArrayKey(Data.niggaArray));
         param1 = param1.replace(/\b(spic)\b/gi,Data.randArrayKey(Data.niggaArray));
         param1 = param1.replace(/shit/gi,Data.randArrayKey(Data.shitArray));
         param1 = param1.replace(/bitch/gi,Data.randArrayKey(Data.bitchArray));
         param1 = param1.replace(/cunt/gi,Data.randArrayKey(Data.bitchArray));
         return param1.replace(/whore/gi,Data.randArrayKey(Data.bitchArray));
      }
      
      public static function randArrayKey(param1:Array) : String
      {
         return param1[Math.floor(Math.random() * param1.length)];
      }
      
      public static function rand(param1:int, param2:int) : int
      {
         return param1 + Math.floor(Math.random() * (param2 - param1 + 1));
      }
      
      public static function parseLinks(param1:String) : String
      {
         param1 = String(parseUser(param1));
         param1 = String(parseURL(param1));
         param1 = param1.replace(/(\[level=)(\d{1,8})(\])(.+)(\[\/level\])/gi,"<a href=\'event:level`$2\'><u><font color=\'#0000FF\'>$4</font></u></a>");
         param1 = param1.replace(/(\[guild=)(\d{1,6})(\])(.+)(\[\/guild\])/gi,"<a href=\'event:guild`$2\'><u><font color=\'#0000FF\'>$4</font></u></a>");
         param1 = param1.replace(/(\[guildlink=)(\d{1,6})(\])(.+)(\[\/guildlink\])/gi,"<a href=\'event:guild`$2\'><u><font color=\'#0000FF\'>$4</font></u></a>");
         param1 = param1.replace(/(\[invite=)(\d+)(\])(.+)(\[\/invite\])/gi,"<a href=\'event:invite`$2\'><u><font color=\'#0000FF\'>$4</font></u></a>");
         param1 = param1.replace(/(\[invitelink=)(\d+)(\])(.+)(\[\/invitelink\])/gi,"<a href=\'event:invite`$2\'><u><font color=\'#0000FF\'>$4</font></u></a>");
         param1 = param1.replace(/(\[discordverif=)(.+)(\])(.+)(\[\/discordverif\])/gi,"<a href=\'event:discordverify`$2\'><u><font color=\'#0000FF\'>$4</font></u></a>");
         param1 = param1.replace(/(\[color=)(#[0-9a-fA-F]{6})(\])(.+)(\[\/color\])/gi,"<font color=\'$2\'>$4</font>");
         param1 = param1.replace(/(\[b\])(.+)(\[\/b\])/gi,"<b>$2</b>");
         param1 = param1.replace(/(\[bold\])(.+)(\[\/bold\])/gi,"<b>$2</b>");
         param1 = param1.replace(/(\[i\])(.+)(\[\/i\])/gi,"<i>$2</i>");
         param1 = param1.replace(/(\[em\])(.+)(\[\/em\])/gi,"<i>$2</i>");
         param1 = param1.replace(/(\[u\])(.+)(\[\/u\])/gi,"<u>$2</u>");
         param1 = param1.replace(/(\[tiny\])(.+)(\[\/tiny\])/gi,"<font size=\'6\'>$2</font>");
         param1 = param1.replace(/(\[small\])(.+)(\[\/small\])/gi,"<font size=\'9\'>$2</font>");
         param1 = param1.replace(/(\[medium\])(.+)(\[\/medium\])/gi,"<font size=\'12\'>$2</font>");
         param1 = param1.replace(/(\[large\])(.+)(\[\/large\])/gi,"<font size=\'24\'>$2</font>");
         return param1.replace(/(\[big\])(.+)(\[\/big\])/gi,"<font size=\'24\'>$2</font>");
      }
      
      private static function parseUser(param1:String) : String
      {
         var _loc5_:* = undefined;
         var _loc6_:Array = null;
         var _loc2_:String = param1.replace(/(\[user=)(\d{1}(?:\,((\d{1}){0,1}|\*)))(\])([a-zA-Z0-9-.:;=?~!()@*,+$#% ]+)(\[\/user\])/gi,"<a href=\'event:user`$2`$6`1\'><u><font color=\'<*>$2<*>\'>$6</font></u></a>");
         if(param1 == _loc2_)
         {
            return param1;
         }
         var _loc3_:Array = _loc2_.split("<*>");
         var _loc4_:int = 1;
         while(_loc4_ < _loc3_.length)
         {
            if((_loc5_ = _loc3_[_loc4_].split(","))[1] == "*")
            {
               _loc3_[_loc4_] = "83C141";
            }
            else
            {
               _loc6_ = groupColors[numLimit(int(_loc5_[0]),0,groupColors.length)];
               _loc3_[_loc4_] = _loc6_[numLimit(int(_loc5_[1]),0,_loc6_.length)];
            }
            _loc3_[_loc4_] = "#" + _loc3_[_loc4_];
            _loc4_ += 2;
         }
         return _loc3_.join("");
      }
      
      private static function parseURL(param1:String) : String
      {
         var _loc2_:String = param1.replace(/\[[uU][rR][lL]\](https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,4}\b(((?:&amp;)|[-a-zA-Z0-9@:%_\+.~#?&\/=])*))\[\/[uU][rR][lL]\]/g,"<a href=\'event:url`<*>$1<*>\'><u><font color=\'#0000FF\'><*>$1<*></font></u></a>");
         _loc2_ = _loc2_.replace(/\[[uU][rR][lL]=(https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,4}\b(((?:&amp;)|[-a-zA-Z0-9@:%_\+.~#?&\/=])*))\](.+?)\[\/[uU][rR][lL]\]/g,"<a href=\'event:url`$1\'><u><font color=\'#0000FF\'>$5</font></u></a>");
         if(param1 == _loc2_)
         {
            return param1;
         }
         var _loc3_:Array = _loc2_.split("<*>");
         var _loc4_:* = 1;
         while(_loc4_ < _loc3_.length)
         {
            _loc3_[_loc4_] = _loc3_[_loc4_].replace(/(?:&amp;)/gi,"&");
            _loc4_ += 2;
         }
         return _loc3_.join("");
      }
      
      public static function urlify(param1:String, param2:String, param3:String = "#0000FF") : *
      {
         param1 = escapeString(param1);
         param2 = escapeString(param2);
         return "<a href=\"" + param1 + "\" target=\"_blank\"><u><font color=\"" + param3 + "\">" + param2 + "</font></u></a>";
      }
      
      public static function pythag(param1:Number, param2:Number) : Number
      {
         return Math.sqrt(param1 * param1 + param2 * param2);
      }
      
      public static function numLimit(param1:Number, param2:Number, param3:Number) : *
      {
         if(param1 > param3)
         {
            param1 = param3;
         }
         else if(param1 < param2)
         {
            param1 = param2;
         }
         return param1;
      }
      
      public static function method_314(param1:DisplayObject, param2:Number, param3:Number) : *
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = param2 / param1.width;
         var _loc6_:Number = param3 / param1.height;
         if(_loc5_ < _loc6_)
         {
            _loc4_ = _loc5_;
         }
         else
         {
            _loc4_ = _loc6_;
         }
         if(_loc4_ < 1)
         {
            param1.width *= _loc4_;
            param1.height *= _loc4_;
         }
      }
      
      public static function method_9(param1:Number, param2:Number, param3:Number) : Point
      {
         var _loc4_:int = param1;
         var _loc5_:int = param2;
         if(param3 > 180)
         {
            param3 = -360 + param3;
         }
         else if(param3 < -180)
         {
            param3 = 360 + param3;
         }
         if(param3 == 90)
         {
            _loc4_ = param2;
            _loc5_ = -param1;
         }
         else if(Math.abs(param3) == 180)
         {
            _loc4_ = -param1;
            _loc5_ = -param2;
         }
         else if(param3 == -90)
         {
            _loc4_ = -param2;
            _loc5_ = param1;
         }
         return new Point(_loc4_,_loc5_);
      }
      
      public static function method_852(param1:int) : Object
      {
         var _loc2_:Number = 25;
         var _loc3_:Object = new Object();
         if(param1 < _loc2_)
         {
            _loc3_.lowExp = 0;
            _loc3_.highExp = _loc2_;
         }
         else
         {
            while(_loc2_ < param1)
            {
               _loc2_ *= 1.25;
            }
            _loc3_.lowExp = _loc2_ * (1 / 1.25);
            _loc3_.highExp = _loc2_;
         }
         return _loc3_;
      }
      
      public static function method_439(param1:int = 8) : String
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc2_:* = "0123456789_!@#$%&*()-=+/abcdfghjkmnpqrstvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_!@#$%&*()-=+/";
         var _loc3_:int = int(_loc2_.length);
         var _loc4_:* = "";
         while(_loc5_ < param1)
         {
            _loc6_ = int(Math.floor(Math.random() * _loc3_));
            _loc7_ = String(_loc2_.substr(_loc6_,1));
            _loc4_ += _loc7_;
            _loc5_++;
         }
         return _loc4_;
      }
   }
}
