package ui
{
   import flash.display.Sprite;
   import flash.events.*;
   
   public class ArrowButtons extends Sprite
   {
       
      
      private var m:ArrowButtonsGraphic;
      
      private var array:Array;
      
      private var index:int = 0;
      
      public var value:int;
      
      public function ArrowButtons(param1:Array, param2:int)
      {
         this.m = new ArrowButtonsGraphic();
         super();
         this.array = param1;
         this.setValue(param2);
         addChild(this.m);
         this.m.left.addEventListener(MouseEvent.CLICK,this.clickLeft);
         this.m.right.addEventListener(MouseEvent.CLICK,this.clickRight);
      }
      
      private function clickLeft(param1:MouseEvent) : *
      {
         --this.index;
         this.wrapCheck();
      }
      
      private function clickRight(param1:MouseEvent) : *
      {
         ++this.index;
         this.wrapCheck();
      }
      
      private function wrapCheck() : *
      {
         var _loc1_:int = this.array.length - 1;
         this.index = this.index < 0 ? _loc1_ : (this.index > _loc1_ ? 0 : int(this.index));
         this.value = this.array[this.index];
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function setValue(param1:int) : *
      {
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         while(_loc3_ < this.array.length)
         {
            if(param1 == this.array[_loc3_])
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         if(_loc2_ == -1)
         {
            _loc2_ = 0;
         }
         else
         {
            this.value = param1;
            this.index = _loc2_;
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function remove() : *
      {
         this.m.left.removeEventListener(MouseEvent.CLICK,this.clickLeft);
         this.m.right.removeEventListener(MouseEvent.CLICK,this.clickRight);
         removeChild(this.m);
         this.m = null;
         parent.removeChild(this);
      }
   }
}
