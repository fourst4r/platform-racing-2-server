package package_19
{
   import flash.events.MouseEvent;
   
   public class MusicMenuButton extends class_215
   {
       
      
      private var song:String = "random";
      
      public function MusicMenuButton()
      {
         super();
         addChild(new MusicNoteGraphic());
      }
      
      public function setSong(param1:String) : *
      {
         this.song = param1 === "" ? "random" : param1;
      }
      
      override protected function onClick(param1:MouseEvent) : *
      {
         new MusicMenu(this,this.song);
      }
   }
}
