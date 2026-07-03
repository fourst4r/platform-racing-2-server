package items
{
   import blocks.Block;
   import package_6.*;
   import package_8.LocalCharacter;
   import package_9.*;
   
   public class Teleport extends Item
   {
      private var spaceDown:Boolean = false;
       
      
      public function Teleport(param1:LocalCharacter)
      {
         super(param1);
      }

      override public function setSpace(isPressed:Boolean) : *
      {
         if(isPressed && !this.spaceDown)
         {
            this.spaceDown = true;
            super.setSpace(false);
            super.setSpace(true);
         }
         else if(!isPressed && this.spaceDown)
         {
            this.spaceDown = false;
            super.setSpace(false);
         }
      }
      
      override public function useItem() : *
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = character.scaleX > 0 ? 120 : -120;
         var _loc2_:Block = Course.course.blockBackground.getBlockFromPos(character.x + _loc1_,character.y - 5,true);
         if(_loc2_ == null || !_loc2_.isActive())
         {
            _loc3_ = character.x;
            _loc4_ = character.y - 25;
            new TeleportPop(_loc3_,_loc4_);
            Main.socket.write("add_effect`Teleport`" + _loc3_ + "`" + _loc4_);
            character.x += _loc1_;
            _loc3_ = character.x;
            _loc4_ = character.y - 25;
            new TeleportPop(_loc3_,_loc4_);
            Main.socket.write("add_effect`Teleport`" + _loc3_ + "`" + _loc4_);
            super.useItem();
         }
      }
   }
}
