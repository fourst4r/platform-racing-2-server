package package_4
{
   import com.jiggmin.data.*;
   import fl.events.*;
   import flash.display.DisplayObject;
   import flash.events.*;
   import flash.net.*;
   import sounds.*;
   
   public class OptionsPopup extends Popup
   {
       
      
      private var m:OptionsPopupGraphic;
      
      private var fps30:Boolean;
      
      private var drawArt:Boolean;
      
      private var altCtrl:Object;
      
      private var hTrueY:Number = -71.5;
      
      private var hFalseY:Number = -43.5;
      
      private var buttonStartPos:int = 80;
      
      private var hoverActive:HoverPopup;
      
      public function OptionsPopup()
      {
         this.m = new OptionsPopupGraphic();
         this.fps30 = Settings.getValue(Settings.FPS_30,false);
         this.drawArt = Settings.getValue(Settings.DRAW_ART,true);
         this.altCtrl = Settings.getValue(Settings.ALTERNATE_CONTROLS,Settings.DEFAULT_ALT_CONTROLS);
         super();
         addChild(this.m);
         this.m.musicSlider.value = Settings.musicLevel;
         this.m.musicSlider.addEventListener(SliderEvent.CHANGE,this.musicSliderChange,false,0,true);
         this.m.soundSlider.value = Settings.soundLevel;
         this.m.soundSlider.addEventListener(SliderEvent.CHANGE,this.soundSliderChange,false,0,true);
         this.m.soundSlider.addEventListener(SliderEvent.THUMB_RELEASE,this.soundSliderRelease,false,0,true);
         this.m.musicPercentBox.text = Settings.musicLevel + "%";
         this.m.soundPercentBox.text = Settings.soundLevel + "%";
         this.m.wasdUp.maxChars = this.m.wasdRight.maxChars = this.m.wasdDown.maxChars = this.m.wasdLeft.maxChars = this.m.wasdItem.maxChars = 1;
         this.m.wasdUp.restrict = this.m.wasdRight.restrict = this.m.wasdDown.restrict = this.m.wasdLeft.restrict = this.m.wasdItem.restrict = "0-9 A-Z";
         this.m.wasdUp.text = String.fromCharCode(this.altCtrl.up).toUpperCase();
         this.m.wasdRight.text = String.fromCharCode(this.altCtrl.right).toUpperCase();
         this.m.wasdDown.text = String.fromCharCode(this.altCtrl.down).toUpperCase();
         this.m.wasdLeft.text = String.fromCharCode(this.altCtrl.left).toUpperCase();
         this.m.wasdItem.text = String.fromCharCode(this.altCtrl.item).toUpperCase();
         this.m.filterHighlight.y = this.fps30 === false ? Number(this.hFalseY) : Number(this.hTrueY);
         this.m.artHighlight.y = this.drawArt === false ? Number(this.hFalseY) : Number(this.hTrueY);
         this.m.filterOn_bt.addEventListener(MouseEvent.CLICK,this.toggleFilterOn,false,0,true);
         this.m.filterOff_bt.addEventListener(MouseEvent.CLICK,this.toggleFilterOff,false,0,true);
         this.m.artOn_bt.addEventListener(MouseEvent.CLICK,this.toggleArtOn,false,0,true);
         this.m.artOff_bt.addEventListener(MouseEvent.CLICK,this.toggleArtOff,false,0,true);
         this.m.music_bt.addEventListener(MouseEvent.CLICK,this.clickMusic,false,0,true);
         this.m.music_bt.addEventListener(MouseEvent.MOUSE_OVER,this.hoverMusic,false,0,true);
         this.m.music_bt.addEventListener(MouseEvent.MOUSE_OUT,this.hoverOut,false,0,true);
         this.toggleArtBtnListeners(this.drawArt);
         this.m.removeChild(this.m.changePass_bt);
         this.m.removeChild(this.m.changeEmail_bt);
         this.m.removeChild(this.m.guildLeave_bt);
         this.m.removeChild(this.m.guildCreate_bt);
         this.m.removeChild(this.m.guildEdit_bt);
         this.m.removeChild(this.m.guildTransfer_bt);
         if(Main.group != 0)
         {
            this.addOptionsButton(this.m.changePass_bt,this.clickChangePass);
            this.addOptionsButton(this.m.changeEmail_bt,this.clickChangeEmail);
            if(Main.guild != 0)
            {
               if(Main.guildOwner == 0)
               {
                  this.addOptionsButton(this.m.guildLeave_bt,this.clickLeaveGuild);
               }
               else
               {
                  this.addOptionsButton(this.m.guildTransfer_bt,this.clickGuildTransfer);
                  this.addOptionsButton(this.m.guildEdit_bt,this.clickGuildEdit);
               }
            }
            else
            {
               this.addOptionsButton(this.m.guildCreate_bt,this.clickGuildCreate);
            }
         }
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose,false,0,true);
      }
      
      private function toggleArtBtnListeners(param1:Boolean) : *
      {
         this.m.artOffText.visible = !param1;
         this.m.art_bt.visible = param1;
         this.m.art_bt.removeEventListener(MouseEvent.CLICK,this.clickArt);
         this.m.art_bt.removeEventListener(MouseEvent.MOUSE_OVER,this.hoverArt);
         this.m.art_bt.removeEventListener(MouseEvent.MOUSE_OUT,this.hoverOut);
         if(param1)
         {
            this.m.art_bt.addEventListener(MouseEvent.CLICK,this.clickArt,false,0,true);
            this.m.art_bt.addEventListener(MouseEvent.MOUSE_OVER,this.hoverArt,false,0,true);
            this.m.art_bt.addEventListener(MouseEvent.MOUSE_OUT,this.hoverOut,false,0,true);
         }
      }
      
      private function musicSliderChange(param1:SliderEvent) : *
      {
         var _loc2_:int = int(Data.numLimit(param1.value,0,100));
         if(Settings.musicLevel === 0 && _loc2_ > 0)
         {
            Main.noodleTown.startPlaying();
         }
         Settings.setValue(Settings.MUSIC_VOLUME,_loc2_);
         this.m.musicPercentBox.text = Settings.musicLevel + "%";
         Main.noodleTown.setTargetVolume(0.6 * (Settings.musicLevel / 100));
      }
      
      private function soundSliderChange(param1:SliderEvent) : *
      {
         Settings.setValue(Settings.SOUND_VOLUME,Data.numLimit(param1.value,0,100));
         this.m.soundPercentBox.text = Settings.soundLevel + "%";
      }
      
      private function soundSliderRelease(param1:SliderEvent) : *
      {
         SoundEffects.playSound(new JumpSound(),0.75 * (Settings.soundLevel / 100));
      }
      
      private function toggleFilterOn(param1:MouseEvent) : *
      {
         this.m.filterHighlight.y = this.hTrueY;
         this.fps30 = true;
      }
      
      private function toggleFilterOff(param1:MouseEvent) : *
      {
         this.m.filterHighlight.y = this.hFalseY;
         this.fps30 = false;
      }
      
      private function toggleArtOn(param1:MouseEvent) : *
      {
         this.m.artHighlight.y = this.hTrueY;
         this.drawArt = true;
         this.toggleArtBtnListeners(true);
      }
      
      private function toggleArtOff(param1:MouseEvent) : *
      {
         this.m.artHighlight.y = this.hFalseY;
         this.drawArt = false;
         this.toggleArtBtnListeners(false);
      }
      
      private function clickArt(param1:MouseEvent) : *
      {
         new OptionsArtQualityMenu(param1.currentTarget);
      }
      
      private function hoverArt(param1:MouseEvent) : *
      {
         this.hoverActive = new HoverPopup("Choose Art Quality","Choose whether to draw art with lossless quality. This setting may degrade performance on some systems.",this.m.art_bt);
         this.hoverActive.x += 5;
      }
      
      private function clickMusic(param1:MouseEvent) : *
      {
         new OptionsSongsMenu(param1.currentTarget);
      }
      
      private function hoverMusic(param1:MouseEvent) : *
      {
         this.hoverOut();
         this.hoverActive = new HoverPopup("Choose Music","Choose which songs are allowed to play in a level.",this.m.music_bt);
      }
      
      private function hoverOut(param1:* = null) : *
      {
         if(this.hoverActive != null)
         {
            this.hoverActive.remove();
            this.hoverActive = null;
         }
      }
      
      private function addOptionsButton(param1:DisplayObject, param2:Function) : *
      {
         this.m.addChild(param1);
         param1.y = this.buttonStartPos;
         this.buttonStartPos -= 20;
         param1.addEventListener(MouseEvent.CLICK,param2,false,0,true);
      }
      
      private function clickChangePass(param1:MouseEvent) : *
      {
         new ChangePasswordPopup();
         startFadeOut();
      }
      
      private function clickChangeEmail(param1:MouseEvent) : *
      {
         new SetEmailPopup();
         Main.hasEmail = true;
         startFadeOut();
      }
      
      private function clickLeaveGuild(param1:MouseEvent) : *
      {
         new ConfirmPopup(this.confirmLeaveGuild,"Are you sure you want to leave your guild?");
      }
      
      private function confirmLeaveGuild() : *
      {
         var _loc1_:URLRequest = new URLRequest(Main.baseURL + "/guild_leave.php");
         _loc1_.data = new URLVariables();
         _loc1_.method = URLRequestMethod.POST;
         var _loc2_:UploadingPopup = new UploadingPopup(_loc1_,"json","Leaving guild...");
         _loc2_.addEventListener(Event.COMPLETE,this.doLeaveGuild,false,0,true);
         startFadeOut();
      }
      
      private function doLeaveGuild(param1:Event) : *
      {
         var _loc2_:Object = JSON.parse(param1.target.data);
         if(Boolean(_loc2_) && _loc2_.success === true)
         {
            Main.guild = 0;
            Main.guildOwner = 0;
            Main.emblem = "";
            Main.guildName = "";
            Main.instance.dispatchEvent(new Event(Main.accountChange));
         }
      }
      
      private function clickGuildCreate(param1:MouseEvent) : *
      {
         new CreateGuildPopup(0);
         startFadeOut();
      }
      
      private function clickGuildEdit(param1:MouseEvent) : *
      {
         new CreateGuildPopup(Main.guild);
         startFadeOut();
      }
      
      private function clickGuildTransfer(param1:MouseEvent) : *
      {
         new TransferGuildPopup();
         startFadeOut();
      }
      
      private function clickClose(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         if(OptionsSongsMenu.instance != null)
         {
            OptionsSongsMenu.instance.remove();
         }
         this.m.changePass_bt.removeEventListener(MouseEvent.CLICK,this.clickChangePass);
         this.m.changeEmail_bt.removeEventListener(MouseEvent.CLICK,this.clickChangeEmail);
         this.m.guildLeave_bt.removeEventListener(MouseEvent.CLICK,this.clickLeaveGuild);
         this.m.guildCreate_bt.removeEventListener(MouseEvent.CLICK,this.clickGuildCreate);
         this.m.guildEdit_bt.removeEventListener(MouseEvent.CLICK,this.clickGuildEdit);
         this.m.guildTransfer_bt.removeEventListener(MouseEvent.CLICK,this.clickGuildTransfer);
         this.m.music_bt.removeEventListener(MouseEvent.CLICK,this.clickMusic);
         this.m.music_bt.removeEventListener(MouseEvent.MOUSE_OVER,this.hoverMusic);
         this.m.music_bt.removeEventListener(MouseEvent.MOUSE_OUT,this.hoverOut);
         this.toggleArtBtnListeners(false);
         this.hoverOut();
         if(this.m.wasdUp.text == "")
         {
            this.m.wasdUp.text = "W";
         }
         if(this.m.wasdRight.text == "")
         {
            this.m.wasdRight.text = "D";
         }
         if(this.m.wasdDown.text == "")
         {
            this.m.wasdDown.text = "S";
         }
         if(this.m.wasdLeft.text == "")
         {
            this.m.wasdLeft.text = "A";
         }
         if(this.m.wasdItem.text == "")
         {
            this.m.wasdItem.text = "I";
         }
         this.altCtrl.up = this.m.wasdUp.text.toUpperCase().charCodeAt(0);
         this.altCtrl.right = this.m.wasdRight.text.toUpperCase().charCodeAt(0);
         this.altCtrl.down = this.m.wasdDown.text.toUpperCase().charCodeAt(0);
         this.altCtrl.left = this.m.wasdLeft.text.toUpperCase().charCodeAt(0);
         this.altCtrl.item = this.m.wasdItem.text.toUpperCase().charCodeAt(0);
         Settings.setValue(Settings.ALTERNATE_CONTROLS,this.altCtrl);
         Settings.setValue(Settings.DRAW_ART,this.drawArt);
         Settings.setValue(Settings.FPS_30,this.fps30);
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
