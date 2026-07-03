package com.jiggmin.ColorPicker
{
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.ui.*;
   import package_4.Popup;
   import ui.*;
   
   public class ColorPickerPopup extends Popup
   {
       
      
      private var eyedropper:CursorEyedropper;
      
      private var palette:Sprite;
      
      private var colorChoices:Array;
      
      private var outlineCC:Sprite;
      
      private var outlinePC:Sprite;
      
      private var initialColor:int;
      
      private var previewColor:int = -1;
      
      private var color:int = -1;
      
      private var hue:Number = 0;
      
      private var saturation:Number = 0;
      
      private var brightness:Number = 50;
      
      private var spectrum:Sprite;
      
      private var hueSlider:Sprite;
      
      private var colorPreviewBox:Sprite;
      
      private var spectrumBG:BitmapData;
      
      private var hueArrow:ColorPickerHueArrowGraphic;
      
      private var crosshairs:ColorPickerCrosshairsGraphic;
      
      private var priorCursor:CustomCursor;
      
      private var priorCursorActive:Boolean;
      
      private var me:MouseEvent;
      
      private var m:ColorPickerPopupGraphic;
      
      public function ColorPickerPopup(param1:int)
      {
         var _loc2_:Sprite = null;
         var _loc3_:Sprite = null;
         super(false);
         this.m = new ColorPickerPopupGraphic();
         addChild(this.m);
         this.m.ok_bt.addEventListener(MouseEvent.CLICK,this.clickOK,false,0,true);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel,false,0,true);
         this.m.textBox.restrict = "0123456789abcdefABCDEF#x";
         this.m.textBox.addEventListener(Event.CHANGE,this.setColorFromText,false,0,true);
         this.spectrum = this.initSpectrum(60,60);
         this.spectrum.x = 15;
         this.spectrum.y = 150;
         addChild(this.spectrum);
         this.showOutline(this.spectrum);
         this.hueSlider = this.initHueSlider(15,60);
         this.hueSlider.x = this.spectrum.x + this.spectrum.width + 10;
         this.hueSlider.y = this.spectrum.y;
         addChild(this.hueSlider);
         _loc2_ = this.makeOutline(15,60);
         _loc2_.x = this.hueSlider.x;
         _loc2_.y = this.hueSlider.y;
         addChild(_loc2_);
         this.outlineCC = this.makePickedColorBox();
         this.outlineCC.visible = false;
         this.outlinePC = this.makePickedColorBox();
         this.outlinePC.visible = false;
         this.palette = new Sprite();
         this.palette.x = 15;
         this.palette.y = 15;
         this.palette.mouseChildren = false;
         this.palette.addChild(this.outlineCC);
         this.palette.addChild(this.outlinePC);
         this.initPalette();
         addChild(this.palette);
         this.colorPreviewBox = new Sprite();
         this.colorPreviewBox.graphics.beginFill(0);
         this.colorPreviewBox.graphics.drawRect(0,0,120,25);
         this.colorPreviewBox.graphics.endFill();
         this.colorPreviewBox.x = 115;
         this.colorPreviewBox.y = 185;
         addChild(this.colorPreviewBox);
         _loc3_ = this.makeOutline(120,25);
         _loc3_.x = this.colorPreviewBox.x;
         _loc3_.y = this.colorPreviewBox.y;
         addChild(_loc3_);
         this.setColor(param1);
         this.initialColor = param1;
         this.highlightCurrentColorIfInPalette();
         this.hueSlider.addEventListener(MouseEvent.MOUSE_DOWN,this.clickHueSlider,false,0,true);
         this.spectrum.addEventListener(MouseEvent.MOUSE_DOWN,this.onSpectrumDown,false,0,true);
         this.palette.addEventListener(MouseEvent.MOUSE_MOVE,this.hoverOverPalette,false,0,true);
         this.palette.addEventListener(MouseEvent.MOUSE_DOWN,this.clickPalette,false,0,true);
         this.palette.addEventListener(MouseEvent.MOUSE_OUT,this.hoverOutPalette,false,0,true);
      }
      
      public function init() : *
      {
         this.eyedropper = new CursorEyedropper();
         this.eyedropper.method_101(this);
         this.eyedropper.addEventListener(Event.CHANGE,this.onEyedropperMove,false,0,true);
         this.eyedropper.addEventListener(Event.COMPLETE,this.applyColor,false,0,true);
         if(CustomCursor.instance != null)
         {
            this.priorCursor = CustomCursor.instance;
            this.priorCursorActive = this.priorCursor.isActive();
            this.priorCursor.pause();
         }
         CustomCursor.change(this.eyedropper);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler,false,0,true);
         if(x + width > Main.stage.stageWidth)
         {
            x = Main.stage.stageWidth - width;
         }
         if(x < 0)
         {
            x = 0;
         }
         if(y + height > Main.stage.stageHeight)
         {
            y = Main.stage.stageHeight - height;
         }
         if(y < 0)
         {
            y = 0;
         }
      }
      
      public function setColor(param1:int) : *
      {
         var _loc2_:Object = null;
         if(this.color != param1)
         {
            this.color = param1;
            _loc2_ = ColorUtil.hex24ToHSB(param1);
            this.hue = _loc2_.hue;
            this.hueArrow.y = Math.round(60 - this.hue / 360 * 60);
            this.updateSpectrumGradient();
            this.saturation = _loc2_.saturation;
            this.crosshairs.x = Math.round(this.saturation / 100 * 60);
            this.brightness = _loc2_.brightness;
            this.crosshairs.y = Math.round(60 - this.brightness / 100 * 60);
            this.updateColorPreview();
         }
      }
      
      private function updateColorPreview(param1:int = -1) : *
      {
         if(param1 == -1)
         {
            param1 = int(ColorUtil.hsbToHex24(this.hue,this.saturation,this.brightness));
         }
         if(stage.focus != this.m.textBox.textField)
         {
            this.m.textBox.text = "#" + ColorUtil.decimalToHex(param1).substr(2);
         }
         this.changePreviewBoxColor(this.colorPreviewBox,param1);
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function getColor() : int
      {
         return this.previewColor != -1 ? int(this.previewColor) : int(this.color);
      }
      
      public function method_101(param1:DisplayObject) : *
      {
         this.eyedropper.method_101(param1);
      }
      
      private function changePreviewBoxColor(param1:DisplayObject, param2:int) : *
      {
         var _loc3_:Object = ColorUtil.hex24ToRGB(param2);
         param1.transform.colorTransform = new ColorTransform(0,0,0,1,_loc3_.red,_loc3_.green,_loc3_.blue,0);
      }
      
      private function highlightCurrentColorIfInPalette() : *
      {
         var _loc3_:int = 0;
         var _loc1_:int = 10;
         var _loc2_:int = 0;
         while(_loc2_ < this.colorChoices.length)
         {
            _loc3_ = 0;
            while(_loc3_ < this.colorChoices[_loc2_].length)
            {
               if(this.colorChoices[_loc2_][_loc3_] == this.color)
               {
                  this.outlineCC.visible = true;
                  this.outlineCC.x = _loc2_ * _loc1_;
                  this.outlineCC.y = _loc3_ * _loc1_;
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      private function mouseUpHandler(param1:MouseEvent) : *
      {
         Mouse.show();
         Mouse.cursor = MouseCursor.ARROW;
         Mouse.cursor = MouseCursor.AUTO;
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.previewColorAtMouse);
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.dragHueSlider);
      }
      
      private function onSpectrumDown(param1:MouseEvent) : *
      {
         Mouse.hide();
         this.previewColorAtMouse(param1);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.previewColorAtMouse,false,0,true);
      }
      
      private function clickHueSlider(param1:MouseEvent) : *
      {
         Mouse.hide();
         this.dragHueSlider(param1);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.dragHueSlider,false,0,true);
      }
      
      private function previewColorAtMouse(param1:MouseEvent) : *
      {
         var _loc2_:Point = this.spectrum.globalToLocal(new Point(param1.stageX,param1.stageY));
         var _loc3_:int = int(Data.numLimit(Math.round(_loc2_.x),0,60));
         var _loc4_:int = int(Data.numLimit(Math.round(_loc2_.y),0,60));
         this.crosshairs.x = _loc3_;
         this.crosshairs.y = _loc4_;
         this.saturation = 100 * (_loc3_ / 60);
         this.brightness = 100 - 100 * (_loc4_ / 60);
         this.color = ColorUtil.hsbToHex24(this.hue,this.saturation,this.brightness);
         this.updateColorPreview();
         this.outlineCC.visible = false;
      }
      
      private function dragHueSlider(param1:MouseEvent) : *
      {
         var _loc3_:int = 0;
         var _loc2_:Point = this.hueSlider.globalToLocal(new Point(param1.stageX,param1.stageY));
         _loc3_ = int(Data.numLimit(_loc2_.y,0,60));
         this.hueArrow.y = Math.round(_loc3_);
         this.hue = 360 - 360 * (_loc3_ / 60);
         this.color = ColorUtil.hsbToHex24(this.hue,this.saturation,this.brightness);
         this.updateSpectrumGradient();
         this.updateColorPreview();
         this.outlineCC.visible = false;
      }
      
      private function onEyedropperMove(param1:Event) : *
      {
         this.previewColor = this.eyedropper.color;
         this.updateColorPreview(this.previewColor);
      }
      
      private function applyColor(param1:Event) : *
      {
         this.previewColor = -1;
         this.setColor(this.eyedropper.color);
         this.updateColorPreview();
         method_136();
      }
      
      private function hoverOverPalette(param1:MouseEvent) : *
      {
         var _loc2_:Point = this.palette.globalToLocal(new Point(param1.stageX,param1.stageY));
         var _loc3_:int = int(Data.numLimit(Math.floor(_loc2_.x / 10),0,21));
         var _loc4_:int = int(Data.numLimit(Math.floor(_loc2_.y / 10),0,11));
         this.outlinePC.x = _loc3_ * 10;
         this.outlinePC.y = _loc4_ * 10;
         this.outlinePC.visible = true;
         this.previewColor = this.colorChoices[_loc3_][_loc4_];
         this.updateColorPreview(this.previewColor);
      }
      
      private function clickPalette(param1:MouseEvent) : *
      {
         param1.stopImmediatePropagation();
         var _loc2_:int = this.outlinePC.x / 10;
         var _loc3_:int = this.outlinePC.y / 10;
         this.setColor(this.colorChoices[_loc2_][_loc3_]);
         this.outlineCC.x = _loc2_ * 10;
         this.outlineCC.y = _loc3_ * 10;
         this.outlineCC.visible = true;
         this.remove();
      }
      
      private function hoverOutPalette(param1:MouseEvent) : *
      {
         this.previewColor = -1;
         this.outlinePC.visible = false;
         this.updateColorPreview();
      }
      
      private function setColorFromText(param1:Event) : *
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(stage.focus == this.m.textBox.textField)
         {
            _loc2_ = String(this.m.textBox.text);
            _loc3_ = 0;
            if(_loc2_ != "")
            {
               _loc2_ = _loc2_.split("#").join("");
               _loc2_ = _loc2_.split("0x").join("");
               _loc3_ = Number("0x" + _loc2_);
               if(isNaN(_loc3_))
               {
                  _loc3_ = 0;
               }
            }
            this.setColor(_loc3_);
         }
      }
      
      private function clickOK(param1:MouseEvent) : *
      {
         this.remove();
      }
      
      private function clickCancel(param1:MouseEvent) : *
      {
         this.color = this.initialColor;
         dispatchEvent(new Event(Event.CHANGE));
         this.remove();
      }
      
      private function initPalette() : *
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this.palette.graphics.clear();
         this.palette.graphics.lineStyle(1,0,1,true);
         this.colorChoices = ColorChoices.populate();
         var _loc1_:int = 10;
         var _loc2_:int = 0;
         while(_loc2_ < this.colorChoices.length)
         {
            _loc3_ = this.colorChoices[_loc2_];
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if((_loc5_ = int(this.colorChoices[_loc2_][_loc4_])) == this.color)
               {
                  this.outlineCC.visible = true;
                  this.outlineCC.x = _loc2_ * _loc1_;
                  this.outlineCC.y = _loc4_ * _loc1_;
               }
               this.palette.graphics.beginFill(_loc5_);
               this.palette.graphics.drawRect(_loc2_ * _loc1_,_loc4_ * _loc1_,_loc1_,_loc1_);
               this.palette.graphics.endFill();
               _loc4_++;
            }
            _loc2_++;
         }
      }
      
      private function makePickedColorBox() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.lineStyle(1,16777215,1,true);
         _loc1_.graphics.drawRect(0,0,10,10);
         return _loc1_;
      }
      
      private function initHueSlider(param1:int, param2:int) : Sprite
      {
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc3_:BitmapData = new BitmapData(param1,param2,false,16777215);
         var _loc4_:int = 0;
         while(_loc4_ < param2)
         {
            _loc7_ = 360 - 360 * _loc4_ / param2;
            _loc8_ = Number(ColorUtil.hsbToHex24(_loc7_,100,100));
            _loc3_.fillRect(new Rectangle(0,_loc4_,param1,1),_loc8_);
            _loc4_++;
         }
         this.hueArrow = new ColorPickerHueArrowGraphic();
         this.hueArrow.x = param1 + 1;
         this.hueArrow.y = param2;
         this.hueArrow.mouseEnabled = this.hueArrow.mouseChildren = false;
         var _loc5_:Sprite;
         (_loc5_ = new Sprite()).graphics.beginFill(0,0);
         _loc5_.graphics.drawRect(0,0,param1 + 10,param2);
         _loc5_.graphics.endFill();
         var _loc6_:Sprite;
         (_loc6_ = new Sprite()).addChild(new Bitmap(_loc3_));
         _loc6_.addChild(this.hueArrow);
         _loc6_.addChild(_loc5_);
         return _loc6_;
      }
      
      private function initSpectrum(param1:int, param2:int) : Sprite
      {
         this.spectrumBG = new BitmapData(param1,param2,false,0);
         this.crosshairs = new ColorPickerCrosshairsGraphic();
         this.crosshairs.mouseEnabled = this.crosshairs.mouseChildren = false;
         this.crosshairs.x = this.crosshairs.y = 20;
         var _loc3_:Sprite = new Sprite();
         _loc3_.addChild(new Bitmap(this.spectrumBG));
         _loc3_.addChild(this.crosshairs);
         return _loc3_;
      }
      
      private function updateSpectrumGradient() : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc1_:int = 0;
         while(_loc1_ < this.spectrumBG.width)
         {
            _loc2_ = _loc1_ / this.spectrumBG.width * 100;
            _loc3_ = 0;
            while(_loc3_ < this.spectrumBG.height)
            {
               _loc4_ = 100 - _loc3_ / this.spectrumBG.height * 100;
               _loc5_ = Number(ColorUtil.hsbToHex24(this.hue,_loc2_,_loc4_));
               this.spectrumBG.setPixel(_loc1_,_loc3_,_loc5_);
               _loc3_++;
            }
            _loc1_++;
         }
      }
      
      private function showOutline(param1:DisplayObject) : Sprite
      {
         var _loc2_:Sprite = this.makeOutline(Math.round(param1.width),Math.round(param1.height));
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         addChild(_loc2_);
      }
      
      private function makeOutline(param1:int, param2:int) : Sprite
      {
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.lineStyle(1,3355443,1,true);
         _loc3_.graphics.moveTo(0,param2);
         _loc3_.graphics.lineTo(0,0);
         _loc3_.graphics.lineTo(param1,0);
         _loc3_.graphics.lineStyle(1,16777215,1,true);
         _loc3_.graphics.lineTo(param1,param2);
         _loc3_.graphics.lineTo(0,param2);
         return _loc3_;
      }
      
      override public function remove() : *
      {
         if(!isRemoved())
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.previewColorAtMouse);
            this.spectrum.removeEventListener(MouseEvent.MOUSE_DOWN,this.onSpectrumDown);
            this.hueSlider.removeEventListener(MouseEvent.MOUSE_DOWN,this.clickHueSlider);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.dragHueSlider);
            this.palette.removeEventListener(MouseEvent.MOUSE_MOVE,this.hoverOverPalette);
            this.palette.removeEventListener(MouseEvent.MOUSE_DOWN,this.clickPalette);
            this.palette.removeEventListener(MouseEvent.MOUSE_OUT,this.hoverOutPalette);
            this.eyedropper.removeEventListener(Event.CHANGE,this.onEyedropperMove);
            this.eyedropper.removeEventListener(Event.COMPLETE,this.applyColor);
            this.m.ok_bt.removeEventListener(MouseEvent.CLICK,this.clickOK);
            this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
            this.m.textBox.removeEventListener(Event.CHANGE,this.setColorFromText);
            this.spectrumBG.dispose();
            if(CustomCursor.instance != null)
            {
               CustomCursor.unsetInstance();
               if(this.priorCursor != null)
               {
                  CustomCursor.change(this.priorCursor);
                  this.priorCursor.init();
                  if(!this.priorCursorActive)
                  {
                     this.priorCursor.pause();
                  }
               }
            }
            else if(this.priorCursor != null)
            {
               this.priorCursor.remove();
            }
            this.spectrum = null;
            this.hueSlider = null;
            this.palette = null;
            this.spectrumBG = null;
            this.hueArrow = null;
            this.crosshairs = null;
            this.eyedropper = null;
            this.priorCursor = null;
            this.me = null;
         }
         super.remove();
      }
   }
}
