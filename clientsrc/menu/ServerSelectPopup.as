package menu
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.*;
   import package_4.*;
   
   public class ServerSelectPopup extends Popup
   {
       
      
      private var m:ServerSelectPopupGraphic;
      
      public function ServerSelectPopup(param1:Boolean = true, param2:Boolean = false)
      {
         this.m = new ServerSelectPopupGraphic();
         super();
         this.m.login_bt.addEventListener(MouseEvent.CLICK,this.clickLogIn,false,0,true);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel,false,0,true);
         this.m.reload_bt.addEventListener(MouseEvent.CLICK,this.clickReload,false,0,true);
         if(param1 || param2)
         {
            this.m.user_del_bt.alpha = 0.1;
            this.m.user_del_bt.enabled = this.m.userSelect.enabled = false;
            this.m.userSelect.prompt = param2 ? Main.userName : "Guest";
         }
         else
         {
            this.m.userSelect.addEventListener(Event.CHANGE,this.userChange,false,0,true);
            this.userSelectPopulate();
         }
         addChild(this.m);
         CheckServers.determineServer(this.m.serverSelect);
      }
      
      public function userSelectPopulate() : *
      {
         var _loc3_:Object = null;
         var _loc1_:Array = SavedAccounts.getAll();
         if(_loc1_.length === 0)
         {
            new LoginPopup();
            startFadeOut();
            return;
         }
         this.m.userSelect.removeAll();
         this.m.userSelect.prompt = null;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = {};
            _loc3_.label = _loc1_[_loc2_].name;
            _loc3_.token = _loc1_[_loc2_].token;
            this.m.userSelect.addItem(_loc3_);
            _loc2_++;
         }
         this.m.userSelect.addItem({
            "label":"Use Other Account...",
            "token":""
         });
         this.m.userSelect.selectedItem = this.m.userSelect.dataProvider.getItemAt(0);
         this.m.userSelect.enabled = true;
         this.m.userSelect.dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function toggleUserButton(param1:Boolean) : *
      {
         if(param1)
         {
            this.m.user_del_bt.alpha = this.m.login_bt.alpha = 1;
            this.m.user_del_bt.enabled = this.m.login_bt.enabled = true;
            this.m.user_del_bt.addEventListener(MouseEvent.CLICK,this.clickUserDelete,false,0,true);
         }
         else
         {
            this.m.user_del_bt.alpha = this.m.login_bt.alpha = 0.1;
            this.m.user_del_bt.enabled = this.m.login_bt.enabled = false;
            this.m.user_del_bt.removeEventListener(MouseEvent.CLICK,this.clickUserDelete);
         }
      }
      
      private function userChange(param1:Event) : *
      {
         var _loc2_:Object = this.m.userSelect.selectedItem;
         if(_loc2_.token === "")
         {
            Main.token = "";
            Main.remember = false;
            this.toggleUserButton(false);
            new LoginPopup(this);
         }
         else
         {
            Main.token = _loc2_.token;
            Main.remember = true;
            this.toggleUserButton(true);
         }
      }
      
      private function clickUserDelete(param1:MouseEvent) : *
      {
         var _loc2_:String = String(Data.escapeString(this.m.userSelect.selectedItem.label));
         new ConfirmPopup(this.doUserDelete,"Are you sure you want to delete \"" + _loc2_ + "\" from your saved accounts?");
      }
      
      public function doUserDelete() : *
      {
         var _loc1_:Object = this.m.userSelect.selectedItem;
         if(_loc1_.token === "")
         {
            return;
         }
         var _loc2_:URLVariables = new URLVariables();
         var _loc3_:URLRequest = new URLRequest(Main.baseURL + "/logout.php");
         _loc3_.data = _loc2_;
         _loc3_.method = URLRequestMethod.POST;
         var _loc4_:SuperLoader;
         (_loc4_ = new SuperLoader(true,SuperLoader.j)).load(_loc3_);
         if(SavedAccounts.deleteAccount(_loc1_.label) === false)
         {
            new MessagePopup("Error: Invalid account specified.");
            return;
         }
         this.userSelectPopulate();
      }
      
      private function clickLogIn(param1:MouseEvent) : *
      {
         if(this.m.serverSelect.length > 0)
         {
            Main.server = this.m.serverSelect.selectedItem.server;
            new ConnectingPopup();
            startFadeOut();
         }
      }
      
      private function clickReload(param1:MouseEvent) : *
      {
         if(this.m.reload_bt.enabled == true)
         {
            this.m.reload_bt.enabled = false;
            this.m.reload_bt.alpha = 0.1;
            setTimeout(this.enableReload,10000);
            CheckServers.reload();
         }
      }
      
      private function enableReload() : *
      {
         this.m.reload_bt.enabled = true;
         this.m.reload_bt.alpha = 1;
      }
      
      private function clickCancel(param1:MouseEvent) : *
      {
         Main.token = "";
         Main.remember = false;
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.m.login_bt.removeEventListener(MouseEvent.CLICK,this.clickLogIn);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         this.m.reload_bt.removeEventListener(MouseEvent.CLICK,this.clickReload);
         this.m.user_del_bt.removeEventListener(MouseEvent.CLICK,this.clickUserDelete);
         this.m.userSelect.removeEventListener(Event.CHANGE,this.userChange);
         CheckServers.removeBox();
         super.remove();
      }
   }
}
