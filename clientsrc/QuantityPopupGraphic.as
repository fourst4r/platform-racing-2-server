package
{
   import fl.controls.Button;
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
   
   public dynamic class QuantityPopupGraphic extends MovieClip
   {
       
      
      public var buy_bt:Button;
      
      public var cancel_bt:Button;
      
      public var costBox:TextField;
      
      public var maxBox:TextField;
      
      public var numSelectedBox:TextField;
      
      public var quantitySlider:Slider;
      
      public function QuantityPopupGraphic()
      {
         super();
         this.__setProp_buy_bt_QuantityPopupGraphic_Layer_1_0();
         this.__setProp_cancel_bt_QuantityPopupGraphic_Layer_1_0();
         this.__setProp_quantitySlider_QuantityPopupGraphic_Layer_1_0();
      }
      
      internal function __setProp_buy_bt_QuantityPopupGraphic_Layer_1_0() : *
      {
         try
         {
            this.buy_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.buy_bt.emphasized = false;
         this.buy_bt.enabled = true;
         this.buy_bt.label = "Buy";
         this.buy_bt.labelPlacement = "right";
         this.buy_bt.selected = false;
         this.buy_bt.toggle = false;
         this.buy_bt.visible = true;
         try
         {
            this.buy_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_QuantityPopupGraphic_Layer_1_0() : *
      {
         try
         {
            this.cancel_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.cancel_bt.emphasized = false;
         this.cancel_bt.enabled = true;
         this.cancel_bt.label = "Cancel";
         this.cancel_bt.labelPlacement = "right";
         this.cancel_bt.selected = false;
         this.cancel_bt.toggle = false;
         this.cancel_bt.visible = true;
         try
         {
            this.cancel_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_quantitySlider_QuantityPopupGraphic_Layer_1_0() : *
      {
         try
         {
            this.quantitySlider["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.quantitySlider.direction = "horizontal";
         this.quantitySlider.enabled = true;
         this.quantitySlider.liveDragging = true;
         this.quantitySlider.maximum = 24;
         this.quantitySlider.minimum = 1;
         this.quantitySlider.snapInterval = 1;
         this.quantitySlider.tickInterval = 1;
         this.quantitySlider.value = 1;
         this.quantitySlider.visible = true;
         try
         {
            this.quantitySlider["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
