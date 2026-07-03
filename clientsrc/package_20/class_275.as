package package_20
{
   import background.BlockBackground;
   import background.ObjectBackground;
   import flash.events.MouseEvent;
   import flash.geom.*;
   import levelEditor.*;
   
   public class class_275 extends class_269
   {
       
      
      private var blockBackground:BlockBackground;
      
      public function class_275(param1:int)
      {
         this.blockBackground = LevelEditor.editor.blockBG;
         super(param1);
      }
      
      override protected function dropObject(param1:int, param2:int) : *
      {
         var _loc3_:ObjectBackground = null;
         var _loc4_:Point = null;
         var _loc5_:BlockObject;
         if((_loc5_ = this.getBlock(param1,param2)) == null)
         {
            _loc3_ = editor.cur;
            _loc4_ = new Point(param1,param2);
            _loc4_ = editor.cur.globalToLocal(_loc4_);
            _loc4_.x -= 15;
            _loc4_.y -= 15;
            _loc4_.x = Math.round(_loc4_.x);
            _loc4_.y = Math.round(_loc4_.y);
            _loc3_.addObject(displayCode,_loc4_.x,_loc4_.y);
         }
      }
      
      override protected function mouseMoveHandler(param1:MouseEvent) : *
      {
         super.mouseMoveHandler(param1);
         if(isMouseDown())
         {
            if(!editor.cur.hitTestPoint(param1.stageX,param1.stageY,true))
            {
               this.dropObject(param1.stageX,param1.stageY);
            }
         }
      }
      
      private function getBlock(param1:int, param2:int) : BlockObject
      {
         var _loc3_:Point = new Point(param1,param2);
         _loc3_ = this.blockBackground.globalToLocal(_loc3_);
         return this.blockBackground.getBlockAt(_loc3_.x - 15,_loc3_.y - 15);
      }
      
      override public function remove() : *
      {
         this.blockBackground = null;
         super.remove();
      }
   }
}
