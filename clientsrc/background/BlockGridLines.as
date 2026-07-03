package background
{
   import page.GamePage;
   
   public class BlockGridLines extends Background
   {
       
      
      private var segSize:Number = 30;
      
      public function BlockGridLines(param1:GamePage)
      {
         super(param1);
         this.drawGrid(1);
      }
      
      public function setZoom(param1:Number) : *
      {
         this.drawGrid(param1);
      }
      
      private function drawGrid(param1:Number) : *
      {
         var _loc2_:Number = 550 / param1 + this.segSize;
         var _loc3_:Number = 400 / param1 + this.segSize;
         graphics.clear();
         graphics.lineStyle(1,7829367,0.25);
         var _loc4_:Number = 0;
         while(_loc4_ <= _loc2_)
         {
            graphics.moveTo(_loc4_,0);
            graphics.lineTo(_loc4_,_loc3_);
            _loc4_ += this.segSize;
         }
         var _loc5_:Number = 0;
         while(_loc5_ <= _loc3_)
         {
            graphics.moveTo(0,_loc5_);
            graphics.lineTo(_loc2_,_loc5_);
            _loc5_ += this.segSize;
         }
      }
      
      override public function setPos(param1:Number, param2:Number) : *
      {
         param1 %= this.segSize;
         param2 %= this.segSize;
         x = param1 - Math.floor(width / 2 / this.segSize) * this.segSize;
         y = param2 - Math.floor(height / 2 / this.segSize) * this.segSize;
      }
   }
}
