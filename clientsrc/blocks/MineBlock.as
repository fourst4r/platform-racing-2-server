package blocks
{
   import com.jiggmin.data.*;
   import flash.geom.Point;
   import package_8.LocalCharacter;
   import package_9.*;
   import package_6.Course;
   
   public class MineBlock extends Block
   {
      public function MineBlock()
      {
         super(Objects.BLOCK_MINE);
         safeStand = false;
      }
      
      override public function onStand(param1:LocalCharacter) : *
      {
         super.onStand(param1);
         this.method_81(param1);
      }
      
      override public function onBump(param1:LocalCharacter) : *
      {
         super.onBump(param1);
         this.method_81(param1);
      }
      
      override public function onLeftHit(param1:LocalCharacter) : *
      {
         super.onLeftHit(param1);
         this.method_81(param1);
      }
      
      override public function onRightHit(param1:LocalCharacter) : *
      {
         super.onRightHit(param1);
         this.method_81(param1);
      }
      
      override public function onTouch(param1:LocalCharacter) : *
      {
         super.onTouch(param1);
         this.method_81(param1);
      }
      
      override public function onDamage(param1:Number) : *
      {
         super.onDamage(param1);
         localActivate();
      }
      
      override protected function activate(param1:String = "") : *
      {
         var _loc3_:int = 0;
         var _loc4_:MinePieceGraphic = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:Point = method_18();
         while(_loc3_ < 10)
         {
            _loc5_ = Math.random() * 30 + _loc2_.x;
            _loc6_ = Math.random() * 30 + _loc2_.y;
            BlockPieceSystem.instance.spawn(MinePieceGraphic,_loc5_,_loc6_,0.75,0.95,0.05,30,30,50);
            _loc3_++;
         }
         new MineExplode(_loc2_.x,_loc2_.y);
         remove();
      }
      
      private function method_81(param1:LocalCharacter) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(!frozen)
         {
            _loc2_ = param1.x - (x + 15);
            _loc3_ = param1.y - param1.var_325 / 2 - (y + 15);
            _loc4_ = Math.atan2(_loc3_,_loc2_);
            _loc5_ = Math.cos(_loc4_) * 50;
            _loc6_ = Math.sin(_loc4_) * 50;
            param1.hit(_loc5_,_loc6_);

            // HACK for the sake of hat removers:
            // If the player is at the start position, don't activate the mine for other players.
            var startPos = Course.course.startPosArray[param1.tempID % 4];
            if (Math.abs(x - startPos.x) <= 45 && Math.abs(y - startPos.y) <= 45) {
               this.activate(param1);
               return;
            }
            
            localActivate();
         }
      }
   }
}
