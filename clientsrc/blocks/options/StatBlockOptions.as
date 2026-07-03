package blocks.options
{
   import blocks.*;
   import fl.events.*;
   
   public class StatBlockOptions extends BlockOptions
   {
       
      
      public function StatBlockOptions(param1:Block)
      {
         m = new StatBlockOptionsGraphic();
         super(param1);
         m.titleBox.text = param1 is HappyBlock ? "-- Happy Block --" : "-- Sad Block --";
         m.descBox.text = "All the stats of players that bump this block will be " + (param1 is HappyBlock ? "increased" : "decreased") + " by:";
         m.slider.value = m.statBox.text = Math.abs(param1.getChangeAmt());
         m.slider.addEventListener(SliderEvent.THUMB_DRAG,this.updateStatDisplay,false,0,true);
      }
      
      private function updateStatDisplay(param1:SliderEvent) : *
      {
         m.statBox.text = m.slider.value;
      }
      
      override public function remove() : *
      {
         block.applyOptions(m.slider.value * (block is HappyBlock ? 1 : -1));
         super.remove();
      }
   }
}
