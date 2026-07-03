package package_9
{
   import flash.display.DisplayObject;
   import flash.events.*;
   
   public class BlockPiece extends Effect
   {
       
      
      private var velX:Number;
      
      private var velY:Number;
      
      private var var_372:Number;
      
      private var gravity:Number;
      
      private var friction:Number;
      
      private var name_3:Number;
      
      public function BlockPiece(param1:DisplayObject, param2:Number = 1, param3:Number = 0.95, param4:Number = 0.01, param5:Number = 10, param6:Number = 10, param7:Number = 10, param8:Number = 0, param9:Number = 0)
      {
         super();
         addChild(param1);
         x = param8;
         y = param9;
         this.gravity = param2;
         this.friction = param3;
         this.name_3 = param4;
         rotation = Math.random() * 360;
         this.velX = Math.random() * param5 * 2 - param5;
         this.velY = Math.random() * param6 * 2 - param6;
         this.var_372 = Math.random() * param7 * 2 - param7;
         addEventListener(Event.ENTER_FRAME,this.go,false,0,true);
      }
      
      private function go(param1:Event) : *
      {
         this.velX *= this.friction;
         this.velY *= this.friction;
         this.var_372 *= this.friction;
         this.velY += this.gravity;
         x += this.velX;
         y += this.velY;
         rotation += this.var_372;
         alpha -= this.name_3;
         if(alpha <= 0)
         {
            this.remove();
         }
      }
      
      override public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.go);
         super.remove();
      }
   }
}
