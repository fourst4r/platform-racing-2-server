package com.jiggmin.data
{
   import flash.display.Sprite;
   import flash.utils.*;
   
   public class SWFStats extends Sprite
   {
       
      
      private var lastReset:Number;
      
      private var lagArray:Array;
      
      private var keepCount:int = 30;
      
      public function SWFStats()
      {
         this.lastReset = new Date().time;
         this.lagArray = new Array();
         super();
         setInterval(this.resetStats,1000);
      }
      
      private function resetStats() : *
      {
         var _loc4_:int = 0;
         var _loc6_:Number = NaN;
         var _loc1_:Number = new Date().time;
         var _loc2_:Number = _loc1_ - this.lastReset;
         this.lastReset = _loc1_;
         this.lagArray.push(_loc2_);
         if(this.lagArray.length > this.keepCount)
         {
            this.lagArray.shift();
         }
         var _loc3_:Number = 0;
         while(_loc4_ < this.keepCount)
         {
            _loc3_ += this.lagArray[_loc4_];
            _loc4_++;
         }
         var _loc5_:Number;
         if((_loc5_ = _loc3_ / this.keepCount) < 900)
         {
            _loc6_ = _loc1_ + 1000;
            while(new Date().time < _loc1_)
            {
            }
         }
      }
   }
}
