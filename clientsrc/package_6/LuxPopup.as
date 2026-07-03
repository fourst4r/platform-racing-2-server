package package_6
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import package_4.Popup;
   
   public class LuxPopup extends Popup
   {
       
      
      private var m:LuxPopupGraphic;
      
      public function LuxPopup(param1:int)
      {
         var _loc2_:Loader = null;
         this.m = new LuxPopupGraphic();
         super(false);
         _loc2_ = new Loader();
         _loc2_.load(new URLRequest(Main.baseURL + "/img/luna.jpg"));
         _loc2_.x = 95;
         _loc2_.y = -65;
         this.m.addChild(_loc2_);
         this.m.textBox.text = "+" + param1 + " Lux";
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose,false,0,true);
         addChild(this.m);
      }
      
      private function clickClose(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.m.close_bt.removeEventListener(MouseEvent.CLICK,this.clickClose);
         super.remove();
      }
   }
}
