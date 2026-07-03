package blocks
{
   import com.jiggmin.data.*;
   import flash.geom.Point;
   import package_8.LocalCharacter;
   
   public class PushBlock extends Block
   {
       
      
      public function PushBlock()
      {
         super(Objects.BLOCK_PUSH);
         safeStand = false;
      }
      
      override public function onStand(param1:LocalCharacter) : *
      {
         super.onStand(param1);
         this.localActivate("down");
      }
      
      override public function onBump(param1:LocalCharacter) : *
      {
         super.onBump(param1);
         this.localActivate("up");
      }
      
      override public function onLeftHit(param1:LocalCharacter) : *
      {
         super.onLeftHit(param1);
         this.localActivate("right");
      }
      
      override public function onRightHit(param1:LocalCharacter) : *
      {
         super.onRightHit(param1);
         this.localActivate("left");
      }
      
      override protected function localActivate(param1:String = "") : *
      {
         if(!frozen)
         {
            super.localActivate(param1);
         }
      }
      
      override protected function activate(param1:String = "") : *
      {
         if(param1 == "down")
         {
            this.push(0,1);
         }
         else if(param1 == "up")
         {
            this.push(0,-1);
         }
         else if(param1 == "right")
         {
            this.push(1,0);
         }
         else if(param1 == "left")
         {
            this.push(-1,0);
         }
      }
      
      private function push(param1:int, param2:int) : *
      {
         var _loc3_:Point = Data.method_9(param1,param2,map.rotation);
         move(_loc3_.x,_loc3_.y,map);
      }
   }
}
