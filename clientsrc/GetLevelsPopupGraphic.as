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
   
   public dynamic class GetLevelsPopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var delete_bt:Button;
      
      public var levelsHolder:MovieClip;
      
      public var load_bt:Button;
      
      public var loadingGraphic:LoadingGraphic;
      
      public var titleBox:TextField;
      
      public function GetLevelsPopupGraphic()
      {
         super();
         this.__setProp_cancel_bt_Symbol1096_Layer3_0();
         this.__setProp_load_bt_Symbol1096_Layer2_0();
         this.__setProp_delete_bt_Symbol1096_Layer1_0();
      }
      
      internal function __setProp_cancel_bt_Symbol1096_Layer3_0() : *
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
      
      internal function __setProp_load_bt_Symbol1096_Layer2_0() : *
      {
         try
         {
            this.load_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.load_bt.emphasized = false;
         this.load_bt.enabled = true;
         this.load_bt.label = "Load";
         this.load_bt.labelPlacement = "right";
         this.load_bt.selected = false;
         this.load_bt.toggle = false;
         this.load_bt.visible = true;
         try
         {
            this.load_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_delete_bt_Symbol1096_Layer1_0() : *
      {
         try
         {
            this.delete_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.delete_bt.emphasized = false;
         this.delete_bt.enabled = true;
         this.delete_bt.label = "Delete";
         this.delete_bt.labelPlacement = "right";
         this.delete_bt.selected = false;
         this.delete_bt.toggle = false;
         this.delete_bt.visible = true;
         try
         {
            this.delete_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
