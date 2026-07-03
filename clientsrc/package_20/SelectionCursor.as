package package_20
{
   import flash.display.Shape;
   import flash.events.*;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import levelEditor.*;
   import ui.CustomCursor;
   import package_20.ObjectGroupCursor;

   public class SelectionCursor extends CustomCursor
   {
      private var editor:LevelEditor;
      private var shape:Shape;
      private var highlight:Shape;
      private var startPt:Point;
      private var endPt:Point;
      private var region:Rectangle;

      public function SelectionCursor()
      {
         this.editor = LevelEditor.editor;
         super();
         this.hideMouse();
         this.applyCursorGraphic(new SelectionCursorGraphic());
         if (this.editor != null && this.editor.cur != null)
         {
            this.shape = new Shape();
            this.editor.cur.addChild(this.shape);
            this.highlight = new Shape();
            this.editor.cur.addChild(this.highlight);
         }
         addEventListener(Event.ENTER_FRAME, this.onEnterFrame, false, 0, true);
      }

      private function onEnterFrame(e:Event):void
      {
         // keep cursor graphic scaling consistent with editor zoom
         if (this.editor != null && this.editor.cur != null)
         {
            this.scaleX = this.editor.scaleX * this.editor.cur.scaleX;
            this.scaleY = this.editor.scaleY * this.editor.cur.scaleY;
         }
         this.ensureOverlayOnTop();
      }

      private function ensureOverlayOnTop() : void
      {
         if (this.editor == null || this.editor.cur == null)
         {
            return;
         }
         var parentContainer:* = this.editor.cur;
         if (this.highlight != null && this.highlight.parent == parentContainer)
         {
            parentContainer.setChildIndex(this.highlight, parentContainer.numChildren - 1);
         }
         if (this.shape != null && this.shape.parent == parentContainer)
         {
            parentContainer.setChildIndex(this.shape, parentContainer.numChildren - 1);
         }
      }

      private function drawSelectionRect():void
      {
         if (this.shape == null || this.editor == null) return;
         var x0:Number = Math.min(this.startPt.x, this.endPt.x);
         var y0:Number = Math.min(this.startPt.y, this.endPt.y);
         var w:Number = Math.max(this.startPt.x, this.endPt.x) - x0;
         var h:Number = Math.max(this.startPt.y, this.endPt.y) - y0;
         var g = this.shape.graphics;
         g.clear();
         // contrast stroke against current editor color
         var col:int = int(this.editor.getColor()) ^ 0xFFFFFF;
         g.lineStyle(1, col, 1);
         g.drawRect(x0, y0, w, h);

         // update highlights for blocks in the in-progress selection
         var tmpRect:Rectangle = new Rectangle(x0, y0, w, h);
         this.drawHighlights(tmpRect);
      }

      private function drawHighlights(rect:Rectangle) : void
      {
         if (this.highlight == null) return;
         var gh = this.highlight.graphics;
         gh.clear();
         if (rect == null) return;
         var blocks:Array = this.editor.getBlocksInRegion(rect);
         var seg:int = LevelEditor.segSize;
         var fillCol:int = 0x33CCFF;
         gh.lineStyle(1, fillCol, 0.6);
         gh.beginFill(fillCol, 0.18);
         for each (var bo:levelEditor.BlockObject in blocks)
         {
            gh.drawRect(bo.x, bo.y, seg, seg);
         }
         gh.endFill();
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

         var localStart:Point = this.editor.cur.globalToLocal(new Point(e.stageX, e.stageY));
         this.startPt = localStart;
         this.endPt = localStart;
         this.region = null;
         // prevent underlying blocks from receiving the mouse down (stops drag)
         e.stopImmediatePropagation();
         return null;
      }

      override protected function mouseMoveHandler(e:MouseEvent) : *
      {
         super.mouseMoveHandler(e);
         if (!isMouseDown() || this.editor == null) return null;

         var pt:Point = this.editor.cur.globalToLocal(new Point(e.stageX, e.stageY));
         if (this.startPt == null)
         {
            this.startPt = pt;
         }
         else
         {
            this.endPt = pt;
         }
         this.drawSelectionRect();
         return null;
      }

      override protected function mouseUpHandler(e:MouseEvent) : *
      {
         super.mouseUpHandler(e);
         if (this.shape != null) this.shape.graphics.clear();
         if (this.startPt != null && this.endPt != null)
         {
            this.region = new Rectangle();
            this.region.x = Math.min(this.startPt.x, this.endPt.x);
            this.region.y = Math.min(this.startPt.y, this.endPt.y);
            this.region.right = Math.max(this.startPt.x, this.endPt.x);
            this.region.bottom = Math.max(this.startPt.y, this.endPt.y);
            this.drawHighlights(this.region);
         }
         this.startPt = null;
         this.endPt = null;
         return null;
      }

      override public function keyDownHandler(e:KeyboardEvent) : *
      {
         // Do not call super to avoid switching to ObjectDeleter on CTRL
         if (e.keyCode == Keyboard.DELETE || e.keyCode == Keyboard.Q)
         {
            if (this.region != null)
            {
               this.editor.removeBlocksInRegion(this.region);
            }
            return null;
         }
         return null;
      }

      public function getSelectionRegion() : Rectangle
      {
         return this.region;
      }

      public function getSelectedBlocks() : Array
      {
         if (this.region == null) return [];
         return this.editor.getBlocksInRegion(this.region);
      }

      override public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
         if (this.shape != null && this.shape.parent != null)
         {
            this.shape.parent.removeChild(this.shape);
         }
         if (this.highlight != null && this.highlight.parent != null)
         {
            this.highlight.parent.removeChild(this.highlight);
         }
         this.shape = null;
         this.highlight = null;
         this.startPt = null;
         this.endPt = null;
         this.region = null;
         return super.remove();
      }
   }
}

import flash.display.Shape;

class SelectionCursorGraphic extends Shape
{
   public function SelectionCursorGraphic()
   {
      super();
      graphics.lineStyle(1);
      graphics.moveTo(15, 0);
      graphics.lineTo(15, 30);
      graphics.moveTo(0, 15);
      graphics.lineTo(30, 15);
   }
}
