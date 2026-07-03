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
   
   public dynamic class TestCourseGraphic extends MovieClip
   {
       
      
      public var back_bt:Button;
      
      public var restart_bt:Button;
      
      public function TestCourseGraphic()
      {
         super();
         this.__setProp_back_bt_TestCourseControls_Layer2_0();
         this.__setProp_restart_bt_TestCourseControls_Layer1_0();
      }
      
      internal function __setProp_back_bt_TestCourseControls_Layer2_0() : *
      {
         try
         {
            this.back_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.back_bt.emphasized = false;
         this.back_bt.enabled = true;
         this.back_bt.label = "Back";
         this.back_bt.labelPlacement = "right";
         this.back_bt.selected = false;
         this.back_bt.toggle = false;
         this.back_bt.visible = true;
         try
         {
            this.back_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_restart_bt_TestCourseControls_Layer1_0() : *
      {
         try
         {
            this.restart_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.restart_bt.emphasized = false;
         this.restart_bt.enabled = true;
         this.restart_bt.label = "Restart";
         this.restart_bt.labelPlacement = "right";
         this.restart_bt.selected = false;
         this.restart_bt.toggle = false;
         this.restart_bt.visible = true;
         try
         {
            this.restart_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
