package package_19
{
   import blocks.*;
   import fl.controls.CheckBox;
   import items.*;
   import levelEditor.*;
   import package_4.class_264;
   import page.*;
   
   public class ItemMenu extends class_264
   {
       
      
      private var m:ItemMenuGraphic;
      
      private var numItems:int;
      
      public function ItemMenu(param1:ItemMenuButton)
      {
         var _loc4_:CheckBox = null;
         this.m = new ItemMenuGraphic();
         this.numItems = Items.getAllCodes().length;
         addChild(this.m);
         super(param1);
         var _loc2_:Vector.<int> = GamePage.course.allowedItems;
         var _loc3_:int = 1;
         while(_loc3_ <= this.numItems)
         {
            _loc4_ = this.m["check" + _loc3_];
            if(_loc2_.indexOf(_loc3_) != -1)
            {
               _loc4_.selected = true;
            }
            _loc3_++;
         }
      }
      
      override public function remove() : *
      {
         var _loc1_:int = 0;
         var _loc2_:CheckBox = null;
         var _loc3_:Array = null;
         var _loc4_:BlockObject = null;
         if(GamePage.course != null)
         {
            GamePage.course.allowedItems = new Vector.<int>();
            _loc1_ = 1;
            while(_loc1_ <= this.numItems)
            {
               _loc2_ = this.m["check" + _loc1_];
               if(_loc2_.selected)
               {
                  GamePage.course.allowedItems.push(_loc1_);
               }
               _loc1_++;
            }
            if(LevelEditor.editor != null)
            {
               _loc3_ = LevelEditor.editor.blockBG.getAllBlocksOfType(ItemBlock);
               for each(_loc4_ in _loc3_)
               {
                  _loc4_.m.updateGameItems();
               }
            }
         }
         super.remove();
      }
   }
}
