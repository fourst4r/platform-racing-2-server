package blocks
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.geom.Point;
   import flash.utils.*;
   import package_8.LocalCharacter;
   
   public class VanishBlock extends Block
   {
       
      
      private var var_602:uint;
      
      public function VanishBlock()
      {
         super(Objects.BLOCK_VANISH);
         safeStand = false;
      }
      
      override public function onStand(param1:LocalCharacter) : *
      {
         super.onStand(param1);
         this.activate();
      }
      
      override public function onBump(param1:LocalCharacter) : *
      {
         super.onBump(param1);
         this.activate();
      }
      
      override public function onLeftHit(param1:LocalCharacter) : *
      {
         super.onLeftHit(param1);
         this.activate();
      }
      
      override public function onRightHit(param1:LocalCharacter) : *
      {
         super.onRightHit(param1);
         this.activate();
      }
      
      override public function onDamage(param1:Number) : *
      {
         super.onDamage(param1);
         this.activate();
      }
      
      private function method_594() : *
      {
         var _loc1_:Point = getSeg();
         if(!map.characterOccupiesSpace(_loc1_.x,_loc1_.y))
         {
            alpha = 0.2;
            this.clear();
            addEventListener(Event.ENTER_FRAME,this.method_117,false,0,true);
            active = true;
         }
         else
         {
            active = false;
            this.activate();
         }
      }
      
      private function fadeOut(param1:Event) : *
      {
         alpha -= 0.1;
         if(alpha <= 0)
         {
            alpha = 0;
            active = false;
            this.clear();
            this.var_602 = setTimeout(this.method_594,2000);
         }
      }
      
      private function method_117(param1:Event) : *
      {
         alpha += 0.1;
         if(alpha >= 1)
         {
            alpha = 1;
            this.clear();
         }
      }
      
      override protected function activate(param1:String = "") : *
      {
         if(!frozen)
         {
            this.clear();
            addEventListener(Event.ENTER_FRAME,this.fadeOut,false,0,true);
         }
      }
      
      private function clear() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.fadeOut);
         removeEventListener(Event.ENTER_FRAME,this.method_117);
         clearTimeout(this.var_602);
      }
      
      override public function remove() : *
      {
         this.clear();
         super.remove();
      }
   }
}
