package
{
   import fl.controls.Button;
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
   
   public dynamic class SetEmailPopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var email1Box:TextInput;
      
      public var email2Box:TextInput;
      
      public var ok_bt:Button;
      
      public var passBox:TextInput;
      
      public function SetEmailPopupGraphic()
      {
         super();
         this.__setProp_ok_bt_SetChangeEmail_Layer7_0();
         this.__setProp_email1Box_SetChangeEmail_Layer6_0();
         this.__setProp_cancel_bt_SetChangeEmail_Layer5_0();
         this.__setProp_email2Box_SetChangeEmail_Layer3_0();
         this.__setProp_passBox_SetChangeEmail_Layer1_0();
      }
      
      internal function __setProp_ok_bt_SetChangeEmail_Layer7_0() : *
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
      
      internal function __setProp_email1Box_SetChangeEmail_Layer6_0() : *
      {
         try
         {
            this.email1Box["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.email1Box.displayAsPassword = false;
         this.email1Box.editable = true;
         this.email1Box.enabled = true;
         this.email1Box.maxChars = 100;
         this.email1Box.restrict = "";
         this.email1Box.text = "";
         this.email1Box.visible = true;
         try
         {
            this.email1Box["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_SetChangeEmail_Layer5_0() : *
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
      
      internal function __setProp_email2Box_SetChangeEmail_Layer3_0() : *
      {
         try
         {
            this.email2Box["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.email2Box.displayAsPassword = false;
         this.email2Box.editable = true;
         this.email2Box.enabled = true;
         this.email2Box.maxChars = 100;
         this.email2Box.restrict = "";
         this.email2Box.text = "";
         this.email2Box.visible = true;
         try
         {
            this.email2Box["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_passBox_SetChangeEmail_Layer1_0() : *
      {
         try
         {
            this.passBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.passBox.displayAsPassword = true;
         this.passBox.editable = true;
         this.passBox.enabled = true;
         this.passBox.maxChars = 100;
         this.passBox.restrict = "";
         this.passBox.text = "";
         this.passBox.visible = true;
         try
         {
            this.passBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
