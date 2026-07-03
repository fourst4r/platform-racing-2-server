package items
{
   import background.*;
   import flash.geom.Point;
   import package_6.*;
   import package_8.LocalCharacter;
   
   public class IceWave extends Item
   {
       
      
      public function IceWave(param1:LocalCharacter)
      {
         super(param1);
         setUses(3);
         setReloadTime(1000);
      }
      
      override public function useItem() : *
      {
         character.curWeapon.freezeWave.gotoAndPlay("fire");
         var _loc1_:Point = method_37();
         var _loc2_:Number = 20;
         var _loc3_:Number = 0;
         if(character.scaleX < 0)
         {
            _loc3_ = 180;
            _loc2_ = -_loc2_;
         }
         var _loc4_:int = _loc1_.x + _loc2_;
         var _loc5_:int = _loc1_.y;
         var _loc6_:int = int(Course.course.blockBackground.rotation);
         var _loc7_:String = "IceWave`" + _loc4_ + "`" + _loc5_ + "`" + _loc3_ + "`" + _loc6_ + "`" + character.tempID;
         EffectBackground.instance.addEffect(_loc7_.split("`"));
         Main.socket.write("add_effect`" + _loc7_);
         super.useItem();
      }
   }
}
