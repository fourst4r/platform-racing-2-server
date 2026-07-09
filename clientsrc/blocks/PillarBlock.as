package blocks
{
   import blocks.options.*;
   import com.jiggmin.data.*;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.PixelSnapping;
   
   public class PillarBlock extends Block
   {
      public static const DEFAULT_STYLE:int = 1;
      
      public static const DEFAULT_COLOR:int = 15592939;
      
      private var styleBitmap:Bitmap;
      
      private var tintBitmap:Bitmap;
      
      private var style:int = 1;
      
      private var color:int = 15592939;
      
      public function PillarBlock()
      {
         this.styleBitmap = new Bitmap(null,PixelSnapping.ALWAYS,false);
         this.tintBitmap = new Bitmap(null,PixelSnapping.ALWAYS,false);
         this.tintBitmap.blendMode = BlendMode.MULTIPLY;
         this.tintBitmap.alpha = 0.65;
         optionsMenu = PillarBlockOptions;
         super(Objects.BLOCK_PILLAR);
         addChild(this.styleBitmap);
         addChild(this.tintBitmap);
         this.redraw();
      }
      
      public function getStyle() : int
      {
         return this.style;
      }
      
      public function getColor() : int
      {
         return this.color;
      }
      
      public function applyOptions(param1:String) : *
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         if(param1 == null || param1 == "")
         {
            this.style = DEFAULT_STYLE;
            this.color = DEFAULT_COLOR;
            options = "";
            this.redraw();
            return;
         }
         _loc2_ = String(param1).split(":");
         _loc3_ = int(_loc2_[0]);
         if(_loc3_ < 1 || _loc3_ > 3)
         {
            _loc3_ = DEFAULT_STYLE;
         }
         this.style = _loc3_;
         if(_loc2_.length > 1 && _loc2_[1] != null && _loc2_[1] != "")
         {
            _loc4_ = Number(_loc2_[1]);
            this.color = isNaN(_loc4_) ? DEFAULT_COLOR : int(_loc4_);
         }
         else
         {
            this.color = DEFAULT_COLOR;
         }
         options = this.style == DEFAULT_STYLE && this.color == DEFAULT_COLOR ? "" : this.style + ":" + this.color;
         this.redraw();
      }
      
      override public function remove() : *
      {
         if(this.tintBitmap.bitmapData != null)
         {
            this.tintBitmap.bitmapData.dispose();
            this.tintBitmap.bitmapData = null;
         }
         this.styleBitmap.bitmapData = null;
         if(this.styleBitmap.parent != null)
         {
            this.styleBitmap.parent.removeChild(this.styleBitmap);
         }
         if(this.tintBitmap.parent != null)
         {
            this.tintBitmap.parent.removeChild(this.tintBitmap);
         }
         super.remove();
      }
      
      private function redraw() : *
      {
         var _loc1_:* = this.tintBitmap.bitmapData;
         this.styleBitmap.bitmapData = Blocks.getPillarBitmap(this.style);
         this.tintBitmap.bitmapData = Blocks.getSolidColorBitmap(this.color);
         if(_loc1_ != null)
         {
            _loc1_.dispose();
         }
      }
   }
}
