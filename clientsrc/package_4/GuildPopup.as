package package_4
{
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import ui.*;
   
   public class GuildPopup extends Popup
   {
      
      public static var instance:GuildPopup;
       
      
      private var m:GuildPopupGraphic;
      
      private var superLoader:SuperLoader;
      
      private var loader:Loader;
      
      private var guildMembers:Vector.<GuildMemberName>;
      
      private var scroll:CustomScrollBar;
      
      private var guildName:String;
      
      private var guildId:int;
      
      private var guildIdShown:Boolean = false;
      
      private var ownerId:int;
      
      public function GuildPopup(param1:int = 0, param2:String = "")
      {
         this.guildMembers = new Vector.<GuildMemberName>();
         super();
         this.guildId = param1;
         this.guildName = "";
         if(GuildPopup.instance != null)
         {
            GuildPopup.instance.startFadeOut();
         }
         GuildPopup.instance = this;
         this.m = new GuildPopupGraphic();
         this.m.gotoAndStop("loading");
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose,false,0,true);
         addChild(this.m);
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.id = param1;
         _loc3_.name = param2;
         _loc3_.getMembers = "yes";
         var _loc4_:URLRequest;
         (_loc4_ = new URLRequest(Main.baseURL + "/guild_info.php")).data = _loc3_;
         this.superLoader = new SuperLoader(true,SuperLoader.j);
         this.superLoader.addEventListener(SuperLoader.d,this.parseReturn,false,0,true);
         this.superLoader.addEventListener(SuperLoader.e,this.clickClose,false,0,true);
         this.superLoader.load(_loc4_);
      }
      
      private function determineVisuals() : *
      {
         this.m.gotoAndStop("nonMember");
         this.m.edit_bt.visible = this.m.delete_bt.visible = false;
         if(Main.group >= 2 && Main.isTrialMod == false)
         {
            this.m.edit_bt.visible = true;
            this.m.edit_bt.addEventListener(MouseEvent.CLICK,this.clickEdit,false,0,true);
            if(Main.group == 3)
            {
               this.m.delete_bt.visible = true;
               this.m.delete_bt.addEventListener(MouseEvent.CLICK,this.clickDelete,false,0,true);
            }
         }
         this.loader = new Loader();
         this.loader.x = -140;
         this.loader.y = -109;
         addChild(this.loader);
         this.scroll = new CustomScrollBar();
         this.scroll.x = 126;
         this.scroll.y = -28;
      }
      
      private function parseReturn(param1:Event) : *
      {
         var _loc4_:Object = null;
         var _loc5_:GuildMemberName = null;
         this.determineVisuals();
         var _loc2_:Object = this.superLoader.parsedData.guild;
         var _loc3_:Array = this.superLoader.parsedData.members;
         this.guildId = _loc2_.guild_id;
         this.ownerId = _loc2_.owner_id;
         this.guildName = _loc2_.guild_name;
         this.m.titleBox.text = "-- " + this.guildName + " --";
         this.m.gpTodayBox.text = "GP Today: " + Data.formatNumber(_loc2_.gp_today);
         this.m.gpTotalBox.text = "GP Total: " + Data.formatNumber(_loc2_.gp_total);
         this.m.membersCount.text = "Members: " + _loc2_.member_count + " (" + _loc2_.active_count + " active)";
         this.m.guildProse.text = _loc2_.note;
         this.loader.load(new URLRequest(Main.baseURL + "/emblems/" + _loc2_.emblem));
         for each(_loc4_ in _loc3_)
         {
            (_loc5_ = new GuildMemberName(_loc4_,this.ownerId == _loc4_.user_id)).y = this.guildMembers.length * 16;
            this.m.membersHolder.addChild(_loc5_);
            this.guildMembers.push(_loc5_);
         }
         if(this.guildId != 0 && Main.guild == this.guildId)
         {
            this.m.gotoAndStop("member");
            this.m.close_bt.x = 8;
            this.m.close_bt.width = 85;
            this.m.messageButton.addEventListener(MouseEvent.CLICK,this.clickMessage,false,0,true);
         }
         addChild(this.scroll);
         this.scroll.init(this.m.membersHolder,100,100);
         this.m.loadingGraphic.visible = false;
         Main.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.toggleGuildIdShown,false,0,true);
         Main.stage.focus = Main.stage;
      }
      
      private function clickMessage(param1:MouseEvent) : *
      {
         new SendMessagePopup("guild","",true);
      }
      
      private function clickClose(param1:*) : *
      {
         startFadeOut();
      }
      
      private function clickEdit(param1:MouseEvent) : *
      {
         startFadeOut();
         new CreateGuildPopup(this.guildId);
      }
      
      private function clickDelete(param1:MouseEvent) : *
      {
         var _loc2_:* = "Are you sure you want to delete this guild?";
         if(this.guildName != "")
         {
            _loc2_ = "Are you sure you want to delete " + Data.escapeString(this.guildName) + "?";
         }
         new ConfirmPopup(this.confirmDelete,_loc2_);
      }
      
      public function confirmDelete() : *
      {
         var _loc1_:SuperLoader = new SuperLoader(true,SuperLoader.j);
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.guild_id = this.guildId;
         var _loc3_:URLRequest = new URLRequest(Main.baseURL + "/guild_delete.php");
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         _loc1_.load(_loc3_);
         startFadeOut();
      }
      
      private function toggleGuildIdShown(param1:KeyboardEvent) : *
      {
         if(param1.keyCode !== 16 || param1.type !== KeyboardEvent.KEY_DOWN)
         {
            return;
         }
         this.m.titleBox.text = !this.guildIdShown ? "-- Guild ID: " + this.guildId + " --" : "-- " + this.guildName + " --";
         this.guildIdShown = !this.guildIdShown;
      }
      
      override public function remove() : *
      {
         var _loc1_:GuildMemberName = null;
         if(GuildPopup.instance === this)
         {
            GuildPopup.instance = null;
         }
         Main.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.toggleGuildIdShown);
         for each(_loc1_ in this.guildMembers)
         {
            _loc1_.remove();
         }
         this.guildMembers = null;
         this.superLoader.removeEventListener(SuperLoader.d,this.parseReturn);
         this.superLoader.removeEventListener(SuperLoader.e,this.clickClose);
         this.superLoader.remove();
         this.superLoader = null;
         if(this.scroll != null)
         {
            this.scroll.remove();
            this.scroll = null;
         }
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
