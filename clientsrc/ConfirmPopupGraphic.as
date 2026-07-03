package
{
   import fl.controls.Button;
   import fl.controls.TextArea;
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
   
   public dynamic class ConfirmPopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var ok_bt:Button;
      
      public var textBox:TextArea;
      
      public function ConfirmPopupGraphic()
      {
         super();
         this.__setProp_ok_bt_Symbol1093_Layer3_0();
         this.__setProp_cancel_bt_Symbol1093_Layer2_0();
         this.__setProp_textBox_Symbol1093_Layer1_0();
      }
      
      internal function __setProp_ok_bt_Symbol1093_Layer3_0() : *
      {
         try
         {
            this.ok_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.ok_bt.emphasized = false;
         this.ok_bt.enabled = true;
         this.ok_bt.label = "OK";
         this.ok_bt.labelPlacement = "right";
         this.ok_bt.selected = false;
         this.ok_bt.toggle = false;
         this.ok_bt.visible = true;
         try
         {
            this.ok_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_Symbol1093_Layer2_0() : *
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
      
      internal function __setProp_textBox_Symbol1093_Layer1_0() : *
      {
         try
         {
            this.textBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.textBox.condenseWhite = false;
         this.textBox.editable = false;
         this.textBox.enabled = true;
         this.textBox.horizontalScrollPolicy = "auto";
         this.textBox.htmlText = "";
         this.textBox.maxChars = 0;
         this.textBox.restrict = "";
         this.textBox.text = "";
         this.textBox.verticalScrollPolicy = "auto";
         this.textBox.visible = true;
         this.textBox.wordWrap = true;
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
