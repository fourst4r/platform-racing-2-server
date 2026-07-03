package ui
{
   import com.jiggmin.data.*;
   import fl.events.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class StatSlider extends Removable
   {
       
      
      private var m:StatSliderGraphic;
      
      private var target:StatsSelect;
      
      internal var value:Number;
      
      private var holdStart:Number = 0;
      
      private var holdSpeed:int = 0;
      
      private var updateInterval:uint;
      
      public function StatSlider(param1:String, param2:StatsSelect)
      {
         this.m = new StatSliderGraphic();
         super();
         this.target = param2;
         this.m.nameBox.text = param1;
         this.m.textBox.restrict = "0123456789";
         addChild(this.m);
         this.m.decBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.arrowBtnDown,false,0,true);
         this.m.incBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.arrowBtnDown,false,0,true);
         this.m.decBtn.addEventListener(MouseEvent.MOUSE_UP,this.arrowBtnUp,false,0,true);
         this.m.incBtn.addEventListener(MouseEvent.MOUSE_UP,this.arrowBtnUp,false,0,true);
         this.m.slider.addEventListener(Event.CHANGE,this.onSliderChange,false,0,true);
         this.m.textBox.addEventListener(Event.CHANGE,this.onTextChange,false,0,true);
         if(this.target != null)
         {
            this.m.slider.addEventListener(SliderEvent.THUMB_RELEASE,this.target.saveLEStats,false,0,true);
         }
      }
      
      private function arrowBtnDown(param1:MouseEvent) : *
      {
         this.holdStart = Data.getMS();
         this.updateHoldSpeed(param1.target === this.m.incBtn ? "inc" : "dec");
      }
      
      private function arrowBtnUp(param1:* = null) : *
      {
         this.holdStart = this.holdSpeed = 0;
         clearInterval(this.updateInterval);
         if(this.target != null)
         {
            this.target.updateSavedLEStats = param1 === false ? Boolean(this.target.updateSavedLEStats) : true;
            this.target.saveLEStats();
         }
      }
      
      private function updateHoldSpeed(param1:String) : *
      {
         var mode:String = param1;
         var now:Number = Number(Data.getMS());
         if(now - this.holdStart <= 2000)
         {
            this.holdSpeed = 8;
            this.updateStatFromHeld(mode);
         }
         else if(now - this.holdStart <= 4000)
         {
            this.holdSpeed = 16;
         }
         else
         {
            this.holdSpeed = 32;
         }
         clearInterval(this.updateInterval);
         if(this.holdSpeed <= 0)
         {
            return;
         }
         this.updateInterval = setInterval(function():*
         {
            updateStatFromHeld(mode);
         },Math.floor(1000 / this.holdSpeed));
      }
      
      private function updateStatFromHeld(param1:String) : *
      {
         var _loc2_:int = Data.getMS() - this.holdStart;
         var _loc3_:int = param1 === "inc" ? int(this.value + 1) : int(this.value - 1);
         this.setValue(Data.numLimit(_loc3_,0,100));
         if(this.holdSpeed === 8 && _loc2_ > 2000 || this.holdSpeed === 16 && _loc2_ > 4000)
         {
            this.updateHoldSpeed(param1);
         }
         else if(_loc3_ <= 0 && param1 === "dec" || _loc3_ >= 100 && param1 === "inc")
         {
            this.arrowBtnUp();
         }
      }
      
      private function onSliderChange(param1:Event) : *
      {
         this.setValue(param1.target.value);
         if(this.target != null)
         {
            this.target.updateSavedLEStats = true;
         }
      }
      
      private function onTextChange(param1:Event) : *
      {
         this.setValue(int(param1.target.text));
         if(this.target != null)
         {
            this.target.updateSavedLEStats = true;
         }
      }
      
      public function getValue() : *
      {
         return this.value;
      }
      
      public function setValue(param1:int) : *
      {
         var _loc2_:Number = NaN;
         this.value = Data.numLimit(param1,0,100);
         if(this.target != null)
         {
            _loc2_ = Number(this.target.getPointsRemaining());
            this.value = _loc2_ < 0 ? this.value + _loc2_ : Number(this.value);
            this.m.textBox.text = this.m.slider.value = this.value;
            this.target.updateStatsDisplay();
            if(_loc2_ <= 0 && this.holdStart > 0)
            {
               this.arrowBtnUp();
            }
         }
         else
         {
            this.m.textBox.text = this.m.slider.value = this.value;
         }
      }
      
      override public function remove() : *
      {
         this.arrowBtnUp(false);
         this.m.slider.removeEventListener(Event.CHANGE,this.onSliderChange);
         this.m.textBox.removeEventListener(Event.CHANGE,this.onTextChange);
         removeChild(this.m);
         this.m = null;
         this.target = null;
         super.remove();
      }
   }
}
