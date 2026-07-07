package package_6
{
   import com.jiggmin.data.*;
   import fl.controls.*;
   import flash.events.*;
   import flash.text.TextField;
   import package_4.*;
   import page.Chat;
   
   public class RaceChat extends Chat
   {
      
      public static var textBox:TextField;
       
      
      private var m:RaceChatGraphic;
      
      public function RaceChat()
      {
         this.m = new RaceChatGraphic();
         super();
         addChild(this.m);
         maxMessages = 7;
         this.m.chatInput.restrict = "^`";
         this.m.chatInput.tabEnabled = false;
         this.m.chatInput.focusRect = false;
         this.m.top.textBox1.mouseWheelEnabled = this.m.bg.textBox2.mouseWheelEnabled = false;
         this.m.addEventListener(MouseEvent.MOUSE_WHEEL,this.ensureBottom,false,0,true);
         Main.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler,false,0,true);
         Main.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.focusOrSend,false,0,true);
         htmlNameMaker.listenForLink(this.m.top.textBox1);
         RaceChat.textBox = this.m.chatInput;
      }
      
      override public function receiveSystemMessage(param1:Array) : *
      {
         displayMessage("<i><font color=\'#3E8697\'>" + param1[0] + "</font></i><br/>");
      }
      
      private function ensureBottom(param1:MouseEvent) : *
      {
         this.m.top.textBox1.scrollV = this.m.bg.textBox2.scrollV = this.m.top.textBox1.maxScrollV;
      }
      
      private function mouseDownHandler(param1:MouseEvent) : *
      {
         if(param1.target != this && param1.target != this.m.chatInput && Main.stage.focus == this.m.chatInput)
         {
            this.focusOnRace();
         }
      }
      
      private function focusOrSend(param1:KeyboardEvent) : *
      {
         if(param1.keyCode == 13 && !(param1.target.parent is TextArea))
         {
            if(param1.target != this && param1.target != this.m.chatInput)
            {
               Main.stage.focus = this.m.chatInput;
               this.m.chatInput.setSelection(0,0);
            }
            else
            {
               if(Data.trimWhitespace(this.m.chatInput.text).toLowerCase() === "/level" && Course.course != null)
               {
                  new LevelInfoPopup(Course.course.getCourseID());
               }
               else
               {
                  this.sendMessage(this.m.chatInput.text);
               }
               this.m.chatInput.text = "";
               this.focusOnRace();
            }
         }
      }
      
      override protected function sendMessage(param1:String) : *
      {
         var trimmedMessage:String = Data.trimWhitespace(param1).toLowerCase();
         if(trimmedMessage == "/disconnect")
         {
            this.m.chatInput.text = "";
            if(Main.socket != null && Main.socket.connected)
            {
               this.receiveSystemMessage(["Simulating unexpected disconnect."]);
               Main.socket.simulateUnexpectedDisconnect();
            }
            else
            {
               this.receiveSystemMessage(["No active socket to disconnect."]);
            }
            return;
         }
         this.m.chatInput.text = "";
         super.sendMessage(param1);
      }
      
      override protected function showMessages() : *
      {
         this.m.top.textBox1.htmlText = this.m.bg.textBox2.htmlText = existingMessages;
         this.m.top.textBox1.scrollV = this.m.bg.textBox2.scrollV = this.m.top.textBox1.maxScrollV;
      }
      
      private function focusOnRace() : *
      {
         Main.stage.focus = Main.stage;
      }
      
      override public function remove() : *
      {
         this.m.removeEventListener(MouseEvent.MOUSE_WHEEL,this.ensureBottom);
         Main.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         Main.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.focusOrSend);
         RaceChat.textBox = null;
         super.remove();
      }
   }
}
