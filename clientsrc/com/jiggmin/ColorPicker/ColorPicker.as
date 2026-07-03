package com.jiggmin.ColorPicker
{
   import flash.events.*;
   import flash.geom.*;
   
   public class ColorPicker extends Removable
   {
      
      public static const RIGHT:String = "right";
      
      public static const LEFT:String = "left";
      
      internal static var recentColors:Array = new Array(8947848,5592405,8947848,5592405,8947848,5592405,8947848,5592405,8947848,5592405,8947848,5592405);
       
      
      public var direction:String = "right";
      
      protected var color:int;
      
      private var popup:ColorPickerPopup;
      
      private var m:ColorPickerGraphic;
      
      public function ColorPicker()
      {
         super();
         this.m = new ColorPickerGraphic();
         addChild(this.m);
         this.setColor(255);
         mouseChildren = false;
         addEventListener(MouseEvent.CLICK,this.clickHandler,false,0,true);
      }
      
      public function getColor() : int
      {
         return this.color;
      }
      
      public function setColor(param1:* = null) : *
      {
         var _loc2_:ColorTransform = null;
         param1 = param1 is Number ? param1 : this.popup.getColor();
         if(this.color != param1)
         {
            this.color = param1;
            _loc2_ = new ColorTransform();
            _loc2_.color = this.color;
            this.m.colorMC.transform.colorTransform = _loc2_;
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      private function clickHandler(param1:MouseEvent) : *
      {
         param1.stopImmediatePropagation();
         if(this.popup != null && !this.popup.isRemoved())
         {
            this.closePopup();
         }
         else
         {
            this.openPopup();
         }
      }
      
      private function openPopup() : *
      {
         this.closePopup();
         var _loc1_:Point = this.localToGlobal(new Point(0,0));
         this.popup = new ColorPickerPopup(this.color);
         this.popup.x = this.direction == RIGHT ? _loc1_.x + width + 5 : _loc1_.x - this.popup.width - 5;
         this.popup.addEventListener(Event.CHANGE,this.setColor,false,0,true);
         this.popup.addEventListener(Removable.REMOVE,this.closePopup,false,0,true);
         stage.addChild(this.popup);
         this.popup.init();
         this.popup.method_101(this);
         this.popup.y = _loc1_.y;
         if(this.popup.y > Main.clientHeight - this.popup.height)
         {
            this.popup.y = Main.clientHeight - this.popup.height;
         }
         this.popup.x = Math.round(this.popup.x);
         this.popup.y = Math.round(this.popup.y);
         dispatchEvent(new Event(Event.OPEN));
      }
      
      public function closePopup(param1:* = null) : *
      {
         if(this.popup != null)
         {
            this.setColor(this.popup.getColor());
            this.popup.removeEventListener(Event.CHANGE,this.setColor);
            this.popup.removeEventListener(Removable.REMOVE,this.closePopup);
            this.popup.method_136();
            this.popup = null;
            if(recentColors.indexOf(this.color) == -1)
            {
               recentColors.unshift(this.color);
               recentColors.pop();
            }
            dispatchEvent(new Event(Event.CLOSE));
         }
      }
      
      override public function remove() : *
      {
         removeEventListener(MouseEvent.CLICK,this.clickHandler);
         this.closePopup();
         super.remove();
      }
   }
}
