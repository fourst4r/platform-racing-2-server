package package_19
{
   import flash.events.MouseEvent;
   
   public class HatsMenuButton extends class_215
   {
       
      
      public function HatsMenuButton(param1:Number = 0)
      {
         super();
         var _loc2_:HatsButtonGraphic = new HatsButtonGraphic();
         addChild(_loc2_);
      }
      
      override protected function onClick(param1:MouseEvent) : *
      {
         param1.stopImmediatePropagation();
         new HatsMenu(this);
      }
   }
}
