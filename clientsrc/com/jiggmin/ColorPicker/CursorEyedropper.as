package com.jiggmin.ColorPicker
{
   import flash.display.*;
   import flash.events.*;
   import ui.CustomCursor;
   
   public class CursorEyedropper extends CustomCursor
   {
       
      
      public var color:int;
      
      private var var_352:Array;
      
      private var cursorContainer:BitmapData;
      
      public function CursorEyedropper()
      {
         this.var_352 = new Array();
         super();
         visible = false;
         addChild(new CursorEyedropperGraphic());
         this.cursorContainer = new BitmapData(stageRef.stageWidth,stageRef.stageHeight);
      }
      
      override public function init() : *
      {
         super.init();
         visible = false;
         addEventListener(Event.ENTER_FRAME,this.maybeUpdate,false,0,true);
      }
      
      override public function pause() : *
      {
         super.pause();
         removeEventListener(Event.ENTER_FRAME,this.maybeUpdate);
      }
      
      public function method_101(param1:DisplayObject) : *
      {
         this.var_352.push(param1);
      }
      
      private function maybeUpdate(param1:Event) : *
      {
         var _loc4_:Boolean = false;
         var _loc2_:MouseEvent = getMouse();
         var _loc3_:DisplayObject = _loc2_ != null ? DisplayObject(_loc2_.target) : null;
         if(_loc3_ != null)
         {
            _loc4_ = true;
            while(_loc3_.parent != null)
            {
               if(this.method_612(_loc3_))
               {
                  _loc4_ = false;
                  break;
               }
               _loc3_ = _loc3_.parent;
            }
            if(_loc4_)
            {
               if(!visible)
               {
                  visible = true;
                  hideMouse();
                  this.drawEyedropper();
               }
               this.updateColor();
               dispatchEvent(new Event(Event.CHANGE));
            }
            else if(visible)
            {
               visible = false;
               showMouse();
               this.color = -1;
               dispatchEvent(new Event(Event.CHANGE));
            }
         }
      }
      
      override protected function mouseDownHandler(param1:MouseEvent) : *
      {
         if(visible)
         {
            param1.stopImmediatePropagation();
            this.drawEyedropper();
            this.updateColor();
            dispatchEvent(new Event(Event.COMPLETE));
         }
         super.mouseDownHandler(param1);
      }
      
      private function drawEyedropper(param1:TimerEvent = null) : *
      {
         if(visible)
         {
            visible = false;
            this.cursorContainer.draw(stageRef);
            visible = true;
         }
      }
      
      private function method_612(param1:DisplayObject) : Boolean
      {
         return this.var_352.indexOf(param1) != -1;
      }
      
      private function updateColor() : *
      {
         var _loc1_:MouseEvent = getMouse();
         this.color = this.cursorContainer.getPixel(Math.floor(_loc1_.stageX),Math.floor(_loc1_.stageY));
      }
      
      override public function remove() : *
      {
         showMouse();
         super.remove();
         this.cursorContainer.dispose();
         this.cursorContainer = null;
         this.var_352 = null;
      }
   }
}
