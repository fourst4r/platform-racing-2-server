package items
{
   import com.jiggmin.data.*;
   import package_8.LocalCharacter;
   import sounds.*;
   
   public class SuperJump extends Item
   {
      
      private var spaceDown:Boolean = false;
      
       
      
      public function SuperJump(param1:LocalCharacter)
      {
         super(param1);
      }
      
      override public function setSpace(param1:Boolean) : *
      {
         if(param1 && !this.spaceDown)
         {
            this.spaceDown = true;
            super.setSpace(false);
            super.setSpace(true);
         }
         else if(!param1 && this.spaceDown)
         {
            this.spaceDown = false;
            super.setSpace(false);
         }
      }
      
      override public function useItem() : *
      {
         if(!character.crouching)
         {
            SoundEffects.playSound(new SuperJumpSound(),Settings.soundLevel / 100);
            character.velY -= 25;
            super.useItem();
         }
      }
   }
}
