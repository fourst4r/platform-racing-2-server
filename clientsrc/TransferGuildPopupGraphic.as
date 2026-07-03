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
   
   public dynamic class TransferGuildPopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var emailBox:TextInput;
      
      public var nameBox:TextInput;
      
      public var ok_bt:Button;
      
      public var passBox:TextInput;
      
      public function TransferGuildPopupGraphic()
      {
         super();
         this.__setProp_ok_bt_TransferGuildPopup_Layer7_0();
         this.__setProp_passBox_TransferGuildPopup_Layer6_0();
         this.__setProp_cancel_bt_TransferGuildPopup_Layer5_0();
         this.__setProp_nameBox_TransferGuildPopup_Layer3_0();
         this.__setProp_emailBox_TransferGuildPopup_Layer1_0();
      }
      
      internal function __setProp_ok_bt_TransferGuildPopup_Layer7_0() : *
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
      
      internal function __setProp_passBox_TransferGuildPopup_Layer6_0() : *
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
         this.passBox.maxChars = 0;
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
      
      internal function __setProp_cancel_bt_TransferGuildPopup_Layer5_0() : *
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
      
      internal function __setProp_nameBox_TransferGuildPopup_Layer3_0() : *
      {
         try
         {
            this.nameBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.nameBox.displayAsPassword = false;
         this.nameBox.editable = true;
         this.nameBox.enabled = true;
         this.nameBox.maxChars = 20;
         this.nameBox.restrict = "";
         this.nameBox.text = "";
         this.nameBox.visible = true;
         try
         {
            this.nameBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_emailBox_TransferGuildPopup_Layer1_0() : *
      {
         try
         {
            this.emailBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.emailBox.displayAsPassword = false;
         this.emailBox.editable = true;
         this.emailBox.enabled = true;
         this.emailBox.maxChars = 100;
         this.emailBox.restrict = "";
         this.emailBox.text = "";
         this.emailBox.visible = true;
         try
         {
            this.emailBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
