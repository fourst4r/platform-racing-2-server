package blocks
{
   import package_8.LocalCharacter;
   
   public class ArrowBlock extends Block
   {
       
      
      private var arrowMC:ArrowBlockGraphic;
      
      private var rot:Number;
      
      public function ArrowBlock(param1:int, param2:Number)
      {
         this.arrowMC = new ArrowBlockGraphic();
         this.rot = param2;
         super(param1);
         var_490 = false;
         this.arrowMC.rotation = this.rot;
         this.arrowMC.x = this.arrowMC.y = 15;
         addChild(this.arrowMC);
      }
      
      override public function getCode() : int
      {
         return this.blockCode;
      }
      
      override public function onStand(param1:LocalCharacter) : *
      {
         super.onStand(param1);
         var _loc2_:Number = Number(this.method_125());
         if(_loc2_ == 0 && !param1.crouching)
         {
            param1.velY -= 10;
         }
         else
         {
            this.push(param1,_loc2_);
         }
         this.method_87();
      }
      
      override public function onBump(param1:LocalCharacter) : *
      {
         super.onBump(param1);
         var _loc2_:Number = Number(this.method_125());
         if(_loc2_ == 0)
         {
            param1.velY = param1.down == false && param1.crouching == false ? -14 : 0;
         }
         else
         {
            this.push(param1,_loc2_);
         }
         this.method_87();
      }
      
      override public function onLeftHit(param1:LocalCharacter) : *
      {
         super.onLeftHit(param1);
         var _loc2_:Number = Number(this.method_125());
         this.push(param1,_loc2_);
         this.method_87();
      }
      
      override public function onRightHit(param1:LocalCharacter) : *
      {
         super.onRightHit(param1);
         var _loc2_:Number = Number(this.method_125());
         this.push(param1,_loc2_);
         this.method_87();
      }
      
      public function method_87() : *
      {
         if(this.arrowMC.currentFrame < 5)
         {
            this.arrowMC.gotoAndPlay(this.arrowMC.currentFrame + 1);
         }
         else if(this.arrowMC.currentFrame > 5)
         {
            this.arrowMC.gotoAndPlay(this.arrowMC.currentFrame - 1);
         }
      }
      
      private function method_125() : Number
      {
         var _loc1_:Number = map.rotation + this.rot;
         rotation = _loc1_;
         _loc1_ = rotation;
         rotation = 0;
         return _loc1_;
      }
      
      private function push(param1:LocalCharacter, param2:Number) : *
      {
         if(param2 == 0 && param1.crouching == false)
         {
            param1.velY -= 1.2;
         }
         if(param2 == 180 || param2 == -180)
         {
            param1.velY += 5;
         }
         if(param2 == -90)
         {
            param1.velX -= 3;
         }
         if(param2 == 90)
         {
            param1.velX += 3;
         }
      }
      
      override public function remove() : *
      {
         if(this.arrowMC.parent != null)
         {
            this.arrowMC.parent.removeChild(this.arrowMC);
            this.arrowMC = null;
         }
         super.remove();
      }
   }
}
