package blocks
{
   import com.jiggmin.data.*;
   import package_8.LocalCharacter;
   
   public class IceBlock extends Block
   {
       
      
      public function IceBlock()
      {
         super(Objects.BLOCK_ICE);
      }
      
      override public function onStand(param1:LocalCharacter) : *
      {
         super.onStand(param1);
         param1.traction = 0.05;
      }
   }
}
