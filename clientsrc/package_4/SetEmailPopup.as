package package_4
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.net.*;
   
   public class SetEmailPopup extends Popup
   {
       
      
      private var m:SetEmailPopupGraphic;
      
      public function SetEmailPopup()
      {
         this.m = new SetEmailPopupGraphic();
         super();
         this.m.ok_bt.addEventListener(MouseEvent.CLICK,this.clickOk,false,0,true);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel,false,0,true);
         this.m.email1Box.addEventListener(KeyboardEvent.KEY_DOWN,this.listenForEnterKey,false,0,true);
         this.m.email2Box.addEventListener(KeyboardEvent.KEY_DOWN,this.listenForEnterKey,false,0,true);
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
         var _loc5_:* = undefined;
         var _loc6_:URLVariables = null;
         var _loc7_:URLRequest = null;
         if(this.m.email1Box.text == "" || this.m.passBox.text == "")
         {
            new MessagePopup("Please fill in all of the fields.");
         }
         else if(this.m.email1Box.text != this.m.email2Box.text)
         {
            new MessagePopup("The emails don\'t match. Please re-check them.");
         }
         else
         {
            _loc2_ = new Object();
            _loc2_.email = this.m.email1Box.text;
            _loc2_.pass = this.m.passBox.text;
            _loc3_ = JSON.stringify(_loc2_);
            (_loc4_ = new Encryptor()).setKey(Env.ACCOUNT_CHANGE_KEY);
            _loc4_.setIV(Env.ACCOUNT_CHANGE_IV);
            _loc5_ = _loc4_.encrypt(_loc3_);
            (_loc6_ = new URLVariables()).data = _loc5_;
            (_loc7_ = new URLRequest(Main.baseURL + "/account_change_email.php")).data = _loc6_;
            _loc7_.method = URLRequestMethod.POST;
            new UploadingPopup(_loc7_,SuperLoader.j);
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
         this.m.email1Box.removeEventListener(KeyboardEvent.KEY_DOWN,this.listenForEnterKey);
         this.m.email2Box.removeEventListener(KeyboardEvent.KEY_DOWN,this.listenForEnterKey);
         super.remove();
      }
   }
}
