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
   
   public dynamic class OptionsArtQualityMenuGraphic extends MovieClip
   {
       
      
      public var lossless_chk:CheckBox;
      
      public function OptionsArtQualityMenuGraphic()
      {
         super();
         this.__setProp_lossless_chk_ArtQualityMenu_buttons_0();
      }
      
      internal function __setProp_lossless_chk_ArtQualityMenu_buttons_0() : *
      {
         try
         {
            this.lossless_chk["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.lossless_chk.enabled = true;
         this.lossless_chk.label = "Lossless (EXPERIMENTAL)";
         this.lossless_chk.labelPlacement = "right";
         this.lossless_chk.selected = false;
         this.lossless_chk.visible = true;
         try
         {
            this.lossless_chk["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
