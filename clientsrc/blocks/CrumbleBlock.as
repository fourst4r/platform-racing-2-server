package blocks
{
   import com.jiggmin.data.*;
   import flash.geom.Point;
   import package_8.*;
   import package_9.*;
   
   public class CrumbleBlock extends Block
   {
      private var life:int = 10;
      
      public function CrumbleBlock()
      {
         super(Objects.BLOCK_CRUMBLE);
         safeStand = false;
      }
      
      override public function onStand(param1:LocalCharacter) : *
      {
         var _loc2_:Number = Number(this.cheeseHandler(param1,Math.round(param1.velY * 2),true));
         localActivate(_loc2_.toString());
         if(!isRemoved())
         {
            super.onStand(param1);
         }
      }
      
      override public function onBump(param1:LocalCharacter) : *
      {
         var _loc2_:Number = Number(this.cheeseHandler(param1,Math.round(-param1.velY)));
         localActivate(_loc2_.toString());
         if(!isRemoved())
         {
            super.onBump(param1);
         }
      }
      
      override public function onLeftHit(param1:LocalCharacter) : *
      {
         var _loc3_:Point = null;
         var _loc4_:Block = null;
         var _loc5_:Block = null;
         var _loc2_:Number = Number(this.cheeseHandler(param1,Math.round(param1.velX * 1.75)));
         if(_loc2_ == 50)
         {
            _loc3_ = getSeg();
            if((_loc4_ = map.getBlockFromSeg(_loc3_.x - 1,_loc3_.y - 1)) == null && !param1.crouching)
            {
               if((_loc5_ = map.getBlockFromSeg(_loc3_.x,_loc3_.y - 1)) != null && _loc5_ is CrumbleBlock)
               {
                  _loc5_.localActivate("50");
               }
            }
         }
         localActivate(_loc2_.toString());
         if(!isRemoved())
         {
            super.onLeftHit(param1);
         }
      }
      
      override public function onRightHit(param1:LocalCharacter) : *
      {
         var _loc3_:Point = null;
         var _loc4_:Block = null;
         var _loc5_:Block = null;
         var _loc2_:Number = Number(this.cheeseHandler(param1,Math.round(-param1.velX * 1.75)));
         if(_loc2_ == 50)
         {
            _loc3_ = getSeg();
            if((_loc4_ = map.getBlockFromSeg(_loc3_.x + 1,_loc3_.y - 1)) == null && !param1.crouching)
            {
               if((_loc5_ = map.getBlockFromSeg(_loc3_.x,_loc3_.y - 1)) != null && _loc5_ is CrumbleBlock)
               {
                  _loc5_.localActivate("50");
               }
            }
         }
         localActivate(_loc2_.toString());
         if(!isRemoved())
         {
            super.onRightHit(param1);
         }
      }
      
      override public function onDamage(param1:Number) : *
      {
         super.onDamage(param1);
         localActivate("5");
      }
      
      override protected function activate(param1:String = "") : *
      {
         var _loc2_:* = Math.floor(Number(param1) / 4);
         this.life -= _loc2_;
         this.throwPieces(_loc2_ * 2);
         if(this.life <= 0)
         {
            this.doCrumble();
         }
      }
      
      private function cheeseHandler(param1:LocalCharacter, param2:Number, param3:Boolean = false) : *
      {
         if(param2 > 1 && param1.var_4.getBool(Character.CHEESE))
         {
            return param3 ? param2 * 2 : 50;
         }
         return param2;
      }
      
      private function doCrumble() : *
      {
         this.throwPieces(10);
         remove();
      }
      
      private function throwPieces(param1:Number) : *
      {
         var _loc4_:CrumblePieceGraphic = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:Point = method_18();
         param1 = param1 > 20 ? 20 : param1;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc5_ = Math.random() * 30 + _loc2_.x;
            _loc6_ = Math.random() * 30 + _loc2_.y;
            BlockPieceSystem.instance.spawn(CrumblePieceGraphic,_loc5_,_loc6_,0.75,0.95,0.05,5,5,15);
            _loc3_++;
         }
      }
   }
}
