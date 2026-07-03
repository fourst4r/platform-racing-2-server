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
   
   public dynamic class TempModMenuGraphic extends MovieClip
   {
       
      
      public var kickButton:Button;
      
      public var warning1Button:Button;
      
      public var warning2Button:Button;
      
      public var warning3Button:Button;
      
      public function TempModMenuGraphic()
      {
         super();
         this.__setProp_warning1Button_TempModMenu_Layer4_0();
         this.__setProp_warning2Button_TempModMenu_Layer3_0();
         this.__setProp_warning3Button_TempModMenu_Layer2_0();
         this.__setProp_kickButton_TempModMenu_Layer1_0();
      }
      
      internal function __setProp_warning1Button_TempModMenu_Layer4_0() : *
      {
         try
         {
            this.warning1Button["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.warning1Button.emphasized = false;
         this.warning1Button.enabled = true;
         this.warning1Button.label = "Warning 1";
         this.warning1Button.labelPlacement = "right";
         this.warning1Button.selected = false;
         this.warning1Button.toggle = false;
         this.warning1Button.visible = true;
         try
         {
            this.warning1Button["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_warning2Button_TempModMenu_Layer3_0() : *
      {
         try
         {
            this.warning2Button["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.warning2Button.emphasized = false;
         this.warning2Button.enabled = true;
         this.warning2Button.label = "Warning 2";
         this.warning2Button.labelPlacement = "right";
         this.warning2Button.selected = false;
         this.warning2Button.toggle = false;
         this.warning2Button.visible = true;
         try
         {
            this.warning2Button["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_warning3Button_TempModMenu_Layer2_0() : *
      {
         try
         {
            this.warning3Button["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.warning3Button.emphasized = false;
         this.warning3Button.enabled = true;
         this.warning3Button.label = "Warning 3";
         this.warning3Button.labelPlacement = "right";
         this.warning3Button.selected = false;
         this.warning3Button.toggle = false;
         this.warning3Button.visible = true;
         try
         {
            this.warning3Button["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_kickButton_TempModMenu_Layer1_0() : *
      {
         try
         {
            this.kickButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.kickButton.emphasized = false;
         this.kickButton.enabled = true;
         this.kickButton.label = "30 Minute Kick";
         this.kickButton.labelPlacement = "right";
         this.kickButton.selected = false;
         this.kickButton.toggle = false;
         this.kickButton.visible = true;
         try
         {
            this.kickButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
