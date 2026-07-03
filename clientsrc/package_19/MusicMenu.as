package package_19
{
   import flash.events.*;
   import levelEditor.*;
   import package_4.class_264;
   import ui.*;
   
   public class MusicMenu extends class_264
   {
       
      
      private var list:GameSound;
      
      private var target:MusicMenuButton;
      
      public function MusicMenu(param1:MusicMenuButton, param2:String)
      {
         this.list = new GameSound(true);
         this.target = param1;
         this.list.x = -this.list.width / 2;
         this.list.y = -15;
         this.list.setSong(param2);
         addChild(new MusicMenuGraphic());
         addChild(this.list);
         super(param1);
         this.list.addEventListener(Event.CHANGE,this.changeSong,false,0,true);
      }
      
      private function changeSong(param1:Event) : *
      {
         LevelEditor.editor.setSong(param1.target.selectedItem.id);
      }
      
      override public function remove() : *
      {
         this.list.removeEventListener(Event.CHANGE,this.changeSong);
         this.list.remove();
         super.remove();
      }
   }
}
