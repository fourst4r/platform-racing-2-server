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
   
   public dynamic class SendMessagePopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var codes_bt:InfoButton;
      
      public var messageCharsRemaining:TextField;
      
      public var nameBox:TextInput;
      
      public var send_bt:Button;
      
      public var textBox:TextArea;
      
      public function SendMessagePopupGraphic()
      {
         super();
         this.__setProp_textBox_SendMessage_text_boxes_0();
         this.__setProp_send_bt_SendMessage_buttons_0();
         this.__setProp_cancel_bt_SendMessage_buttons_0();
      }
      
      internal function __setProp_textBox_SendMessage_text_boxes_0() : *
      {
         try
         {
            this.textBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.textBox.condenseWhite = false;
         this.textBox.editable = true;
         this.textBox.enabled = true;
         this.textBox.horizontalScrollPolicy = "auto";
         this.textBox.htmlText = "";
         this.textBox.maxChars = 1000;
         this.textBox.restrict = "";
         this.textBox.text = "";
         this.textBox.verticalScrollPolicy = "auto";
         this.textBox.visible = true;
         this.textBox.wordWrap = true;
         try
         {
            this.textBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_send_bt_SendMessage_buttons_0() : *
      {
         try
         {
            this.send_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.send_bt.emphasized = false;
         this.send_bt.enabled = true;
         this.send_bt.label = "Send";
         this.send_bt.labelPlacement = "right";
         this.send_bt.selected = false;
         this.send_bt.toggle = false;
         this.send_bt.visible = true;
         try
         {
            this.send_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_SendMessage_buttons_0() : *
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
   }
}
