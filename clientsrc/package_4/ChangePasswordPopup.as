package package_4
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.net.*;
   
   public class ChangePasswordPopup extends Popup
   {
       
      
      private var m:ChangePasswordPopupGraphic;
      
      public function ChangePasswordPopup()
      {
         this.m = new ChangePasswordPopupGraphic();
         super();
         this.m.ok_bt.addEventListener(MouseEvent.CLICK,this.clickOk,false,0,true);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel,false,0,true);
         this.m.currentPassBox.addEventListener(KeyboardEvent.KEY_DOWN,this.listenForEnterKey,false,0,true);
         this.m.newPassBox1.addEventListener(KeyboardEvent.KEY_DOWN,this.listenForEnterKey,false,0,true);
         this.m.newPassBox2.addEventListener(KeyboardEvent.KEY_DOWN,this.listenForEnterKey,false,0,true);
         addChild(this.m);
      }
      
      private function listenForEnterKey(param1:KeyboardEvent) : *
      {
         if(param1.keyCode == 13)
         {
            this.clickOk(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      private function clickOk(param1:MouseEvent) : *
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:Encryptor = null;
         var _loc5_:String = null;
         var _loc6_:URLVariables = null;
         var _loc7_:URLRequest = null;
         if(this.m.newPassBox1.text != this.m.newPassBox2.text)
         {
            new MessagePopup("Error: The passwords don\'t match.");
         }
         else if(this.m.newPassBox1.text == this.m.currentPassBox.text)
         {
            new MessagePopup("Error: Your current and new passwords match. Try picking a new password.");
         }
         else
         {
            _loc2_ = new Object();
            _loc2_.name = Main.loggedInAs;
            _loc2_.old_pass = this.m.currentPassBox.text;
            _loc2_.new_pass = this.m.newPassBox1.text;
            _loc3_ = JSON.stringify(_loc2_);
            (_loc4_ = new Encryptor()).setKey(Env.LOGIN_KEY);
            _loc4_.setIV(Env.LOGIN_IV);
            _loc5_ = _loc4_.encrypt(_loc3_);
            (_loc6_ = new URLVariables()).i = _loc5_;
            (_loc7_ = new URLRequest(Main.baseURL + "/change_password.php")).data = _loc6_;
            _loc7_.method = URLRequestMethod.POST;
            new UploadingPopup(_loc7_,"json","Changing password...");
            startFadeOut();
         }
      }
      
      private function clickCancel(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.m.ok_bt.removeEventListener(MouseEvent.CLICK,this.clickOk);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         this.m.currentPassBox.removeEventListener(KeyboardEvent.KEY_DOWN,this.listenForEnterKey);
         this.m.newPassBox1.removeEventListener(KeyboardEvent.KEY_DOWN,this.listenForEnterKey);
         this.m.newPassBox2.removeEventListener(KeyboardEvent.KEY_DOWN,this.listenForEnterKey);
         super.remove();
      }
   }
}
