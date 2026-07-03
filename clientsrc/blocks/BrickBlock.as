package blocks
{
   import com.jiggmin.data.*;
   import flash.geom.Point;
   import package_8.LocalCharacter;
   import package_9.*;
   
   public class BrickBlock extends Block
   {
      public function BrickBlock()
      {
         super(Objects.BLOCK_BRICK);
         safeStand = false;
      }
      
      override public function onBump(param1:LocalCharacter) : *
      {
         super.onBump(param1);
         if(!frozen)
         {
            localActivate();
         }
      }
      
      override public function onDamage(param1:Number) : *
      {
         super.onDamage(param1);
         if(!frozen)
         {
            localActivate();
         }
      }
      
      override protected function activate(param1:String = "") : *
      {
         var _loc3_:int = 0;
         var _loc2_:Point = method_18();
         while(_loc3_ < 6)
         {
            var _loc5_ = Math.random() * 30 + _loc2_.x;
            var _loc6_ = Math.random() * 30 + _loc2_.y;
            BlockPieceSystem.instance.spawn(BrickPieceGraphic,_loc5_,_loc6_,0.75,0.95,0.05,10,10,25);
            _loc3_++;
         }
         remove();
      }
   }
}
