package package_9
{
   import sounds.*;
   
   public class MineExplode extends Effect
   {
       
      
      private var m:MineExplodeAnimation;
      
      public function MineExplode(param1:Number, param2:Number)
      {
         this.m = new MineExplodeAnimation();
         super();
         x = param1;
         y = param2;
         addChild(this.m);
         method_2(14);
         SoundEffects.playGameSound(new ExplosionSound(),param1,param2);
      }
      
      override public function remove() : *
      {
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
