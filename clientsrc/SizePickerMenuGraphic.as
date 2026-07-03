package
{
   import fl.controls.Slider;
   import fl.controls.TextInput;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public dynamic class SizePickerMenuGraphic extends MovieClip
   {
       
      
      public var slider:Slider;
      
      public var textBox:TextInput;
      
      public function SizePickerMenuGraphic()
      {
         super();
         this.__setProp_slider_Symbol1301_Layer3_0();
         this.__setProp_textBox_Symbol1301_Layer1_0();
      }
      
      internal function __setProp_slider_Symbol1301_Layer3_0() : *
      {
         try
         {
            this.slider["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.slider.direction = "horizontal";
         this.slider.enabled = true;
         this.slider.liveDragging = true;
         this.slider.maximum = 100;
         this.slider.minimum = 1;
         this.slider.snapInterval = 1;
         this.slider.tickInterval = 0;
         this.slider.value = 0;
         this.slider.visible = true;
         try
         {
            this.slider["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_textBox_Symbol1301_Layer1_0() : *
      {
         try
         {
            this.textBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.textBox.displayAsPassword = false;
         this.textBox.editable = true;
         this.textBox.enabled = true;
         this.textBox.maxChars = 3;
         this.textBox.restrict = "0-9";
         this.textBox.text = "25";
         this.textBox.visible = true;
         try
         {
            this.textBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
