package ui
{
   import flash.events.*;
   
   public class LobbyTab extends Removable
   {
       
      
      private var m:LobbyTabGraphic;
      
      private var tabsHolder:TabsHolder;
      
      private var tabFunction:Function;
      
      public function LobbyTab(param1:Function, param2:String)
      {
         this.m = new LobbyTabGraphic();
         super();
         this.tabFunction = param1;
         this.m.textBox.text = param2;
         this.m.textBox.autoSize = "left";
         this.m.bg.width = this.m.textBox.width + 10;
         addChild(this.m);
         this.activate();
      }
      
      internal function setTabsHolder(param1:TabsHolder) : *
      {
         this.tabsHolder = param1;
      }
      
      private function onClick(param1:MouseEvent) : *
      {
         this.select();
      }
      
      private function onHover(param1:MouseEvent) : *
      {
         this.m.bg.gotoAndStop("over");
         this.tabsHolder.moveToFront(this);
      }
      
      private function onHoverOut(param1:MouseEvent) : *
      {
         this.m.bg.gotoAndStop("up");
      }
      
      public function select() : *
      {
         this.tabsHolder.select(this);
         this.tabFunction();
         this.deactivate();
         this.m.bg.gotoAndStop("selected");
      }
      
      public function activate() : *
      {
         this.deactivate();
         addEventListener(MouseEvent.CLICK,this.onClick);
         addEventListener(MouseEvent.MOUSE_OVER,this.onHover);
         addEventListener(MouseEvent.MOUSE_OUT,this.onHoverOut);
      }
      
      private function deactivate() : *
      {
         this.m.bg.gotoAndStop("up");
         removeEventListener(MouseEvent.CLICK,this.onClick);
         removeEventListener(MouseEvent.MOUSE_OVER,this.onHover);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onHoverOut);
      }
      
      override public function remove() : *
      {
         this.deactivate();
         removeChild(this.m);
         this.m = null;
         this.tabsHolder = null;
         this.tabFunction = null;
         super.remove();
      }
   }
}
