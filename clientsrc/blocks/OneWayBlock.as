package blocks
{
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
