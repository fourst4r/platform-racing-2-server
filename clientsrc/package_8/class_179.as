package package_8
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.*;
   
   public class class_179 extends class_125
   {
       
      
      private var var_128:Object;
      
      private var var_567:Number;
      
      private var var_608:Number;
      
      private var holder:DisplayObjectContainer;
      
      public function class_179(param1:int, param2:int, param3:DisplayObject, param4:DisplayObjectContainer, param5:Object, param6:Number = 0, param7:Number = 0)
      {
         super(param1,param2,param3);
         this.var_128 = param5;
         this.holder = param4;
         this.var_567 = param6;
         this.var_608 = param7;
      }
      
      override protected function createParticle(param1:Number, param2:Number) : DisplayObject
      {
         if(!target.parent)
         {
            return null;
         }
         this.var_128.minX = param1 + this.var_128.minOffsetX;
         this.var_128.maxX = param1 + this.var_128.maxOffsetX;
         this.var_128.minY = param2 + this.var_128.minOffsetY;
         this.var_128.maxY = param2 + this.var_128.maxOffsetY;
         var _loc3_:class_240 = new class_240(this.var_128);
         this.holder.addChild(_loc3_);
         return _loc3_;
      }
      
      override protected function makeX() : Number
      {
         return this.method_470().x;
      }
      
      override protected function makeY() : Number
      {
         return this.method_470().y;
      }
      
      private function method_470() : Object
      {
         if(!this.holder || !target || !target.parent)
         {
            return new Point(0,0);
         }
         var _loc1_:Point = new Point(target.x - this.var_567,target.y - this.var_608);
         _loc1_ = target.parent.localToGlobal(_loc1_);
         return this.holder.globalToLocal(_loc1_);
      }
   }
}
