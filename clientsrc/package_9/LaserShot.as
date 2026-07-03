package package_9
{
   import flash.events.*;
   import sounds.*;
   
   public class LaserShot extends ShotEffect
   {
       
      
      private var m:LaserShotGraphic;
      
      public function LaserShot(param1:Number, param2:Number, param3:String, param4:int, param5:int)
      {
         this.m = new LaserShotGraphic();
         var _loc6_:Number = 0;
         if(param3 == "left")
         {
            _loc6_ = 180;
         }
         super(param1,param2,_loc6_,param4,param5,"laser");
         method_62(29);
         addChild(this.m);
         SoundEffects.playGameSound(new LaserSound(),param1,param2,1.5);
      }
      
      override protected function hitAnything() : *
      {
         super.hitAnything();
         this.m.gotoAndPlay("hit");
         method_2(18);
         SoundEffects.playGameSound(new LaserHitSound(),x,y,1.5);
         removeEventListener(Event.ENTER_FRAME,method_152);
      }
      
      override public function remove() : *
      {
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
