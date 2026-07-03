package ui
{
   import com.jiggmin.ColorPicker.*;
   import com.jiggmin.data.*;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.*;
   import flash.ui.*;
   import flash.utils.*;
   import levelEditor.*;
   import package_20.*;
   
   public class CustomCursor extends Removable
   {
      
      public static var stageRef:Stage;
      
      public static var instance:CustomCursor;
       
      
      private var active:Boolean = false;
      
      private var me:MouseEvent;
      
      private var mouseDown:Boolean;
      
      private var mouseHidden:Boolean = false;
      
      public var var_411:Boolean = true;
      
      public function CustomCursor()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         x = stageRef.mouseX;
         y = stageRef.mouseY;
      }
      
      public static function change(param1:CustomCursor) : *
      {
         unsetInstance();
         instance = param1;
         stageRef.addChild(param1);
         if(!param1.isActive())
         {
            param1.init();
         }
      }
      
      public static function unsetInstance() : *
      {
         if(instance != null)
         {
            if(instance.var_411 == true)
            {
               instance.remove();
            }
            else
            {
               instance.pause();
            }
            instance = null;
         }
      }
      
      public static function pause() : *
      {
         if(instance != null)
         {
            instance.pause();
         }
      }
      
      public static function init() : *
      {
         if(instance != null)
         {
            instance.init();
         }
      }
      
      public function init() : *
      {
         this.active = true;
         visible = true;
         if(this.mouseHidden)
         {
            this.hideMouse();
         }
         stageRef.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler,false,0,true);
         stageRef.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler,true,0,true);
         stageRef.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler,false,0,true);
         stageRef.addEventListener(MouseEvent.MOUSE_OVER,this.mouseFocusHandler,false,0,true);
         stageRef.addEventListener(MouseEvent.MOUSE_OUT,this.mouseFocusHandler,false,0,true);
         stageRef.addEventListener(TouchEvent.TOUCH_MOVE,this.touchHandler);
         stageRef.addEventListener(TouchEvent.TOUCH_BEGIN,this.touchHandler);
         stageRef.addEventListener(TouchEvent.TOUCH_END,this.touchHandler);
         stageRef.addEventListener(TouchEvent.TOUCH_ROLL_OVER,this.touchHandler);
         stageRef.addEventListener(TouchEvent.TOUCH_ROLL_OUT,this.touchHandler);
         stageRef.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         stageRef.addEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);
      }
      
      private function touchHandler(param1:TouchEvent) : *
      {
         var _loc2_:String = null;
         if(param1.type == TouchEvent.TOUCH_MOVE)
         {
            _loc2_ = String(MouseEvent.MOUSE_MOVE);
         }
         else if(param1.type == TouchEvent.TOUCH_BEGIN)
         {
            _loc2_ = String(MouseEvent.MOUSE_DOWN);
         }
         else if(param1.type == TouchEvent.TOUCH_END)
         {
            _loc2_ = String(MouseEvent.MOUSE_UP);
         }
         else if(param1.type == TouchEvent.TOUCH_ROLL_OVER)
         {
            _loc2_ = String(MouseEvent.MOUSE_OVER);
         }
         else if(param1.type == TouchEvent.TOUCH_ROLL_OUT)
         {
            _loc2_ = String(MouseEvent.MOUSE_OUT);
         }
         if(_loc2_ != null)
         {
            dispatchEvent(new MouseEvent(_loc2_));
         }
      }
      
      public function pause() : *
      {
         this.active = false;
         visible = false;
         if(this.mouseHidden)
         {
            this.showMouse();
         }
         stageRef.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
         stageRef.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler,true);
         stageRef.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         stageRef.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseFocusHandler);
         stageRef.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseFocusHandler);
         stageRef.removeEventListener(TouchEvent.TOUCH_MOVE,this.touchHandler);
         stageRef.removeEventListener(TouchEvent.TOUCH_BEGIN,this.touchHandler);
         stageRef.removeEventListener(TouchEvent.TOUCH_END,this.touchHandler);
         stageRef.removeEventListener(TouchEvent.TOUCH_ROLL_OVER,this.touchHandler);
         stageRef.removeEventListener(TouchEvent.TOUCH_ROLL_OUT,this.touchHandler);
         stageRef.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         stageRef.removeEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);
      }
      
      public function isActive() : Boolean
      {
         return this.active;
      }
      
      public function getMouse() : MouseEvent
      {
         return this.me;
      }
      
      public function isMouseDown() : Boolean
      {
         return this.mouseDown;
      }
      
      protected function hideMouse() : *
      {
         this.mouseHidden = true;
         Mouse.hide();
      }
      
      protected function showMouse() : *
      {
         this.mouseHidden = false;
         Mouse.show();
         Mouse.cursor = MouseCursor.ARROW;
         Mouse.cursor = MouseCursor.AUTO;
      }
      
      protected function mouseMoveHandler(param1:MouseEvent) : *
      {
         this.me = param1;
         this.x = param1.stageX;
         this.y = param1.stageY;
      }
      
      protected function mouseDownHandler(param1:MouseEvent) : *
      {
         this.me = param1;
         this.mouseDown = true;
      }
      
      protected function mouseUpHandler(param1:MouseEvent) : *
      {
         this.me = param1;
         this.mouseDown = false;
      }
      
      public function keyDownHandler(param1:KeyboardEvent) : *
      {
         if(LevelEditor.editor == null || instance == null || instance is TextTool || instance is Brush || instance is CursorEyedropper)
         {
            return;
         }
         if((param1.keyCode == Keyboard.COMMAND || param1.keyCode == Keyboard.CONTROL) && !(instance is ObjectDeleter))
         {
            Memory.memory.leCursorTempInstanceType = getQualifiedClassName(instance);
            Memory.memory.leCursorTempInstanceID = instance.getID();
            change(new ObjectDeleter());
         }
      }
      
      public function keyUpHandler(param1:KeyboardEvent) : *
      {
         var _loc2_:* = undefined;
         if(LevelEditor.editor == null || instance == null || instance is TextTool || instance is Brush || instance is CursorEyedropper)
         {
            return;
         }
         if(Memory.memory.leCursorTempInstanceType != null && Memory.memory.leCursorTempInstanceType.indexOf("ObjectDeleter") == -1)
         {
            _loc2_ = getDefinitionByName(Memory.memory.leCursorTempInstanceType) as Class;
            change(new _loc2_(Memory.memory.leCursorTempInstanceID));
            Memory.memory.leCursorTempInstanceType = null;
            Memory.memory.leCursorTempInstanceID = null;
         }
      }
      
      protected function mouseFocusHandler(param1:MouseEvent) : *
      {
         this.me = param1;
      }
      
      protected function applyCursorGraphic(param1:DisplayObject) : *
      {
         param1.x = -(param1.width / 2);
         param1.y = -(param1.height / 2);
         addChild(param1);
      }
      
      override public function remove() : *
      {
         this.pause();
         CustomCursor.instance = null;
         this.me = null;
         super.remove();
      }
   }
}
