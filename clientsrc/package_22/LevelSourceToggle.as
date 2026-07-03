package package_22
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class LevelSourceToggle extends Sprite
   {
      
      private var box:Sprite;
      
      private var label:TextField;
      
      private var _selected:Boolean;
      
      public function LevelSourceToggle(text:String, selected:Boolean = false)
      {
         this.box = new Sprite();
         this.label = new TextField();
         super();
         this._selected = selected;
         this.drawBox();
         addChild(this.box);
         var format:TextFormat = new TextFormat("_sans",12,0x325638,true);
         this.label.defaultTextFormat = format;
         this.label.autoSize = TextFieldAutoSize.LEFT;
         this.label.selectable = false;
         this.label.mouseEnabled = false;
         this.label.text = text;
         this.label.x = this.box.width + 6;
         this.label.y = -2;
         addChild(this.label);
         buttonMode = true;
         useHandCursor = true;
         mouseChildren = false;
         addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
      }
      
      private function onClick(event:MouseEvent) : void
      {
         this.selected = !this._selected;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(value:Boolean) : void
      {
         if(this._selected == value)
         {
            return;
         }
         this._selected = value;
         this.drawBox();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function drawBox() : void
      {
         this.box.graphics.clear();
         this.box.graphics.lineStyle(1,3355704);
         this.box.graphics.beginFill(this._selected ? 3881782 : 16777215);
         this.box.graphics.drawRect(0,0,12,12);
         this.box.graphics.endFill();
         if(this._selected)
         {
            this.box.graphics.lineStyle(2,16777215);
            this.box.graphics.moveTo(3,7);
            this.box.graphics.lineTo(5,9);
            this.box.graphics.lineTo(9,3);
         }
      }
      
      public function dispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onClick);
      }
   }
}
