package com.jiggmin.data
{
   public class ColorUtil
   {
       
      
      public function ColorUtil()
      {
         super();
      }
      
      public static function hsbToRGB(param1:Number, param2:Number, param3:Number) : Object
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         param1 %= 360;
         if(param3 == 0)
         {
            return {
               "red":0,
               "green":0,
               "blue":0
            };
         }
         param2 /= 100;
         param3 /= 100;
         param1 /= 60;
         var _loc7_:Number = Math.floor(param1);
         var _loc8_:Number = param1 - _loc7_;
         var _loc9_:Number = param3 * (1 - param2);
         var _loc10_:Number = param3 * (1 - param2 * _loc8_);
         var _loc11_:Number = param3 * (1 - param2 * (1 - _loc8_));
         switch(_loc7_)
         {
            case 0:
               _loc4_ = param3;
               _loc5_ = _loc11_;
               _loc6_ = _loc9_;
               break;
            case 1:
               _loc4_ = _loc10_;
               _loc5_ = param3;
               _loc6_ = _loc9_;
               break;
            case 2:
               _loc4_ = _loc9_;
               _loc5_ = param3;
               _loc6_ = _loc11_;
               break;
            case 3:
               _loc4_ = _loc9_;
               _loc5_ = _loc10_;
               _loc6_ = param3;
               break;
            case 4:
               _loc4_ = _loc11_;
               _loc5_ = _loc9_;
               _loc6_ = param3;
               break;
            case 5:
               _loc4_ = param3;
               _loc5_ = _loc9_;
               _loc6_ = _loc10_;
         }
         return {
            "red":Math.round(_loc4_ * 255),
            "green":Math.round(_loc5_ * 255),
            "blue":Math.round(_loc6_ * 255)
         };
      }
      
      public static function rgbToHSB(param1:Number, param2:Number, param3:Number) : Object
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = Math.min(Math.min(param1,param2),param3);
         var _loc6_:Number;
         var _loc7_:Number = (_loc6_ = Math.max(Math.max(param1,param2),param3)) - _loc5_;
         var _loc8_:Number;
         if((_loc8_ = _loc6_ == 0 ? 0 : _loc7_ / _loc6_) == 0)
         {
            _loc4_ = 0;
         }
         else
         {
            if(param1 == _loc6_)
            {
               _loc4_ = 60 * (param2 - param3) / _loc7_;
            }
            else if(param2 == _loc6_)
            {
               _loc4_ = 120 + 60 * (param3 - param1) / _loc7_;
            }
            else
            {
               _loc4_ = 240 + 60 * (param1 - param2) / _loc7_;
            }
            if(_loc4_ < 0)
            {
               _loc4_ += 360;
            }
         }
         _loc8_ *= 100;
         _loc6_ = _loc6_ / 255 * 100;
         return {
            "hue":_loc4_,
            "saturation":_loc8_,
            "brightness":_loc6_
         };
      }
      
      public static function rgbToHex24(param1:int, param2:int, param3:int) : uint
      {
         return param1 << 16 | param2 << 8 | param3;
      }
      
      public static function hex24ToRGB(param1:Number) : Object
      {
         return {
            "red":param1 >> 16 & 255,
            "green":param1 >> 8 & 255,
            "blue":param1 & 255
         };
      }
      
      public static function argbToHex32(param1:int, param2:int, param3:int, param4:int) : uint
      {
         return param4 << 24 | param1 << 16 | param2 << 8 | param3;
      }
      
      public static function hex32ToARGB(param1:Number) : Object
      {
         return {
            "alpha":param1 >> 24 & 255,
            "red":param1 >> 16 & 255,
            "green":param1 >> 8 & 255,
            "blue":param1 & 255
         };
      }
      
      public static function hex24ToHSB(param1:Number) : Object
      {
         var _loc2_:Object = hex24ToRGB(param1);
         return rgbToHSB(_loc2_.red,_loc2_.green,_loc2_.blue);
      }
      
      public static function hsbToHex24(param1:Number, param2:Number, param3:Number) : Number
      {
         var _loc4_:Object = ColorUtil.hsbToRGB(param1,param2,param3);
         return ColorUtil.rgbToHex24(_loc4_.red,_loc4_.green,_loc4_.blue);
      }
      
      public static function decimalToHex(param1:Number) : String
      {
         var _loc2_:String = param1.toString(16).toUpperCase();
         while(_loc2_.length < 6)
         {
            _loc2_ = "0" + _loc2_;
         }
         return "0x" + _loc2_;
      }
   }
}
