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
   
   public dynamic class ChooseLevelModModePopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var restrict_bt:Button;
      
      public var unpublish_bt:Button;
      
      public function ChooseLevelModModePopupGraphic()
      {
         super();
         this.__setProp_unpublish_bt_ChooseLevelModModePopup_Layer_1_0();
         this.__setProp_cancel_bt_ChooseLevelModModePopup_Layer_1_0();
         this.__setProp_restrict_bt_ChooseLevelModModePopup_Layer_1_0();
      }
      
      internal function __setProp_unpublish_bt_ChooseLevelModModePopup_Layer_1_0() : *
      {
         try
         {
            this.unpublish_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.unpublish_bt.emphasized = false;
         this.unpublish_bt.enabled = true;
         this.unpublish_bt.label = "Unpublish";
         this.unpublish_bt.labelPlacement = "right";
         this.unpublish_bt.selected = false;
         this.unpublish_bt.toggle = false;
         this.unpublish_bt.visible = true;
         try
         {
            this.unpublish_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_ChooseLevelModModePopup_Layer_1_0() : *
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
      
      internal function __setProp_restrict_bt_ChooseLevelModModePopup_Layer_1_0() : *
      {
         try
         {
            this.restrict_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.restrict_bt.emphasized = false;
         this.restrict_bt.enabled = true;
         this.restrict_bt.label = "Restrict";
         this.restrict_bt.labelPlacement = "right";
         this.restrict_bt.selected = false;
         this.restrict_bt.toggle = false;
         this.restrict_bt.visible = true;
         try
         {
            this.restrict_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
