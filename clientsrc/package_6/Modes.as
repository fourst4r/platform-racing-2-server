package package_6
{
   public class Modes
   {
      
      public static var egg:String = "egg";
      
      public static var dm:String = "deathmatch";
      
      public static var race:String = "race";
      
      public static var obj:String = "objective";
      
      public static var hat:String = "hat";
       
      
      public function Modes()
      {
         super();
      }
      
      public static function getFullName(param1:String) : *
      {
         if(param1 == "e" || param1 == "eggs" || param1 == Modes.egg)
         {
            return "Alien Eggs";
         }
         if(param1 == "d" || param1 == "dm" || param1 == Modes.dm)
         {
            return "Deathmatch";
         }
         if(param1 == "o" || param1 == "obj" || param1 == Modes.obj)
         {
            return "Objective";
         }
         if(param1 == "h" || param1 == Modes.hat)
         {
            return "Hat Attack";
         }
         return "Race";
      }
   }
}
