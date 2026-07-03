package blocks
{
   import com.jiggmin.data.*;
   import flash.geom.Point;
   import package_8.LocalCharacter;
   
   public class SafetyBlock extends Block
   {
       
      
      public function SafetyBlock()
      {
         super(Objects.BLOCK_SAFETY);
         safeStand = false;
         active = false;
      }
      
      override public function onTouch(param1:LocalCharacter) : *
      {
         var _loc2_:Point = null;
         super.onTouch(param1);
         if(!frozen)
         {
            _loc2_ = getSeg();
            if(param1.var_407 != _loc2_.x || param1.var_366 < _loc2_.y || param1.var_366 > _loc2_.y + 2)
            {
               param1.returnToLastSafeSpot();
            }
         }
      }
   }
}
