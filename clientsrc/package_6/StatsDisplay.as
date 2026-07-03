package package_6
{
   import flash.events.*;
   import flash.utils.*;
   import package_4.*;
   
   public class StatsDisplay extends Removable
   {
       
      
      private var m:StatsDisplayGraphic;
      
      private var target:Course;
      
      private var pop:HoverPopup;
      
      private var hoverTimeout:uint;
      
      public function StatsDisplay(param1:Course)
      {
         this.m = new StatsDisplayGraphic();
         super();
         this.target = param1;
         addChild(this.m);
      }
      
      public function onMouse(param1:MouseEvent) : *
      {
         if(param1.type == MouseEvent.MOUSE_OUT)
         {
            clearTimeout(this.hoverTimeout);
            if(this.pop != null)
            {
               this.pop.remove();
               this.pop = null;
            }
         }
         else
         {
            this.hoverTimeout = setTimeout(this.showHover,250);
         }
      }
      
      private function showHover() : *
      {
         clearTimeout(this.hoverTimeout);
         this.pop = new HoverPopup("Current Stats","Speed: " + this.m.speedBox.text + "\nAcceleration: " + this.m.accelBox.text + "\nJumping: " + this.m.jumpBox.text,this);
      }
      
      public function setStats(param1:int, param2:int, param3:int) : *
      {
         this.m.speedBox.text = param1;
         this.m.accelBox.text = param2;
         this.m.jumpBox.text = param3;
      }

      public function setStatsText(speedText:String, accelText:String, jumpText:String) : *
      {
         this.m.speedBox.text = speedText;
         this.m.accelBox.text = accelText;
         this.m.jumpBox.text = jumpText;
      }
      
      override public function remove() : *
      {
         dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
         super.remove();
      }
   }
}
