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
   
   public dynamic class AdminMenuGraphic extends MovieClip
   {
       
      
      public var demote_bt:Button;
      
      public var permaMod_bt:Button;
      
      public var tempMod_bt:Button;
      
      public var trialMod_bt:Button;
      
      public function AdminMenuGraphic()
      {
         super();
         this.__setProp_permaMod_bt_Symbol1138_Layer4_0();
         this.__setProp_demote_bt_Symbol1138_Layer3_0();
         this.__setProp_tempMod_bt_Symbol1138_Layer2_0();
         this.__setProp_trialMod_bt_Symbol1138_Layer1_0();
      }
      
      internal function __setProp_permaMod_bt_Symbol1138_Layer4_0() : *
      {
         try
         {
            this.permaMod_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.permaMod_bt.emphasized = false;
         this.permaMod_bt.enabled = true;
         this.permaMod_bt.label = "Mod";
         this.permaMod_bt.labelPlacement = "right";
         this.permaMod_bt.selected = false;
         this.permaMod_bt.toggle = false;
         this.permaMod_bt.visible = true;
         try
         {
            this.permaMod_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_demote_bt_Symbol1138_Layer3_0() : *
      {
         try
         {
            this.demote_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.demote_bt.emphasized = false;
         this.demote_bt.enabled = true;
         this.demote_bt.label = "De-Mod";
         this.demote_bt.labelPlacement = "right";
         this.demote_bt.selected = false;
         this.demote_bt.toggle = false;
         this.demote_bt.visible = true;
         try
         {
            this.demote_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_tempMod_bt_Symbol1138_Layer2_0() : *
      {
         try
         {
            this.tempMod_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.tempMod_bt.emphasized = false;
         this.tempMod_bt.enabled = true;
         this.tempMod_bt.label = "Temp Mod";
         this.tempMod_bt.labelPlacement = "right";
         this.tempMod_bt.selected = false;
         this.tempMod_bt.toggle = false;
         this.tempMod_bt.visible = true;
         try
         {
            this.tempMod_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_trialMod_bt_Symbol1138_Layer1_0() : *
      {
         try
         {
            this.trialMod_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.trialMod_bt.emphasized = false;
         this.trialMod_bt.enabled = true;
         this.trialMod_bt.label = "Trial Mod";
         this.trialMod_bt.labelPlacement = "right";
         this.trialMod_bt.selected = false;
         this.trialMod_bt.toggle = false;
         this.trialMod_bt.visible = true;
         try
         {
            this.trialMod_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
