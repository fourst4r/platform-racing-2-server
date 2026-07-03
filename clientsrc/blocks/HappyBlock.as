package blocks
{
   import blocks.options.*;
   import com.jiggmin.data.*;
   import package_6.*;
   import package_8.LocalCharacter;
   import sounds.*;
   
   public class HappyBlock extends SupplyBlock
   {
       
      
      private var changeAmt:int = 5;
      
      public function HappyBlock()
      {
         optionsMenu = StatBlockOptions;
         super(Objects.BLOCK_HAPPY);
      }
      
      public function getChangeAmt() : *
      {
         return this.changeAmt;
      }
      
      public function applyOptions(param1:String) : *
      {
         this.changeAmt = Data.numLimit(int(param1),5,100);
         options = this.changeAmt > 5 ? String(this.changeAmt) : "";
      }
      
      override protected function useSupply(param1:LocalCharacter) : *
      {
         super.useSupply(param1);
         param1.statsChange(this.changeAmt);
         if(Course.course != null && Course.course is TestCourse)
         {
            Course.course.statsSelectSetFromCharacter();
         }
         SoundEffects.playSound(new BumpHappySound(),0.75 * (Settings.soundLevel / 100));
      }
   }
}
