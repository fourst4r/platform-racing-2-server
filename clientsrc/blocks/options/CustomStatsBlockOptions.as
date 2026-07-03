package blocks.options
{
   import blocks.Block;
   import fl.controls.CheckBox;
   import flash.events.*;
   import package_4.*;
   import ui.*;
   
   public class CustomStatsBlockOptions extends BlockOptions
   {
       
      
      private var speedSlider:StatSlider;
      
      private var accelSlider:StatSlider;
      
      private var jumpnSlider:StatSlider;

      private var speedChk:CheckBox;

      private var accelChk:CheckBox;

      private var jumpnChk:CheckBox;
      
      private var resetPop:HoverPopup;
      
      public function CustomStatsBlockOptions(param1:Block)
      {
         m = new CustomStatsBlockOptionsGraphic();
         super(param1);
         this.speedSlider = new StatSlider("Speed",null);
         this.accelSlider = new StatSlider("Acceleration",null);
         this.jumpnSlider = new StatSlider("Jumping",null);
         this.speedSlider.x = this.accelSlider.x = this.jumpnSlider.x = -62.75;
         this.speedSlider.y = -40;
         this.accelSlider.y = 0;
         this.jumpnSlider.y = 40;
        this.speedChk = new CheckBox();
        this.accelChk = new CheckBox();
        this.jumpnChk = new CheckBox();
        this.speedChk.label = this.accelChk.label = this.jumpnChk.label = "";
        this.speedChk.setSize(14,14);
        this.accelChk.setSize(14,14);
        this.jumpnChk.setSize(14,14);
        this.speedChk.selected = this.accelChk.selected = this.jumpnChk.selected = true;
        this.speedChk.addEventListener(Event.CHANGE,this.onApplyChange,false,0,true);
        this.accelChk.addEventListener(Event.CHANGE,this.onApplyChange,false,0,true);
        this.jumpnChk.addEventListener(Event.CHANGE,this.onApplyChange,false,0,true);
         m.resetChk.addEventListener(Event.CHANGE,this.onResetClick,false,0,true);
         if(param1.options == "reset")
         {
            m.resetChk.selected = true;
         }
         var _loc2_:Array = param1.getCustomStats();
         var _loc3_:Array = param1.getCustomStatsEnabled();
         this.speedSlider.setValue(_loc2_[0]);
         this.accelSlider.setValue(_loc2_[1]);
         this.jumpnSlider.setValue(_loc2_[2]);
         this.speedChk.selected = _loc3_[0];
         this.accelChk.selected = _loc3_[1];
         this.jumpnChk.selected = _loc3_[2];
         addChild(this.speedSlider);
         addChild(this.accelSlider);
         addChild(this.jumpnSlider);
         addChild(this.speedChk);
         addChild(this.accelChk);
         addChild(this.jumpnChk);
         this.positionApplyChecks();
         this.updateControlStates();
         m.resetChk.addEventListener(MouseEvent.MOUSE_OVER,this.onResetMouse,false,0,true);
         m.resetChk.addEventListener(MouseEvent.MOUSE_OUT,this.onResetMouse,false,0,true);
      }
      
      private function onResetClick(param1:Event) : *
      {
         this.updateControlStates();
      }

      private function onApplyChange(param1:Event) : *
      {
         this.updateControlStates();
      }

      private function updateControlStates() : *
      {
         var _loc1_:Boolean = !m.resetChk.selected;
         this.speedChk.enabled = this.accelChk.enabled = this.jumpnChk.enabled = _loc1_;
         this.speedChk.alpha = this.accelChk.alpha = this.jumpnChk.alpha = _loc1_ ? 1 : 0.25;
         this.updateSliderState(this.speedSlider,_loc1_ && this.speedChk.selected);
         this.updateSliderState(this.accelSlider,_loc1_ && this.accelChk.selected);
         this.updateSliderState(this.jumpnSlider,_loc1_ && this.jumpnChk.selected);
      }

      private function updateSliderState(param1:StatSlider, param2:Boolean) : *
      {
         param1.alpha = !!param2 ? 1 : 0.25;
         param1.mouseEnabled = param2;
         param1.mouseChildren = param2;
      }

      private function positionApplyChecks() : *
      {
         var _loc1_:Number = this.speedSlider.x + this.speedSlider.width - 10;
         this.speedChk.x = this.accelChk.x = this.jumpnChk.x = _loc1_;
         this.speedChk.y = this.speedSlider.y + (this.speedSlider.height - this.speedChk.height) * 0.5;
         this.accelChk.y = this.accelSlider.y + (this.accelSlider.height - this.accelChk.height) * 0.5;
         this.jumpnChk.y = this.jumpnSlider.y + (this.jumpnSlider.height - this.jumpnChk.height) * 0.5;
      }
      
      private function onResetMouse(param1:MouseEvent = null) : *
      {
         if(param1 != null && param1.type == MouseEvent.MOUSE_OVER && this.resetPop == null)
         {
            this.resetPop = new HoverPopup("Reset To Starting Stats","Checking this box will reset the bumping player\'s stats to those with which they entered the course.",m.resetChk);
         }
         else if(this.resetPop != null)
         {
            this.resetPop.remove();
            this.resetPop = null;
         }
      }
      
      override public function remove() : *
      {
         this.onResetMouse();
         block.applyOptions(!!m.resetChk.selected ? "reset" : [(!!this.speedChk.selected ? this.speedSlider.getValue() : "x"),(!!this.accelChk.selected ? this.accelSlider.getValue() : "x"),(!!this.jumpnChk.selected ? this.jumpnSlider.getValue() : "x")].join("-"));
         super.remove();
      }
   }
}
