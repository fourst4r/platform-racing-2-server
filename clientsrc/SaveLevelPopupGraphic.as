package
{
   import fl.controls.Button;
   import fl.controls.CheckBox;
   import fl.controls.TextArea;
   import fl.controls.TextInput;
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
   
   public dynamic class SaveLevelPopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var newest_chk:CheckBox;
      
      public var noteBox:TextArea;
      
      public var noteCharsRemaining:TextField;
      
      public var publish_chk:CheckBox;
      
      public var save_bt:Button;
      
      public var titleBox:TextInput;
      
      public var titleCharsRemaining:TextField;
      
      public function SaveLevelPopupGraphic()
      {
         super();
         this.__setProp_titleBox_SaveLevel_Layer9_0();
         this.__setProp_cancel_bt_SaveLevel_Layer6_0();
         this.__setProp_save_bt_SaveLevel_Layer5_0();
         this.__setProp_publish_chk_SaveLevel_Layer3_0();
         this.__setProp_newest_chk_SaveLevel_Layer3_0();
         this.__setProp_noteBox_SaveLevel_Layer1_0();
      }
      
      internal function __setProp_titleBox_SaveLevel_Layer9_0() : *
      {
         try
         {
            this.titleBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.titleBox.displayAsPassword = false;
         this.titleBox.editable = true;
         this.titleBox.enabled = true;
         this.titleBox.maxChars = 50;
         this.titleBox.restrict = "";
         this.titleBox.text = "";
         this.titleBox.visible = true;
         try
         {
            this.titleBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_SaveLevel_Layer6_0() : *
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
      
      internal function __setProp_save_bt_SaveLevel_Layer5_0() : *
      {
         try
         {
            this.save_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.save_bt.emphasized = false;
         this.save_bt.enabled = true;
         this.save_bt.label = "Save";
         this.save_bt.labelPlacement = "right";
         this.save_bt.selected = false;
         this.save_bt.toggle = false;
         this.save_bt.visible = true;
         try
         {
            this.save_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_publish_chk_SaveLevel_Layer3_0() : *
      {
         try
         {
            this.publish_chk["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.publish_chk.enabled = true;
         this.publish_chk.label = "";
         this.publish_chk.labelPlacement = "left";
         this.publish_chk.selected = false;
         this.publish_chk.visible = true;
         try
         {
            this.publish_chk["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_newest_chk_SaveLevel_Layer3_0() : *
      {
         try
         {
            this.newest_chk["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.newest_chk.enabled = false;
         this.newest_chk.label = "";
         this.newest_chk.labelPlacement = "right";
         this.newest_chk.selected = false;
         this.newest_chk.visible = true;
         try
         {
            this.newest_chk["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_noteBox_SaveLevel_Layer1_0() : *
      {
         try
         {
            this.noteBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.noteBox.condenseWhite = false;
         this.noteBox.editable = true;
         this.noteBox.enabled = true;
         this.noteBox.horizontalScrollPolicy = "auto";
         this.noteBox.htmlText = "";
         this.noteBox.maxChars = 255;
         this.noteBox.restrict = "";
         this.noteBox.text = "";
         this.noteBox.verticalScrollPolicy = "auto";
         this.noteBox.visible = true;
         this.noteBox.wordWrap = true;
         try
         {
            this.noteBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
