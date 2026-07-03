package package_18
{
   import com.jiggmin.ColorPicker.*;
   import flash.display.*;
   import flash.events.*;
   import ui.*;
   
   public class PartSelector extends Sprite
   {
       
      
      private var arrows:ArrowButtons;
      
      private var cp:ColorPicker;
      
      private var cp2:ColorPicker;
      
      private var color:int = 0;
      
      private var color2:int = 0;
      
      private var value:int = 0;
      
      public var infoButton:InfoButton;
      
      public var partArray:Array;
      
      public var epicArray:Array;
      
      private var var_182:DisplayObject;
      
      public function PartSelector(param1:Array, param2:int, param3:int, param4:Array, param5:int = -1)
      {
         var _loc6_:DisplayObject = null;
         super();
         this.value = param2;
         this.color = param3;
         this.color2 = param5;
         this.cp = new ColorPicker();
         this.cp.addEventListener(Event.CLOSE,this.onColorChange,false,0,true);
         this.cp.width = this.cp.height = 20;
         this.cp.setColor(this.color);
         this.cp.x = 120;
         addChild(this.cp);
         this.cp2 = new ColorPicker();
         this.cp2.addEventListener(Event.CLOSE,this.onColorChange,false,0,true);
         this.cp2.width = this.cp2.height = 20;
         this.cp2.setColor(this.color2);
         this.cp2.x = 120;
         addChild(this.cp2);
         (_loc6_ = this.method_737(this.cp.width,this.cp.height)).x = this.cp2.x;
         _loc6_.y = this.cp2.y;
         addChild(_loc6_);
         this.cp2.mask = _loc6_;
         this.var_182 = this.method_809(this.cp.width - 6,this.cp.height - 6);
         this.var_182.x = this.cp2.x + 3;
         this.var_182.y = this.cp2.y + 3;
         addChild(this.var_182);
         this.partArray = param1;
         this.epicArray = param4;
         this.cpEpicCheck();
         this.arrows = new ArrowButtons(param1,param2);
         this.arrows.addEventListener(Event.CHANGE,this.onArrowClick,false,0,true);
         addChild(this.arrows);
         this.infoButton = new InfoButton();
         this.infoButton.width = 15;
         this.infoButton.height = 20.3;
         this.infoButton.x = this.cp.x + 27.5;
         this.infoButton.y = this.cp.y + 3;
         addChild(this.infoButton);
      }
      
      public function getColor() : int
      {
         return this.color;
      }
      
      public function getColorCP2() : int
      {
         return this.cp2.getColor();
      }
      
      public function getColor2() : int
      {
         return this.isPartEpic() ? int(this.color2) : -1;
      }
      
      public function getValue() : int
      {
         return int(this.value);
      }
      
      public function setValue(param1:int) : *
      {
         this.value = param1;
         this.cpEpicCheck();
         this.arrows.setValue(this.value);
      }
      
      public function setColors(param1:int, param2:int) : *
      {
         this.cp.setColor(param1);
         this.cp2.setColor(param2 == -1 ? this.color2 : param2);
         this.color = param1;
         this.color2 = param2 == -1 ? int(this.color2) : param2;
         this.cpEpicCheck();
      }
      
      public function randomize() : *
      {
         var _loc1_:int = int(this.partArray[Math.floor(Math.random() * this.partArray.length)]);
         var _loc2_:int = Math.floor(Math.random() * 16777215);
         var _loc3_:int = Math.floor(Math.random() * 16777215);
         this.setColors(_loc2_,_loc3_);
         this.setValue(_loc1_);
      }
      
      public function isPartEpic(param1:* = null) : Boolean
      {
         return this.epicArray.indexOf(param1 != null ? param1.toString() : this.value.toString()) != -1 || this.epicArray.indexOf("*") != -1;
      }
      
      private function method_737(param1:int, param2:int) : DisplayObject
      {
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(0);
         _loc3_.graphics.moveTo(0,param2);
         _loc3_.graphics.lineTo(param1,param2);
         _loc3_.graphics.lineTo(param1,0);
         _loc3_.graphics.lineTo(0,param2);
         _loc3_.graphics.endFill();
         return _loc3_;
      }
      
      private function method_809(param1:int, param2:int) : DisplayObject
      {
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.lineStyle(1,0);
         _loc3_.graphics.moveTo(0,param2);
         _loc3_.graphics.lineTo(param1,0);
         _loc3_.alpha = 0.5;
         _loc3_.mouseEnabled = false;
         _loc3_.mouseChildren = false;
         return _loc3_;
      }
      
      private function onColorChange(param1:Event) : *
      {
         this.color = this.cp.getColor();
         this.color2 = this.cp2.getColor();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function onArrowClick(param1:Event) : *
      {
         this.value = this.arrows.value;
         this.cpEpicCheck();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function cpEpicCheck() : *
      {
         if(this.isPartEpic())
         {
            this.cp2.visible = true;
            this.var_182.visible = true;
         }
         else
         {
            this.cp2.visible = false;
            this.var_182.visible = false;
         }
      }
      
      public function remove() : *
      {
         this.cp.removeEventListener(Event.CLOSE,this.onColorChange);
         this.cp.remove();
         this.cp = null;
         this.cp2.removeEventListener(Event.CLOSE,this.onColorChange);
         this.cp2.remove();
         this.cp2 = null;
         this.arrows.removeEventListener(Event.CHANGE,this.onArrowClick);
         this.arrows.remove();
         this.arrows = null;
         removeChild(this.infoButton);
         this.infoButton = null;
         removeChild(this.var_182);
         this.var_182 = null;
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}
