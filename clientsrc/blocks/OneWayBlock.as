package blocks
{
   import com.jiggmin.data.Data;
   import flash.geom.Point;
   import package_8.LocalCharacter;
   
   public class OneWayBlock extends Block
   {
      private var collisionFace:int;
      
      public function OneWayBlock(blockCode:int, collisionFace:int)
      {
         this.collisionFace = collisionFace;
         super(blockCode);
      }
      
      override public function collidesOnFace(character:LocalCharacter, face:int = -1) : Boolean
      {
         return face == this.getCollisionFace();
      }

      public function shouldPopOut(param1:LocalCharacter) : Boolean
      {
         var _loc2_:Point = this.getCharacterLocalPos(param1);
         return this.isInPopOutRange(_loc2_.x,_loc2_.y);
      }

      public function shouldResolveCollision(param1:LocalCharacter) : Boolean
      {
         var _loc2_:Point = this.getCharacterLocalPos(param1);
         if(this.collisionFace == FACE_TOP && _loc2_.y < 0)
         {
            return true;
         }
         if(this.collisionFace == FACE_RIGHT && _loc2_.x > 30)
         {
            return true;
         }
         if(this.collisionFace == FACE_BOTTOM && _loc2_.y > 30)
         {
            return true;
         }
         if(this.collisionFace == FACE_LEFT && _loc2_.x < 0)
         {
            return true;
         }
         return this.isInPopOutRange(_loc2_.x,_loc2_.y);
      }

      private function getCharacterLocalPos(param1:LocalCharacter) : Point
      {
         var _loc2_:Point = Data.method_9(param1.x,param1.y,this.map.rotation);
         var _loc3_:Point = this.getPos();
         _loc2_.x -= _loc3_.x;
         _loc2_.y -= _loc3_.y;
         return _loc2_;
      }

      private function isInPopOutRange(param1:Number, param2:Number) : Boolean
      {
         // Allow 25px of travel from the non-colliding face before triggering.
         if(this.collisionFace == FACE_TOP)
         {
            return param2 >= 0 && param2 <= 5;
         }
         if(this.collisionFace == FACE_RIGHT)
         {
            return param1 >= 25 && param1 <= 30;
         }
         if(this.collisionFace == FACE_BOTTOM)
         {
            return param2 >= 25 && param2 <= 30;
         }
         return param1 >= 0 && param1 <= 5;
      }
      
      private function getCollisionFace() : int
      {
         if(map == null)
         {
            return this.collisionFace;
         }
         if(map.rotation == 90)
         {
            if(this.collisionFace == FACE_TOP)
            {
               return FACE_RIGHT;
            }
            if(this.collisionFace == FACE_RIGHT)
            {
               return FACE_BOTTOM;
            }
            if(this.collisionFace == FACE_BOTTOM)
            {
               return FACE_LEFT;
            }
            return FACE_TOP;
         }
         if(map.rotation == -90)
         {
            if(this.collisionFace == FACE_TOP)
            {
               return FACE_LEFT;
            }
            if(this.collisionFace == FACE_LEFT)
            {
               return FACE_BOTTOM;
            }
            if(this.collisionFace == FACE_BOTTOM)
            {
               return FACE_RIGHT;
            }
            return FACE_TOP;
         }
         if(Math.abs(map.rotation) == 180)
         {
            if(this.collisionFace == FACE_TOP)
            {
               return FACE_BOTTOM;
            }
            if(this.collisionFace == FACE_RIGHT)
            {
               return FACE_LEFT;
            }
            if(this.collisionFace == FACE_BOTTOM)
            {
               return FACE_TOP;
            }
            return FACE_RIGHT;
         }
         return this.collisionFace;
      }
   }
}
