package com.jiggmin.data
{
   import com.hurlant.crypto.symmetric.*;
   import flash.utils.ByteArray;
   
   public class AESPad implements IPad
   {
       
      
      private var blockSize:uint;
      
      private var char0:String;
      
      public function AESPad(param1:uint = 0)
      {
         this.char0 = String.fromCharCode(0);
         super();
         this.blockSize = param1;
      }
      
      public function pad(param1:ByteArray) : void
      {
         while(param1.length % this.blockSize != 0)
         {
            param1.writeUTFBytes(this.char0);
         }
      }
      
      public function unpad(param1:ByteArray) : void
      {
         param1.position = 0;
         var _loc2_:String = param1.readUTFBytes(param1.bytesAvailable);
         _loc2_.split(this.char0).join("");
         param1.writeUTFBytes(_loc2_);
      }
      
      public function setBlockSize(param1:uint) : void
      {
         this.blockSize = param1;
      }
   }
}
