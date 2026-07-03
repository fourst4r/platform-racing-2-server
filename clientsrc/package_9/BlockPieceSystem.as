package package_9
{
   import background.EffectBackground;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   import page.GamePage;
   
   /**
    * Note for more speed we can:
    *   1. Drop rotation steps to 16 (lower memory, faster cache build).
    *   2. Switch to copyPixels with precomputed alpha steps (more work, faster per‑frame).
    */
   public class BlockPieceSystem extends Sprite
   {
      public static var instance:BlockPieceSystem;
      
      private static var pieceCache:Object = {};
      private static const ROTATION_STEPS:int = 32;
      private static const TWO_PI:Number = Math.PI * 2;
      private static const ROTATION_STEP:Number = TWO_PI / ROTATION_STEPS;
      
      private var host:EffectBackground;
      private var bitmap:Bitmap;
      private var buffer:BitmapData;
      private var clearRect:Rectangle;
      private var viewWidth:int = 0;
      private var viewHeight:int = 0;
      private var particles:Array = [];
      private var matrix:Matrix = new Matrix();
      private var colorTransform:ColorTransform = new ColorTransform();
      
      public function BlockPieceSystem(host:EffectBackground)
      {
         super();
         this.host = host;
         instance = this;
         mouseEnabled = false;
         mouseChildren = false;
         tabEnabled = false;
         tabChildren = false;
         focusRect = false;
         this.bitmap = new Bitmap();
         addChild(this.bitmap);
         updateViewSize();
         addEventListener(Event.ENTER_FRAME,this.onFrame,false,0,true);
      }
      
      public function spawn(pieceClass:Class, startX:Number, startY:Number, gravity:Number = 1, friction:Number = 0.95, fadeRate:Number = 0.01, velocityXRange:Number = 10, velocityYRange:Number = 10, rotationRange:Number = 10) : void
      {
         var info:Object = getPieceInfo(pieceClass);
         var p:Object = {
            "info":info,
            "x":startX,
            "y":startY,
            "vx":Math.random() * velocityXRange * 2 - velocityXRange,
            "vy":Math.random() * velocityYRange * 2 - velocityYRange,
            "vr":(Math.random() * rotationRange * 2 - rotationRange) * (Math.PI / 180),
            "rot":Math.random() * Math.PI * 2,
            "gravity":gravity,
            "friction":friction,
            "fade":fadeRate,
            "alpha":1
         };
         this.particles.push(p);
      }
      
      public function clear() : void
      {
         this.particles = [];
         if(this.buffer != null)
         {
            this.buffer.fillRect(this.clearRect,0);
         }
      }
      
      public function remove() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onFrame);
         clear();
         if(this.buffer != null)
         {
            this.buffer.dispose();
            this.buffer = null;
         }
         this.bitmap = null;
         this.host = null;
         if(parent != null)
         {
            parent.removeChild(this);
         }
         if(instance == this)
         {
            instance = null;
         }
      }
      
      private function onFrame(param1:Event) : void
      {
         if(this.particles.length <= 0)
         {
            return;
         }
         updateViewSize();
         this.bitmap.x = -this.host.x - this.viewWidth / 2;
         this.bitmap.y = -this.host.y - this.viewHeight / 2;
         this.buffer.lock();
         this.buffer.fillRect(this.clearRect,0);
         var i:int = this.particles.length - 1;
         while(i >= 0)
         {
            var p:Object = this.particles[i];
            p.vx *= p.friction;
            p.vy *= p.friction;
            p.vr *= p.friction;
            p.vy += p.gravity;
            p.x += p.vx;
            p.y += p.vy;
            p.rot += p.vr;
            p.alpha -= p.fade;
            if(p.alpha <= 0)
            {
               this.particles.splice(i,1);
               i--;
               continue;
            }
            var localX:Number = p.x + this.host.x + this.viewWidth / 2;
            var localY:Number = p.y + this.host.y + this.viewHeight / 2;
            if(localX < -60 || localY < -60 || localX > this.viewWidth + 60 || localY > this.viewHeight + 60)
            {
               i--;
               continue;
            }
            var info:Object = p.info;
            var angle:Number = p.rot % TWO_PI;
            if(angle < 0)
            {
               angle += TWO_PI;
            }
            var idx:int = int(angle / ROTATION_STEP);
            if(idx >= ROTATION_STEPS)
            {
               idx = 0;
            }
            var frame:Object = info.rotations[idx];
            this.matrix.identity();
            this.matrix.translate(localX - frame.offsetX, localY - frame.offsetY);
            this.colorTransform.alphaMultiplier = p.alpha;
            this.buffer.draw(frame.bmp,this.matrix,this.colorTransform,null,null,false);
            i--;
         }
         this.buffer.unlock();
      }
      
      private function updateViewSize() : void
      {
         if(Main.stage == null)
         {
            return;
         }
         var scale:Number = 1;
         if(GamePage.course != null)
         {
            scale = GamePage.course.scale;
         }
         if(scale <= 0)
         {
            scale = 1;
         }
         var w:int = Math.ceil(Main.stage.stageWidth / scale);
         var h:int = Math.ceil(Main.stage.stageHeight / scale);
         if(w == this.viewWidth && h == this.viewHeight && this.buffer != null)
         {
            return;
         }
         this.viewWidth = w;
         this.viewHeight = h;
         if(this.buffer != null)
         {
            this.buffer.dispose();
         }
         this.buffer = new BitmapData(this.viewWidth,this.viewHeight,true,0);
         this.bitmap.bitmapData = this.buffer;
         this.clearRect = new Rectangle(0,0,this.viewWidth,this.viewHeight);
      }
      
      private function getPieceInfo(pieceClass:Class) : Object
      {
         var key:String = getQualifiedClassName(pieceClass);
         if(pieceCache[key] != null)
         {
            return pieceCache[key];
         }
         var inst:DisplayObject = new pieceClass();
         var bounds:Rectangle = inst.getBounds(inst);
         var w:int = Math.max(1,Math.ceil(bounds.width));
         var h:int = Math.max(1,Math.ceil(bounds.height));
         var centerX:Number = bounds.x + bounds.width / 2;
         var centerY:Number = bounds.y + bounds.height / 2;
         var rotations:Array = [];
         var m:Matrix = new Matrix();
         var step:int = 0;
         while(step < ROTATION_STEPS)
         {
            var angle:Number = step * ROTATION_STEP;
            var cos:Number = Math.cos(angle);
            var sin:Number = Math.sin(angle);
            var rotW:Number = Math.abs(cos * w) + Math.abs(sin * h);
            var rotH:Number = Math.abs(sin * w) + Math.abs(cos * h);
            var bmp:BitmapData = new BitmapData(Math.max(1,Math.ceil(rotW)),Math.max(1,Math.ceil(rotH)),true,0);
            m.identity();
            m.translate(-centerX,-centerY);
            m.rotate(angle);
            m.translate(bmp.width / 2,bmp.height / 2);
            bmp.draw(inst,m,null,null,null,true);
            rotations.push({
               "bmp":bmp,
               "offsetX":bmp.width / 2,
               "offsetY":bmp.height / 2
            });
            step++;
         }
         var info:Object = {
            "rotations":rotations
         };
         pieceCache[key] = info;
         return info;
      }
   }
}
