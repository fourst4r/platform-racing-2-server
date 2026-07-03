package
{
   import fl.controls.Button;
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
   
   public dynamic class MessagesGraphic extends MovieClip
   {
       
      
      public var deleteAll_bt:Button;
      
      public var sendMessage_bt:Button;
      
      public var var_295:MovieClip;
      
      public function MessagesGraphic()
      {
         super();
         this.__setProp_sendMessage_bt_TabPMs_Layer2_0();
         this.__setProp_deleteAll_bt_TabPMs_Layer1_0();
      }
      
      internal function __setProp_sendMessage_bt_TabPMs_Layer2_0() : *
      {
         try
         {
            this.sendMessage_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.sendMessage_bt.emphasized = false;
         this.sendMessage_bt.enabled = true;
         this.sendMessage_bt.label = "Send Message";
         this.sendMessage_bt.labelPlacement = "right";
         this.sendMessage_bt.selected = false;
         this.sendMessage_bt.toggle = false;
         this.sendMessage_bt.visible = true;
         try
         {
            this.sendMessage_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_deleteAll_bt_TabPMs_Layer1_0() : *
      {
         try
         {
            this.deleteAll_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.deleteAll_bt.emphasized = false;
         this.deleteAll_bt.enabled = true;
         this.deleteAll_bt.label = "Delete All";
         this.deleteAll_bt.labelPlacement = "right";
         this.deleteAll_bt.selected = false;
         this.deleteAll_bt.toggle = false;
         this.deleteAll_bt.visible = true;
         try
         {
            this.deleteAll_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
