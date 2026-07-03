package com.jiggmin.data
{
   import flash.display.*;
   import flash.geom.*;
   import flash.utils.*;
   
   public class EpicFlash
   {
       
      
      private var items:Vector.<DisplayObject>;
      
      private var var_416:int;
      
      private var var_444:int;
      
      private var active:Boolean = false;
      
      public function EpicFlash(param1:int = 500)
      {
         this.items = new Vector.<DisplayObject>();
         super();
         this.var_444 = param1;
      }
      
      public function start() : *
      {
         clearInterval(this.var_416);
         this.var_416 = setInterval(this.method_554,this.var_444);
         this.active = true;
      }
      
      public function stop() : *
      {
         clearInterval(this.var_416);
         this.active = false;
      }
      
      public function method_580(param1:int) : *
      {
         this.var_444 = param1;
         if(this.active)
         {
            this.start();
         }
      }
      
      public function isEmpty() : Boolean
      {
         if(this.items.length <= 0)
         {
            return true;
         }
         return false;
      }
      
      public function addItem(param1:DisplayObject) : *
      {
         this.items.push(param1);
      }
      
      private function method_554() : *
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.color = Math.round(Math.random() * 16777215);
         for each(_loc1_ in this.items)
         {
            _loc1_.transform.colorTransform = _loc2_;
         }
      }
      
      public function remove() : *
      {
         this.items = null;
      }
   }
}
