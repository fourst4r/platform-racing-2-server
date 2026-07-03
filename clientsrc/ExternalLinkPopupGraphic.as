package
{
   import fl.controls.Button;
   import fl.controls.TextArea;
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
   
   public dynamic class ExternalLinkPopupGraphic extends MovieClip
   {
       
      
      public var close_bt:Button;
      
      public var linkBox:TextArea;
      
      public var proceed_bt:Button;
      
      public function ExternalLinkPopupGraphic()
      {
         super();
         this.__setProp_linkBox_ExternalLinkPopup_Layer3_0();
         this.__setProp_close_bt_ExternalLinkPopup_Layer2_0();
         this.__setProp_proceed_bt_ExternalLinkPopup_Layer2_0();
      }
      
      internal function __setProp_linkBox_ExternalLinkPopup_Layer3_0() : *
      {
         try
         {
            this.linkBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.linkBox.condenseWhite = false;
         this.linkBox.editable = false;
         this.linkBox.enabled = true;
         this.linkBox.horizontalScrollPolicy = "auto";
         this.linkBox.htmlText = "";
         this.linkBox.maxChars = 0;
         this.linkBox.restrict = "";
         this.linkBox.text = "";
         this.linkBox.verticalScrollPolicy = "auto";
         this.linkBox.visible = true;
         this.linkBox.wordWrap = true;
         try
         {
            this.linkBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_close_bt_ExternalLinkPopup_Layer2_0() : *
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
         this.close_bt.label = "Go Back";
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
      
      internal function __setProp_proceed_bt_ExternalLinkPopup_Layer2_0() : *
      {
         try
         {
            this.proceed_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.proceed_bt.emphasized = false;
         this.proceed_bt.enabled = true;
         this.proceed_bt.label = "Proceed";
         this.proceed_bt.labelPlacement = "right";
         this.proceed_bt.selected = false;
         this.proceed_bt.toggle = false;
         this.proceed_bt.visible = true;
         try
         {
            this.proceed_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
