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
   
   public dynamic class ConnectingPopupGraphic extends MovieClip
   {
       
      
      public var var_1:Button;
      
      public function ConnectingPopupGraphic()
      {
         super();
         this.__setProp_var_1_Symbol980_Layer1_0();
      }
      
      internal function __setProp_var_1_Symbol980_Layer1_0() : *
      {
         try
         {
            this.var_1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.var_1.emphasized = false;
         this.var_1.enabled = true;
         this.var_1.label = "Close";
         this.var_1.labelPlacement = "right";
         this.var_1.selected = false;
         this.var_1.toggle = false;
         this.var_1.visible = true;
         try
         {
            this.var_1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
