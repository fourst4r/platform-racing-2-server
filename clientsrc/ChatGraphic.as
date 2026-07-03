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
   
   public dynamic class ChatGraphic extends MovieClip
   {
       
      
      public var chatInput:TextInput;
      
      public var infoButton:InfoButton;
      
      public var joinRoom_bt:Button;
      
      public var roomBox:TextInput;
      
      public var send_bt:Button;
      
      public var textBox:TextArea;
      
      public function ChatGraphic()
      {
         super();
         this.__setProp_textBox_Symbol1217_Layer9_0();
         this.__setProp_chatInput_Symbol1217_Layer8_0();
         this.__setProp_send_bt_Symbol1217_Layer7_0();
         this.__setProp_roomBox_Symbol1217_Layer6_0();
         this.__setProp_joinRoom_bt_Symbol1217_Layer5_0();
      }
      
      internal function __setProp_textBox_Symbol1217_Layer9_0() : *
      {
         try
         {
            this.textBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.textBox.condenseWhite = false;
         this.textBox.editable = false;
         this.textBox.enabled = true;
         this.textBox.horizontalScrollPolicy = "auto";
         this.textBox.htmlText = "";
         this.textBox.maxChars = 0;
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
      
      internal function __setProp_chatInput_Symbol1217_Layer8_0() : *
      {
         try
         {
            this.chatInput["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.chatInput.displayAsPassword = false;
         this.chatInput.editable = true;
         this.chatInput.enabled = true;
         this.chatInput.maxChars = 150;
         this.chatInput.restrict = "^`";
         this.chatInput.text = "";
         this.chatInput.visible = true;
         try
         {
            this.chatInput["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_send_bt_Symbol1217_Layer7_0() : *
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
      
      internal function __setProp_roomBox_Symbol1217_Layer6_0() : *
      {
         try
         {
            this.roomBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.roomBox.displayAsPassword = false;
         this.roomBox.editable = true;
         this.roomBox.enabled = true;
         this.roomBox.maxChars = 16;
         this.roomBox.restrict = "^`";
         this.roomBox.text = "";
         this.roomBox.visible = true;
         try
         {
            this.roomBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_joinRoom_bt_Symbol1217_Layer5_0() : *
      {
         try
         {
            this.joinRoom_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.joinRoom_bt.emphasized = false;
         this.joinRoom_bt.enabled = true;
         this.joinRoom_bt.label = "Join Room";
         this.joinRoom_bt.labelPlacement = "right";
         this.joinRoom_bt.selected = false;
         this.joinRoom_bt.toggle = false;
         this.joinRoom_bt.visible = true;
         try
         {
            this.joinRoom_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
