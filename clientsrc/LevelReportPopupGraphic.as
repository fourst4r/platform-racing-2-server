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
   
   public dynamic class LevelReportPopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var reasonBox:TextInput;
      
      public var report_bt:Button;
      
      public function LevelReportPopupGraphic()
      {
         super();
         this.__setProp_report_bt_LevelReportPopup_Layer_1_0();
         this.__setProp_cancel_bt_LevelReportPopup_Layer_1_0();
      }
      
      internal function __setProp_report_bt_LevelReportPopup_Layer_1_0() : *
      {
         try
         {
            this.report_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.report_bt.emphasized = false;
         this.report_bt.enabled = true;
         this.report_bt.label = "Report";
         this.report_bt.labelPlacement = "right";
         this.report_bt.selected = false;
         this.report_bt.toggle = false;
         this.report_bt.visible = true;
         try
         {
            this.report_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_LevelReportPopup_Layer_1_0() : *
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
