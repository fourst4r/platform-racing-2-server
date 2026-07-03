package ui
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.*;
   
   public class class_229 extends Sprite
   {
       
      
      private var m:MovieClip;
      
      private var selected:Boolean = false;
      
      private var hovering:Boolean = false;
      
      public function class_229(param1:MovieClip)
      {
         super();
         this.m = param1;
         addEventListener(MouseEvent.MOUSE_OVER,this.overHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.outHandler,false,0,true);
         this.display();
      }
      
      public function method_368(param1:Boolean) : *
      {
         this.selected = param1;
         this.display();
      }
      
      public function getSelected() : Boolean
      {
         return this.selected;
      }
      
      private function overHandler(param1:MouseEvent) : *
      {
         this.hovering = true;
         this.display();
      }
      
      private function outHandler(param1:MouseEvent) : *
      {
         this.hovering = false;
         this.display();
      }
      
      private function display() : *
      {
         if(this.selected)
         {
            this.m.gotoAndStop("selected");
         }
         else if(this.hovering)
         {
            this.m.gotoAndStop("over");
         }
         else
         {
            this.m.gotoAndStop("up");
         }
      }
      
      public function remove() : *
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.outHandler);
         this.m = null;
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}
