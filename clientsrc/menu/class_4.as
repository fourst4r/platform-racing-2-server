package menu
{
   import com.jiggmin.data.*;
   
   public class class_4
   {
      
      private static var hashing:class_20 = new class_20();
       
      
      public function class_4()
      {
         super();
      }
      
      public static function init() : *
      {
         hashing.initEncryptor("1",Env.COMM_PASS);
         hashing.initEncryptor("10","ayo3JnBGQCZVRiEhVjFAQA==");
      }
      
      public static function method_310(param1:int) : String
      {
         var _loc2_:String = "1";
         if(param1 === 10)
         {
            _loc2_ = "10";
         }
         return hashing.getString(_loc2_);
      }
   }
}
