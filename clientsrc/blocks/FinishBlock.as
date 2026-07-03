package blocks
{
   import com.jiggmin.data.*;
   import package_6.*;
   import package_8.LocalCharacter;
   
   public class FinishBlock extends SupplyBlock
   {
      
      public static var var_228:int = 1;
       
      
      private var id:int;
      
      public function FinishBlock()
      {
         this.id = var_228++;
         super(Objects.BLOCK_FINISH);
      }
      
      public function getId() : int
      {
         return this.id;
      }
      
      override protected function useSupply(param1:LocalCharacter) : *
      {
         var _loc2_:int = getPosX() + 15;
         var _loc3_:int = getPosY() + 15;
         Course.course.finish(this.id,_loc2_,_loc3_);
      }
   }
}
