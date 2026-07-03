package sounds
{
   import com.jiggmin.data.*;
   import flash.media.*;
   import package_6.*;
   
   public class SoundEffects
   {
       
      
      public function SoundEffects()
      {
         super();
      }
      
      public static function playSound(param1:Sound, param2:Number = 1, param3:Number = 0, param4:Number = 0) : SoundChannel
      {
         var _loc5_:SoundTransform = null;
         if(param2 > 0.0001)
         {
            (_loc5_ = new SoundTransform()).volume = param2;
            _loc5_.pan = param3;
            return param1.play(0,param4,_loc5_);
         }
         return null;
      }
      
      public static function playGameSound(param1:Sound, param2:Number, param3:Number, param4:Number = 1, param5:Number = 0, param6:Number = 0) : SoundChannel
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         if(Course.course != null)
         {
            _loc7_ = 700;
            _loc8_ = param2 + Course.course.posX;
            _loc9_ = param3 + Course.course.posY;
            if((_loc10_ = Number(Data.pythag(_loc8_,_loc9_))) > 700)
            {
               _loc10_ = 700;
            }
            _loc11_ = (_loc7_ - _loc10_) / _loc7_;
            param4 *= _loc11_;
            param5 = _loc8_ / _loc7_;
            param5 = Number(Data.numLimit(param5,-_loc7_,_loc7_));
            if(param4 * (Settings.soundLevel / 100) > 0.0001)
            {
               return playSound(param1,param4 * (Settings.soundLevel / 100),param5,param6);
            }
         }
         return null;
      }
   }
}
