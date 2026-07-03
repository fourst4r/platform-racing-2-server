package package_8
{
   import flash.display.DisplayObject;
   import flash.utils.*;
   import package_9.*;
   
   public class class_125
   {
       
      
      private var var_416:uint;
      
      private var var_444:int;
      
      private var duration:int;
      
      private var life:int;
      
      protected var target:DisplayObject;
      
      public function class_125(param1:int, param2:int, param3:DisplayObject)
      {
         super();
         this.var_444 = param1;
         this.duration = param2;
         this.target = param3;
         this.life = Math.floor(param2 / param1);
         this.var_416 = setInterval(this.method_571,param1);
      }
      
      protected function method_571() : *
      {
         var _loc1_:Number = Number(this.makeX());
         var _loc2_:Number = Number(this.makeY());
         var _loc3_:DisplayObject = this.createParticle(_loc1_,_loc2_);
         --this.life;
         if(this.life <= 0)
         {
            this.remove();
         }
      }
      
      protected function makeX() : Number
      {
         return this.target.x + Math.random() * 20 - 10;
      }
      
      protected function makeY() : Number
      {
         return this.target.y - Math.random() * 55;
      }
      
      protected function createParticle(param1:Number, param2:Number) : DisplayObject
      {
         return new class_178(param1,param2);
      }
      
      public function remove() : *
      {
         this.target = null;
         clearInterval(this.var_416);
      }
   }
}
