package items
{
   import package_8.LocalCharacter;
   
   public class Items
   {
      
      public static const laserGun:int = 1;
      
      public static const mine:int = 2;
      
      public static const lightning:int = 3;
      
      public static const teleport:int = 4;
      
      public static const superJump:int = 5;
      
      public static const jetPack:int = 6;
      
      public static const speedBurst:int = 7;
      
      public static const sword:int = 8;
      
      public static const iceWave:int = 9;
       
      
      public function Items()
      {
         super();
      }
      
      public static function getAllCodes() : Vector.<int>
      {
         return new <int>[laserGun,mine,lightning,teleport,superJump,jetPack,speedBurst,sword,iceWave];
      }
      
      public static function getFromCode(param1:int, param2:LocalCharacter) : Item
      {
         if(param1 == laserGun)
         {
            return new LaserGun(param2);
         }
         if(param1 == mine)
         {
            return new Mine(param2);
         }
         if(param1 == lightning)
         {
            return new Lightning(param2);
         }
         if(param1 == teleport)
         {
            return new Teleport(param2);
         }
         if(param1 == superJump)
         {
            return new SuperJump(param2);
         }
         if(param1 == jetPack)
         {
            return new JetPack(param2);
         }
         if(param1 == speedBurst)
         {
            return new SpeedBurst(param2);
         }
         if(param1 == sword)
         {
            return new Sword(param2);
         }
         if(param1 == iceWave)
         {
            return new IceWave(param2);
         }
         return null;
      }
      
      public static function getCodeFromItem(param1:Item) : int
      {
         if(param1 is LaserGun)
         {
            return laserGun;
         }
         if(param1 is Mine)
         {
            return mine;
         }
         if(param1 is Lightning)
         {
            return lightning;
         }
         if(param1 is Teleport)
         {
            return teleport;
         }
         if(param1 is SuperJump)
         {
            return superJump;
         }
         if(param1 is JetPack)
         {
            return jetPack;
         }
         if(param1 is SpeedBurst)
         {
            return speedBurst;
         }
         if(param1 is Sword)
         {
            return sword;
         }
         if(param1 is IceWave)
         {
            return iceWave;
         }
         return 0;
      }
      
      public static function getNameFromCode(param1:int) : String
      {
         if(param1 == laserGun)
         {
            return "Laser";
         }
         if(param1 == mine)
         {
            return "Mine";
         }
         if(param1 == lightning)
         {
            return "Lightning";
         }
         if(param1 == teleport)
         {
            return "Teleport";
         }
         if(param1 == superJump)
         {
            return "Super Jump";
         }
         if(param1 == jetPack)
         {
            return "Jet Pack";
         }
         if(param1 == speedBurst)
         {
            return "Speed Burst";
         }
         if(param1 == sword)
         {
            return "Sword";
         }
         if(param1 == iceWave)
         {
            return "Ice Wave";
         }
         return "None";
      }
      
      public static function getCodeFromName(param1:String) : int
      {
         if(param1 == "Laser" || param1 == "Laser Gun")
         {
            return laserGun;
         }
         if(param1 == "Mine")
         {
            return mine;
         }
         if(param1 == "Lightning")
         {
            return lightning;
         }
         if(param1 == "Teleport")
         {
            return teleport;
         }
         if(param1 == "Super Jump")
         {
            return superJump;
         }
         if(param1 == "Jet Pack")
         {
            return jetPack;
         }
         if(param1 == "Speed Burst")
         {
            return speedBurst;
         }
         if(param1 == "Sword")
         {
            return sword;
         }
         if(param1 == "Ice Wave")
         {
            return iceWave;
         }
         return 0;
      }
   }
}
