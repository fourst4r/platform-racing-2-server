package menu
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import package_4.Popup;
   
   public class ConnectingPopup extends Popup
   {
       
      
      private var m:ConnectingPopupGraphic;

      private var reconnectMode:Boolean = false;
      
      public function ConnectingPopup(param1:Boolean = false)
      {
         this.m = new ConnectingPopupGraphic();
         super();
         this.reconnectMode = param1;
         addChild(this.m);
         if(Main.socket != null)
         {
            Main.socket.remove();
         }
         Main.socket = new PR2Socket();
         CommandHandler.commandHandler.defineCommand("setLoginID",this.setLoginID);
         this.m.var_1.addEventListener(MouseEvent.CLICK,this.clickCancel,false,0,true);
         Main.socket.addEventListener(IOErrorEvent.IO_ERROR,this.method_99,false,0,true);
         Main.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.method_99,false,0,true);
         Main.socket.connect(Main.server.address,Main.server.port);
      }
      
      public function setLoginID(param1:Array) : *
      {
         new LoggingInPopup(param1[0],this.reconnectMode);
         startFadeOut();
      }
      
      private function method_99(param1:Event) : *
      {
         if(this.reconnectMode)
         {
            RaceReconnectController.onReconnectLoginFailed();
         }
         startFadeOut();
      }
      
      private function clickCancel(param1:MouseEvent) : *
      {
         startFadeOut();
         if(Main.socket != null)
         {
            Main.socket.remove();
         }
         if(this.reconnectMode)
         {
            RaceReconnectController.onReconnectLoginFailed();
         }
      }
      
      override public function remove() : *
      {
         CommandHandler.commandHandler.defineCommand("setLoginID",null);
         this.m.var_1.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         Main.socket.removeEventListener(IOErrorEvent.IO_ERROR,this.method_99);
         Main.socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.method_99);
         super.remove();
      }
   }
}
