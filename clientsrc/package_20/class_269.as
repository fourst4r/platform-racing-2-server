package package_20
{
   import background.ObjectBackground;
   import com.jiggmin.data.*;
   import flash.display.DisplayObject;
   import flash.events.*;
   import flash.geom.*;
   import levelEditor.*;
   import ui.CustomCursor;
   
   public class class_269 extends CustomCursor
   {
       
      
      protected var displayCode:int;
      
      protected var editor:LevelEditor;
      
      public function class_269(param1:int)
      {
         var _loc2_:DisplayObject = null;
         this.editor = LevelEditor.editor;
         super();
         this.displayCode = param1;
         if(param1 >= 0)
         {
            _loc2_ = Objects.getFromCode(param1);
            _loc2_.alpha = 0.5;
            applyCursorGraphic(_loc2_);
            this.method_458();
         }
         addEventListener(Event.ENTER_FRAME,this.method_152,false,0,true);
      }
      
      private function method_458() : *
      {
         scaleX = this.editor.scaleX * this.editor.cur.scaleX;
         scaleY = this.editor.scaleY * this.editor.cur.scaleY;
      }
      
      private function method_152(param1:Event) : *
      {
         this.method_458();
      }
      
      override protected function mouseDownHandler(param1:MouseEvent) : *
      {
         super.mouseDownHandler(param1);
         if(param1.target is BrushGraphic || Boolean(this.editor.menu.hitTestPoint(param1.stageX,param1.stageY,true)) || Boolean(this.editor.cur.hitTestPoint(param1.stageX,param1.stageY,true)))
         {
            this.remove();
         }
         else
         {
            param1.stopImmediatePropagation();
            this.dropObject(param1.stageX,param1.stageY);
         }
      }
      
      protected function dropObject(param1:int, param2:int) : *
      {
         var _loc3_:ObjectBackground = this.editor.cur;
         var _loc4_:DisplayObject = Objects.getFromCode(this.displayCode);
         var _loc5_:Point = new Point(param1,param2);
         _loc5_ = this.editor.cur.globalToLocal(_loc5_);
         _loc5_.x -= _loc4_.width / 2;
         _loc5_.y -= _loc4_.height / 2;
         _loc5_.x = Math.round(_loc5_.x);
         _loc5_.y = Math.round(_loc5_.y);
         _loc3_.addObject(this.displayCode,_loc5_.x,_loc5_.y);
      }
      
      public function getID() : int
      {
         return this.displayCode;
      }
      
      override public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.method_152);
         this.editor = null;
         super.remove();
      }
   }
}
