package package_19
{
   import com.jiggmin.ColorPicker.*;
   import flash.display.Sprite;
   import flash.events.*;
   import levelEditor.*;
   
   public class BackgroundColorPickerButton extends Sprite
   {
       
      
      private var cp:ColorPicker;
      
      public function BackgroundColorPickerButton()
      {
         this.cp = new ColorPicker();
         super();
         this.cp.width = this.cp.height = 30;
         this.cp.direction = ColorPicker.LEFT;
         this.updateColor();
         addChild(this.cp);
         this.cp.addEventListener(Event.CLOSE,this.onClose,false,0,true);
      }
      
      public function updateColor() : *
      {
         this.cp.setColor(LevelEditor.editor.getColor());
      }
      
      private function onClose(param1:Event) : *
      {
         LevelEditor.editor.setColor(this.cp.getColor());
         Main.stage.focus = Main.stage;
      }
      
      public function remove() : *
      {
         this.cp.removeEventListener(Event.CLOSE,this.onClose);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}
