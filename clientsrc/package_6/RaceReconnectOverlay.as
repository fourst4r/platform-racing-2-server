package package_6
{
   import com.jiggmin.data.RaceReconnectController;
   import flash.events.MouseEvent;
   import package_4.Popup;

   public class RaceReconnectOverlay extends Popup
   {
      private var m:ConfirmPopupGraphic;
      private var statusText:String = "Disconnected from server.";

      public function RaceReconnectOverlay()
      {
         this.m = new ConfirmPopupGraphic();
         super();
         this.m.ok_bt.label = "Reconnect";
         this.m.cancel_bt.label = "Leave Race";
         this.m.textBox.editable = false;
         this.m.textBox.wordWrap = true;
         this.updateText();
         this.m.ok_bt.addEventListener(MouseEvent.CLICK,this.clickReconnect,false,0,true);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickLeave,false,0,true);
         addChild(this.m);
      }

      public function setStatus(value:String, enableReconnect:Boolean) : void
      {
         this.statusText = value;
         this.updateText();
         this.m.ok_bt.enabled = enableReconnect;
         this.m.ok_bt.mouseEnabled = enableReconnect;
         this.m.ok_bt.alpha = enableReconnect ? 1 : 0.5;
      }

      override public function remove() : *
      {
         this.m.ok_bt.removeEventListener(MouseEvent.CLICK,this.clickReconnect);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickLeave);
         super.remove();
      }

      private function updateText() : void
      {
         this.m.textBox.text = "Connection Lost\n\n" + this.statusText;
      }

      private function clickReconnect(event:MouseEvent) : void
      {
         RaceReconnectController.requestReconnect();
      }

      private function clickLeave(event:MouseEvent) : void
      {
         RaceReconnectController.leaveRace();
      }
   }
}
