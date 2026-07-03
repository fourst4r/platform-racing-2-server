package ui
{
   import com.jiggmin.data.*;
   import flash.display.Stage;
   import package_8.LocalCharacter;
   
   public class StatsSelect extends Removable
   {
       
      
      private var m:PointsRemainingGraphic;
      
      private var speedSlider:StatSlider;
      
      private var accelSlider:StatSlider;
      
      private var jumpnSlider:StatSlider;
      
      private var totalPoints:int;
      
      private var character:LocalCharacter;
      
      private var stageRef:Stage;
      
      public var updateSavedLEStats:Boolean = false;
      
      public function StatsSelect(param1:int, param2:int, param3:int, param4:int, param5:LocalCharacter)
      {
         this.m = new PointsRemainingGraphic();
         this.stageRef = Main.stage;
         super();
         this.totalPoints = param1;
         this.character = param5;
         if(this.totalPoints < param2 + param3 + param4)
         {
            this.totalPoints = param2 + param3 + param4;
         }
         addChild(this.m);
         this.speedSlider = new StatSlider("Speed",this);
         this.accelSlider = new StatSlider("Acceleration",this);
         this.jumpnSlider = new StatSlider("Jumping",this);
         this.speedSlider.setValue(param2);
         this.accelSlider.setValue(param3);
         this.jumpnSlider.setValue(param4);
         this.speedSlider.x = this.accelSlider.x = this.jumpnSlider.x = 8;
         this.speedSlider.y = 30;
         this.accelSlider.y = 70;
         this.jumpnSlider.y = 110;
         addChild(this.speedSlider);
         addChild(this.accelSlider);
         addChild(this.jumpnSlider);
      }
      
      public function getStats() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.speed = this.speedSlider.value;
         _loc1_.acceleration = this.accelSlider.value;
         _loc1_.jumping = this.jumpnSlider.value;
         return _loc1_;
      }
      
      public function setStatsFromCharacter() : *
      {
         this.updateSavedLEStats = false;
         this.setStats(this.character.getStats());
      }
      
      public function setStats(param1:Object) : *
      {
         this.speedSlider.setValue(param1.speed);
         this.accelSlider.setValue(param1.acceleration);
         this.jumpnSlider.setValue(param1.jumping);
         this.updateStatsDisplay();
      }
      
      internal function getPointsRemaining() : int
      {
         var _loc1_:int = this.speedSlider.value + this.accelSlider.value + this.jumpnSlider.value;
         return this.totalPoints - _loc1_;
      }
      
      public function saveLEStats(param1:* = null) : *
      {
         if(this.character != null && this.character.inLE() && this.updateSavedLEStats)
         {
            Settings.setValue(Settings.LE_TEST_STATS,this.character.getStats());
         }
      }
      
      public function updateStatsDisplay() : *
      {
         this.m.textBox.text = this.getPointsRemaining().toString();
         if(this.character != null)
         {
            this.character.setStats(this.speedSlider.value,this.accelSlider.value,this.jumpnSlider.value);
         }
      }
      
      public function getInfoStr() : String
      {
         return this.speedSlider.value + "`" + this.accelSlider.value + "`" + this.jumpnSlider.value;
      }
      
      override public function remove() : *
      {
         this.speedSlider.remove();
         this.accelSlider.remove();
         this.jumpnSlider.remove();
         this.speedSlider = null;
         this.accelSlider = null;
         this.jumpnSlider = null;
         this.character = null;
         this.stageRef = null;
         super.remove();
      }
   }
}
