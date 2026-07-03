package package_6
{
   import com.jiggmin.data.*;
   import flash.display.Sprite;
   
   public class Hearts extends Sprite
   {
       
      
      private var totalHearts:int = 0;
      
      private var yInc:int = 20;
      
      private var scale:Number = 0.2;
      
      public function Hearts()
      {
         super();
      }
      
      public function method_798(param1:int) : *
      {
         param1 = int(Data.numLimit(param1,0,15));
         while(this.totalHearts < param1)
         {
            this.addHeart();
         }
         while(this.totalHearts > param1)
         {
            this.removeHeart();
         }
      }
      
      public function method_758() : int
      {
         return this.totalHearts;
      }
      
      private function addHeart() : *
      {
         var _loc1_:HeartGraphic = null;
         _loc1_ = new HeartGraphic();
         _loc1_.scaleX = _loc1_.scaleY = this.scale;
         _loc1_.x = 0;
         _loc1_.y = this.totalHearts * this.yInc;
         addChild(_loc1_);
         ++this.totalHearts;
      }
      
      private function removeHeart() : *
      {
         removeChildAt(this.numChildren - 1);
         --this.totalHearts;
      }
      
      public function remove() : *
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}
