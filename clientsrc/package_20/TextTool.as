package package_20
{
   import background.ObjectBackground;
   import flash.geom.*;
   import levelEditor.*;
   
   public class TextTool extends class_269
   {
       
      
      public function TextTool()
      {
         super(-1);
         applyCursorGraphic(new TextToolCursorGraphic());
         hideMouse();
      }
      
      override protected function dropObject(param1:int, param2:int) : *
      {
         var _loc3_:ObjectBackground = editor.cur;
         var _loc4_:Point = editor.cur.globalToLocal(new Point(param1 - 5,param2 - 16));
         var _loc5_:TextObject;
         (_loc5_ = _loc3_.addText("",_loc4_.x,_loc4_.y,TextObject.var_380,true)).select();
         _loc5_.startEditing();
         remove();
      }
   }
}
