package package_14
{
   import com.jiggmin.ColorPicker.*;
   import flash.display.Stage;
   import flash.events.*;
   import package_19.*;
   import package_20.*;
   import ui.*;
   
   public class Tools extends SideBar
   {
      
      private static var color:Number = 0;
      
      private static var size:Number = 4;
       
      
      private var stageRef:Stage;
      
      private var colorPicker:ColorPicker;
      
      private var brush:Brush;
      
      private var eraser:Eraser;
      
      private var sizePicker:SizePicker;
      
      private var brushButton:BrushButtonGraphic;
      
      private var eraserButton:EraserButtonGraphic;
      
      private var active:Boolean = false;
      
      public function Tools()
      {
         this.stageRef = Main.stage;
         this.colorPicker = new ColorPicker();
         this.brush = new Brush();
         this.eraser = new Eraser();
         this.sizePicker = new SizePicker(this,Tools.size);
         this.brushButton = new BrushButtonGraphic();
         this.eraserButton = new EraserButtonGraphic();
         super();
         addItem(new Landscape(),"Landscape Mode","Switch to the landscape toolbar.");
         addItem(this.brushButton,"Brush","Draw things, yay!");
         addItem(this.eraserButton,"Eraser","Erase the things you have drawn, yay!");
         addItem(this.sizePicker,"Size Picker","Change the size of the brush and eraser.");
         addItem(this.colorPicker,"Color Picker","Choose your color with wisdom.");
         this.colorPicker.width = this.colorPicker.height = 30;
         this.colorPicker.direction = ColorPicker.LEFT;
         this.colorPicker.addEventListener(Event.CLOSE,this.chooseColor);
         this.brushButton.addEventListener(MouseEvent.MOUSE_DOWN,this.onBrushDown);
         this.eraserButton.addEventListener(MouseEvent.MOUSE_DOWN,this.onEraserDown);
         this.brush.setSize(Tools.size);
         this.eraser.setSize(Tools.size);
         this.colorPicker.setColor(Tools.color);
         this.brush.setColor(Tools.color);
      }
      
      public function setSize(param1:Number) : *
      {
         Tools.size = param1;
         this.eraser.setSize(Tools.size);
         this.brush.setSize(Tools.size);
      }
      
      public function setZoom(param1:Number) : *
      {
         this.eraser.setZoom(param1);
         this.brush.setZoom(param1);
      }
      
      private function onBrushDown(param1:MouseEvent) : *
      {
         param1.stopImmediatePropagation();
         CustomCursor.change(this.brush);
      }
      
      private function onEraserDown(param1:MouseEvent) : *
      {
         param1.stopImmediatePropagation();
         CustomCursor.change(this.eraser);
      }
      
      private function chooseColor(param1:Event) : *
      {
         Tools.color = this.colorPicker.getColor();
         this.brush.setColor(Tools.color);
         this.stageRef.focus = this.stageRef;
      }
      
      override public function init() : *
      {
         CustomCursor.init();
         CustomCursor.change(this.brush);
         this.active = true;
      }
      
      override public function exit() : *
      {
         this.colorPicker.closePopup();
         CustomCursor.pause();
         super.exit();
         this.active = false;
      }
      
      override public function remove() : *
      {
         this.exit();
         CustomCursor.unsetInstance();
         this.colorPicker.removeEventListener(Event.CLOSE,this.chooseColor);
         this.colorPicker.remove();
         this.colorPicker = null;
         this.brushButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.onBrushDown);
         this.eraserButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.onEraserDown);
         this.brush.remove();
         this.brush = null;
         this.eraser.remove();
         this.eraser = null;
         super.remove();
      }
   }
}
