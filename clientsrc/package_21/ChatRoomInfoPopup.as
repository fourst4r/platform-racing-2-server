package package_21
{
   import com.jiggmin.data.*;
   import flash.display.DisplayObject;
   import package_4.InfoPopup;
   
   public class ChatRoomInfoPopup extends InfoPopup
   {
       
      
      private var m:ChatRoomInfoPopupGraphic;
      
      public function ChatRoomInfoPopup(param1:DisplayObject)
      {
         this.m = new ChatRoomInfoPopupGraphic();
         addChild(this.m);
         super(param1);
         CommandHandler.commandHandler.defineCommand("setChatRoomList",this.setChatRoomList);
         Main.socket.write("get_chat_rooms`");
      }
      
      public function setChatRoomList(param1:Array) : *
      {
         var _loc3_:String = null;
         this.m.loadingGraphic.visible = false;
         var _loc2_:String = "<font face=\"_sans\" size=\"11\">";
         for each(_loc3_ in param1)
         {
            this.m.textBox.htmlText = this.m.textBox.htmlText + _loc2_ + _loc3_ + "</font>" + "<br/>";
         }
      }
      
      override public function remove() : *
      {
         CommandHandler.commandHandler.defineCommand("setChatRoomList",null);
         super.remove();
      }
   }
}
