package package_6
{
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.geom.Rectangle;
   
   public class MiniMap extends Removable
   {
       
      
      private var bitmapData:BitmapData;
      
      private var bitmap:Bitmap;
      
      private var holder:Sprite;
      
      private var var_16:Sprite;
      
      private var var_49:Sprite;
      
      private var playerDots:Sprite;
      
      private var m:MiniMapGraphic;
      
      private var maxSpaceWidth:int = 400;
      
      private var maxSpaceHeight:int = 44;
      
      private var scale:Number;
      
      public function MiniMap()
      {
         this.holder = new Sprite();
         this.var_16 = new Sprite();
         this.var_49 = new Sprite();
         this.playerDots = new Sprite();
         this.m = new MiniMapGraphic();
         super();
         addChild(this.m);
         this.var_16.graphics.beginFill(0);
      }
      
      public function method_680(param1:int, param2:Number, param3:Number) : *
      {
         var _loc4_:MiniMapFinishGraphic = null;
         if(param1 == Objects.BLOCK_FINISH)
         {
            (_loc4_ = new MiniMapFinishGraphic()).x = param2 + 15;
            _loc4_.y = param3 + 15;
            this.var_49.addChild(_loc4_);
         }
         this.drawBlock(param2,param3);
      }
      
      public function removeFinish(param1:int, param2:int) : *
      {
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         while(_loc3_ < this.var_49.numChildren)
         {
            if((_loc4_ = this.var_49.getChildAt(_loc3_)).x == param1 && _loc4_.y == param2)
            {
               this.var_49.removeChild(_loc4_);
               return;
            }
            _loc3_++;
         }
      }
      
      private function drawBlock(param1:int, param2:int) : *
      {
         this.var_16.graphics.beginFill(0);
         this.var_16.graphics.moveTo(param1,param2);
         this.var_16.graphics.lineTo(param1 + 30,param2);
         this.var_16.graphics.lineTo(param1 + 30,param2 + 30);
         this.var_16.graphics.lineTo(param1,param2 + 30);
         this.var_16.graphics.lineTo(param1,param2);
         this.var_16.graphics.endFill();
      }
      
      public function getDot() : MiniMapDot
      {
         var _loc1_:MiniMapDot = new MiniMapDot();
         this.playerDots.addChild(_loc1_);
         this.method_182(this.playerDots,this.holder.scaleX,4);
         return _loc1_;
      }
      
      public function rasterize() : *
      {
         var _loc8_:Sprite = null;
         this.var_16.graphics.endFill();
         this.var_16.scaleX = this.var_16.scaleY = 1;
         var _loc1_:Number = this.maxSpaceWidth / this.var_16.width;
         var _loc2_:Number = this.maxSpaceWidth / this.var_16.height;
         var _loc3_:Number = this.maxSpaceHeight / this.var_16.height;
         var _loc4_:Number = this.maxSpaceHeight / this.var_16.width;
         var _loc5_:Number = _loc1_ < _loc3_ ? _loc1_ : _loc3_;
         var _loc6_:Number = _loc2_ < _loc4_ ? _loc2_ : _loc4_;
         var _loc7_:Number = _loc5_ > _loc6_ ? _loc5_ : _loc6_;
         this.var_49.scaleX = this.var_49.scaleY = this.playerDots.scaleX = this.playerDots.scaleY = this.var_16.scaleX = this.var_16.scaleY = _loc7_;
         (_loc8_ = new Sprite()).addChild(this.var_16);
         var _loc9_:Rectangle = this.var_16.getBounds(_loc8_);
         this.var_49.x = this.playerDots.x = this.var_16.x = -_loc9_.left;
         this.var_49.y = this.playerDots.y = this.var_16.y = -_loc9_.top;
         var _loc10_:Number = Number(Data.numLimit(this.var_16.width,1,this.maxSpaceWidth));
         var _loc11_:Number = Number(Data.numLimit(this.var_16.height,1,this.maxSpaceWidth));
         this.bitmapData = new BitmapData(Math.ceil(_loc10_),Math.ceil(_loc11_),true,0);
         this.bitmap = new Bitmap(this.bitmapData);
         this.bitmapData.draw(_loc8_);
         this.var_16.graphics.clear();
         this.var_16 = new Sprite();
         addChild(this.holder);
         this.holder.addChild(this.bitmap);
         this.holder.addChild(this.var_49);
         this.holder.addChild(this.playerDots);
         this.method_263();
      }
      
      private function method_263() : *
      {
         this.holder.scaleX = this.holder.scaleY = 1;
         var _loc1_:Rectangle = this.bitmap.getBounds(this);
         var _loc2_:Number = this.maxSpaceWidth / _loc1_.width;
         var _loc3_:Number = this.maxSpaceHeight / _loc1_.height;
         this.scale = _loc2_ < _loc3_ ? _loc2_ : _loc3_;
         this.scale = Data.numLimit(this.scale,0,1);
         this.holder.scaleX = this.holder.scaleY = this.scale;
         _loc1_ = this.bitmap.getBounds(this);
         var _loc4_:int = int((this.maxSpaceWidth - _loc1_.width) / 2);
         var _loc5_:int = int((this.maxSpaceHeight - _loc1_.height) / 2);
         this.holder.x = this.holder.x + (_loc4_ - _loc1_.left) + 3;
         this.holder.y = this.holder.y + (_loc5_ - _loc1_.top) + 3;
         this.method_182(this.playerDots,this.scale,4);
         this.method_182(this.var_49,this.scale,4);
      }
      
      private function method_182(param1:Sprite, param2:Number, param3:Number) : *
      {
         var _loc5_:DisplayObject = null;
         var _loc4_:int = 0;
         while(_loc4_ < param1.numChildren)
         {
            _loc5_ = param1.getChildAt(_loc4_);
            _loc5_.width = _loc5_.height = 4 / (param2 * param1.scaleX);
            _loc4_++;
         }
      }
      
      public function rotate(param1:Number) : *
      {
         this.holder.rotation = param1;
         this.method_263();
      }
      
      public function clear() : *
      {
         if(this.bitmapData != null)
         {
            this.bitmapData.dispose();
            this.bitmapData = null;
         }
         while(this.var_49.numChildren > 0)
         {
            this.var_49.removeChildAt(0);
         }
      }
      
      override public function remove() : *
      {
         this.clear();
         while(this.playerDots.numChildren > 0)
         {
            this.playerDots.getChildAt(0).remove();
            this.playerDots.removeChildAt(0);
         }
         removeChild(this.m);
         this.bitmap = null;
         this.holder = null;
         this.var_16 = null;
         this.var_49 = null;
         this.playerDots = null;
         this.m = null;
         super.remove();
      }
   }
}
