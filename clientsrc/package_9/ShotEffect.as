package package_9
{
   import blocks.Block;
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.geom.Point;
   import package_6.*;
   import package_8.Character;
   
   public class ShotEffect extends Effect
   {
       
      
      private var course:Course;
      
      private var var_154:Number = 5;
      
      private var posX:Number;
      
      private var posY:Number;
      
      private var velX:Number;
      
      private var velY:Number;
      
      private var var_278:Number = 0;
      
      private var type:String;
      
      protected var var_377:int;
      
      protected var life:Number = 100;
      
      protected var shooterID:int = -1;
      
      protected var var_493:Boolean = false;
      
      public function ShotEffect(param1:Number, param2:Number, param3:Number, param4:int, param5:int, param6:String)
      {
         super(param1,param2);
         this.course = Course.course;
         this.posX = param1;
         this.posY = param2;
         this.method_775(param3);
         this.rotation = param3 + this.course.blockBackground.rotation - param4;
         this.var_377 = param4;
         this.shooterID = param5;
         this.type = param6;
         addEventListener(Event.ENTER_FRAME,this.method_152,false,0,true);
         this.position();
         this.method_253();
      }
      
      public function method_62(param1:Number) : *
      {
         this.var_154 = param1;
         this.method_389();
      }
      
      public function method_775(param1:Number) : *
      {
         this.var_278 = param1;
         this.method_389();
      }
      
      protected function method_152(param1:Event) : *
      {
         this.move();
         this.position();
         this.method_253();
         --this.life;
         if(this.life <= 0)
         {
            this.method_601();
         }
      }
      
      protected function move() : *
      {
         this.posX += this.velX;
         this.posY += this.velY;
      }
      
      protected function position() : *
      {
         var _loc1_:Point = Data.method_9(this.posX,this.posY,-(this.course.blockBackground.rotation - this.var_377));
         x = _loc1_.x;
         y = _loc1_.y;
      }
      
      private function method_253() : *
      {
         var _loc1_:Block = this.course.blockBackground.getBlockFromPos(x,y,true);
         if(_loc1_ != null && (Boolean(this.var_493) || _loc1_.isActive()))
         {
            this.hitBlock(_loc1_);
         }
         var _loc2_:Character = this.method_782(x,y);
         if(_loc2_ != null)
         {
            this.hitPlayer(_loc2_);
         }
      }
      
      protected function method_782(param1:int, param2:int) : Character
      {
         var _loc3_:Character = null;
         for each(_loc3_ in this.course.playerArray)
         {
            if(_loc3_.tempID != this.shooterID && _loc3_.y > param2 && _loc3_.y < param2 + 60 && !_loc3_.removed)
            {
               if(scaleX == 1 && _loc3_.x > param1 - 60 && _loc3_.x < param1 || scaleX == -1 && _loc3_.x < param1 + 60 && _loc3_.x > param1)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      protected function method_389() : *
      {
         var _loc1_:Number = this.var_278 * Data.DEG_RAD;
         this.velX = Math.cos(_loc1_) * this.var_154;
         this.velY = Math.sin(_loc1_) * this.var_154;
      }
      
      protected function hitBlock(param1:Block) : *
      {
         param1.onDamage(this.velX);
         this.hitAnything();
      }
      
      protected function hitPlayer(param1:Character) : *
      {
         if(param1.type == "local")
         {
            param1.hit(this.velX,this.velY);
         }
         x = param1.x - this.velX;
         this.hitAnything();
      }
      
      protected function hitAnything() : *
      {
      }
      
      protected function method_601() : *
      {
         this.remove();
      }
      
      override public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.method_152);
         this.course = null;
         super.remove();
      }
   }
}
