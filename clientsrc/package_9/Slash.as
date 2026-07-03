package package_9
{
   import blocks.Block;
   import com.jiggmin.data.*;
   import flash.geom.Point;
   import package_6.*;
   import package_8.LocalCharacter;
   import sounds.*;
   
   public class Slash extends Effect
   {
       
      
      private var m:SlashAnimation;
      
      private var course:Course;
      
      private var character:LocalCharacter;
      
      private var var_154:int = 29;
      
      private var var_609:int;
      
      public function Slash(param1:int, param2:int, param3:String, param4:int)
      {
         this.m = new SlashAnimation();
         this.course = Course.course;
         this.character = Course.course.var_9;
         this.var_609 = param4;
         super(param1,param2);
         addChild(this.m);
         method_2(6);
         if(param3 == "left")
         {
            this.var_154 = -29;
            scaleX = -1;
         }
         this.method_66(x,y - 14);
         this.method_66(x,y + 14);
         this.method_66(x + this.var_154,y - 14);
         this.method_66(x + this.var_154,y + 14);
         this.method_66(x + this.var_154 * 2,y - 14);
         this.method_66(x + this.var_154 * 2,y + 14);
         SoundEffects.playGameSound(new SwishSound(),param1,param2);
      }
      
      private function method_66(param1:int, param2:int) : *
      {
         var _loc3_:Point = Data.method_9(param1,param2,this.course.blockBackground.rotation);
         var _loc4_:Block;
         if((_loc4_ = this.course.blockBackground.getBlockFromPos(_loc3_.x,_loc3_.y)) != null && _loc4_.isActive())
         {
            _loc4_.onDamage(this.var_154);
         }
         if(this.character != null && this.character.tempID != this.var_609 && this.character.y > param2 - 14 && this.character.y < param2 + 74)
         {
            if(this.character.x > param1 - 14 && this.character.x < param1 + 14)
            {
               this.character.hit(this.var_154,-9);
            }
         }
      }
      
      override public function remove() : *
      {
         removeChild(this.m);
         this.course = null;
         this.character = null;
         this.m = null;
         super.remove();
      }
   }
}
