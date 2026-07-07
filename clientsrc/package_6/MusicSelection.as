package package_6
{
   import flash.events.*;
   import ui.*;
   
   public class MusicSelection extends Removable
   {
       
      
      private var m:MusicSelectionGraphic;
      
      public var dropdown:GameSound;
      
      public function MusicSelection()
      {
         this.m = new MusicSelectionGraphic();
         this.dropdown = new GameSound();
         super();
         addChild(this.m);
         this.dropdown.x = 7;
         this.dropdown.y = 7;
         addChild(this.dropdown);
         if(Main.muteButton != null)
         {
            Main.muteButton.addEventListener(Event.CHANGE,this.syncVisibility,false,0,true);
         }
         this.syncVisibility();
      }
      
      public function setSong(param1:String) : *
      {
         this.dropdown.setSong(param1);
      }

      public function syncVisibility(param1:Event = null) : *
      {
         var visibleNow:Boolean = !MuteButton.muted;
         visible = visibleNow;
         mouseEnabled = visibleNow;
         mouseChildren = visibleNow;
      }
      
      override public function remove() : *
      {
         if(Main.muteButton != null)
         {
            Main.muteButton.removeEventListener(Event.CHANGE,this.syncVisibility);
         }
         this.dropdown.remove();
         super.remove();
      }
   }
}
