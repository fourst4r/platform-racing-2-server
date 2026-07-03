package package_9
{
   import blocks.*;
   import com.jiggmin.data.*;
   import package_8.*;
   
   public class IceWaveShot extends ShotEffect
   {
      
      private static var var_168:int = 0;
       
      
      private var m:IceWaveGraphic;
      
      private var var_322:Number;
      
      private var var_278:Number;
      
      public function IceWaveShot(param1:Number, param2:Number, param3:Number, param4:int, param5:int, param6:Number, param7:int = 75)
      {
         this.m = new IceWaveGraphic();
         ++var_168;
         super(param1,param2,param3,param4,param5,"ice");
         var_493 = true;
         this.life = param7;
         this.var_278 = param3;
         this.var_322 = param6;
         addChild(this.m);
         this.method_219();
      }
      
      private function method_219() : *
      {
         if(!isRemoved())
         {
            method_62(30);
            this.move();
            method_62(5);
         }
      }
      
      override protected function move() : *
      {
         super.move();
         alpha = Math.random() * life / 100 + 0.25;
      }
      
      override protected function hitBlock(param1:Block) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(!(param1 is IceBlock) && param1.getCode() != Objects.BLOCK_ICE)
         {
            param1.freeze(true);
            if(var_168 < 10 && life > 10)
            {
               _loc2_ = this.var_322 - 60;
               _loc3_ = this.var_322 + 60;
               _loc4_ = Number(Data.numLimit(this.var_278 + 30,_loc2_,_loc3_));
               _loc5_ = Number(Data.numLimit(this.var_278 - 30,_loc2_,_loc3_));
               if(_loc4_ != this.var_278)
               {
                  new IceWaveShot(x,y,_loc4_,var_377,shooterID,this.var_322,life / 2);
               }
               if(_loc5_ != this.var_278)
               {
                  new IceWaveShot(x,y,_loc5_,var_377,shooterID,this.var_322,life / 2);
               }
               life -= 5;
               this.method_219();
            }
         }
      }
      
      override protected function hitPlayer(param1:Character) : *
      {
         var _loc2_:LocalCharacter = null;
         if(param1 is LocalCharacter)
         {
            _loc2_ = LocalCharacter(param1);
            if(!_loc2_.isFrozen())
            {
               _loc2_.freeze();
            }
         }
      }
      
      override public function remove() : *
      {
         --var_168;
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
