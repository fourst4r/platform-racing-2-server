package items
{
   import flash.utils.*;
   import package_8.LocalCharacter;
   
   public class SpeedBurst extends Item
   {
       
      
      private var expireListener:uint;
      
      private var used:Boolean = false;
      
      public var duration:Number = 5000;
      
      public function SpeedBurst(param1:LocalCharacter)
      {
         super(param1);
      }
      
      override public function useItem() : *
      {
         if(!this.used)
         {
            this.used = true;
            this.expireListener = setTimeout(this.slowDown,this.duration);
            character.accel *= 2;
            character.maxVelX *= 2;
            character.beginSparkles(this.duration);
         }
      }
      
      public function isUsed() : *
      {
         return this.used;
      }
      
      private function slowDown() : *
      {
         character.setItem(0);
      }
      
      override public function remove() : *
      {
         character.endSparkles(this.used);
         character.resetStats();
         clearTimeout(this.expireListener);
         super.remove();
      }
   }
}
