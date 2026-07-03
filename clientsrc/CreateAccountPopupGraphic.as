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
   
   public dynamic class CreateAccountPopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var createAccount_bt:Button;
      
      public var emailBox:TextInput;
      
      public var nameBox:TextInput;
      
      public var passBox1:TextInput;
      
      public var passBox2:TextInput;
      
      public function CreateAccountPopupGraphic()
      {
         super();
         this.__setProp_createAccount_bt_Symbol486_Layer8_0();
         this.__setProp_nameBox_Symbol486_Layer7_0();
         this.__setProp_passBox1_Symbol486_Layer6_0();
         this.__setProp_passBox2_Symbol486_Layer4_0();
         this.__setProp_cancel_bt_Symbol486_Layer1_0();
      }
      
      internal function __setProp_createAccount_bt_Symbol486_Layer8_0() : *
      {
         try
         {
            this.createAccount_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.createAccount_bt.emphasized = false;
         this.createAccount_bt.enabled = true;
         this.createAccount_bt.label = "Create Account";
         this.createAccount_bt.labelPlacement = "right";
         this.createAccount_bt.selected = false;
         this.createAccount_bt.toggle = false;
         this.createAccount_bt.visible = true;
         try
         {
            this.createAccount_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_nameBox_Symbol486_Layer7_0() : *
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
      
      internal function __setProp_passBox1_Symbol486_Layer6_0() : *
      {
         try
         {
            this.passBox1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.passBox1.displayAsPassword = true;
         this.passBox1.editable = true;
         this.passBox1.enabled = true;
         this.passBox1.maxChars = 0;
         this.passBox1.restrict = "";
         this.passBox1.text = "";
         this.passBox1.visible = true;
         try
         {
            this.passBox1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_passBox2_Symbol486_Layer4_0() : *
      {
         try
         {
            this.passBox2["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.passBox2.displayAsPassword = true;
         this.passBox2.editable = true;
         this.passBox2.enabled = true;
         this.passBox2.maxChars = 0;
         this.passBox2.restrict = "";
         this.passBox2.text = "";
         this.passBox2.visible = true;
         try
         {
            this.passBox2["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_Symbol486_Layer1_0() : *
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
   }
}
