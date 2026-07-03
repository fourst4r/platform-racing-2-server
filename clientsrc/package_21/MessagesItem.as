package package_21
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.ui.*;
   import package_4.*;
   
   public class MessagesItem extends Removable
   {
       
      
      private var m:MessagesItemGraphic;
      
      private var reportButton:ReportMessageButton;
      
      private var deleteButton:DeleteMessageButton;
      
      private var replyButton:ReplyMessageButton;
      
      private var htmlNameMaker:HTMLNameMaker;
      
      private var userName:String;
      
      public var messageId:Number;
      
      private var target:Messages;
      
      private var messageText:String;
      
      private var time:int;
      
      private var hover:HoverPopup;
      
      public function MessagesItem(param1:Messages, param2:Number, param3:String, param4:String, param5:String, param6:Boolean, param7:Number, param8:Number)
      {
         this.m = new MessagesItemGraphic();
         this.reportButton = new ReportMessageButton();
         this.deleteButton = new DeleteMessageButton();
         this.replyButton = new ReplyMessageButton();
         this.htmlNameMaker = new HTMLNameMaker();
         super();
         this.target = param1;
         this.messageId = param2;
         this.userName = param3;
         var _loc9_:String = String(this.htmlNameMaker.makeName(param3,param4,"",true));
         this.htmlNameMaker.listenForLink(this.m.nameBox);
         this.htmlNameMaker.listenForLink(this.m.textBox);
         this.messageText = param5;
         if(param4 < 3)
         {
            param5 = String(Data.escapeString(param5,true));
         }
         param5 = (param5 = String(Data.parseLinks(param5))).replace(/\r/g,"<br>");
         this.m.nameBox.htmlText = _loc9_;
         this.m.textBox.htmlText = param5;
         this.m.textBox.autoSize = "left";
         this.m.bg.height = this.m.textBox.height + 6;
         this.m.guildMsgIcon.visible = param6;
         this.time = param7;
         var _loc10_:Date = new Date(this.time * 1000);
         this.m.timeBox.text = _loc10_.toLocaleDateString();
         this.m.timeBox.y = this.m.textBox.height + 32;
         this.reportButton.y = this.deleteButton.y = this.replyButton.y = this.m.textBox.height + 42;
         this.reportButton.x = 15;
         this.deleteButton.x = 37;
         this.replyButton.x = 59;
         this.m.timeBox.addEventListener(MouseEvent.MOUSE_OVER,this.hoverTime,false,0,true);
         this.m.timeBox.addEventListener(MouseEvent.MOUSE_OUT,this.hoverOutTime,false,0,true);
         this.reportButton.addEventListener(MouseEvent.CLICK,this.clickReport);
         this.deleteButton.addEventListener(MouseEvent.CLICK,this.clickDelete);
         this.replyButton.addEventListener(MouseEvent.CLICK,this.clickReply);
         addChild(this.m);
         addChild(this.reportButton);
         addChild(this.deleteButton);
         addChild(this.replyButton);
      }
      
      private function clickReport(param1:MouseEvent) : *
      {
         new ConfirmPopup(this.confirmReport,"Are you sure you want to report this message to the moderators? If the sender of this message is asking for your password, being a rather mean jerk, or spamming your inbox, then please do report this message.");
      }
      
      private function clickDelete(param1:MouseEvent) : *
      {
         new ConfirmPopup(this.confirmDelete,"Are you sure you want to delete this message from " + Data.escapeString(this.userName) + "?");
      }
      
      private function clickReply(param1:MouseEvent) : *
      {
         var _loc2_:* = "\n--- \n" + this.messageText;
         var _loc3_:int = 200;
         if(_loc2_.length > _loc3_)
         {
            _loc2_ = _loc2_.substr(0,_loc3_) + "...";
         }
         new SendMessagePopup(this.userName,_loc2_);
      }
      
      private function confirmReport() : *
      {
         this.target.doReport(this);
      }
      
      public function confirmDelete() : *
      {
         this.target.doDelete(this);
      }
      
      private function hoverTime(param1:MouseEvent) : *
      {
         Mouse.cursor = MouseCursor.BUTTON;
         this.m.timeBox.textColor = 6710886;
         this.hover = new HoverPopup("Sent Time","This message was sent on " + Data.getDateTimeStr(this.time,["long","medium"]) + ".",this.m.timeBox);
      }
      
      private function hoverOutTime(param1:* = null) : *
      {
         Mouse.cursor = MouseCursor.AUTO;
         this.m.timeBox.textColor = 0;
         if(this.hover != null)
         {
            this.hover.remove();
            this.hover = null;
         }
      }
      
      override public function remove() : *
      {
         this.hoverOutTime();
         this.m.timeBox.removeEventListener(MouseEvent.MOUSE_OVER,this.hoverTime);
         this.m.timeBox.removeEventListener(MouseEvent.MOUSE_OUT,this.hoverOutTime);
         this.reportButton.removeEventListener(MouseEvent.CLICK,this.clickReport);
         this.deleteButton.removeEventListener(MouseEvent.CLICK,this.clickDelete);
         this.replyButton.removeEventListener(MouseEvent.CLICK,this.clickReply);
         this.reportButton.remove();
         this.deleteButton.remove();
         this.replyButton.remove();
         this.htmlNameMaker.remove();
         super.remove();
      }
   }
}
