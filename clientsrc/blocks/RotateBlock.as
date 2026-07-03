package blocks
{
   import package_6.*;
   import package_8.LocalCharacter;
   
   public class RotateBlock extends Block
   {
       
      
      protected var dir:String;
      
      public function RotateBlock(param1:int)
      {
         super(param1);
      }
      
      override public function onBump(param1:LocalCharacter) : *
      {
         super.onBump(param1);
         if(!frozen)
         {
            param1.setMode("freeze");
            param1.velX = param1.velY = 0;
            Course.course.startRotate(this.dir);
         }
      }
   }
}
