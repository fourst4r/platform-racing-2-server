package items
{
   import package_8.LocalCharacter;
   import package_9.*;
   
   public class Lightning extends Item
   {
       
      
      public function Lightning(param1:LocalCharacter)
      {
         super(param1);
      }
      
      override public function useItem() : *
      {
         new Zap(character,false);
         Main.socket.write("zap`");
         super.useItem();
      }
   }
}
