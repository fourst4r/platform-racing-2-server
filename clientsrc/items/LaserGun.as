package items
{
   import flash.geom.Point;
   import package_6.*;
   import package_8.LocalCharacter;
   import package_9.*;
   
   public class LaserGun extends Item
   {
       
      
      public function LaserGun(param1:LocalCharacter)
      {
         super(param1);
         setUses(3);
         setReloadTime(800);
      }
      
      override public function useItem() : *
      {
         character.curWeapon.gun.gotoAndPlay("shoot");
         var _loc1_:Point = method_37();
         var _loc2_:Number = 20;
         var _loc3_:* = "right";
         if(character.scaleX < 0)
         {
            _loc2_ = -_loc2_;
            character.velX += 15;
            _loc3_ = "left";
         }
         else
         {
            character.velX -= 15;
         }
         var _loc4_:int = _loc1_.x + _loc2_;
         var _loc5_:int = _loc1_.y;
         var _loc6_:int = int(Course.course.blockBackground.rotation);
         var _loc7_:LaserShot = new LaserShot(_loc4_,_loc5_,_loc3_,_loc6_,character.tempID);
         Main.socket.write("add_effect`Laser`" + _loc4_ + "`" + _loc5_ + "`" + _loc3_ + "`" + _loc6_ + "`" + character.tempID);
         super.useItem();
      }
   }
}
