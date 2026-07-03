package blocks
{
   import com.jiggmin.data.*;
   import package_8.LocalCharacter;
   
   public class HeartBlock extends SupplyBlock
   {
       
      
      public function HeartBlock()
      {
         super(Objects.BLOCK_HEART);
      }
      
      override protected function useSupply(param1:LocalCharacter) : *
      {
         super.useSupply(param1);
         param1.gainHeart();
      }
   }
}
