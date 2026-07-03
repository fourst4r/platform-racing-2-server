package package_9
{
   import com.jiggmin.data.*;
   import flash.geom.Point;
   import package_6.*;
   import sounds.*;
   
   public class MineAppear extends Effect
   {
       
      
      private var m:MineAppearAnimation;
      
      public function MineAppear(param1:Number, param2:Number)
      {
         this.m = new MineAppearAnimation();
         rotation = Course.course.blockBackground.rotation;
         var _loc3_:Point = Data.method_9(param1,param2,-rotation);
         super(_loc3_.x,_loc3_.y);
         addChild(this.m);
         method_2(33);
         SoundEffects.playGameSound(new MineAppearSound(),_loc3_.x,_loc3_.y);
      }
      
      override public function remove() : *
      {
         var _loc1_:Point = null;
         if(Course.course != null)
         {
            _loc1_ = Data.method_9(x,y,Course.course.blockBackground.rotation);
            if(Course.course.blockBackground.getBlockFromPos(_loc1_.x,_loc1_.y) == null)
            {
               Course.course.blockBackground.placeBlock(Objects.BLOCK_MINE,_loc1_.x,_loc1_.y);
            }
         }
         this.m = null;
         super.remove();
      }
   }
}
