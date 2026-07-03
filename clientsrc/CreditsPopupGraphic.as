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
   
   public dynamic class CreditsPopupGraphic extends MovieClip
   {
       
      
      public var artPg1:MovieClip;
      
      public var artPg2:MovieClip;
      
      public var artPg3:MovieClip;
      
      public var art_nav_bts:TextField;
      
      public var buildBox:TextField;
      
      public var close_bt:Button;
      
      public var musicPg1:MovieClip;
      
      public var musicPg2:MovieClip;
      
      public var music_nav_bt:TextField;
      
      public var versionBox:TextField;
      
      public function CreditsPopupGraphic()
      {
         super();
         this.__setProp_close_bt_CreditsPopup_close_button_0();
      }
      
      internal function __setProp_close_bt_CreditsPopup_close_button_0() : *
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
