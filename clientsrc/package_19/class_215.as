package package_19
{
   import flash.display.Sprite;
   import flash.events.*;
   
   public class class_215 extends Sprite
   {
       
      
      public function class_215()
      {
         var _loc1_:Square = null;
         super();
         _loc1_ = new Square();
         _loc1_.width = _loc1_.height = 30;
         _loc1_.alpha = 0;
         _loc1_.x = _loc1_.y = 15;
         addChild(_loc1_);
         addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(param1:MouseEvent) : *
      {
      }
      
      public function remove() : *
      {
         removeEventListener(MouseEvent.CLICK,this.onClick);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}
