package package_19
{
   import flash.display.MovieClip;
   import flash.events.*;
   import package_14.Tools;
   
   public class SizePicker extends MovieClip
   {
       
      
      private var size:Number;
      
      private var tools:Tools;
      
      private var m:SizePickerGraphic;
      
      private var menu:SizePickerMenu;
      
      public function SizePicker(param1:Tools, param2:int = 4)
      {
         this.m = new SizePickerGraphic();
         super();
         this.tools = param1;
         this.setSize(param2);
         addChild(this.m);
         addEventListener(MouseEvent.MOUSE_DOWN,this.downHandler);
      }
      
      private function downHandler(param1:MouseEvent) : *
      {
         this.menu = new SizePickerMenu(this,this.size);
      }
      
      public function setSize(param1:Number) : *
      {
         this.size = param1;
         this.m.circle.width = this.m.circle.height = Math.sqrt(this.size) * 3;
         this.tools.setSize(this.size);
      }
      
      public function remove() : *
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.downHandler);
         if(this.menu != null)
         {
            this.menu.remove();
         }
         parent.removeChild(this);
      }
   }
}
