package
{
   import fl.controls.Button;
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
   
   public dynamic class CreateGuildPopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var changeEmblem_bt:SimpleButton;
      
      public var confirm_bt:Button;
      
      public var deleteEmblem_bt:SimpleButton;
      
      public var nameBox:TextInput;
      
      public var proseBox:TextArea;
      
      public var titleBox:TextField;
      
      public var transfer_bg:ShadowBG;
      
      public var transfer_bt:SimpleButton;
      
      public function CreateGuildPopupGraphic()
      {
         super();
         this.__setProp_nameBox_Symbol1245_Layer8_0();
         this.__setProp_proseBox_Symbol1245_Layer6_0();
         this.__setProp_cancel_bt_Symbol1245_Layer2_0();
         this.__setProp_confirm_bt_Symbol1245_Layer1_0();
      }
      
      internal function __setProp_nameBox_Symbol1245_Layer8_0() : *
      {
         try
         {
            this.nameBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.nameBox.displayAsPassword = false;
         this.nameBox.editable = true;
         this.nameBox.enabled = true;
         this.nameBox.maxChars = 20;
         this.nameBox.restrict = "";
         this.nameBox.text = "";
         this.nameBox.visible = true;
         try
         {
            this.nameBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_proseBox_Symbol1245_Layer6_0() : *
      {
         try
         {
            this.proseBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.proseBox.condenseWhite = false;
         this.proseBox.editable = true;
         this.proseBox.enabled = true;
         this.proseBox.horizontalScrollPolicy = "auto";
         this.proseBox.htmlText = "";
         this.proseBox.maxChars = 100;
         this.proseBox.restrict = "";
         this.proseBox.text = "";
         this.proseBox.verticalScrollPolicy = "auto";
         this.proseBox.visible = true;
         this.proseBox.wordWrap = true;
         try
         {
            this.proseBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_Symbol1245_Layer2_0() : *
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
      
      internal function __setProp_confirm_bt_Symbol1245_Layer1_0() : *
      {
         try
         {
            this.confirm_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.confirm_bt.emphasized = false;
         this.confirm_bt.enabled = true;
         this.confirm_bt.label = "Confirm";
         this.confirm_bt.labelPlacement = "right";
         this.confirm_bt.selected = false;
         this.confirm_bt.toggle = false;
         this.confirm_bt.visible = true;
         try
         {
            this.confirm_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
