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
   
   public dynamic class PartPopupGraphic extends MovieClip
   {
       
      
      public var body:MovieClip;
      
      public var close_bt:Button;
      
      public var descBox:TextField;
      
      public var epicBox:TextField;
      
      public var equip_bt:Button;
      
      public var foot:MovieClip;
      
      public var hat:HatGraphic;
      
      public var head:MovieClip;
      
      public var obtainBox:TextField;
      
      public var ownedBox:TextField;
      
      public var titleBox:TextField;
      
      public function PartPopupGraphic()
      {
         super();
         this.__setProp_close_bt_Symbol1252_Layer3_0();
         this.__setProp_equip_bt_Symbol1252_Layer3_0();
      }
      
      internal function __setProp_close_bt_Symbol1252_Layer3_0() : *
      {
         try
         {
            this.close_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.close_bt.emphasized = false;
         this.close_bt.enabled = true;
         this.close_bt.label = "Close";
         this.close_bt.labelPlacement = "right";
         this.close_bt.selected = false;
         this.close_bt.toggle = false;
         this.close_bt.visible = true;
         try
         {
            this.close_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_equip_bt_Symbol1252_Layer3_0() : *
      {
         try
         {
            this.equip_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.equip_bt.emphasized = false;
         this.equip_bt.enabled = false;
         this.equip_bt.label = "Equip";
         this.equip_bt.labelPlacement = "right";
         this.equip_bt.selected = false;
         this.equip_bt.toggle = false;
         this.equip_bt.visible = true;
         try
         {
            this.equip_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
