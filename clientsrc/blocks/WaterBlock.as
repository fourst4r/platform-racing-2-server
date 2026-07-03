package blocks
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.geom.Point;
   import package_6.*;
   import package_8.LocalCharacter;
   
   public class WaterBlock extends Block
   {
       
      
      private var var_484:Boolean = false;
      
      public function WaterBlock()
      {
         super(Objects.BLOCK_WATER);
         safeStand = false;
         active = false;
      }
      
      override public function onTouch(param1:LocalCharacter) : *
      {
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         super.onTouch(param1);
         if(!frozen)
         {
            if(!param1.grounded && param1.mode != "freeze" && param1.mode != "hurt" && param1.mode != "frozenSolid2")
            {
               param1.setMode("water");
               param1.var_240 = 2;
               param1.swimAccelXMultiplier = 0.5;
               param1.swimAccelYMultiplier = 0.65;
               param1.swimVelDamping = 0.92;
            }
            else
            {
               param1.targetVelX *= 0.9;
               param1.traction = 0.1;
            }
            if(param1.parent == Course.course.frontBackground)
            {
               Course.course.backBackground.addChild(param1);
            }
            _loc2_ = method_18();
            _loc3_ = getSeg();
            param1.var_407 = _loc3_.x;
            param1.var_366 = _loc3_.y;
            param1.lastSafeX = _loc2_.x + 15;
            param1.lastSafeY = _loc2_.y + 15;
            this.method_339();
         }
      }
      
      public function method_584() : *
      {
         this.method_339();
      }
      
      private function method_339() : *
      {
         alpha -= 0.1;
         if(alpha < 0.5)
         {
            alpha = 0.5;
         }
         if(!this.var_484)
         {
            this.var_484 = true;
            addEventListener(Event.ENTER_FRAME,this.method_117,false,0,true);
         }
      }
      
      private function method_117(param1:Event) : *
      {
         alpha += 0.03;
         if(alpha >= 1)
         {
            alpha = 1;
            this.var_484 = false;
            removeEventListener(Event.ENTER_FRAME,this.method_117);
         }
      }
      
      override public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.method_117);
         super.remove();
      }
   }
}
