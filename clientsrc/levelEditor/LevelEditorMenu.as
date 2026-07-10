package levelEditor
{
   import flash.display.MovieClip;
   import flash.events.*;
   import menu.*;
   import package_14.*;
   import package_15.*;
   import package_4.*;
   import package_6.*;
   
   public class LevelEditorMenu extends MovieClip
   {
       
      
      public var blocks:Blocks;
      
      public var settings:Settings;
      
      public var stamps:Stamps;
      
      public var tools:Tools;
      
      public var bg:Backgrounds;
      
      public var sideBar:SideBar;
      
      private var editor:LevelEditor;
      
      public var m:LevelEditorMenuGraphic;
      
      public function LevelEditorMenu()
      {
         this.blocks = new Blocks();
         this.settings = new Settings();
         this.stamps = new Stamps();
         this.tools = new Tools();
         this.bg = new Backgrounds();
         this.sideBar = this.blocks;
         this.editor = LevelEditor.editor;
         this.m = new LevelEditorMenuGraphic();
         super();
         addChild(this.m);
         addChild(this.sideBar);
         this.m.blocksButton.addEventListener(MouseEvent.CLICK,this.clickBlocks,false,0,true);
         this.m.settingsButton.addEventListener(MouseEvent.CLICK,this.clickSettings,false,0,true);
         this.m.layer00Button.addEventListener(MouseEvent.CLICK,this.clickLayer00,false,0,true);
         this.m.layer0Button.addEventListener(MouseEvent.CLICK,this.clickLayer0,false,0,true);
         this.m.layer1Button.addEventListener(MouseEvent.CLICK,this.clickLayer1,false,0,true);
         this.m.layer2Button.addEventListener(MouseEvent.CLICK,this.clickLayer2,false,0,true);
         this.m.layer3Button.addEventListener(MouseEvent.CLICK,this.clickLayer3,false,0,true);
         this.m.bgButton.addEventListener(MouseEvent.CLICK,this.clickBG,false,0,true);
         this.m.saveButton.addEventListener(MouseEvent.CLICK,this.clickSave,false,0,true);
         this.m.loadButton.addEventListener(MouseEvent.CLICK,this.clickLoad,false,0,true);
         this.m.testButton.addEventListener(MouseEvent.CLICK,this.clickTest,false,0,true);
         this.m.newButton.addEventListener(MouseEvent.CLICK,this.clickNew,false,0,true);
         this.m.exitButton.addEventListener(MouseEvent.CLICK,this.clickExit,false,0,true);
         this.m.undoButton.addEventListener(MouseEvent.CLICK,this.clickUndo,false,0,true);
         this.m.redoButton.addEventListener(MouseEvent.CLICK,this.clickRedo,false,0,true);
         this.m.zoomSelect.addEventListener(Event.CHANGE,this.chooseZoom,false,0,true);
      }
      
      internal function init() : *
      {
         this.m.zoomSelect.selectedIndex = 3;
         // No level editing right now...
         if(Main.group <= 0)
         {
            this.m.saveButton.enabled = false;
            this.m.loadButton.enabled = false;
         }
      }
      
      private function moveGlow(param1:Object) : *
      {
         this.m.selectedGlow.x = param1.x + param1.width / 2;
         this.m.selectedGlow.width = param1.width + 6;
      }
      
      private function clickBlocks(param1:MouseEvent) : *
      {
         this.changeSideBar(this.blocks);
         this.editor.focusOn(this.editor.blockBG);
         this.editor.cur = this.editor.blockBG;
         this.changeUndoRedoState();
         this.moveGlow(this.m.blocksButton);
      }
      
      private function clickLayer00(param1:MouseEvent) : *
      {
         this.setLayer(5);
         this.moveGlow(param1.target);
      }
      
      private function clickLayer0(param1:MouseEvent) : *
      {
         this.setLayer(4);
         this.moveGlow(param1.target);
      }
      
      private function clickLayer1(param1:MouseEvent) : *
      {
         this.setLayer(1);
         this.moveGlow(param1.target);
      }
      
      private function clickLayer2(param1:MouseEvent) : *
      {
         this.setLayer(2);
         this.moveGlow(param1.target);
      }
      
      private function clickLayer3(param1:MouseEvent) : *
      {
         this.setLayer(3);
         this.moveGlow(param1.target);
      }
      
      private function clickBG(param1:MouseEvent) : *
      {
         this.changeSideBar(this.bg);
         this.editor.focusNone();
         this.m.undoButton.enabled = this.m.redoButton.enabled = false;
         this.moveGlow(param1.target);
      }
      
      private function clickSettings(param1:MouseEvent) : *
      {
         this.changeSideBar(this.settings);
         this.editor.focusNone();
         this.m.undoButton.enabled = this.m.redoButton.enabled = false;
         this.moveGlow(param1.target);
      }
      
      private function setLayer(param1:Number) : *
      {
         if(this.sideBar != this.stamps && this.sideBar != this.tools)
         {
            this.changeSideBar(this.stamps);
         }
         this.editor.cur = this.editor["bg" + param1];
         this.editor.var_220 = this.editor["draw" + param1];
         if(this.sideBar == this.stamps)
         {
            this.editor.focusOn(this.editor.cur);
         }
         else if(this.sideBar == this.tools)
         {
            this.editor.focusOn(this.editor.var_220);
         }
      }
      
      private function clickSave(param1:MouseEvent) : *
      {
         new SaveLevelPopup();
      }
      
      private function clickLoad(param1:MouseEvent) : *
      {
         if(this.editor.canViewLevelReports() === true)
         {
            new ChooseLevelsModePopup();
         }
         else
         {
            new GetLevels();
         }
      }
      
      public function setReportsMode(param1:Boolean = false) : *
      {
         this.m.saveButton.enabled = !param1;
         this.editor.setReportsMode(param1);
      }
      
      private function clickTest(param1:MouseEvent) : *
      {
         if(!this.editor.drawing)
         {
            Main.pageHolder.changePage(new TestCourse(this.editor.method_344(),this.editor.canViewLevelReports(),this.editor.inReportsMode(),this.editor.getHotkeysSnapshot()));
         }
      }
      
      private function clickNew(param1:MouseEvent) : *
      {
         new ConfirmPopup(this.clearEditor,"Are you sure you want to clear this level? All unsaved data will be lost.");
      }
      
      public function clearEditor() : *
      {
         this.editor.clear();
         this.bg.cp_btn.updateColor();
      }
      
      private function clickExit(param1:MouseEvent) : *
      {
         new ConfirmPopup(this.exitEditor,"Are you sure you want exit? All unsaved data will be lost.");
      }
      
      public function exitEditor() : *
      {
         new ConnectingPopup();
      }
      
      private function clickUndo(param1:MouseEvent) : *
      {
         this.editor.var_225.undo();
         this.changeUndoRedoState();
      }
      
      private function clickRedo(param1:MouseEvent) : *
      {
         this.editor.var_225.redo();
         this.changeUndoRedoState();
      }
      
      private function chooseZoom(param1:Event) : *
      {
         var _loc2_:Number = Number(param1.target.selectedItem.data);
         _loc2_ /= 100;
         LevelEditor.editor.setZoom(_loc2_);
         this.tools.setZoom(_loc2_);
         Main.stage.focus = Main.stage;
      }
      
      public function changeUndoRedoState() : *
      {
         this.m.undoButton.enabled = this.editor.var_225.saveArray.length > 0;
         this.m.redoButton.enabled = this.editor.var_225.redoArray.length > 0;
      }
      
      public function changeSideBar(param1:SideBar) : *
      {
         if(this.sideBar != null)
         {
            this.sideBar.exit();
         }
         this.sideBar = param1;
         this.sideBar.init();
         addChild(this.sideBar);
      }
      
      public function reset() : *
      {
         this.clickBlocks(null);
         this.tools.exit();
      }
      
      public function remove() : *
      {
         this.m.blocksButton.removeEventListener(MouseEvent.CLICK,this.clickBlocks);
         this.m.settingsButton.removeEventListener(MouseEvent.CLICK,this.clickSettings);
         this.m.layer00Button.removeEventListener(MouseEvent.CLICK,this.clickLayer00);
         this.m.layer0Button.removeEventListener(MouseEvent.CLICK,this.clickLayer0);
         this.m.layer1Button.removeEventListener(MouseEvent.CLICK,this.clickLayer1);
         this.m.layer2Button.removeEventListener(MouseEvent.CLICK,this.clickLayer2);
         this.m.layer3Button.removeEventListener(MouseEvent.CLICK,this.clickLayer3);
         this.m.bgButton.removeEventListener(MouseEvent.CLICK,this.clickBG);
         this.m.saveButton.removeEventListener(MouseEvent.CLICK,this.clickSave);
         this.m.loadButton.removeEventListener(MouseEvent.CLICK,this.clickLoad);
         this.m.testButton.removeEventListener(MouseEvent.CLICK,this.clickTest);
         this.m.newButton.removeEventListener(MouseEvent.CLICK,this.clickNew);
         this.m.exitButton.removeEventListener(MouseEvent.CLICK,this.clickExit);
         this.m.undoButton.removeEventListener(MouseEvent.CLICK,this.clickUndo);
         this.m.redoButton.removeEventListener(MouseEvent.CLICK,this.clickRedo);
         this.m.zoomSelect.removeEventListener(Event.CLOSE,this.chooseZoom);
         this.blocks.remove();
         this.settings.remove();
         this.stamps.remove();
         this.tools.remove();
      }
   }
}
