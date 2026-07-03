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
   
   public dynamic class PrizePopupGraphic extends MovieClip
   {
       
      
      public var bg:ShadowBG;
      
      public var body:MovieClip;
      
      public var close_bt:Button;
      
      public var exp:MovieClip;
      
      public var flavor:TextField;
      
      public var flavorBg:ShadowBG;
      
      public var foot:MovieClip;
      
      public var hat:HatGraphic;
      
      public var head:MovieClip;
      
      public var textBox:TextField;
      
      public var titleBox:TextField;
      
      public function PrizePopupGraphic()
      {
         super();
         this.__setProp_close_bt_PrizePopup_Layer8_0();
      }
      
      internal function __setProp_close_bt_PrizePopup_Layer8_0() : *
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
   }
}
