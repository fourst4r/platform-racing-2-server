package package_19
{
   import flash.display.Sprite;
   import flash.events.*;
   import levelEditor.*;
   
   public class Landscape extends Sprite
   {
       
      
      private var editor:LevelEditor;
      
      public function Landscape()
      {
         this.editor = LevelEditor.editor;
         super();
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         addChild(new LandscapeGraphic());
      }
      
      private function mouseDownHandler(param1:MouseEvent) : *
      {
         this.editor.menu.changeSideBar(this.editor.menu.stamps);
         this.editor.focusOn(this.editor.cur);
      }
      
      public function remove() : *
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
      }
   }
}
