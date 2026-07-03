package lobby
{
   import page.Page;
   import page.PageHolder;
   import ui.*;
   
   public class LobbySide extends PageHolder
   {
       
      
      private var bg:HalfSquareBG;
      
      private var tabsHolder:TabsHolder;
      
      public function LobbySide(param1:Array, param2:String = "", param3:Number = 0, param4:Number = 100, param5:Number = 100)
      {
         this.bg = new HalfSquareBG();
         this.bg.y = 15;
         addChild(this.bg);
         this.tabsHolder = new TabsHolder(param1,param2,param3,param4);
         addChild(this.tabsHolder);
         this.setSize(param4,param5);
         super();
      }
      
      public function setSize(param1:Number, param2:Number) : *
      {
         this.bg.height = param2 - 15;
         this.bg.width = param1;
         this.tabsHolder.populateTabs(param1);
      }
      
      override public function changePage(param1:Page) : *
      {
         super.changePage(param1);
         if(param1 != null)
         {
            param1.x = 4;
            param1.y = 20;
         }
      }
      
      override public function remove() : *
      {
         this.tabsHolder.remove();
         super.remove();
      }
   }
}
