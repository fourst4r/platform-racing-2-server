package package_9
{
   import blocks.Block;
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.geom.Point;
   import package_6.*;
   import package_8.LocalCharacter;
   
   public class class_81 extends Effect
   {
       
      
      protected var velX:Number = 0;
      
      protected var velY:Number = 0;
      
      public var posX:Number;
      
      public var posY:Number;
      
      public var rot:int;
      
      private var time:Number;
      
      private var var_681:Number;
      
      private var var_683:Number;
      
      private var grounded:Boolean = false;
      
      public function class_81(param1:int, param2:int, param3:int)
      {
         super();
         this.posX = param1;
         this.posY = param2;
         this.rot = param3;
         this.method_720();
      }
      
      public function method_720() : *
      {
         addEventListener(Event.ENTER_FRAME,this.go,false,0,true);
      }
      
      public function method_205() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.go);
      }
      
      protected function go(param1:Event) : *
      {
         var _loc2_:Block = null;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         this.velY += 0.2;
         if(this.velY > 8)
         {
            this.velY = 8;
         }
         this.posY += this.velY;
         this.posX += this.velX;
         rotation = Course.course.blockBackground.rotation - this.rot;
         _loc4_ = Data.method_9(this.posX,this.posY,-rotation);
         if(this.velX != 0)
         {
            _loc5_ = Data.method_9(this.posX + this.velX,this.posY - 10,-rotation);
            _loc2_ = Course.course.blockBackground.getBlockFromPos(_loc5_.x,_loc5_.y,true);
            if(_loc2_ != null && _loc2_.isActive())
            {
               _loc3_ = _loc2_.method_18(this.rot);
               if(this.velX < 0)
               {
                  this.posX = _loc3_.x + 31;
               }
               else
               {
                  this.posX = _loc3_.x - 1;
               }
               this.onTouchWall();
            }
         }
         _loc2_ = Course.course.blockBackground.getBlockFromPos(_loc4_.x,_loc4_.y,true);
         if(_loc2_ != null && _loc2_.isActive())
         {
            this.grounded = true;
            _loc3_ = _loc2_.method_18(this.rot);
            if(this.velY < 0)
            {
               this.velY *= -0.5;
               this.posY = _loc3_.y + 31;
            }
            else
            {
               this.velY = 0;
               this.posY = _loc3_.y;
            }
         }
         else
         {
            this.grounded = false;
         }
         if(this.method_181(x,y))
         {
            this.onTouchLocalPlayer();
         }
         _loc4_ = Data.method_9(this.posX,this.posY,-rotation);
         x = _loc4_.x;
         y = _loc4_.y;
      }
      
      protected function method_181(param1:int, param2:int) : Boolean
      {
         var _loc3_:LocalCharacter = Course.course.var_9;
         if(_loc3_ != null && !_loc3_.removed)
         {
            if(Math.abs(_loc3_.x - param1) < 25 && _loc3_.y > param2 - 5 && (!_loc3_.crouching && _loc3_.y < param2 + 65 || _loc3_.crouching && _loc3_.y < param2 + 25))
            {
               return true;
            }
         }
         return false;
      }
      
      protected function onTouchLocalPlayer() : *
      {
      }
      
      protected function onTouchWall() : *
      {
      }
      
      public function method_311() : Boolean
      {
         return this.grounded;
      }
      
      override public function remove() : *
      {
         this.method_205();
         super.remove();
      }
   }
}
