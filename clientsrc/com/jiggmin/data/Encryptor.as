package com.jiggmin.data
{
   import com.hurlant.crypto.symmetric.*;
   import com.hurlant.util.*;
   import flash.utils.*;
   
   public class Encryptor
   {
       
      
      private var mode:CBCMode;
      
      private var iv:String;
      
      public function Encryptor()
      {
         super();
      }
      
      public function setKey(param1:String) : *
      {
         var _loc2_:ByteArray = this.stringToByteArray(param1);
         var _loc3_:AESPad = new AESPad();
         var _loc4_:AESKey = new AESKey(_loc2_);
         this.mode = new CBCMode(_loc4_,_loc3_);
      }
      
      public function setIV(param1:String) : *
      {
         var _loc2_:ByteArray = this.stringToByteArray(param1);
         IVMode(this.mode).IV = _loc2_;
         this.iv = param1;
      }
      
      public function encrypt(param1:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         this.mode.encrypt(_loc2_);
         return this.byteArrayToString(_loc2_);
      }
      
      public function decrypt(param1:String) : String
      {
         var _loc2_:ByteArray = this.stringToByteArray(param1);
         this.mode.decrypt(_loc2_);
         _loc2_.position = 0;
         return _loc2_.readUTFBytes(_loc2_.bytesAvailable);
      }
      
      private function byteArrayToString(param1:ByteArray) : String
      {
         return Base64.encodeByteArray(param1);
      }
      
      private function stringToByteArray(param1:String) : ByteArray
      {
         return Base64.decodeToByteArray(param1);
      }
      
      public function remove() : *
      {
         this.mode = null;
      }
   }
}
