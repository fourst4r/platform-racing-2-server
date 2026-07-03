package package_9
{
   import background.*;
   import com.jiggmin.data.*;
   import flash.events.Event;
   import flash.geom.*;
   import flash.utils.*;
   import package_6.*;
   import sounds.*;
   
   public class Egg extends class_81
   {
      
      private static var var_406:int = 0;
      
      private static var var_466:int = 1;
      
      private static var var_474:int = 2;
      
      private static var var_491:int = 3;
      
      private static var rand:Random = new Random(1);
      
      private static var var_223:int = 1;
      
      private static var mode:int = 3;
       
      
      private var var_486:int;
      
      private var m:EggGraphic;
      
      private var scale:Number = 0.12;
      
      private var maxX:int;
      
      private var minX:int;
      
      private var maxY:int;
      
      private var minY:int;
      
      private var var_286:int = 0;
      
      private var id:int;
      
      private var var_382:int = 0;
      
      public function Egg()
      {
         this.m = new EggGraphic();
         addChild(this.m);
         alpha = 0;
         this.id = var_223++;
         CommandHandler.commandHandler.defineCommand("removeEgg" + this.id,this.method_744);
         var _loc1_:Map = Course.course.blockBackground;
         var _loc2_:int = int(rand.nextMinMax(Math.min(_loc1_.minX,_loc1_.maxX),Math.max(_loc1_.minX,_loc1_.maxX)));
         var _loc3_:int = int(rand.nextMinMax(Math.min(_loc1_.minY,_loc1_.maxY),Math.max(_loc1_.minY,_loc1_.maxY)));
         var _loc4_:int = rand.nextMinMax(-1,3) * 90;
         var _loc5_:Point = Data.method_9(_loc2_,_loc3_,-_loc4_);
         super(_loc5_.x,_loc5_.y,_loc4_);
         this.setLimits();
         velX = rand.nextMinMax(0,2) == 1 ? 1 : -1;
         var _loc6_:ColorTransform;
         (_loc6_ = new ColorTransform()).color = Math.floor(Math.random() * 16777215);
         var _loc7_:ColorTransform;
         (_loc7_ = new ColorTransform()).color = Math.floor(Math.random() * 16777215);
         var _loc8_:ColorTransform;
         (_loc8_ = new ColorTransform()).color = Math.floor(Math.random() * 16777215);
         scaleX = scaleY = this.scale;
         this.m.var_165.gotoAndStop(1);
         this.m.var_152.gotoAndStop(1);
         this.m.var_165.colorMC.gotoAndStop(1);
         this.m.var_152.colorMC.gotoAndStop(1);
         this.m.var_165.colorMC2.gotoAndStop(1);
         this.m.var_152.colorMC2.gotoAndStop(1);
         this.m.var_165.colorMC2.visible = false;
         this.m.var_152.colorMC2.visible = false;
         this.m.var_165.colorMC.transform.colorTransform = _loc6_;
         this.m.var_152.colorMC.transform.colorTransform = _loc6_;
         this.m.egg.base.transform.colorTransform = _loc7_;
         this.m.egg.dots.transform.colorTransform = _loc8_;
      }
      
      public static function method_333(param1:int) : *
      {
         rand = new Random(param1);
         var_223 = 1;
         mode = rand.nextMinMax(0,5);
         if(mode > 3)
         {
            mode = 3;
         }
      }
      
      public function setLimits() : *
      {
         var _loc1_:int = 0;
         var _loc2_:Map = Course.course.blockBackground;
         this.maxX = _loc2_.maxX + 300;
         this.minX = _loc2_.minX - 300;
         this.maxY = _loc2_.maxY + 300;
         this.minY = _loc2_.minY - 300;
         var _loc3_:Point = Data.method_9(this.minX,this.minY,-rot);
         var _loc4_:Point = Data.method_9(this.maxX,this.maxY,-rot);
         this.maxX = _loc4_.x;
         this.maxY = _loc4_.y;
         this.minX = _loc3_.x;
         this.minY = _loc3_.y;
         if(this.maxX < this.minX)
         {
            _loc1_ = int(this.maxX);
            this.maxX = this.minX;
            this.minX = _loc1_;
         }
         if(this.maxY < this.minY)
         {
            _loc1_ = int(this.maxY);
            this.maxY = this.minY;
            this.minY = _loc1_;
         }
      }
      
      private function method_723() : *
      {
         if(posX > this.maxX)
         {
            posX = this.minX;
         }
         if(posX < this.minX)
         {
            posX = this.maxX;
         }
         if(posY > this.maxY)
         {
            posY = this.minY;
         }
         if(posY < this.minY)
         {
            posY = this.maxY;
         }
      }
      
      override protected function go(param1:Event) : *
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Slash = null;
         var _loc10_:LaserShot = null;
         super.go(param1);
         if(velX > 0)
         {
            scaleX = this.scale;
         }
         else
         {
            scaleX = -this.scale;
         }
         if(Course.course.gameMode == "egg")
         {
            this.method_723();
         }
         if(this.var_286 > 0)
         {
            --this.var_286;
         }
         if(alpha < 1)
         {
            alpha += 0.02;
         }
         var _loc11_:int = posX + (velX * (Math.random() * 100) + 50);
         var _loc12_:int = posY;
         var _loc13_:Point = Data.method_9(_loc11_,_loc12_,-rotation);
         if(this.var_382 <= 0 && method_181(_loc13_.x,_loc13_.y))
         {
            this.var_382 = 120;
            _loc2_ = 0;
            _loc3_ = "right";
            _loc4_ = -1;
            _loc6_ = posX;
            _loc7_ = posY - 10;
            if(scaleX < 0)
            {
               _loc2_ = 180;
               _loc3_ = "left";
            }
            _loc8_ = -1;
            if(mode == var_491)
            {
               _loc8_ = Math.random();
            }
            if(mode == var_406 || _loc8_ > 0.66)
            {
               _loc5_ = "IceWave`" + _loc6_ + "`" + _loc7_ + "`" + _loc2_ + "`" + rot + "`" + _loc4_;
               EffectBackground.instance.addEffect(_loc5_.split("`"));
            }
            else if(mode == var_466 || _loc8_ > 0.33)
            {
               _loc9_ = new Slash(_loc6_,_loc7_,_loc3_,_loc4_);
               _loc5_ = "Slash`" + _loc6_ + "`" + _loc7_ + "`" + _loc3_ + "`" + _loc4_;
            }
            else if(mode == var_474 || _loc8_ > 0)
            {
               _loc10_ = new LaserShot(_loc6_,_loc7_,_loc3_,rot,_loc4_);
               _loc5_ = "Laser`" + _loc6_ + "`" + _loc7_ + "`" + _loc3_ + "`" + rot + "`" + _loc4_;
            }
            Main.socket.write("add_effect`" + _loc5_);
         }
         else
         {
            --this.var_382;
         }
      }
      
      override protected function onTouchLocalPlayer() : *
      {
         this.beginRemove();
         SoundEffects.playGameSound(new CollectEggSound(),x,y,1.5);
         Course.course.collectEgg(this.id);
      }
      
      public function method_744(param1:Array) : *
      {
         this.remove();
      }
      
      override protected function onTouchWall() : *
      {
         if(method_311())
         {
            if(this.var_286 > 0)
            {
               posY -= 30;
            }
            this.var_286 = 2;
            velX *= -1;
         }
      }
      
      public function beginRemove() : *
      {
         method_205();
         this.m.gotoAndPlay("squash");
         clearTimeout(this.var_486);
         this.var_486 = setTimeout(this.remove,1000);
      }
      
      override public function remove() : *
      {
         super.remove();
         clearTimeout(this.var_486);
         CommandHandler.commandHandler.defineCommand("removeEgg" + this.id,null);
      }
   }
}
