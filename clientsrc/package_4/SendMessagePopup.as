package package_4
{
   import flash.events.*;
   import flash.net.*;
   
   public class SendMessagePopup extends Popup
   {
       
      
      private var m:SendMessagePopupGraphic;
      
      private var isGuildMessage:Boolean = false;
      
      private var hover:HoverPopup = null;
      
      public function SendMessagePopup(param1:String = "", param2:String = "", param3:Boolean = false, param4:Boolean = false)
      {
         this.m = new SendMessagePopupGraphic();
         super();
         this.isGuildMessage = param3;
         this.m.send_bt.addEventListener(MouseEvent.CLICK,this.clickSend,false,0,true);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel,false,0,true);
         this.m.codes_bt.addEventListener(MouseEvent.CLICK,this.clickCodes,false,0,true);
         this.m.codes_bt.addEventListener(MouseEvent.MOUSE_OVER,this.hoverOverCodes,false,0,true);
         this.m.codes_bt.addEventListener(MouseEvent.MOUSE_OUT,this.hoverOutCodes,false,0,true);
         this.m.nameBox.text = param1;
         this.m.textBox.text = param2;
         this.countChars();
         this.m.textBox.addEventListener(Event.CHANGE,this.countChars,false,0,true);
         addChild(this.m);
         if(this.isGuildMessage)
         {
            this.m.nameBox.editable = false;
            this.m.nameBox.alpha = 0.5;
         }
         if(param4)
         {
            addEventListener(LOADED,this.focusNameBox,false,0,true);
         }
         else
         {
            addEventListener(LOADED,this.focusTextBox,false,0,true);
         }
      }
      
      private function hoverOverCodes(param1:MouseEvent) : *
      {
         this.hover = new HoverPopup("Rich Formatting","Impress your friends by using rich formatting in PMs! Click to learn more.",this.m.codes_bt);
      }
      
      private function hoverOutCodes(param1:* = null) : *
      {
         if(this.hover != null)
         {
            this.hover.remove();
            this.hover = null;
         }
      }
      
      private function clickCodes(param1:MouseEvent) : *
      {
         new PMRFCodesPopup();
      }
      
      private function focusNameBox(param1:Event) : *
      {
         removeEventListener(LOADED,this.focusNameBox);
         Main.stage.focus = this.m.nameBox;
      }
      
      private function focusTextBox(param1:Event) : *
      {
         removeEventListener(LOADED,this.focusTextBox);
         Main.stage.focus = this.m.textBox;
      }
      
      private function countChars(param1:Event = null) : *
      {
         this.m.messageCharsRemaining.text = this.m.textBox.length + " / 1000";
      }
      
      private function clickSend(param1:MouseEvent) : *
      {
         var _loc2_:URLVariables = null;
         var _loc3_:* = null;
         var _loc4_:URLRequest = null;
         var _loc5_:UploadingPopup = null;
         if(this.m.nameBox.text == "")
         {
            new MessagePopup("Please enter a name!");
         }
         else if(this.m.textBox.text == "")
         {
            new MessagePopup("You didn\'t write a message!");
         }
         else
         {
            _loc2_ = new URLVariables();
            _loc2_.to_name = this.m.nameBox.text;
            _loc2_.message = this.m.textBox.text;
            _loc3_ = Main.baseURL + "/message_send.php";
            if(this.isGuildMessage)
            {
               _loc3_ = Main.baseURL + "/guild_message.php";
            }
            (_loc4_ = new URLRequest(_loc3_)).data = _loc2_;
            _loc4_.method = URLRequestMethod.POST;
            (_loc5_ = new UploadingPopup(_loc4_,"json")).addEventListener(SuperLoader.d,this.clickCancel,false,0,true);
            _loc5_.addEventListener(SuperLoader.e,this.onError,false,0,true);
         }
      }
      
      private function onError(param1:*) : *
      {
      }
      
      private function clickCancel(param1:*) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.hoverOutCodes();
         this.m.textBox.removeEventListener(Event.CHANGE,this.countChars);
         this.m.send_bt.removeEventListener(MouseEvent.CLICK,this.clickSend);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         this.m.codes_bt.removeEventListener(MouseEvent.CLICK,this.clickCodes);
         this.m.codes_bt.removeEventListener(MouseEvent.MOUSE_OVER,this.hoverOverCodes);
         this.m.codes_bt.removeEventListener(MouseEvent.MOUSE_OUT,this.hoverOutCodes);
         super.remove();
      }
   }
}
