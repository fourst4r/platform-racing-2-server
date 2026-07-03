package package_19
{
   import flash.events.MouseEvent;
   import package_20.*;
   import ui.*;
   
   public class TextToolButton extends class_215
   {
       
      
      private var m:TextToolButtonGraphic;
      
      public function TextToolButton()
      {
         this.m = new TextToolButtonGraphic();
         super();
         addChild(this.m);
      }
      
      override protected function onClick(param1:MouseEvent) : *
      {
         param1.stopImmediatePropagation();
         CustomCursor.change(new TextTool());
      }
      
      override public function remove() : *
      {
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
