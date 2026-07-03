package package_8
{
   import com.jiggmin.data.*;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.geom.*;
   
   public class class_240 extends Sprite
   {
       
      
      private var velX:Number;
      
      private var velY:Number;
      
      private var fricX:Number;
      
      private var fricY:Number;
      
      private var accelX:Number;
      
      private var accelY:Number;
      
      private var var_578:int;
      
      private var life:int;
      
      private var targetAlpha:Number;
      
      private var var_275:Number;
      
      private var velAlpha:Number;
      
      private var velScaleX:Number;
      
      private var velScaleY:Number;
      
      private var velRotation:Number;
      
      public function class_240(param1:Object)
      {
         super();
         this.setColor(param1.colors);
         param1.x = this.method_38(param1.minX,param1.maxX);
         param1.y = this.method_38(param1.minY,param1.maxY);
         param1.velX = this.method_38(param1.minVelX,param1.maxVelX);
         param1.velY = this.method_38(param1.minVelY,param1.maxVelY);
         param1.velAlpha = this.method_38(param1.minVelAlpha,param1.maxVelAlpha);
         param1.velRotation = this.method_38(param1.minVelRotation,param1.maxVelRotation);
         param1.scale = this.method_38(param1.minScale,param1.maxScale);
         param1.rotation = this.method_38(param1.minRotation,param1.maxRotation);
         x = Number(param1.x) || 0;
         y = Number(param1.y) || 0;
         rotation = Number(param1.rotation) || 0;
         scaleX = scaleY = Number(param1.scale) || 0;
         this.velX = Number(param1.velX) || 0;
         this.velY = Number(param1.velY) || 0;
         this.fricX = Number(param1.fricX) || 1;
         this.fricY = Number(param1.fricY) || 1;
         this.accelX = Number(param1.accelX) || 0;
         this.accelY = Number(param1.accelY) || 0;
         this.life = this.var_578 = int(param1.life) || 10;
         this.targetAlpha = Number(param1.targetAlpha) || 1;
         this.var_275 = alpha = Number(param1.startAlpha) || 0;
         this.velAlpha = Number(param1.velAlpha) || 0.1;
         this.velScaleX = Number(param1.velScaleX) || 0;
         this.velScaleY = Number(param1.velScaleY) || 0;
         this.velRotation = Number(param1.velRotation) || 0;
         addChild(this.method_508(param1.graphic));
         addEventListener(Event.ENTER_FRAME,this.method_251);
      }
      
      public function setColor(param1:Array) : *
      {
         var _loc2_:Number = Number(Data.randArrayKey(param1));
         var _loc3_:ColorTransform = new ColorTransform();
         _loc3_.color = _loc2_;
         transform.colorTransform = _loc3_;
      }
      
      public function method_508(param1:String) : DisplayObject
      {
         var _loc2_:DisplayObject = null;
         if(param1 == "DjinnIceGraphic")
         {
            _loc2_ = new DjinnIceGraphic();
         }
         return _loc2_;
      }
      
      private function method_38(param1:Number, param2:Number) : Number
      {
         if(Boolean(isNaN(param1)) || Boolean(isNaN(param2)))
         {
            return 0;
         }
         var _loc3_:Number = param2 - param1;
         return Math.random() * _loc3_ + param1;
      }
      
      private function method_251(param1:Event) : *
      {
         x += this.velX;
         y += this.velY;
         this.velX += this.accelX;
         this.velY += this.accelY;
         this.velX *= this.fricX;
         this.velY *= this.fricY;
         scaleX += this.velScaleX;
         scaleY += this.velScaleY;
         rotation += this.velRotation;
         this.var_275 += this.velAlpha;
         if(this.var_275 > 1)
         {
            this.var_275 = 1;
         }
         alpha = this.var_275 * (this.life / this.var_578);
         --this.life;
         if(this.life <= 0)
         {
            this.remove();
         }
      }
      
      public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.method_251);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
