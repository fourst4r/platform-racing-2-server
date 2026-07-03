package package_19
{
   import flash.events.MouseEvent;
   
   public class ItemMenuButton extends class_215
   {
       
      
      public function ItemMenuButton(param1:Number = 0)
      {
         super();
         addChild(new ItemButtonGraphic());
      }
      
      override protected function onClick(param1:MouseEvent) : *
      {
         param1.stopImmediatePropagation();
         new ItemMenu(this);
      }
   }
}
