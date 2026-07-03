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
   
   public dynamic class LogoutPassPopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var logout_bt:Button;
      
      public var passBox:TextInput;
      
      public function LogoutPassPopupGraphic()
      {
         super();
         this.__setProp_logout_bt_LogoutPassPopup_Layer_1_0();
         this.__setProp_passBox_LogoutPassPopup_Layer_1_0();
         this.__setProp_cancel_bt_LogoutPassPopup_Layer_1_0();
      }
      
      internal function __setProp_logout_bt_LogoutPassPopup_Layer_1_0() : *
      {
         try
         {
            this.logout_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.logout_bt.emphasized = false;
         this.logout_bt.enabled = true;
         this.logout_bt.label = "Log Out";
         this.logout_bt.labelPlacement = "right";
         this.logout_bt.selected = false;
         this.logout_bt.toggle = false;
         this.logout_bt.visible = true;
         try
         {
            this.logout_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_passBox_LogoutPassPopup_Layer_1_0() : *
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
      
      internal function __setProp_cancel_bt_LogoutPassPopup_Layer_1_0() : *
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
