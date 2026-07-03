package
{
   import fl.controls.Slider;
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
   
   public dynamic class StatBlockOptionsGraphic extends MovieClip
   {
       
      
      public var descBox:TextField;
      
      public var slider:Slider;
      
      public var statBox:TextField;
      
      public var titleBox:TextField;
      
      public function StatBlockOptionsGraphic()
      {
         super();
         this.__setProp_slider_StatBlockOptions_Layer5_0();
      }
      
      internal function __setProp_slider_StatBlockOptions_Layer5_0() : *
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
         this.slider.minimum = 5;
         this.slider.snapInterval = 5;
         this.slider.tickInterval = 5;
         this.slider.value = 5;
         this.slider.visible = true;
         try
         {
            this.slider["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
