package com.jiggmin.data
{
   public class Time
   {
       
      
      private var var_624:Number = 0;
      
      private var var_568:Number = 0;
      
      public function Time()
      {
         super();
      }
      
      public function setTime(param1:Number) : *
      {
         this.var_624 = param1 * 1000;
         this.var_568 = Data.getMS();
      }
      
      public function getMS() : Number
      {
         return Data.getMS() - this.var_568 + this.var_624;
      }
      
      public function getTimestamp() : Number
      {
         return this.getMS() / 1000;
      }
      
      public function getDay() : Number
      {
         var _loc1_:Number = this.getTimestamp();
         return Math.round(_loc1_ / 24 / 60) / 60;
      }
   }
}
