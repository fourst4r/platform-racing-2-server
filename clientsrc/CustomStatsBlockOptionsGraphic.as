package
{
   import fl.controls.CheckBox;
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
   
   public dynamic class CustomStatsBlockOptionsGraphic extends MovieClip
   {
       
      
      public var resetChk:CheckBox;
      
      public function CustomStatsBlockOptionsGraphic()
      {
         super();
         this.__setProp_resetChk_CustomStatsBlockOptions_Layer11_0();
      }
      
      internal function __setProp_resetChk_CustomStatsBlockOptions_Layer11_0() : *
      {
         try
         {
            this.resetChk["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.resetChk.enabled = true;
         this.resetChk.label = "Reset To Starting Stats";
         this.resetChk.labelPlacement = "right";
         this.resetChk.selected = false;
         this.resetChk.visible = true;
         try
         {
            this.resetChk["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
