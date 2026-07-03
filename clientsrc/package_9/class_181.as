package package_9
{
   import flash.events.*;
   
   public class class_181 extends Effect
   {
       
      
      private var m:Arrow2Graphic;
      
      private var velY:int = 0;
      
      public function class_181(param1:Number, param2:Number)
      {
         this.m = new Arrow2Graphic();
         super();
         x = param1;
         y = param2;
         scaleX = scaleY = 0.25;
         addChild(this.m);
         method_2(15);
         addEventListener(Event.ENTER_FRAME,this.method_152);
      }
      
      private function method_152(param1:Event) : *
      {
         this.velY -= 0.1;
         y -= this.velY;
         alpha -= 0.06;
      }
      
      override public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.method_152);
         this.m = null;
         super.remove();
      }
   }
}
