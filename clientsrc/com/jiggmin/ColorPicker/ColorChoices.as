package com.jiggmin.ColorPicker
{
   import com.jiggmin.data.*;
   
   public class ColorChoices
   {
       
      
      public function ColorChoices()
      {
         super();
      }
      
      public static function populate() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc1_:Array = makeColorArray(22,12);
         var _loc4_:int = 0;
         while(_loc4_ <= 255)
         {
            _loc6_ = 0;
            _loc7_ = 0;
            while(_loc6_ <= 255)
            {
               _loc8_ = 0;
               _loc9_ = 0;
               while(_loc8_ <= 255)
               {
                  _loc10_ = int(ColorUtil.rgbToHex24(_loc4_,_loc8_,_loc6_));
                  _loc11_ = _loc2_ * 6 + _loc9_ + 4;
                  _loc12_ = _loc3_ * 6 + _loc7_;
                  _loc1_[_loc11_][_loc12_] = _loc10_;
                  _loc8_ += 51;
                  _loc9_++;
               }
               _loc6_ += 51;
               _loc7_++;
            }
            _loc4_ += 51;
            if(++_loc2_ > 2)
            {
               _loc2_ = 0;
               _loc3_++;
            }
            _loc9_ = _loc7_ = 0;
         }
         var _loc5_:int = 0;
         while(_loc5_ < 12)
         {
            _loc1_[0][_loc5_] = ColorPicker.recentColors[_loc5_];
            _loc5_++;
         }
         _loc1_[2][0] = 0;
         _loc1_[2][1] = 3355443;
         _loc1_[2][2] = 6710886;
         _loc1_[2][3] = 10066329;
         _loc1_[2][4] = 13421772;
         _loc1_[2][5] = 16777215;
         _loc1_[2][6] = 16711680;
         _loc1_[2][7] = 65280;
         _loc1_[2][8] = 255;
         _loc1_[2][9] = 16776960;
         _loc1_[2][10] = 65535;
         _loc1_[2][11] = 16711935;
         return _loc1_;
      }
      
      private static function makeColorArray(param1:int, param2:int) : Array
      {
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < param1)
         {
            _loc5_ = [];
            _loc6_ = 0;
            while(_loc6_ < param2)
            {
               _loc5_[_loc6_] = 0;
               _loc6_++;
            }
            _loc3_[_loc4_] = _loc5_;
            _loc4_++;
         }
         return _loc3_;
      }
   }
}
