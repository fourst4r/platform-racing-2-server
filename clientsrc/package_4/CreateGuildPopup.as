package package_4
{
   import flash.events.*;
   import flash.net.*;
   import ui.*;
   
   public class CreateGuildPopup extends Popup
   {
       
      
      private var m:CreateGuildPopupGraphic;
      
      private var guildId:int;
      
      private var loading:Boolean = false;
      
      private var loader:SuperLoader;
      
      private var infoLoader:SuperLoader;
      
      private var emblem:EmblemLoader;
      
      public function CreateGuildPopup(param1:int = 0)
      {
         var _loc2_:URLVariables = null;
         var _loc3_:URLRequest = null;
         this.loader = new SuperLoader(true,SuperLoader.j);
         this.infoLoader = new SuperLoader(true,SuperLoader.j);
         super();
         this.guildId = param1;
         this.m = new CreateGuildPopupGraphic();
         this.m.transfer_bg.visible = this.m.transfer_bt.visible = false;
         addChild(this.m);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel,false,0,true);
         this.m.confirm_bt.addEventListener(MouseEvent.CLICK,this.clickConfirm,false,0,true);
         this.infoLoader.addEventListener(SuperLoader.d,this.populateResult,false,0,true);
         this.loader = new SuperLoader(true,SuperLoader.j);
         this.loader.addEventListener(SuperLoader.d,this.accChangeHandler,false,0,true);
         this.loader.addEventListener(SuperLoader.e,this.confirmResponseError,false,0,true);
         this.emblem = new EmblemLoader(100,50,Main.baseURL + "/emblem_upload.php",Main.baseURL + "/emblems/");
         this.emblem.x = -43;
         this.emblem.y = -27;
         this.emblem.getImage("default-emblem.jpg");
         addChild(this.emblem);
         this.m.changeEmblem_bt.addEventListener(MouseEvent.CLICK,this.clickChangeEmblem,false,0,true);
         this.m.deleteEmblem_bt.visible = false;
         if(this.guildId != 0)
         {
            this.loading = true;
            this.m.titleBox.text = "-- Edit Guild --";
            _loc2_ = new URLVariables();
            _loc2_.id = this.guildId;
            _loc3_ = new URLRequest(Main.baseURL + "/guild_info.php");
            _loc3_.data = _loc2_;
            this.infoLoader.load(_loc3_);
            if(Main.guild == this.guildId && Main.guildOwner == 1)
            {
               this.m.transfer_bg.visible = this.m.transfer_bt.visible = true;
               this.m.transfer_bt.addEventListener(MouseEvent.CLICK,this.clickTransfer,false,0,true);
            }
         }
      }
      
      private function clickTransfer(param1:MouseEvent) : *
      {
         if(Main.remember == true)
         {
            new TransferGuildPopup();
            startFadeOut();
         }
         else
         {
            new MessagePopup("Psst... I won\'t work if you\'re not logged in with remember me. Log back in with remember me enabled and click me again! :)");
         }
      }
      
      private function clickDeleteEmblem(param1:MouseEvent) : *
      {
         this.emblem.getImage("default-emblem.jpg");
         this.m.deleteEmblem_bt.visible = false;
         this.m.deleteEmblem_bt.removeEventListener(MouseEvent.CLICK,this.clickDeleteEmblem);
         new MessagePopup("Once you press Confirm, this change will be final. To revert this change, click Cancel.");
      }
      
      private function populateResult(param1:Event) : *
      {
         var _loc2_:Object = this.infoLoader.parsedData.guild;
         this.m.nameBox.text = _loc2_.guild_name;
         this.m.proseBox.text = _loc2_.note;
         this.emblem.getImage(_loc2_.emblem);
         if(_loc2_.emblem != "default-emblem.jpg" && this.guildId != 0)
         {
            this.m.deleteEmblem_bt.visible = true;
            this.m.deleteEmblem_bt.addEventListener(MouseEvent.CLICK,this.clickDeleteEmblem,false,0,true);
         }
         this.loading = false;
      }
      
      private function clickChangeEmblem(param1:MouseEvent) : *
      {
         this.emblem.openBrowse();
      }
      
      private function clickCancel(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      private function clickConfirm(param1:MouseEvent) : *
      {
         if(!this.loading)
         {
            this.loading = true;
            this.m.confirm_bt.alpha = 0.33;
            if(this.emblem.isLoading())
            {
               this.emblem.addEventListener(EmblemLoader.FINISH_LOADING,this.emblemFinished,false,0,true);
            }
            else
            {
               this.doConfirm();
            }
         }
      }
      
      private function emblemFinished(param1:Event) : *
      {
         this.emblem.removeEventListener(EmblemLoader.FINISH_LOADING,this.emblemFinished);
         this.doConfirm();
      }
      
      private function doConfirm() : *
      {
         var _loc1_:URLVariables = new URLVariables();
         if(this.guildId != 0)
         {
            _loc1_.guild_id = this.guildId;
         }
         _loc1_.note = this.m.proseBox.text;
         _loc1_.name = this.m.nameBox.text;
         _loc1_.emblem = this.emblem.getFileName();
         var _loc2_:* = Main.baseURL + "/guild_create.php";
         if(this.guildId != 0)
         {
            _loc2_ = Main.baseURL + "/guild_edit.php";
         }
         var _loc3_:URLRequest = new URLRequest(_loc2_);
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc1_;
         this.loader.load(_loc3_);
      }
      
      private function confirmResponseError(param1:Event) : *
      {
         this.loading = false;
         this.m.confirm_bt.alpha = 1;
      }
      
      private function accChangeHandler(param1:Event) : *
      {
         if(Boolean(this.loading) && Main.guild != this.guildId)
         {
            startFadeOut();
            return;
         }
         var _loc2_:Object = this.loader.parsedData;
         Main.guild = _loc2_.guild_id;
         Main.guildName = _loc2_.guild_name;
         Main.emblem = _loc2_.emblem;
         Main.guildOwner = 1;
         Main.instance.dispatchEvent(new Event(Main.accountChange));
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.loader.removeEventListener(SuperLoader.d,this.accChangeHandler);
         this.loader.removeEventListener(SuperLoader.e,this.confirmResponseError);
         this.loader.remove();
         this.loader = null;
         this.emblem.removeEventListener(EmblemLoader.FINISH_LOADING,this.emblemFinished);
         this.emblem.remove();
         this.emblem = null;
         this.infoLoader.removeEventListener(SuperLoader.d,this.populateResult);
         this.infoLoader.remove();
         this.infoLoader = null;
         this.m.changeEmblem_bt.removeEventListener(MouseEvent.CLICK,this.clickChangeEmblem);
         this.m.deleteEmblem_bt.removeEventListener(MouseEvent.CLICK,this.clickDeleteEmblem);
         this.m.transfer_bt.removeEventListener(MouseEvent.CLICK,this.clickTransfer);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         this.m.confirm_bt.removeEventListener(MouseEvent.CLICK,this.clickConfirm);
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
