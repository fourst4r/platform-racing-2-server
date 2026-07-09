package blocks
{
   import com.jiggmin.data.*;
   
   public class UnsafeStandBlock extends Block
   {
      public function UnsafeStandBlock()
      {
         super(Objects.BLOCK_UNSAFE);
         safeStand = false;
      }
   }
}
