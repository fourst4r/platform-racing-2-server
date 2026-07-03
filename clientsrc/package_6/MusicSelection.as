package package_6
{
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
      }
      
      public function setSong(param1:String) : *
      {
         this.dropdown.setSong(param1);
      }
      
      override public function remove() : *
      {
         this.dropdown.remove();
         super.remove();
      }
   }
}
