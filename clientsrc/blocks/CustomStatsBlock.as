package blocks
{
   import blocks.options.*;
   import com.jiggmin.data.*;
   import package_6.*;
   import package_8.LocalCharacter;
   import sounds.*;
   
   public class CustomStatsBlock extends SupplyBlock
   {
       
      
      private var customStats:Array;
      
      private var customStatsEnabled:Array;
      
      public function CustomStatsBlock()
      {
         this.customStats = [50,50,50];
         this.customStatsEnabled = [true,true,true];
         optionsMenu = CustomStatsBlockOptions;
         super(Objects.BLOCK_CUSTOM_STATS);
      }
      
      public function getCustomStats() : *
      {
         return this.customStats.concat();
      }

      public function getCustomStatsEnabled() : *
      {
         return this.customStatsEnabled.concat();
      }
      
      public function applyOptions(param1:String) : *
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         if(param1 == "reset")
         {
            options = "reset";
            return;
         }
         if(param1 == null || param1 == "")
         {
            this.customStats = [50,50,50];
            this.customStatsEnabled = [true,true,true];
            options = "";
            return;
         }
         _loc2_ = param1.split("-");
         _loc3_ = [50,50,50];
         this.customStatsEnabled = [true,true,true];
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            if(_loc4_ >= _loc2_.length)
            {
               _loc4_++;
               continue;
            }
            _loc5_ = String(_loc2_[_loc4_]);
            if(_loc5_ == "" || _loc5_ == "x" || _loc5_ == "X" || _loc5_ == "null" || _loc5_ == "none" || _loc5_ == "*")
            {
               this.customStatsEnabled[_loc4_] = false;
            }
            else
            {
               _loc6_ = Number(_loc5_);
               if(isNaN(_loc6_))
               {
                  this.customStatsEnabled[_loc4_] = false;
               }
               else
               {
                  _loc3_[_loc4_] = Data.numLimit(int(_loc6_),0,100);
               }
            }
            _loc4_++;
         }
         this.customStats = _loc3_;
         if(this.customStatsEnabled[0] && this.customStatsEnabled[1] && this.customStatsEnabled[2] && this.customStats[0] == 50 && this.customStats[1] == 50 && this.customStats[2] == 50)
         {
            options = "";
         }
         else
         {
            options = String((this.customStatsEnabled[0] ? this.customStats[0] : "x") + "-" + (this.customStatsEnabled[1] ? this.customStats[1] : "x") + "-" + (this.customStatsEnabled[2] ? this.customStats[2] : "x"));
         }
      }
      
      override protected function useSupply(param1:LocalCharacter) : *
      {
         super.useSupply(param1);
         if(options == "reset")
         {
            param1.resetStatsToStart();
         }
         else
         {
            var _loc2_:Object = param1.getStats();
            var _loc3_:int = !!this.customStatsEnabled[0] ? int(this.customStats[0]) : int(_loc2_.speed);
            var _loc4_:int = !!this.customStatsEnabled[1] ? int(this.customStats[1]) : int(_loc2_.acceleration);
            var _loc5_:int = !!this.customStatsEnabled[2] ? int(this.customStats[2]) : int(_loc2_.jumping);
            param1.setStats(_loc3_,_loc4_,_loc5_);
         }
         if(Course.course != null && Course.course is TestCourse)
         {
            Course.course.statsSelectSetFromCharacter();
         }
         SoundEffects.playSound(new StarSound(),0.6 * (Settings.soundLevel / 100));
      }
   }
}
