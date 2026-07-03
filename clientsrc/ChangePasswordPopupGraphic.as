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
   
   public dynamic class ChangePasswordPopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var currentPassBox:TextInput;
      
      public var newPassBox1:TextInput;
      
      public var newPassBox2:TextInput;
      
      public var ok_bt:Button;
      
      public function ChangePasswordPopupGraphic()
      {
         super();
         this.__setProp_ok_bt_Symbol1231_Layer7_0();
         this.__setProp_currentPassBox_Symbol1231_Layer6_0();
         this.__setProp_cancel_bt_Symbol1231_Layer5_0();
         this.__setProp_newPassBox1_Symbol1231_Layer3_0();
         this.__setProp_newPassBox2_Symbol1231_Layer1_0();
      }
      
      internal function __setProp_ok_bt_Symbol1231_Layer7_0() : *
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
      
      internal function __setProp_currentPassBox_Symbol1231_Layer6_0() : *
      {
         try
         {
            this.currentPassBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.currentPassBox.displayAsPassword = true;
         this.currentPassBox.editable = true;
         this.currentPassBox.enabled = true;
         this.currentPassBox.maxChars = 0;
         this.currentPassBox.restrict = "";
         this.currentPassBox.text = "";
         this.currentPassBox.visible = true;
         try
         {
            this.currentPassBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_Symbol1231_Layer5_0() : *
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
      
      internal function __setProp_newPassBox1_Symbol1231_Layer3_0() : *
      {
         try
         {
            this.newPassBox1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.newPassBox1.displayAsPassword = true;
         this.newPassBox1.editable = true;
         this.newPassBox1.enabled = true;
         this.newPassBox1.maxChars = 0;
         this.newPassBox1.restrict = "";
         this.newPassBox1.text = "";
         this.newPassBox1.visible = true;
         try
         {
            this.newPassBox1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_newPassBox2_Symbol1231_Layer1_0() : *
      {
         try
         {
            this.newPassBox2["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.newPassBox2.displayAsPassword = true;
         this.newPassBox2.editable = true;
         this.newPassBox2.enabled = true;
         this.newPassBox2.maxChars = 0;
         this.newPassBox2.restrict = "";
         this.newPassBox2.text = "";
         this.newPassBox2.visible = true;
         try
         {
            this.newPassBox2["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
