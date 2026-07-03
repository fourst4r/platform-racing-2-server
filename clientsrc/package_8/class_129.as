package package_8
{
   import flash.display.DisplayObject;
   import flash.geom.*;
   import package_9.*;
   
   public class class_129 extends class_125
   {
       
      
      public function class_129(param1:int, param2:int, param3:DisplayObject)
      {
         super(param1,param2,param3);
      }
      
      override protected function createParticle(param1:Number, param2:Number) : DisplayObject
      {
         var _loc3_:class_181 = new class_181(param1,param2);
         _loc3_.transform.colorTransform = new ColorTransform(Math.random(),Math.random(),Math.random(),Math.random(),Math.random(),Math.random(),Math.random(),Math.random());
         return _loc3_;
      }
   }
}
