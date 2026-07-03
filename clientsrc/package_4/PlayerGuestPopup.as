package package_4
{
   import flash.events.*;
   
   public class PlayerGuestPopup extends Popup
   {
       
      
      private var m:PlayerGuestPopupGraphic;
      
      private var banMenu:BanMenu;
      
      public function PlayerGuestPopup(param1:String)
      {
         this.m = new PlayerGuestPopupGraphic();
         super();
         this.m.nameBox.text = "-- " + param1 + " --";
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose,false,0,true);
         addChild(this.m);
         if(Main.group >= 2)
         {
            this.banMenu = new BanMenu(param1,this);
            this.banMenu.x = this.banMenu.width / 2 + 3;
            this.m.x = -(this.m.width / 2) - 3;
            addChild(this.banMenu);
         }
      }
      
      private function clickClose(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.m.close_bt.removeEventListener(MouseEvent.CLICK,this.clickClose);
         if(this.banMenu != null)
         {
            this.banMenu.remove();
            this.banMenu = null;
         }
         super.remove();
      }
   }
}
