package blocks.options
{
   import blocks.Block;
   import com.jiggmin.ColorPicker.*;
   import fl.controls.ComboBox;
   import fl.data.DataProvider;
   import flash.events.*;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFieldAutoSize;
   import flash.display.MovieClip;
   
   public class PillarBlockOptions extends BlockOptions
   {
      private var styleSelect:ComboBox;
      
      private var colorPicker:ColorPicker;
      
      public function PillarBlockOptions(param1:Block)
      {
         var _loc2_:MovieClip = new MovieClip();
         this.styleSelect = new ComboBox();
         this.colorPicker = new ColorPicker();
         this.buildPanel(_loc2_,param1);
         m = _loc2_;
         super(param1);
         this.styleSelect.addEventListener(Event.CHANGE,this.onChange,false,0,true);
         this.colorPicker.addEventListener(Event.CLOSE,this.onChange,false,0,true);
      }
      
      private function buildPanel(param1:MovieClip, param2:Block) : *
      {
         var _loc2_:TextField = null;
         var _loc3_:TextField = null;
         var _loc4_:DataProvider = new DataProvider();
         param1.graphics.lineStyle(1,4473924);
         param1.graphics.beginFill(16777215,0.97);
         param1.graphics.drawRoundRect(0,0,155,82,10,10);
         param1.graphics.endFill();
         _loc2_ = this.makeLabel("Style",10,10);
         _loc3_ = this.makeLabel("Background",10,45);
         param1.addChild(_loc2_);
         param1.addChild(_loc3_);
         _loc4_.addItem({
            "label":"Pillar 1",
            "data":1
         });
         _loc4_.addItem({
            "label":"Pillar 2",
            "data":2
         });
         _loc4_.addItem({
            "label":"Pillar 3",
            "data":3
         });
         this.styleSelect.dataProvider = _loc4_;
         this.styleSelect.width = 95;
         this.styleSelect.dropdownWidth = 95;
         this.styleSelect.rowCount = 3;
         this.styleSelect.editable = false;
         this.styleSelect.x = 50;
         this.styleSelect.y = 6;
         this.styleSelect.selectedIndex = Math.max(0, Math.min(2, param2.getStyle() - 1));
         param1.addChild(this.styleSelect);
         this.colorPicker.width = this.colorPicker.height = 30;
         this.colorPicker.x = 105;
         this.colorPicker.y = 43;
         this.colorPicker.setColor(param2.getColor());
         param1.addChild(this.colorPicker);
      }
      
      private function makeLabel(param1:String, param2:Number, param3:Number) : TextField
      {
         var _loc4_:TextField = new TextField();
         _loc4_.defaultTextFormat = new TextFormat("_sans",11,2236962,true);
         _loc4_.autoSize = TextFieldAutoSize.LEFT;
         _loc4_.selectable = false;
         _loc4_.mouseEnabled = false;
         _loc4_.text = param1;
         _loc4_.x = param2;
         _loc4_.y = param3;
         return _loc4_;
      }
      
      private function onChange(param1:Event = null) : *
      {
         block.applyOptions(this.getOptionsString());
      }
      
      private function getOptionsString() : String
      {
         var _loc1_:Object = this.styleSelect.selectedItem;
         var _loc2_:int = _loc1_ != null && _loc1_.data != null ? int(_loc1_.data) : 1;
         return _loc2_ + ":" + this.colorPicker.getColor();
      }
      
      override public function remove() : *
      {
         this.onChange();
         super.remove();
      }
   }
}
