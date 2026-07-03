package menu
{
   import flash.events.*;
   import flash.net.*;
   import package_4.*;
   
   public class ForgotPassPopup extends Popup
   {
       
      
      private var m:ForgotPassPopupGraphic;
      
      public function ForgotPassPopup(param1:String = "")
      {
         this.m = new ForgotPassPopupGraphic();
         super();
         this.m.ok_bt.addEventListener(MouseEvent.CLICK,this.sendForgotPass,false,0,true);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel,false,0,true);
         this.m.nameBox.addEventListener(KeyboardEvent.KEY_DOWN,this.listenForEnter,false,0,true);
         this.m.emailBox.addEventListener(KeyboardEvent.KEY_DOWN,this.listenForEnter,false,0,true);
         this.m.nameBox.text = param1;
         addChild(this.m);
      }
      
      private function listenForEnter(param1:KeyboardEvent) : *
      {
         if(param1.keyCode == 13)
         {
            this.sendForgotPass(param1);
         }
      }
      
      private function sendForgotPass(param1:*) : *
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.name = this.m.nameBox.text;
         _loc2_.email = this.m.emailBox.text;
         var _loc3_:URLRequest = new URLRequest(Main.baseURL + "/forgot_password.php");
         _loc3_.data = _loc2_;
         _loc3_.method = URLRequestMethod.POST;
         new UploadingPopup(_loc3_,"json","Checking your information...");
         startFadeOut();
      }
      
      private function clickCancel(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.m.ok_bt.removeEventListener(MouseEvent.CLICK,this.sendForgotPass);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         this.m.nameBox.removeEventListener(KeyboardEvent.KEY_DOWN,this.listenForEnter);
         this.m.emailBox.removeEventListener(KeyboardEvent.KEY_DOWN,this.listenForEnter);
         super.remove();
      }
   }
}
