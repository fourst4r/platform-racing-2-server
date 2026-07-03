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
   
   public dynamic class ChooseLevelsModePopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var mine_bt:Button;
      
      public var reports_bt:Button;
      
      public function ChooseLevelsModePopupGraphic()
      {
         super();
         this.__setProp_reports_bt_ChooseLevelsModePopup_Layer_1_0();
         this.__setProp_cancel_bt_ChooseLevelsModePopup_Layer_1_0();
         this.__setProp_mine_bt_ChooseLevelsModePopup_Layer_1_0();
      }
      
      internal function __setProp_reports_bt_ChooseLevelsModePopup_Layer_1_0() : *
      {
         try
         {
            this.reports_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.reports_bt.emphasized = false;
         this.reports_bt.enabled = true;
         this.reports_bt.label = "Level Reports";
         this.reports_bt.labelPlacement = "right";
         this.reports_bt.selected = false;
         this.reports_bt.toggle = false;
         this.reports_bt.visible = true;
         try
         {
            this.reports_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_ChooseLevelsModePopup_Layer_1_0() : *
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
      
      internal function __setProp_mine_bt_ChooseLevelsModePopup_Layer_1_0() : *
      {
         try
         {
            this.mine_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.mine_bt.emphasized = false;
         this.mine_bt.enabled = true;
         this.mine_bt.label = "My Levels";
         this.mine_bt.labelPlacement = "right";
         this.mine_bt.selected = false;
         this.mine_bt.toggle = false;
         this.mine_bt.visible = true;
         try
         {
            this.mine_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
