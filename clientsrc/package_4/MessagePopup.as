package package_4
{
   import flash.events.*;
   
   public class MessagePopup extends Popup
   {
       
      
      private var m:MessagePopupGraphic;
      
      public function MessagePopup(param1:String)
      {
         this.m = new MessagePopupGraphic();
         super();
         this.m.textBox.htmlText = param1;
         addChild(this.m);
         this.m.ok_bt.addEventListener(MouseEvent.CLICK,this.clickOk);
      }
      
      private function clickOk(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.m.ok_bt.removeEventListener(MouseEvent.CLICK,this.clickOk);
         super.remove();
      }
   }
}
