package package_4
{
   import flash.events.*;
   
   public class OutfitPopup extends Popup
   {
      
      public static var instance:OutfitPopup;
       
      
      private var confirmFunction:Function;
      
      private var m:OutfitPopupGraphic;
      
      public function OutfitPopup(param1:Function, param2:Object, param3:String = "Are you sure?")
      {
         super();
         if(instance != null)
         {
            instance.startFadeOut();
         }
         instance = this;
         this.confirmFunction = param1;
         this.m = new OutfitPopupGraphic(param2);
         this.m.main.textBox.htmlText = param3;
         addChild(this.m);
         this.m.main.ok_bt.addEventListener(MouseEvent.CLICK,this.clickOK);
         this.m.main.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel);
      }
      
      private function clickOK(param1:MouseEvent) : *
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
         if(instance == this)
         {
            instance = null;
         }
         this.m.main.ok_bt.removeEventListener(MouseEvent.CLICK,this.clickOK);
         this.m.main.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         super.remove();
      }
   }
}
