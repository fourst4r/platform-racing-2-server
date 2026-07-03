package com.jiggmin.pixelEffects
{
   import com.jiggmin.pixelEffects.pixels.*;
   import flash.display.*;
   import flash.geom.*;
   import flash.utils.*;
   
   public class PixelEffect1 extends Sprite
   {
       
      
      private var src:BitmapData;
      
      private var product:BitmapData;
      
      private var productBitmap:Bitmap;
      
      private var bgColor:Number;
      
      private var spread:Number;
      
      private var pull:Number;
      
      private var pixels:Number;
      
      private var scaleRange:Number;
      
      private var interval:Number;
      
      private var segArray:Array;
      
      private var drawInterval:uint;
      
      public function PixelEffect1(param1:BitmapData, param2:Number = 0, param3:Number = 500, param4:Number = 0.19, param5:Number = 15, param6:Number = 15, param7:Number = 55)
      {
         super();
         this.src = param1;
         this.spread = param3;
         this.pull = param4;
         this.pixels = param5;
         this.scaleRange = param6;
         this.interval = param7;
         this.product = new BitmapData(param1.width,param1.height,false,param2);
         this.productBitmap = new Bitmap(this.product);
         addChild(this.productBitmap);
         this.segArray = this.createSegArray();
         this.drawInterval = setInterval(this.drawPixels,param7);
      }
      
      private function createSegArray() : *
      {
         var _loc3_:int = 0;
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ * this.pixels < this.src.width)
         {
            _loc1_[_loc2_] = new Array();
            _loc3_ = 0;
            while(_loc3_ * this.pixels < this.src.height)
            {
               _loc1_[_loc2_][_loc3_] = new Point(_loc2_ * this.pixels,_loc3_ * this.pixels);
               _loc3_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function drawPixels() : *
      {
         this.drawPixel();
         this.drawPixel();
         this.drawPixel();
      }
      
      private function drawPixel() : *
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:BitmapData = null;
         var _loc6_:Rectangle = null;
         var _loc7_:Point = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:SegPixel = null;
         if(this.segArray.length > 0)
         {
            _loc1_ = Math.floor(Math.random() * this.segArray.length);
            _loc2_ = Math.floor(Math.random() * this.segArray[_loc1_].length);
            _loc3_ = Number(this.segArray[_loc1_][_loc2_].x);
            _loc4_ = Number(this.segArray[_loc1_][_loc2_].y);
            this.segArray[_loc1_].splice(_loc2_,1);
            if(this.segArray[_loc1_].length <= 0)
            {
               this.segArray.splice(_loc1_,1);
            }
            _loc5_ = new BitmapData(this.pixels,this.pixels,false,this.bgColor);
            _loc6_ = new Rectangle(_loc3_,_loc4_,this.pixels,this.pixels);
            _loc7_ = new Point(0,0);
            _loc5_.copyPixels(this.src,_loc6_,_loc7_);
            _loc8_ = _loc3_ + Math.random() * this.spread - this.spread / 2 - this.pixels * this.scaleRange / 2;
            _loc9_ = _loc4_ + Math.random() * this.spread - this.spread / 2 - this.pixels * this.scaleRange / 2;
            _loc10_ = Math.random() * this.scaleRange;
            _loc11_ = Math.random() * this.scaleRange;
            _loc12_ = new SegPixel(_loc5_,this.product,_loc8_,_loc9_,_loc10_,_loc11_,_loc3_,_loc4_,this.pull);
            addChild(_loc12_);
         }
         else
         {
            this.finishDrawing();
         }
      }
      
      private function finishDrawing() : *
      {
         clearInterval(this.drawInterval);
      }
      
      private function remove() : *
      {
         this.src.dispose();
         this.product.dispose();
         removeChild(this.productBitmap);
      }
   }
}
