package replay
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.GridFitType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;

   public class TextFieldMarquee
   {
      private static const PADDING:int = 4;
      private static const STATE_IDLE:int = 0;
      private static const STATE_PAUSE_AT_START:int = 1;
      private static const STATE_SCROLLING:int = 2;
      private static const STATE_PAUSE_AT_END:int = 3;

      private var field:TextField;
      private var scrollSpeed:Number;
      private var pauseMs:int;
      private var state:int = STATE_IDLE;
      private var pauseUntil:int = 0;
      private var lastTick:int = 0;
      private var overflowPixels:Number = 0;
      private var currentOffset:Number = 0;
      private var originalParent:DisplayObjectContainer;
      private var originalIndex:int = -1;
      private var originalX:Number = 0;
      private var originalY:Number = 0;
      private var originalWidth:Number = 0;
      private var originalHeight:Number = 0;
      private var wrapper:Sprite;
      private var maskShape:Sprite;

      public function TextFieldMarquee(field:TextField, scrollSpeed:Number = 40, pauseMs:int = 1200)
      {
         this.field = field;
         this.scrollSpeed = scrollSpeed;
         this.pauseMs = pauseMs;
         if(this.field != null)
         {
            this.originalParent = this.field.parent as DisplayObjectContainer;
            this.originalX = this.field.x;
            this.originalY = this.field.y;
            this.originalWidth = this.field.width;
            this.originalHeight = this.field.height;
            if(this.originalParent != null)
            {
               this.originalIndex = this.originalParent.getChildIndex(this.field);
            }
            this.field.wordWrap = false;
            this.field.multiline = false;
            this.field.autoSize = TextFieldAutoSize.LEFT;
            this.field.scrollH = 0;
            this.field.gridFitType = GridFitType.PIXEL;
            this.field.cacheAsBitmap = false;
            this.buildWrapper();
            this.field.addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
         }
         this.refresh();
      }

      public function refresh() : void
      {
         if(this.field == null)
         {
            return;
         }
         if(this.field.parent !== this.wrapper)
         {
            this.buildWrapper();
         }
         this.field.scrollH = 0;
         this.field.x = 0;
         this.currentOffset = 0;
         this.lastTick = getTimer();
         this.overflowPixels = Math.max(0,(this.field.textWidth + PADDING) - this.originalWidth);
         var needsScroll:Boolean = this.field.text != null && this.field.text.length > 0 && this.overflowPixels > 0;
         this.state = needsScroll ? STATE_PAUSE_AT_START : STATE_IDLE;
         this.pauseUntil = this.lastTick + this.pauseMs;
      }

      private function onEnterFrame(event:Event) : void
      {
         if(this.field == null || this.state == STATE_IDLE)
         {
            return;
         }
         var now:int = getTimer();
         if(this.state == STATE_PAUSE_AT_START)
         {
            if(now >= this.pauseUntil)
            {
               this.state = STATE_SCROLLING;
               this.lastTick = now;
            }
            return;
         }
         if(this.state == STATE_SCROLLING)
         {
            var delta:Number = (now - this.lastTick) * this.scrollSpeed / 1000;
            this.lastTick = now;
            if(delta <= 0)
            {
               return;
            }
            var nextOffset:Number = this.currentOffset + delta;
            if(nextOffset >= this.overflowPixels)
            {
               this.currentOffset = this.overflowPixels;
               this.field.x = -int(Math.round(this.currentOffset));
               this.state = STATE_PAUSE_AT_END;
               this.pauseUntil = now + this.pauseMs;
            }
            else
            {
               this.currentOffset = nextOffset;
               this.field.x = -int(Math.round(this.currentOffset));
            }
            return;
         }
         if(this.state == STATE_PAUSE_AT_END && now >= this.pauseUntil)
         {
            this.currentOffset = 0;
            this.field.x = 0;
            this.state = STATE_PAUSE_AT_START;
            this.pauseUntil = now + this.pauseMs;
            this.lastTick = now;
         }
      }

      public function dispose() : void
      {
         if(this.field != null)
         {
            this.field.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            this.field.scrollH = 0;
            this.field.x = this.originalX;
            this.field.y = this.originalY;
            this.field.width = this.originalWidth;
            this.field.autoSize = TextFieldAutoSize.NONE;
            this.teardownWrapper();
         }
         this.state = STATE_IDLE;
      }

      private function buildWrapper() : void
      {
         if(this.field == null || this.originalParent == null)
         {
            return;
         }
         if(this.wrapper == null)
         {
            this.wrapper = new Sprite();
            this.maskShape = new Sprite();
         }
         this.maskShape.graphics.clear();
         this.maskShape.graphics.beginFill(0,1);
         this.maskShape.graphics.drawRect(0,0,this.originalWidth,this.originalHeight);
         this.maskShape.graphics.endFill();
         if(this.maskShape.parent == null)
         {
            this.wrapper.addChild(this.maskShape);
         }
         if(this.field.parent != null)
         {
            this.field.parent.removeChild(this.field);
         }
         this.field.autoSize = TextFieldAutoSize.LEFT;
         this.field.x = 0;
         this.field.y = 0;
         this.wrapper.addChild(this.field);
         this.wrapper.mask = this.maskShape;
         this.wrapper.x = this.originalX;
         this.wrapper.y = this.originalY;
         if(this.wrapper.parent == null)
         {
            this.originalParent.addChildAt(this.wrapper,this.originalIndex >= 0 ? this.originalIndex : this.originalParent.numChildren);
         }
      }

      private function teardownWrapper() : void
      {
         if(this.field != null)
         {
            if(this.field.parent == this.wrapper)
            {
               this.wrapper.removeChild(this.field);
            }
            if(this.originalParent != null && !this.originalParent.contains(this.field))
            {
               this.originalParent.addChildAt(this.field,this.originalIndex >= 0 ? this.originalIndex : this.originalParent.numChildren);
            }
            this.field.x = this.originalX;
            this.field.y = this.originalY;
            this.field.autoSize = TextFieldAutoSize.NONE;
            this.field.width = this.originalWidth;
         }
         if(this.wrapper != null && this.wrapper.parent != null)
         {
            this.wrapper.parent.removeChild(this.wrapper);
         }
         this.wrapper = null;
         this.maskShape = null;
      }
   }
}
