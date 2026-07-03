package package_19
{
   import com.jiggmin.data.*;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.*;
   import package_20.*;
   import ui.*;
   
   public class StampButton extends Sprite
   {
       
      
      protected var displayCode:int;
      
      public function StampButton(param1:int)
      {
         var _loc2_:Square = null;
         super();
         this.displayCode = param1;
         _loc2_ = new Square();
         _loc2_.width = _loc2_.height = 30;
         _loc2_.x = _loc2_.y = 15;
         _loc2_.alpha = 0;
         addChild(_loc2_);
         var _loc3_:DisplayObject = Objects.getFromCode(this.displayCode);
         this.fit(_loc3_);
         addChild(_loc3_);
         addEventListener(MouseEvent.MOUSE_DOWN,this.select);
      }
      
      protected function fit(param1:DisplayObject) : *
      {
         var _loc2_:Number = NaN;
         _loc2_ = 24;
         Data.method_314(param1,_loc2_,_loc2_);
         param1.x = (_loc2_ - param1.width) / 2 + 3;
         param1.y = (_loc2_ - param1.height) / 2 + 3;
      }
      
      protected function select(param1:MouseEvent) : *
      {
         param1.stopImmediatePropagation();
         CustomCursor.change(new class_269(this.displayCode));
      }
      
      public function remove() : *
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.select);
         parent.removeChild(this);
      }
   }
}
