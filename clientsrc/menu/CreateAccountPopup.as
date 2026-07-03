package menu
{
   import flash.events.*;
   import flash.net.*;
   import package_4.*;
   
   public class CreateAccountPopup extends Popup
   {
       
      
      private var m:CreateAccountPopupGraphic;
      
      private var uploadingPopup:UploadingPopup;
      
      public function CreateAccountPopup()
      {
         this.m = new CreateAccountPopupGraphic();
         super();
         addChild(this.m);
         this.m.createAccount_bt.addEventListener(MouseEvent.CLICK,this.clickCreateAccount);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel);
      }
      
      private function clickCreateAccount(param1:MouseEvent) : *
      {
         var _loc2_:* = undefined;
         if(this.m.passBox1.text != this.m.passBox2.text)
         {
            new MessagePopup("The passwords don\'t match. Please enter your password again.");
         }
         else
         {
            _loc2_ = new URLVariables();
            _loc2_.name = this.m.nameBox.text;
            _loc2_.password = this.m.passBox1.text;
            _loc2_.email = this.m.emailBox.text;
            request = new URLRequest(Main.baseURL + "/register_user.php");
            request.data = _loc2_;
            request.method = "POST";
            this.uploadingPopup = new UploadingPopup(request,SuperLoader.j,"Creating account...");
            this.uploadingPopup.addEventListener(SuperLoader.d,this.receiveCreateAccountResult,false,0,true);
         }
      }
      
      private function receiveCreateAccountResult(param1:Event) : *
      {
         if(this.uploadingPopup.parsedData.success == true)
         {
            Main.userName = this.m.nameBox.text;
            Main.userPass = this.m.passBox1.text;
            new ServerSelectPopup(false,true);
            startFadeOut();
         }
      }
      
      private function clickCancel(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         if(this.uploadingPopup != null)
         {
            this.uploadingPopup.removeEventListener(SuperLoader.d,this.receiveCreateAccountResult);
            this.uploadingPopup = null;
         }
         this.m.createAccount_bt.removeEventListener(MouseEvent.CLICK,this.clickCreateAccount);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         super.remove();
      }
   }
}
