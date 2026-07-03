package menu
{
   import flash.events.*;
   import package_4.Popup;
   
   public class CreditsPopup extends Popup
   {
       
      
      private const artPgs:int = 3;
      
      private var artPg:int = 1;
      
      private var musicPg:int = 1;
      
      private var m:CreditsPopupGraphic;
      
      public function CreditsPopup()
      {
         this.m = new CreditsPopupGraphic();
         super();
         this.m.versionBox.text = "PR2 v" + Main.version;
         this.m.versionBox.text = Main.beta === true ? this.m.versionBox.text + " Beta" : String(this.m.versionBox.text);
         this.m.buildBox.text = "Build: " + Main.build;
         this.m.artPg2.visible = this.m.artPg3.visible = this.m.musicPg2.visible = false;
         this.m.art_nav_bts.htmlText = "<a href=\"event:artNext\">(next -&gt;)</a>";
         this.m.music_nav_bt.htmlText = "<a href=\"event:musicToggle\">(more -&gt;)</a>";
         this.m.art_nav_bts.addEventListener(TextEvent.LINK,this.clickArtNav,false,0,true);
         this.m.music_nav_bt.addEventListener(TextEvent.LINK,this.clickMusicNav,false,0,true);
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose,false,0,true);
         addChild(this.m);
      }
      
      private function clickArtNav(param1:TextEvent) : *
      {
         if(this.artPg == 1 && param1.text == "artBack" || this.artPg == this.artPgs && param1.text == "artNext")
         {
            return;
         }
         this.m["artPg" + this.artPg].visible = false;
         this.artPg = param1.text == "artBack" ? int(this.artPg - 1) : int(this.artPg + 1);
         this.m["artPg" + this.artPg].visible = true;
         var _loc2_:* = "";
         if(this.artPg > 1)
         {
            _loc2_ += "<a href=\"event:artBack\">(&lt;- back)</a>";
         }
         if(this.artPg < this.artPgs)
         {
            _loc2_ += (_loc2_ != "" ? " " : "") + "<a href=\"event:artNext\">(next -&gt;)</a>";
         }
         this.m.art_nav_bts.htmlText = _loc2_;
      }
      
      private function clickMusicNav(param1:TextEvent) : *
      {
         this.m["musicPg" + this.musicPg].visible = false;
         this.musicPg = this.musicPg === 1 ? 2 : 1;
         this.m["musicPg" + this.musicPg].visible = true;
         this.m.music_nav_bt.htmlText = "<a href=\"event:musicToggle\">" + (this.musicPg === 2 ? "(&lt;- back)" : "(more -&gt;)") + "</a>";
      }
      
      private function clickClose(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.m.art_nav_bts.removeEventListener(TextEvent.LINK,this.clickArtNav);
         this.m.music_nav_bt.removeEventListener(TextEvent.LINK,this.clickMusicNav);
         this.m.close_bt.removeEventListener(MouseEvent.CLICK,this.clickClose);
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
