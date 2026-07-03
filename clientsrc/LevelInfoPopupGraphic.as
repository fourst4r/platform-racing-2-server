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
   
   public dynamic class LevelInfoPopupGraphic extends MovieClip
   {
       
      
      public var close_bt:Button;
      
      public var levelInfo:MovieClip;
      
      public var loading:LoadingGraphic;
      
      public var play_bt:Button;
      
      public function LevelInfoPopupGraphic()
      {
         super();
         this.__setProp_play_bt_LevelInfoPopup_Layer3_0();
         this.__setProp_close_bt_LevelInfoPopup_Layer3_0();
      }
      
      internal function __setProp_play_bt_LevelInfoPopup_Layer3_0() : *
      {
         try
         {
            this.play_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.play_bt.emphasized = false;
         this.play_bt.enabled = false;
         this.play_bt.label = "Play";
         this.play_bt.labelPlacement = "right";
         this.play_bt.selected = false;
         this.play_bt.toggle = false;
         this.play_bt.visible = true;
         try
         {
            this.play_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_close_bt_LevelInfoPopup_Layer3_0() : *
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
