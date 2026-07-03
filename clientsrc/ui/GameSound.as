package ui
{
   import com.jiggmin.data.*;
   import fl.controls.ComboBox;
   import flash.events.*;
   import flash.media.*;
   import flash.net.*;
   import flash.utils.*;
   
   public class GameSound extends ComboBox
   {
       
      
      private var soundChannel:SoundChannel;
      
      private var inLE:Boolean;
      
      private var enableMusicInt:uint;
      
      private var url:String;
      
      public function GameSound(param1:Boolean = false)
      {
         this.url = Main.baseURL + "/music/new";
         super();
         editable = false;
         this.inLE = param1;
         width = 200;
         rowCount = 4;
         this.addSong({
            "id":"0",
            "label":"None",
            "file":""
         });
         if(this.inLE)
         {
            this.addSong({
               "id":"random",
               "label":"Random",
               "file":""
            });
         }
         this.addSong({
            "id":"1",
            "label":"Orbital Trance - Space Planet",
            "file":"01_orbital-trance.mp3"
         });
         this.addSong({
            "id":"2",
            "label":"Code - Stefano Maccarelli",
            "file":"02_code.mp3"
         });
         this.addSong({
            "id":"3",
            "label":"Paradise on E - API",
            "file":"03_paradise-on-e_ng32772.mp3"
         });
         this.addSong({
            "id":"4",
            "label":"Crying Soul (FL Mix) - Pyroific",
            "file":"04_crying-soul_ng102483.mp3"
         });
         this.addSong({
            "id":"5",
            "label":"My Vision - David Orr",
            "file":"05_my-vision_ng44613.mp3"
         });
         this.addSong({
            "id":"6",
            "label":"Switchblade - Detective Jabsco",
            "file":"06_switchblade_ng59342.mp3"
         });
         this.addSong({
            "id":"7",
            "label":"The Wires - Cheez-R-Us",
            "file":"07_the-wires_ng74690.mp3"
         });
         this.addSong({
            "id":"8",
            "label":"Before Mydnite - F-777",
            "file":"08_before-mydnite_ng108133.mp3"
         });
         this.addSong({
            "id":"10",
            "label":"Broked It - SWiTCH",
            "file":"10_broked-it_ng51265.mp3"
         });
         this.addSong({
            "id":"11",
            "label":"Hello? - TMM43",
            "file":"11_hello_ng83720.mp3"
         });
         this.addSong({
            "id":"12",
            "label":"Pyrokinesis - Sean Tucker",
            "file":"12_pyrokinesis_ng98624.mp3"
         });
         this.addSong({
            "id":"13",
            "label":"Flowerz \'n\' Herbz - Brunzolaitis",
            "file":"13_flowerz-n-herbs_ng109884.mp3"
         });
         this.addSong({
            "id":"14",
            "label":"Instrumental #4 - Reasoner",
            "file":"14_instrumental-4_ng128701.mp3"
         });
         this.addSong({
            "id":"15",
            "label":"Prismatic - Lunanova",
            "file":"15_prismatic.mp3"
         });
         this.addSong({
            "id":"17",
            "label":"Toodaloo - mustangman",
            "file":"17_toodaloo.mp3"
         });
         this.addSong({
            "id":"18",
            "label":"Night Shade - Goliathe",
            "file":"18_night-shade.mp3"
         });
         this.addSong({
            "id":"19",
            "label":"Blizzard! - Majicke",
            "file":"19_blizzard.mp3"
         });
         this.addSong({
            "id":"20",
            "label":"Pasture (Instrumental) - Dangevin",
            "file":"20_pasture.mp3"
         });
         this.addSong({
            "id":"21",
            "label":"Sunset Raiders - AVL",
            "file":"21_sunset-raiders.mp3"
         });
         addEventListener(Event.CLOSE,this.focusStage,false,0,true);
         addEventListener(Event.CHANGE,this.startSong,false,0,true);
         this.enableMusicInt = setInterval(this.checkSetting,500);
      }
      
      private function addSong(param1:Object) : *
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = Settings.getValue(Settings.DISABLED_SONGS);
         if(this.inLE == false && param1.id != 16 && param1.id <= 21 && param1.id != "random" && param1.id != 0 && param1.id != "")
         {
            for(_loc3_ in _loc2_)
            {
               if(_loc2_[_loc3_] == param1.id)
               {
                  return;
               }
            }
         }
         addItem(param1);
      }
      
      private function focusStage(param1:Event = null) : *
      {
         Main.stage.focus = Main.stage;
      }
      
      public function gotArtifact() : *
      {
         this.addSong({
            "id":"16",
            "label":"We Are Loud - Dynamedion",
            "file":"16_we-are-loud.mp3"
         });
         this.setSong("16");
      }
      
      private function checkSetting() : *
      {
         if(this.musicEnabled())
         {
            this.startSong();
         }
      }
      
      private function musicEnabled() : Boolean
      {
         if(Settings.musicLevel > 0 && MuteButton.muted == false && selectedItem != null && selectedItem.id != 0 && this.soundChannel == null)
         {
            return true;
         }
         return false;
      }
      
      public function setSong(param1:String) : *
      {
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc2_:int = 0;
         if((param1 == "random" || param1 == "") && !this.inLE)
         {
            _loc2_ = Math.floor(Math.random() * (length - 1)) + 1;
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < length)
            {
               if((_loc4_ = getItemAt(_loc3_)).id == param1)
               {
                  _loc2_ = _loc3_;
                  break;
               }
               _loc3_++;
            }
         }
         if(param1 != "0" && _loc2_ == 0)
         {
            _loc2_ = Math.floor(Math.random() * (length - 1)) + 1;
         }
         if(_loc2_ > 0 && length == 1)
         {
            _loc2_ = 0;
         }
         selectedIndex = _loc2_;
         if(param1 != "0" && param1 != "random" && param1 != "")
         {
            this.startSong();
         }
      }
      
      private function startSong(param1:Event = null) : *
      {
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         var _loc4_:SoundLoaderContext = null;
         var _loc5_:Sound = null;
         var _loc6_:SoundTransform = null;
         this.stopSong();
         if(Boolean(this.musicEnabled()) && selectedItem.file != "")
         {
            _loc2_ = this.url + "/" + selectedItem.file;
            _loc3_ = new URLRequest(_loc2_);
            _loc4_ = new SoundLoaderContext(3000,false);
            _loc5_ = new Sound(_loc3_,_loc4_);
            (_loc6_ = new SoundTransform()).volume = Settings.musicLevel / 100;
            this.soundChannel = _loc5_.play(0,9999,_loc6_);
            this.soundChannel.addEventListener(Event.SOUND_COMPLETE,this.loopSong,false,0,true);
         }
         Main.stage.focus = Main.stage;
      }
      
      private function loopSong(param1:Event) : *
      {
         this.soundChannel.removeEventListener(Event.SOUND_COMPLETE,this.loopSong);
         this.startSong();
      }
      
      private function stopSong() : *
      {
         if(this.soundChannel != null)
         {
            this.soundChannel.removeEventListener(Event.SOUND_COMPLETE,this.loopSong);
            this.soundChannel.stop();
            this.soundChannel = null;
         }
      }
      
      public function remove() : *
      {
         close();
         clearInterval(this.enableMusicInt);
         removeEventListener(Event.CHANGE,this.startSong);
         this.stopSong();
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}
