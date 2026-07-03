package com.jiggmin.data
{
   import com.hurlant.util.*;
   
   public class class_20
   {
       
      
      private var items:Object;
      
      public function class_20()
      {
         this.items = new Object();
         super();
      }
      
      public function setNumber(param1:String, param2:Number) : *
      {
         var _loc3_:Number = Math.ceil(Math.random() * 999999) - 500000;
         var _loc4_:Number = param2 + _loc3_;
         this.method_350(param1,_loc4_,_loc3_);
      }
      
      public function getNumber(param1:String) : Number
      {
         var _loc2_:Object = this.method_162(param1);
         var _loc3_:Number = 0;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.hidden - _loc2_.key;
         }
         return _loc3_;
      }
      
      public function setBool(param1:String, param2:Boolean) : *
      {
         var _loc3_:int = 0;
         if(param2)
         {
            _loc3_ = 1;
         }
         this.setNumber(param1,_loc3_);
      }
      
      public function getBool(param1:String) : Boolean
      {
         var _loc2_:int = this.getNumber(param1);
         var _loc3_:Boolean = false;
         if(_loc2_ === 1)
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      public function initEncryptor(param1:String, param2:String) : *
      {
         var _loc3_:Encryptor = new Encryptor();
         _loc3_.setKey(Base64.encode(Data.method_439(16)));
         _loc3_.setIV(Base64.encode(Data.method_439(16)));
         this.method_350(param1,_loc3_.encrypt(param2),_loc3_);
      }
      
      public function getString(param1:String) : String
      {
         var _loc2_:Object = this.method_162(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:Encryptor = Encryptor(_loc2_.key);
         return _loc3_.decrypt(_loc2_.hidden);
      }
      
      private function method_350(param1:String, param2:*, param3:*) : *
      {
         var _loc4_:Object = null;
         if((_loc4_ = this.method_162(param1)) != null)
         {
            _loc4_.hidden = param2;
            _loc4_.key = param3;
         }
         else
         {
            (_loc4_ = new Object()).hidden = param2;
            _loc4_.key = param3;
            this.items[param1] = _loc4_;
         }
      }
      
      private function method_162(param1:String) : Object
      {
         return this.items[param1];
      }
      
      public function remove() : *
      {
         this.items = null;
      }
   }
}
