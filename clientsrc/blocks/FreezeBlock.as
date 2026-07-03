package blocks
{
   import com.jiggmin.data.*;
   import flash.geom.ColorTransform;
   import flash.utils.*;
   import package_8.LocalCharacter;

   public class FreezeBlock extends Block
   {
      private var cooldownTimer:uint = 0;
      private var cooldownMs:int = 2000;
      private static var cooldownColor:ColorTransform = new ColorTransform(0.5, 0.5, 0.5);
      private static var normalColor:ColorTransform = new ColorTransform();

      public function FreezeBlock()
      {
         super(Objects.BLOCK_FREEZE);
         safeStand = false;
      }

      private function isOnCooldown():Boolean
      {
         return this.cooldownTimer != 0;
      }

      private function startCooldown():void
      {
         transform.colorTransform = cooldownColor;
         clearTimeout(this.cooldownTimer);
         this.cooldownTimer = setTimeout(this.endCooldown, this.cooldownMs);
      }

      private function endCooldown():void
      {
         clearTimeout(this.cooldownTimer);
         this.cooldownTimer = 0;
         transform.colorTransform = normalColor;
      }

      private function applyBounce(lc:LocalCharacter):void
      {
         var dx:Number = lc.x - (x + 15);
         var dy:Number = (lc.y - lc.var_325 / 2) - (y + 15);
         var ang:Number = Math.atan2(dy, dx);
         var power:Number = 8; // gentle knockback
         lc.velX += Math.cos(ang) * power;
         lc.velY += Math.sin(ang) * power;
      }

      private function doFreeze(lc:LocalCharacter):void
      {
         if (!frozen && !this.isOnCooldown())
         {
            lc.freeze2();
            lc.var_240 = 0;
            this.applyBounce(lc);
            this.startCooldown();
         }
      }

      override public function onStand(lc:LocalCharacter) : *
      {
         super.onStand(lc);
         this.doFreeze(lc);
      }

      override public function onBump(lc:LocalCharacter) : *
      {
         super.onBump(lc);
         this.doFreeze(lc);
      }

      override public function onLeftHit(lc:LocalCharacter) : *
      {
         super.onLeftHit(lc);
         this.doFreeze(lc);
      }

      override public function onRightHit(lc:LocalCharacter) : *
      {
         super.onRightHit(lc);
         this.doFreeze(lc);
      }

      override public function remove() : *
      {
         clearTimeout(this.cooldownTimer);
         transform.colorTransform = normalColor;
         super.remove();
      }
   }
}
