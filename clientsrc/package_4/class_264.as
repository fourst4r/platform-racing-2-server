package package_4
{
   import flash.display.DisplayObject;
   import flash.events.*;
   import flash.utils.*;
   
   public class class_264 extends InfoPopup
   {
       
      
      private var initTimeout:uint;
      
      public function class_264(param1:DisplayObject)
      {
         this.initTimeout = setTimeout(this.init,25);
         super(param1);
      }
      
      private function init() : *
      {
         Main.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.downHandler);
      }
      
      protected function downHandler(param1:MouseEvent) : *
      {
         if(!this.hitTestPoint(param1.stageX,param1.stageY,true))
         {
            this.remove();
         }
      }
      
      override public function remove() : *
      {
         clearTimeout(this.initTimeout);
         Main.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.downHandler);
         super.remove();
      }
   }
}
