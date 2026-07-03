package package_9
{
   import sounds.*;
   
   public class TeleportPop extends Effect
   {
       
      
      private var m:TeleportAnimation;
      
      public function TeleportPop(param1:Number, param2:Number)
      {
         this.m = new TeleportAnimation();
         super(param1,param2);
         addChild(this.m);
         method_2(15);
         SoundEffects.playGameSound(new TeleportSound(),param1,param2,0.66);
      }
      
      override public function remove() : *
      {
         removeChild(this.m);
         this.m.stop();
         this.m = null;
         super.remove();
      }
   }
}
