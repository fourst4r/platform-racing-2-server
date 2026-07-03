package blocks
{
   import com.jiggmin.data.*;
   import package_6.*;
   import package_8.LocalCharacter;
   import sounds.*;
   
   public class TimeBlock extends SupplyBlock
   {
       
      
      public function TimeBlock()
      {
         super(Objects.BLOCK_TIME);
      }
      
      override protected function useSupply(param1:LocalCharacter) : *
      {
         super.useSupply(param1);
         SoundEffects.playSound(new TickTockSound(),1 * (Settings.soundLevel / 100));
         Course.course.timer.addTime(10);
      }
   }
}
