package ui
{
   import flash.display.Sprite;
   import flash.events.*;
   import flash.filters.*;
   
   public class ProgressBar extends Sprite
   {
       
      
      private var bar:ProgressBarGraphic;
      
      private var totalPx:Number = 0;
      
      private var percentComplete:Number = 0;
      
      private var widthPx:Number = 0;
      
      private var var_597:Number;
      
      public function ProgressBar(param1:Number = 200, param2:Number = 0.3)
      {
         this.bar = new ProgressBarGraphic();
         super();
         this.var_597 = param2;
         var _loc3_:DropShadowFilter = new DropShadowFilter(2,45,0,1,2,2);
         this.bar.filters = new Array(_loc3_);
         addChild(this.bar);
         this.bar.width = param1;
         this.bar.bar.width = param1 - 4;
         this.totalPx = param1 - 4;
         addEventListener(Event.ENTER_FRAME,this.go,false,0,true);
      }
      
      private function go(param1:Event) : *
      {
         this.widthPx += (this.percentComplete - this.widthPx) * this.var_597;
         this.bar.bar.width = this.widthPx;
      }
      
      public function incProgress(param1:Number) : *
      {
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         this.percentComplete = this.totalPx * param1;
      }
      
      public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.go);
         if(this.bar != null && this.bar.parent == this)
         {
            removeChild(this.bar);
            this.bar = null;
         }
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}
