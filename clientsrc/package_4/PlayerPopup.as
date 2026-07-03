package package_4
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   import lobby.*;
   import package_18.PartInfo.*;
   import package_6.*;
   import package_8.*;
   import ui.*;
   
   public class PlayerPopup extends Popup
   {
      
      private static var instance:PlayerPopup;
       
      
      private var superLoader:SuperLoader;
      
      private var m:PlayerPopupGraphic;
      
      private var banMenu:BanMenu;
      
      private var adminMenu:AdminMenu;
      
      private var tempModMenu:TempModMenu;
      
      private var guildName:GuildName;
      
      private var userId:int;
      
      private var userName:String;
      
      private var userIdShown:Boolean = false;
      
      private var expGain:ExpGain;
      
      private var times:Array;
      
      private var dataMode:String;
      
      private var cm:CommandHandler;
      
      private var hoverPopup:HoverPopup;
      
      private var hoverTimer:uint;

      private var sourceIs8P:Boolean;
      
      public function PlayerPopup(userName:String, sourceIs8P:Boolean = false)
      {
         this.m = new PlayerPopupGraphic();
         this.cm = CommandHandler.commandHandler;
         super();
         if(PlayerPopup.instance != null)
         {
            PlayerPopup.instance.startFadeOut();
         }
         PlayerPopup.instance = this;
         this.userName = userName;
         this.sourceIs8P = sourceIs8P;
         this.m.nameBox.text = "-- " + userName + " --";
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose,false,0,true);
         this.m.playerInfo.visible = false;
         addChild(this.m);
         if(Main.socket.connected)
         {
            this.cm.defineCommand("playerInfo",this.playerInfoFromSocket);
            Main.socket.write("get_player_info`" + userName);
         }
         else
         {
            this.playerInfoFromHTTP();
         }
         if(Main.group >= 2)
         {
            this.banMenu = new BanMenu(userName,this);
            addChild(this.banMenu);
            this.banMenu.x = this.banMenu.width / 2 + 40;
            this.m.x -= 96;
            if(Main.group >= 3)
            {
               this.m.x = -(this.m.width / 2) - 19;
               this.banMenu.x = this.banMenu.width / 2 - 19;
               this.adminMenu = new AdminMenu(userName,this);
               this.adminMenu.x = 215;
               addChild(this.adminMenu);
            }
         }
         else if(Main.group == 1 && Main.isTempMod)
         {
            this.tempModMenu = new TempModMenu(userName,this);
            addChild(this.tempModMenu);
            this.tempModMenu.x = this.tempModMenu.width / 2 + 47;
            this.m.x -= 96;
         }
      }
      
      private function playerInfoFromSocket(param1:Array) : *
      {
         var ret:String = null;
         var data:Object = null;
         var a:Array = param1;
         this.cm.defineCommand("playerInfo",null);
         try
         {
            ret = String(a[0]);
            if(ret == 0)
            {
               throw new Error();
            }
            this.dataMode = "socket";
            data = JSON.parse(ret);
            this.applyReturnData(data);
         }
         catch(e:Error)
         {
            this.playerInfoFromHTTP();
         }
      }
      
      private function playerInfoFromHTTP() : *
      {
         this.dataMode = "http";
         this.superLoader = new SuperLoader(true,SuperLoader.j);
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.name = this.userName;
         var _loc2_:URLRequest = new URLRequest((this.sourceIs8P ? Main.baseURL : Main.basePr2HubURL) + "/get_player_info.php");
         _loc2_.data = _loc1_;
         this.superLoader.load(_loc2_);
         this.superLoader.addEventListener(SuperLoader.d,this.applyReturnData,false,0,true);
         this.superLoader.addEventListener(SuperLoader.e,this.clickClose,false,0,true);
      }
      
      private function applyReturnData(param1:*) : *
      {
         var _loc2_:Object = null;
         var _loc4_:Character = null;
         var _loc5_:TextFormat = null;
         _loc2_ = this.dataMode == "http" ? SuperLoader(param1.target).parsedData : param1;
         this.userId = int(_loc2_.userId);
         var _loc3_:int = int(_loc2_.group);
         if(_loc3_ == 1)
         {
            if(_loc2_.ca)
            {
               groupText = "Community Ambassador";
               (_loc5_ = new TextFormat()).size = 11;
               this.m.playerInfo.groupBox.defaultTextFormat = _loc5_;
            }
            else
            {
               groupText = "Member";
            }
         }
         else if(_loc3_ == 2)
         {
            if(_loc2_.temp_mod != null && _loc2_.temp_mod == true)
            {
               groupText = "Temporary Moderator";
            }
            else if(_loc2_.trial_mod == true)
            {
               groupText = "Trial Moderator";
            }
            else
            {
               groupText = "Moderator";
            }
         }
         else
         {
            if(_loc3_ != 3)
            {
               PlayerPopup.instance.startFadeOut();
               new PlayerGuestPopup(this.userName);
               return;
            }
            groupText = "Admin";
         }
         if(Main.server.server_owner == this.userId)
         {
            groupText = "Server Owner";
         }
         this.m.playerInfo.statusBox.text = _loc2_.status;
         this.m.playerInfo.groupBox.text = groupText;
         this.m.playerInfo.verifiedIcon.visible = this.m.playerInfo.hofIcon.visible = false;
         if(_loc2_.verified)
         {
            this.m.playerInfo.verifiedIcon.visible = this.m.playerInfo.verifiedIcon.buttonMode = this.m.playerInfo.verifiedIcon.useHandCursor = true;
            this.m.playerInfo.verifiedIcon.addEventListener(MouseEvent.CLICK,this.iconEvent,false,0,true);
            this.m.playerInfo.verifiedIcon.addEventListener(MouseEvent.MOUSE_OVER,this.iconEvent,false,0,true);
            this.m.playerInfo.verifiedIcon.addEventListener(MouseEvent.MOUSE_OUT,this.outHover,false,0,true);
         }
         if(_loc2_.hof)
         {
            this.m.playerInfo.hofIcon.visible = this.m.playerInfo.hofIcon.buttonMode = this.m.playerInfo.hofIcon.useHandCursor = true;
            this.m.playerInfo.hofIcon.addEventListener(MouseEvent.CLICK,this.iconEvent,false,0,true);
            this.m.playerInfo.hofIcon.addEventListener(MouseEvent.MOUSE_OVER,this.iconEvent,false,0,true);
            this.m.playerInfo.hofIcon.addEventListener(MouseEvent.MOUSE_OUT,this.outHover,false,0,true);
            if(!_loc2_.verified)
            {
               this.m.playerInfo.hofIcon.x = -6;
            }
         }
         this.m.playerInfo.rankBox.text = _loc2_.rank;
         this.m.playerInfo.rankBox.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverRankBox,false,0,true);
         this.m.playerInfo.rankBox.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutRankBox,false,0,true);
         this.m.playerInfo.hatBox.text = _loc2_.hats;
         this.m.playerInfo.registerBox.text = _loc2_.registerDate == 0 ? "Age of Heroes" : Data.getShortDateStr(_loc2_.registerDate);
         if(_loc2_.registerDate != 0)
         {
            this.m.playerInfo.registerBox.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverRegisterBox,false,0,true);
            this.m.playerInfo.registerBox.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutRegisterBox,false,0,true);
         }
         this.m.playerInfo.activeBox.text = Data.getShortDateStr(_loc2_.loginDate);
         this.m.playerInfo.activeBox.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverActiveBox,false,0,true);
         this.m.playerInfo.activeBox.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutActiveBox,false,0,true);
         this.times = [_loc2_.registerDate,_loc2_.loginDate];
         if(_loc2_.guildId == 0)
         {
            this.m.playerInfo.guildBox.text = "none";
         }
         else
         {
            this.m.playerInfo.removeChild(this.m.playerInfo.guildBox);
            this.guildName = new GuildName(_loc2_.guildId,_loc2_.guildName,_loc2_.emblem,true,true);
            this.guildName.x = -40;
            this.guildName.y = 64;
            this.m.playerInfo.addChild(this.guildName);
         }
         _loc4_ = new Character(_loc2_.hat,_loc2_.head,_loc2_.body,_loc2_.feet);
         this.m.playerInfo.addChildAt(_loc4_,1);
         _loc4_.setHatColors(_loc2_.hatColor,_loc2_.hatColor2);
         _loc4_.setHeadColors(_loc2_.headColor,_loc2_.headColor2);
         _loc4_.setBodyColors(_loc2_.bodyColor,_loc2_.bodyColor2);
         _loc4_.setFeetColors(_loc2_.feetColor,_loc2_.feetColor2);
         _loc4_.scaleX = _loc4_.scaleY = 2;
         _loc4_.x = -75;
         _loc4_.y = 135;
         if(_loc2_.body == 29)
         {
            _loc4_.scaleX = _loc4_.scaleY = _loc4_.scaleY - 0.5;
            _loc4_.x -= 5;
            _loc4_.y -= 10;
         }
         this.m.playerInfo.supplBg.visible = false;
         this.expGain = new ExpGain();
         this.expGain.x = this.m.playerInfo.x;
         this.expGain.y = this.m.playerInfo.supplBg.y + 3;
         this.expGain.start(_loc2_.exp_points,_loc2_.exp_points,_loc2_.exp_to_rank);
         this.m.playerInfo.inviteButton.visible = false;
         this.m.playerInfo.kickButton.visible = false;
         this.m.playerInfo.kickBg.visible = false;
         if(Main.guildOwner == 1)
         {
            if(_loc2_.guildId == 0)
            {
               this.m.playerInfo.inviteButton.visible = true;
               this.m.playerInfo.inviteButton.addEventListener(MouseEvent.CLICK,this.clickInvite,false,0,true);
            }
            if(_loc2_.guildId == Main.guild)
            {
               this.m.playerInfo.kickButton.visible = true;
               this.m.playerInfo.kickBg.visible = true;
               this.m.playerInfo.kickButton.addEventListener(MouseEvent.CLICK,this.clickKick,false,0,true);
            }
         }
         this.m.playerInfo.messageButton.addEventListener(MouseEvent.MOUSE_OVER,this.overSendPMBt,false,0,true);
         this.m.playerInfo.messageButton.addEventListener(MouseEvent.MOUSE_OUT,this.outHover,false,0,true);
         this.m.playerInfo.messageButton.addEventListener(MouseEvent.CLICK,this.clickSendPM,false,0,true);
         this.m.playerInfo.levelsButton.addEventListener(MouseEvent.CLICK,this.clickViewLevels,false,0,true);
         if(_loc2_.following == 1)
         {
            this.m.playerInfo.followButton.label = "Unfollow";
            this.m.playerInfo.followButton.addEventListener(MouseEvent.CLICK,this.clickUnfollow,false,0,true);
         }
         else
         {
            this.m.playerInfo.followButton.label = "Follow";
            this.m.playerInfo.followButton.addEventListener(MouseEvent.CLICK,this.clickFollow,false,0,true);
         }
         if(_loc2_.friend == 1)
         {
            this.m.playerInfo.friendButton.label = "Remove Friend";
            this.m.playerInfo.friendButton.addEventListener(MouseEvent.CLICK,this.clickRemoveFriend,false,0,true);
         }
         else
         {
            this.m.playerInfo.friendButton.label = "Add to Friends";
            this.m.playerInfo.friendButton.addEventListener(MouseEvent.CLICK,this.clickAddFriend,false,0,true);
         }
         if(_loc2_.ignored == 1)
         {
            this.m.playerInfo.ignoreButton.label = "Unignore";
            this.m.playerInfo.ignoreButton.addEventListener(MouseEvent.CLICK,this.clickUnignore,false,0,true);
         }
         else
         {
            this.m.playerInfo.ignoreButton.label = "Ignore";
            this.m.playerInfo.ignoreButton.addEventListener(MouseEvent.CLICK,this.clickIgnore,false,0,true);
         }
         if(Main.group <= 0)
         {
            this.m.playerInfo.followButton.enabled = false;
            this.m.playerInfo.friendButton.enabled = false;
            this.m.playerInfo.ignoreButton.enabled = false;
         }
         this.m.playerInfo.visible = true;
         this.m.loadingGraphic.visible = false;
         Main.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.toggleUserIdShown,false,0,true);
         Main.stage.focus = Main.stage;
      }
      
      private function iconEvent(param1:MouseEvent) : *
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc2_:Object = {
            "hof":{
               "target":this.m.playerInfo.hofIcon,
               "title":"Hall of Fame",
               "desc":"This player has been inducted into the Hall of Fame for their exceptional talent and dedication to the PR2 and Jiggmin community.",
               "link":"https://jiggmin2.com/forums/showthread.php?tid=4226"
            },
            "verified":{
               "target":this.m.playerInfo.verifiedIcon,
               "title":"Verified",
               "desc":"This account is verified due to its notability and prominence in the community.",
               "link":"https://jiggmin2.com/forums/showthread.php?tid=4227"
            }
         };
         for each(_loc4_ in _loc2_)
         {
            if(param1.target === _loc4_.target)
            {
               _loc3_ = _loc4_;
            }
         }
         if(param1.type === MouseEvent.MOUSE_OVER)
         {
            this.hoverPopup = new HoverPopup(_loc3_.title,_loc3_.desc + " Click for more information.",_loc3_.target);
         }
         else if(param1.type === MouseEvent.CLICK)
         {
            navigateToURL(new URLRequest(_loc3_.link),"_blank");
         }
      }
      
      private function mouseOverRankBox(param1:MouseEvent) : *
      {
         this.m.playerInfo.supplBg.visible = true;
         this.m.playerInfo.addChild(this.expGain);
      }
      
      private function mouseOutRankBox(param1:MouseEvent) : *
      {
         this.m.playerInfo.supplBg.visible = false;
         this.m.playerInfo.removeChild(this.expGain);
      }
      
      private function mouseOverRegisterBox(param1:MouseEvent) : *
      {
         this.m.playerInfo.supplBg.visible = true;
         this.m.playerInfo.supplText.text = Data.getDateTimeStr(this.times[0],["long","medium"]);
      }
      
      private function mouseOutRegisterBox(param1:MouseEvent) : *
      {
         this.m.playerInfo.supplText.text = "";
         this.m.playerInfo.supplBg.visible = false;
      }
      
      private function mouseOverActiveBox(param1:MouseEvent) : *
      {
         this.m.playerInfo.supplBg.visible = true;
         this.m.playerInfo.supplText.text = Data.getDateTimeStr(this.times[1],["long","medium"]);
      }
      
      private function mouseOutActiveBox(param1:MouseEvent) : *
      {
         this.m.playerInfo.supplText.text = "";
         this.m.playerInfo.supplBg.visible = false;
      }
      
      private function clickInvite(param1:MouseEvent) : *
      {
         this.handleURL(Main.baseURL + "/guild_invite.php");
      }
      
      private function clickKick(param1:MouseEvent) : *
      {
         this.handleURL(Main.baseURL + "/guild_kick.php");
      }
      
      private function clickSendPM(param1:MouseEvent) : *
      {
         startFadeOut();
         new SendMessagePopup(this.userName);
      }
      
      private function clickFollow(param1:MouseEvent) : *
      {
         this.handleUserListURL("following","add");
         Main.socket.write("follow_user`" + this.userName);
      }
      
      private function clickUnfollow(param1:MouseEvent) : *
      {
         this.handleUserListURL("following","remove");
         Main.socket.write("unfollow_user`" + this.userName);
      }
      
      private function clickAddFriend(param1:MouseEvent) : *
      {
         this.handleUserListURL("friends","add");
         Main.socket.write("add_friend`" + this.userName);
      }
      
      private function clickRemoveFriend(param1:MouseEvent) : *
      {
         this.handleUserListURL("friends","remove");
         Main.socket.write("remove_friend`" + this.userName);
      }
      
      private function clickIgnore(param1:MouseEvent) : *
      {
         this.handleUserListURL("ignored","add");
         Main.socket.write("ignore_user`" + this.userName);
      }
      
      private function clickUnignore(param1:MouseEvent) : *
      {
         this.handleUserListURL("ignored","remove");
         Main.socket.write("unignore_user`" + this.userName);
      }
      
      private function overSendPMBt(param1:MouseEvent) : *
      {
         var e:MouseEvent = param1;
         this.hoverTimer = setTimeout(function():*
         {
            hoverPopup = new HoverPopup("Send PM","Send a PM to this player.",m.playerInfo.messageButton);
         },500);
      }
      
      private function outHover(param1:MouseEvent = null) : *
      {
         clearTimeout(this.hoverTimer);
         if(this.hoverPopup != null)
         {
            this.hoverPopup.remove();
            this.hoverPopup = null;
         }
      }
      
      private function clickViewLevels(param1:MouseEvent) : *
      {
         if(LobbyRight.lobbyRight != null)
         {
            LobbyRight.lobbyRight.lookupUser(this.userName);
         }
         if(GuildPopup.instance != null)
         {
            GuildPopup.instance.startFadeOut();
         }
         if(PartPopup.instance != null)
         {
            PartPopup.instance.startFadeOut();
         }
         if(PartInfoPopup.instance != null)
         {
            PartInfoPopup.instance.startFadeOut();
         }
         if(LevelInfoPopup.instance != null)
         {
            LevelInfoPopup.instance.startFadeOut();
         }
         startFadeOut();
      }
      
      private function clickClose(param1:*) : *
      {
         startFadeOut();
      }
      
      private function handleUserListURL(param1:String, param2:String) : *
      {
         var _loc3_:* = Main.baseURL + "/user_list_modify.php";
         var _loc4_:URLVariables;
         (_loc4_ = new URLVariables()).target_id = this.userId;
         _loc4_.list = param1;
         _loc4_.mode = param2;
         var _loc5_:URLRequest;
         (_loc5_ = new URLRequest(_loc3_)).method = URLRequestMethod.POST;
         _loc5_.data = _loc4_;
         new UploadingPopup(_loc5_,"json");
         startFadeOut();
      }
      
      private function handleURL(param1:String) : *
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.target_name = this.userName;
         _loc2_.user_id = this.userId;
         var _loc3_:URLRequest = new URLRequest(param1);
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         new UploadingPopup(_loc3_,"json");
         startFadeOut();
      }
      
      private function toggleUserIdShown(param1:KeyboardEvent) : *
      {
         if(param1.keyCode !== 16 || param1.type !== KeyboardEvent.KEY_DOWN)
         {
            return;
         }
         this.m.nameBox.text = !this.userIdShown ? "-- User ID: " + this.userId + " --" : "-- " + this.userName + " --";
         this.userIdShown = !this.userIdShown;
      }
      
      override public function remove() : *
      {
         if(PlayerPopup.instance === this)
         {
            PlayerPopup.instance = null;
         }
         Main.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.toggleUserIdShown);
         this.m.playerInfo.rankBox.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOverRankBox);
         this.m.playerInfo.rankBox.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOutRankBox);
         this.m.playerInfo.registerBox.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOverRegisterBox);
         this.m.playerInfo.registerBox.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOutRegisterBox);
         this.m.playerInfo.activeBox.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOverActiveBox);
         this.m.playerInfo.activeBox.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOutActiveBox);
         this.m.playerInfo.messageButton.removeEventListener(MouseEvent.MOUSE_OVER,this.overSendPMBt);
         this.m.playerInfo.messageButton.removeEventListener(MouseEvent.MOUSE_OUT,this.outHover);
         this.m.playerInfo.messageButton.removeEventListener(MouseEvent.CLICK,this.clickSendPM);
         this.m.playerInfo.levelsButton.removeEventListener(MouseEvent.CLICK,this.clickViewLevels);
         this.m.playerInfo.followButton.removeEventListener(MouseEvent.CLICK,this.clickFollow);
         this.m.playerInfo.followButton.removeEventListener(MouseEvent.CLICK,this.clickUnfollow);
         this.m.playerInfo.friendButton.removeEventListener(MouseEvent.CLICK,this.clickAddFriend);
         this.m.playerInfo.friendButton.removeEventListener(MouseEvent.CLICK,this.clickRemoveFriend);
         this.m.playerInfo.ignoreButton.removeEventListener(MouseEvent.CLICK,this.clickIgnore);
         this.m.playerInfo.ignoreButton.removeEventListener(MouseEvent.CLICK,this.clickUnignore);
         this.m.playerInfo.inviteButton.removeEventListener(MouseEvent.CLICK,this.clickInvite);
         this.m.playerInfo.kickButton.removeEventListener(MouseEvent.CLICK,this.clickKick);
         this.m.close_bt.removeEventListener(MouseEvent.CLICK,this.clickClose);
         clearTimeout(this.hoverTimer);
         this.outHover();
         if(this.banMenu != null)
         {
            this.banMenu.remove();
            this.banMenu = null;
         }
         if(this.adminMenu != null)
         {
            this.adminMenu.remove();
            this.adminMenu = null;
         }
         if(this.tempModMenu != null)
         {
            this.tempModMenu.remove();
            this.tempModMenu = null;
         }
         if(this.guildName != null)
         {
            this.guildName.remove();
            this.guildName = null;
         }
         removeChild(this.m);
         this.m = null;
         this.cm.defineCommand("playerInfo",null);
         this.cm = null;
         if(this.superLoader != null)
         {
            this.superLoader.remove();
         }
         super.remove();
      }
   }
}
