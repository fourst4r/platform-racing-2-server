package package_15
{
   import flash.events.*;
   import levelEditor.*;
   import package_4.*;
   
   public class SaveLevelPopup extends Popup
   {
       
      
      private var editor:LevelEditor;
      
      private var m:SaveLevelPopupGraphic;
      
      public function SaveLevelPopup()
      {
         this.editor = LevelEditor.editor;
         this.m = new SaveLevelPopupGraphic();
         super();
         this.m.titleBox.text = this.editor.title;
         this.m.noteBox.text = this.editor.note;
         this.countChars();
         this.m.titleBox.addEventListener(Event.CHANGE,this.countChars,false,0,true);
         this.m.noteBox.addEventListener(Event.CHANGE,this.countChars,false,0,true);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel,false,0,true);
         this.m.save_bt.addEventListener(MouseEvent.CLICK,this.clickSave,false,0,true);
         this.m.publish_chk.addEventListener(Event.CHANGE,this.updateChks,false,0,true);
         
         this.m.replays_chk.enabled = false;
         this.m.replays_chk.label = "Public replays?";
         this.m.replays_chk.selected = this.editor.replaysPublic;
         
         if(this.editor.live == 1)
         {
            this.m.publish_chk.selected = this.m.newest_chk.enabled = true;
            this.m.newest_chk.selected = this.editor.toNewest;
            this.m.replays_chk.enabled = true;
         }
         addChild(this.m);
      }
      
      private function countChars(param1:* = null) : *
      {
         this.m.titleCharsRemaining.text = this.m.titleBox.length + " / 50";
         this.m.noteCharsRemaining.text = this.m.noteBox.length + " / 255";
      }
      
      private function updateChks(param1:Event) : *
      {
         this.m.newest_chk.enabled = this.m.newest_chk.selected = this.m.publish_chk.selected;
         this.m.replays_chk.enabled = this.m.publish_chk.selected;
      }
      
      private function clickCancel(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      private function clickSave(param1:MouseEvent) : *
      {
         if(this.m.titleBox.text == "")
         {
            new MessagePopup("I\'m not sure what would happen if you didn\'t enter a title, but it would probably destroy the world.");
         }
         else
         {
            this.editor.title = this.m.titleBox.text;
            this.editor.note = this.m.noteBox.text;
            this.editor.live = int(this.m.publish_chk.selected);
            this.editor.toNewest = this.m.newest_chk.selected;
            this.editor.replaysPublic = this.m.replays_chk.selected;
            new UploadingLevelPopup();
            startFadeOut();
         }
      }
      
      override public function remove() : *
      {
         this.m.titleBox.removeEventListener(Event.CHANGE,this.countChars);
         this.m.noteBox.removeEventListener(Event.CHANGE,this.countChars);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         this.m.save_bt.removeEventListener(MouseEvent.CLICK,this.clickSave);
         this.m.publish_chk.removeEventListener(Event.CHANGE,this.updateChks);
         super.remove();
      }
   }
}
