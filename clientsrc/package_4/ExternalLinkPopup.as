package package_4
{
   import flash.events.*;
   import flash.net.*;
   
   public class ExternalLinkPopup extends Popup
   {
      
      private static var instance:ExternalLinkPopup;
       
      
      private var m:ExternalLinkPopupGraphic;
      
      private var url:String;
      
      public function ExternalLinkPopup(param1:String)
      {
         this.m = new ExternalLinkPopupGraphic();
         super();
         if(ExternalLinkPopup.instance != null)
         {
            ExternalLinkPopup.instance.startFadeOut();
         }
         ExternalLinkPopup.instance = this;
         this.url = param1;
         this.m.linkBox.text = this.url;
         this.m.proceed_bt.addEventListener(MouseEvent.CLICK,this.clickGo,false,0,true);
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose,false,0,true);
         addChild(this.m);
      }
      
      private function clickGo(param1:MouseEvent) : *
      {
         navigateToURL(new URLRequest(this.url),"_blank");
         startFadeOut();
      }
      
      private function clickClose(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         if(ExternalLinkPopup.instance === this)
         {
            ExternalLinkPopup.instance = null;
         }
         this.m.proceed_bt.removeEventListener(MouseEvent.CLICK,this.clickGo);
         this.m.close_bt.removeEventListener(MouseEvent.CLICK,this.clickClose);
         super.remove();
      }
   }
}
