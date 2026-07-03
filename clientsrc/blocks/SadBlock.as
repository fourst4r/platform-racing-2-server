package blocks
{
   import blocks.options.*;
   import com.jiggmin.data.*;
   import package_6.*;
   import package_8.LocalCharacter;
   import sounds.*;
   
   public class SadBlock extends SupplyBlock
   {
       
      
      private var changeAmt:int = -5;
      
      public function SadBlock()
      {
         optionsMenu = StatBlockOptions;
         super(Objects.BLOCK_SAD);
      }
      
      public function getChangeAmt() : *
      {
         return this.changeAmt;
      }
      
      public function applyOptions(param1:String) : *
      {
         this.changeAmt = Data.numLimit(int(param1),-100,-5);
         options = this.changeAmt < -5 ? String(this.changeAmt) : "";
      }
      
      override protected function useSupply(param1:LocalCharacter) : *
      {
         super.useSupply(param1);
         param1.statsChange(this.changeAmt);
         if(Course.course != null && Course.course is TestCourse)
         {
            Course.course.statsSelectSetFromCharacter();
         }
         SoundEffects.playSound(new BumpSadSound(),0.75 * (Settings.soundLevel / 100));
      }
   }
}
