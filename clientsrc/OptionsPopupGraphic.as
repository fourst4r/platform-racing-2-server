package
{
   import fl.controls.Button;
   import fl.controls.Slider;
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
   
   public dynamic class OptionsPopupGraphic extends MovieClip
   {
       
      
      public var artHighlight:MovieClip;
      
      public var artOffText:TextField;
      
      public var artOff_bt:Button;
      
      public var artOn_bt:Button;
      
      public var art_bt:SimpleButton;
      
      public var changeEmail_bt:SimpleButton;
      
      public var changePass_bt:SimpleButton;
      
      public var close_bt:Button;
      
      public var filterHighlight:MovieClip;
      
      public var filterOff_bt:Button;
      
      public var filterOn_bt:Button;
      
      public var guildCreate_bt:SimpleButton;
      
      public var guildEdit_bt:SimpleButton;
      
      public var guildLeave_bt:SimpleButton;
      
      public var guildTransfer_bt:SimpleButton;
      
      public var musicPercentBox:TextField;
      
      public var musicSlider:Slider;
      
      public var music_bt:SimpleButton;
      
      public var soundPercentBox:TextField;
      
      public var soundSlider:Slider;
      
      public var wasdDown:TextField;
      
      public var wasdItem:TextField;
      
      public var wasdLeft:TextField;
      
      public var wasdRight:TextField;
      
      public var wasdUp:TextField;
      
      public function OptionsPopupGraphic()
      {
         super();
         this.__setProp_close_bt_OptionsPopup_Layer20_0();
         this.__setProp_musicSlider_OptionsPopup_Layer4_0();
         this.__setProp_soundSlider_OptionsPopup_Layer4_0();
         this.__setProp_filterOn_bt_OptionsPopup_Layer3_0();
         this.__setProp_filterOff_bt_OptionsPopup_Layer3_0();
         this.__setProp_artOn_bt_OptionsPopup_Layer2_0();
         this.__setProp_artOff_bt_OptionsPopup_Layer2_0();
      }
      
      internal function __setProp_close_bt_OptionsPopup_Layer20_0() : *
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
      
      internal function __setProp_musicSlider_OptionsPopup_Layer4_0() : *
      {
         try
         {
            this.musicSlider["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.musicSlider.direction = "vertical";
         this.musicSlider.enabled = true;
         this.musicSlider.liveDragging = true;
         this.musicSlider.maximum = 100;
         this.musicSlider.minimum = 0;
         this.musicSlider.snapInterval = 5;
         this.musicSlider.tickInterval = 0;
         this.musicSlider.value = 100;
         this.musicSlider.visible = true;
         try
         {
            this.musicSlider["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_soundSlider_OptionsPopup_Layer4_0() : *
      {
         try
         {
            this.soundSlider["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.soundSlider.direction = "vertical";
         this.soundSlider.enabled = true;
         this.soundSlider.liveDragging = true;
         this.soundSlider.maximum = 100;
         this.soundSlider.minimum = 0;
         this.soundSlider.snapInterval = 5;
         this.soundSlider.tickInterval = 0;
         this.soundSlider.value = 100;
         this.soundSlider.visible = true;
         try
         {
            this.soundSlider["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_filterOn_bt_OptionsPopup_Layer3_0() : *
      {
         try
         {
            this.filterOn_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.filterOn_bt.emphasized = false;
         this.filterOn_bt.enabled = true;
         this.filterOn_bt.label = "On";
         this.filterOn_bt.labelPlacement = "right";
         this.filterOn_bt.selected = false;
         this.filterOn_bt.toggle = false;
         this.filterOn_bt.visible = true;
         try
         {
            this.filterOn_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_filterOff_bt_OptionsPopup_Layer3_0() : *
      {
         try
         {
            this.filterOff_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.filterOff_bt.emphasized = false;
         this.filterOff_bt.enabled = true;
         this.filterOff_bt.label = "Off";
         this.filterOff_bt.labelPlacement = "right";
         this.filterOff_bt.selected = false;
         this.filterOff_bt.toggle = false;
         this.filterOff_bt.visible = true;
         try
         {
            this.filterOff_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_artOn_bt_OptionsPopup_Layer2_0() : *
      {
         try
         {
            this.artOn_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.artOn_bt.emphasized = false;
         this.artOn_bt.enabled = true;
         this.artOn_bt.label = "On";
         this.artOn_bt.labelPlacement = "right";
         this.artOn_bt.selected = false;
         this.artOn_bt.toggle = false;
         this.artOn_bt.visible = true;
         try
         {
            this.artOn_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_artOff_bt_OptionsPopup_Layer2_0() : *
      {
         try
         {
            this.artOff_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.artOff_bt.emphasized = false;
         this.artOff_bt.enabled = true;
         this.artOff_bt.label = "Off";
         this.artOff_bt.labelPlacement = "right";
         this.artOff_bt.selected = false;
         this.artOff_bt.toggle = false;
         this.artOff_bt.visible = true;
         try
         {
            this.artOff_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
