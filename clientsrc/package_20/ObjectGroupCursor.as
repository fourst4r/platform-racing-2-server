package package_20
{
   import com.jiggmin.data.Objects;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.geom.Point;
   import levelEditor.BlockObject;
   import levelEditor.LevelEditor;
   import ui.CustomCursor;

   public class ObjectGroupCursor extends CustomCursor
   {
      private var editor:LevelEditor;
      private var objects:Array; // of BlockObject
      private var group:Sprite;
      private var lastSX:int = -2147483648;
      private var lastSY:int = -2147483648;
      private function isStartCode(code:int) : Boolean
      {
         return code == com.jiggmin.data.Objects.BLOCK_START1 ||
                code == com.jiggmin.data.Objects.BLOCK_START2 ||
                code == com.jiggmin.data.Objects.BLOCK_START3 ||
                code == com.jiggmin.data.Objects.BLOCK_START4;
      }

      public function ObjectGroupCursor(le:LevelEditor, objs:Array)
      {
         super();
         this.editor = le;
         this.objects = objs != null ? objs.slice() : [];
         this.group = new Sprite();

         if (this.objects.length > 0)
         {
            var offsetX:Number = BlockObject(this.objects[0]).x;
            var offsetY:Number = BlockObject(this.objects[0]).y;

            for each (var bo:BlockObject in this.objects)
            {
               var copy:DisplayObject = Objects.getFromCode(bo.displayCode) as DisplayObject;
               if (copy != null)
               {
                  copy.x = bo.x - offsetX;
                  copy.y = bo.y - offsetY;
                  this.group.addChild(copy);
               }
            }
         }

         this.group.x = -this.group.width / 2;
         this.group.y = -this.group.height / 2;
         addChild(this.group);

         // keep preview scaled with editor zoom
         addEventListener(Event.ENTER_FRAME, this.onEnterFrame, false, 0, true);
      }

      private function onEnterFrame(e:Event) : void
      {
         if (this.editor != null && this.editor.cur != null)
         {
            this.scaleX = this.editor.scaleX * this.editor.cur.scaleX;
            this.scaleY = this.editor.scaleY * this.editor.cur.scaleY;
         }
      }

      override protected function mouseDownHandler(e:MouseEvent) : *
      {
         super.mouseDownHandler(e);
         if (this.editor == null) return null;

         // clicking the menu cancels the cursor
         if (this.editor.menu != null && this.editor.menu.hitTestPoint(e.stageX, e.stageY, true))
         {
            return this.remove();
         }

         this.stampAt(e.stageX, e.stageY);

         e.stopImmediatePropagation();
         return null;
      }

      override protected function mouseMoveHandler(e:MouseEvent) : *
      {
         super.mouseMoveHandler(e);
         if (!isMouseDown() || this.editor == null) return null;
         this.stampAt(e.stageX, e.stageY);
         e.stopImmediatePropagation();
         return null;
      }

      override protected function mouseUpHandler(e:MouseEvent) : *
      {
         super.mouseUpHandler(e);
         this.lastSX = this.lastSY = -2147483648;
      }

      private function stampAt(stageX:Number, stageY:Number) : void
      {
         var pt:Point = this.editor.cur.globalToLocal(new Point(stageX, stageY));
         var offsetX:Number = -this.group.width / 2;
         var offsetY:Number = -this.group.height / 2;

         var anchorPX:int = int(pt.x + offsetX);
         var anchorPY:int = int(pt.y + offsetY);
         var anchorSX:int = Math.round(anchorPX / LevelEditor.segSize);
         var anchorSY:int = Math.round(anchorPY / LevelEditor.segSize);
         if (anchorSX == this.lastSX && anchorSY == this.lastSY) return;
         this.lastSX = anchorSX;
         this.lastSY = anchorSY;

         for (var i:int = 0; i < this.group.numChildren && i < this.objects.length; i++)
         {
            var vis:DisplayObject = this.group.getChildAt(i);
            var src:BlockObject = BlockObject(this.objects[i]);
            if (this.isStartCode(src.displayCode))
            {
               continue;
            }
            var px:int = int(pt.x + vis.x + offsetX);
            var py:int = int(pt.y + vis.y + offsetY);
            var canPlace:Boolean = this.editor.blockBG.isOpen(px, py);
            if (canPlace)
            {
               var opts:String = src.getOptionsString();
               this.editor.blockBG.addObject(src.displayCode, px, py, opts);
               var sx:int = Math.round(px / LevelEditor.segSize);
               var sy:int = Math.round(py / LevelEditor.segSize);
               var placed:BlockObject = this.editor.blockBG.getBlockFromSeg(sx, sy) as BlockObject;
               if (placed != null && opts != null && opts != "")
               {
                  placed.setOptionsString(opts);
               }
            }
         }
      }

      override public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
         return super.remove();
      }
   }
}
