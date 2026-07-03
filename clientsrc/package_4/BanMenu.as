package package_4
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.net.*;
   import package_21.*;
   
   public class BanMenu extends Removable
   {
       
      
      private var m:BanMenuGraphic;
      
      private var target:Popup;
      
      private var userName:String;
      
      private var banSecs:int;
      
      private var uploading:UploadingPopup;
      
      public function BanMenu(param1:String, param2:Popup)
      {
         this.m = new BanMenuGraphic();
         super();
         this.userName = param1;
         this.target = param2;
         if(Main.isTrialMod == false)
         {
            this.m.duration.addItem({
               "label":"Three Days",
               "data":259200
            });
            this.m.duration.addItem({
               "label":"One Week",
               "data":604800
            });
            this.m.duration.addItem({
               "label":"Two Weeks",
               "data":1209600
            });
            this.m.duration.addItem({
               "label":"One Month",
               "data":2592000
            });
            this.m.duration.addItem({
               "label":"Six Months",
               "data":15768000
            });
            this.m.duration.addItem({
               "label":"One Year",
               "data":31536000
            });
            this.m.scope.addItem({
               "label":"Game",
               "data":"game"
            });
            this.m.scope.enabled = true;
         }
         this.m.warning1Button.addEventListener(MouseEvent.CLICK,this.clickWarning1,false,0,true);
         this.m.warning2Button.addEventListener(MouseEvent.CLICK,this.clickWarning2,false,0,true);
         this.m.warning3Button.addEventListener(MouseEvent.CLICK,this.clickWarning3,false,0,true);
         this.m.kickButton.addEventListener(MouseEvent.CLICK,this.clickKick,false,0,true);
         this.m.banButton.addEventListener(MouseEvent.CLICK,this.confirmBan,false,0,true);
         this.m.viewPriorsButton.addEventListener(MouseEvent.CLICK,this.viewPriors,false,0,true);
         addChild(this.m);
      }
      
      private function viewPriors(param1:MouseEvent) : *
      {
         if(Main.socket.connected)
         {
            Main.socket.write("view_priors`" + this.userName);
         }
         else
         {
            new MessagePopup("Error: You are not connected to a server. Please log in and try again.");
         }
      }
      
      private function confirmBan(param1:MouseEvent) : *
      {
         this.banSecs = this.m.duration.selectedItem.data;
         if(this.banSecs == 0)
         {
            new MessagePopup("Error: You must specify a ban length.");
            return;
         }
         var _loc2_:String = this.m.scope.selectedItem.data === "game" ? "ban" : "socially ban";
         var _loc3_:* = "Are you sure you want to " + _loc2_ + " " + Data.escapeString(this.userName) + "?";
         if(this.m.scope.selectedItem.data === "game")
         {
            _loc3_ += " They won\'t be able to log onto PR2 or use any of the pages on pr2hub.com.";
         }
         else
         {
            _loc3_ += " They won\'t be able to register new accounts, use guest accounts, or use any messaging, contest, or guild-related features. They also won\'t be able to publish or rate levels.";
         }
         new ConfirmPopup(this.banUser,_loc3_);
      }
      
      public function banUser() : *
      {
         var _loc1_:String = "";
         if(ChatInstance.instance != null)
         {
            _loc1_ = String(ChatInstance.instance.getChatRecord());
         }
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.banned_name = this.userName;
         _loc2_.duration = this.banSecs;
         _loc2_.reason = this.m.reason.text;
         _loc2_.type = this.m.type.selectedItem.data;
         _loc2_.scope = this.m.scope.selectedItem.data;
         if(Memory.memory.chatRoom !== "mod" && Memory.memory.chatRoom !== "admin")
         {
            _loc2_.record = _loc1_;
         }
         var _loc3_:URLRequest = new URLRequest(Main.baseURL + "/ban_user.php");
         _loc3_.data = _loc2_;
         _loc3_.method = URLRequestMethod.POST;
         this.uploading = new UploadingPopup(_loc3_,"json","Banning...");
         this.uploading.addEventListener(SuperLoader.d,this.onBanSuccess,false,0,true);
         this.uploading.addEventListener(SuperLoader.e,this.method_238,false,0,true);
      }
      
      private function method_238(param1:Event) : *
      {
         this.target.startFadeOut();
      }
      
      private function onBanSuccess(param1:Event) : *
      {
         var _loc2_:int = this.uploading.parsedData.ban_id != null ? int(this.uploading.parsedData.ban_id) : 0;
         Main.socket.write("ban`" + this.userName + "`" + this.banSecs + "`" + this.m.scope.selectedItem.data + "`" + _loc2_ + "`" + this.m.reason.text);
         this.target.startFadeOut();
      }
      
      private function clickWarning1(param1:MouseEvent) : *
      {
         this.warnUser(1);
      }
      
      private function clickWarning2(param1:MouseEvent) : *
      {
         this.warnUser(2);
      }
      
      private function clickWarning3(param1:MouseEvent) : *
      {
         this.warnUser(3);
      }
      
      private function warnUser(param1:int) : *
      {
         Main.socket.write("warn`" + this.userName + "`" + param1);
         this.target.startFadeOut();
      }
      
      private function clickKick(param1:MouseEvent) : *
      {
         new ConfirmPopup(this.kickUser,"Are you sure you want to kick " + Data.escapeString(this.userName) + "? They will not be able to re-enter this server for 30 minutes.");
      }
      
      public function kickUser() : *
      {
         Main.socket.write("kick`" + this.userName);
         this.target.startFadeOut();
      }
      
      override public function remove() : *
      {
         this.m.viewPriorsButton.removeEventListener(MouseEvent.CLICK,this.viewPriors);
         this.m.banButton.removeEventListener(MouseEvent.CLICK,this.confirmBan);
         this.m.warning1Button.removeEventListener(MouseEvent.CLICK,this.clickWarning1);
         this.m.warning2Button.removeEventListener(MouseEvent.CLICK,this.clickWarning2);
         this.m.warning3Button.removeEventListener(MouseEvent.CLICK,this.clickWarning3);
         this.m.kickButton.removeEventListener(MouseEvent.CLICK,this.clickKick);
         this.target = null;
         if(this.uploading != null)
         {
            this.uploading.removeEventListener(SuperLoader.e,this.method_238);
            this.uploading.removeEventListener(SuperLoader.d,this.onBanSuccess);
            this.uploading = null;
         }
         super.remove();
      }
   }
}
