package package_19
{
   import fl.controls.ComboBox;
   import flash.display.DisplayObject;
   import flash.events.*;
   import levelEditor.*;
   import package_4.class_264;
   
   public class ModeMenu extends class_264
   {
       
      
      private var m:ModeMenuGraphic;
      
      private var modeSelect:ComboBox;
      
      private var open:Boolean = false;
      
      public function ModeMenu(param1:DisplayObject)
      {
         var _loc3_:Object = null;
         this.m = new ModeMenuGraphic();
         this.modeSelect = this.m.modeSelect;
         var _loc2_:int = 0;
         while(_loc2_ < this.modeSelect.length)
         {
            _loc3_ = this.modeSelect.getItemAt(_loc2_);
            if(_loc3_.data == LevelEditor.editor.gameMode)
            {
               this.modeSelect.selectedIndex = _loc2_;
               break;
            }
            _loc2_++;
         }
         this.modeSelect.addEventListener(Event.OPEN,this.onOpen,false,0,true);
         this.modeSelect.addEventListener(Event.CHANGE,this.onChange,false,0,true);
         this.modeSelect.addEventListener(Event.CLOSE,this.onClose,false,0,true);
         addChild(this.m);
         super(param1);
      }
      
      private function onOpen(param1:Event) : *
      {
         this.open = true;
      }
      
      private function onClose(param1:Event) : *
      {
         this.open = false;
         this.onChange(param1);
      }
      
      private function onChange(param1:Event) : *
      {
         LevelEditor.editor.setGameMode(this.modeSelect.selectedItem.data);
      }
      
      override protected function downHandler(param1:MouseEvent) : *
      {
         if(!this.open)
         {
            super.downHandler(param1);
         }
      }
      
      override public function remove() : *
      {
         this.modeSelect.removeEventListener(Event.OPEN,this.onOpen);
         this.modeSelect.removeEventListener(Event.CHANGE,this.onChange);
         this.modeSelect.removeEventListener(Event.CLOSE,this.onClose);
         this.modeSelect = null;
         Main.stage.focus = Main.stage;
         super.remove();
      }
   }
}
