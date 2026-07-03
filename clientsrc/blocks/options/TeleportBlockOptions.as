package blocks.options
{
   import blocks.Block;
   import com.jiggmin.ColorPicker.*;
   import flash.events.*;
   
   public class TeleportBlockOptions extends BlockOptions
   {
       
      
      private var cp:ColorPicker;
      
      public function TeleportBlockOptions(param1:Block)
      {
         this.cp = new ColorPicker();
         m = new TeleportBlockOptionsGraphic();
         super(param1);
         this.cp.width = this.cp.height = 30;
         this.cp.x -= 15;
         this.cp.y += 30;
         this.cp.setColor(param1.getColor());
         addChild(this.cp);
         this.cp.addEventListener(Event.CLOSE,this.chooseColor,false,0,true);
      }
      
      private function chooseColor(param1:* = null) : *
      {
         block.applyOptions(this.cp.getColor());
      }
      
      override public function remove() : *
      {
         this.chooseColor();
         removeChild(this.cp);
         super.remove();
      }
   }
}
