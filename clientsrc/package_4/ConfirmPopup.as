package package_4
{
   import flash.events.*;
   
   public class ConfirmPopup extends Popup
   {
       
      
      private var m:ConfirmPopupGraphic;
      
      private var confirmFunction:Function;
      
      public function ConfirmPopup(param1:Function, param2:String = "Are you sure?")
      {
         this.m = new ConfirmPopupGraphic();
         super();
         this.confirmFunction = param1;
         this.m.textBox.htmlText = param2;
         this.m.ok_bt.addEventListener(MouseEvent.CLICK,this.clickOk);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel);
         addChild(this.m);
      }
      
      private function clickOk(param1:MouseEvent) : *
      {
         this.confirmFunction();
         startFadeOut();
      }
      
      private function clickCancel(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.m.ok_bt.removeEventListener(MouseEvent.CLICK,this.clickOk);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         super.remove();
      }
   }
}
