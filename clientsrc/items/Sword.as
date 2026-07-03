package items
{
   import flash.geom.Point;
   import package_8.LocalCharacter;
   import package_9.*;
   
   public class Sword extends Item
   {
       
      
      public function Sword(param1:LocalCharacter)
      {
         super(param1);
         setUses(3);
         setReloadTime(800);
      }
      
      override public function useItem() : *
      {
         var _loc1_:String = "left";
         if(character.scaleX > 0)
         {
            _loc1_ = "right";
            character.velX += 8;
         }
         else
         {
            character.velX -= 8;
         }
         character.curWeapon.sword.gotoAndPlay("swing");
         var _loc2_:Point = method_37();
         var _loc3_:int = _loc2_.x;
         var _loc4_:int = _loc2_.y;
         var _loc5_:Slash = new Slash(_loc3_,_loc4_,_loc1_,character.tempID);
         Main.socket.write("add_effect`Slash`" + _loc3_ + "`" + _loc4_ + "`" + _loc1_ + "`" + character.tempID);
         super.useItem();
      }
   }
}
