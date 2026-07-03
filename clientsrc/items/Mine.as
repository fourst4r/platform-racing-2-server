package items
{
   import background.Map;
   import com.jiggmin.data.*;
   import flash.geom.Point;
   import package_6.*;
   import package_8.LocalCharacter;
   import package_9.*;
   
   public class Mine extends Item
   {
       
      
      public function Mine(param1:LocalCharacter)
      {
         super(param1);
      }
      
      override public function useItem() : *
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc1_:Map = Course.course.blockBackground;
         var _loc2_:Point = method_37();
         _loc2_.x = Math.round(_loc2_.x + 15);
         _loc2_.y = Math.round(_loc2_.y + 10);
         if(_loc1_.getBlockFromPos(_loc2_.x,_loc2_.y,true) == null)
         {
            _loc3_ = _loc1_.getSegFromPos(_loc2_.x,_loc2_.y);
            _loc4_ = _loc1_.getPosFromSeg(_loc3_.x,_loc3_.y);
            _loc4_.x += 15;
            _loc4_.y += 15;
            _loc4_ = Data.method_9(_loc4_.x,_loc4_.y,Course.course.blockBackground.rotation);
            Main.socket.write("add_effect`Mine`" + _loc4_.x + "`" + _loc4_.y + "`" + Course.course.blockBackground.rotation);
            new MineAppear(_loc4_.x,_loc4_.y);
            super.useItem();
         }
      }
   }
}
