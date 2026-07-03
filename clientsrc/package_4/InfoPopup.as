package package_4
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class InfoPopup extends Removable
   {
       
      
      public function InfoPopup(param1:DisplayObject)
      {
         var _loc7_:Number = NaN;
         super();
         var _loc2_:Rectangle = getBounds(Main.stage);
         var _loc3_:Number = _loc2_.left;
         var _loc4_:Number = _loc2_.top;
         var _loc5_:Rectangle;
         if((_loc5_ = param1.getBounds(Main.stage)).left > width)
         {
            _loc3_ = _loc5_.left - width - 7;
         }
         else
         {
            _loc3_ = _loc5_.right + 7;
         }
         if((_loc4_ = _loc5_.top) < 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ + height > 400)
         {
            _loc4_ = 400 - height;
         }
         var _loc6_:Number = _loc3_ - _loc2_.left;
         _loc7_ = _loc4_ - _loc2_.top;
         x = Math.round(_loc6_);
         y = Math.round(_loc7_);
         Main.stage.addChild(this);
      }
   }
}
