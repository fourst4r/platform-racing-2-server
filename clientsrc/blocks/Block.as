package blocks
{
   import background.Map;
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import package_8.*;
   import sounds.*;
   
   public class Block extends Sprite
   {
      public static const FACE_ANY:int = -1;
      
      public static const FACE_TOP:int = 0;
      
      public static const FACE_RIGHT:int = 1;
      
      public static const FACE_BOTTOM:int = 2;
      
      public static const FACE_LEFT:int = 3;
       
      
      private var size:Number = 30;
      
      private var posX:Number;
      
      private var posY:Number;
      
      private var segX:int;
      
      private var segY:int;
      
      private var removed:Boolean = false;
      
      private var var_177:Point;
      
      private var m:Bitmap;
      
      protected var blockCode:int = 0;
      
      protected var active:Boolean = true;
      
      protected var safeStand:Boolean = true;
      
      protected var var_490:Boolean = true;
      
      protected var map:Map;
      
      protected var frozen:Boolean = false;
      
      protected var optionsMenu:Class = null;
      
      private var _options:String = "";
      
      private var var_110:Bitmap;
      
      private var var_455:Number = 0.1;
      
      private var var_600:int = 0;
      
      public function Block(param1:int)
      {
         super();
         var _loc2_:BitmapData = Blocks.getBlock(param1);
         this.m = new Bitmap(_loc2_,PixelSnapping.ALWAYS,false);
         addChild(this.m);
      }
      
      public function initialize(param1:int, param2:int, param3:Map) : *
      {
         this.map = param3;
         this.setSeg(param1,param2);
         this.map.addToBlockArray(this,param1,param2);
      }
      
      public function isInitialized() : Boolean
      {
         return this.map != null;
      }
      
      public function get hasOptions() : Boolean
      {
         return this.optionsMenu != null;
      }
      
      public function openOptions() : *
      {
         new this.optionsMenu(this);
      }
      
      public function get options() : *
      {
         return this._options;
      }
      
      public function set options(param1:String) : *
      {
         if(this.hasOptions && param1 != this._options)
         {
            this._options = param1;
         }
      }
      
      public function getSeg() : Point
      {
         return new Point(this.segX,this.segY);
      }
      
      public function getPos() : Point
      {
         return new Point(this.posX,this.posY);
      }
      
      public function getPosX() : int
      {
         return this.posX;
      }
      
      public function getPosY() : int
      {
         return this.posY;
      }
      
      public function getCode() : int
      {
         return !!this.frozen ? int(Objects.BLOCK_ICE) : int(this.blockCode);
      }
      
      public function isActive() : Boolean
      {
         return !!this.frozen ? true : Boolean(this.active);
      }
      
      public function isRemoved() : Boolean
      {
         return this.removed;
      }
      
      public function method_18(param1:Number = NaN) : Point
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(isNaN(param1))
         {
            param1 = Number(this.map.rotation);
         }
         if(param1 == 90)
         {
            _loc3_ = 30;
         }
         else if(Math.abs(param1) == 180)
         {
            _loc2_ = _loc3_ = 30;
         }
         else if(param1 == -90)
         {
            _loc2_ = 30;
         }
         return Data.method_9(this.posX + _loc2_,this.posY + _loc3_,-param1);
      }
      
      public function method_777() : int
      {
         return Data.getTimestamp() - this.var_600;
      }
      
      public function setSeg(param1:int, param2:int) : *
      {
         this.segX = param1;
         this.segY = param2;
         this.setPos(param1 * this.size,param2 * this.size);
      }
      
      public function setPos(param1:Number, param2:Number) : *
      {
         this.posX = param1;
         this.posY = param2;
         x = param1;
         y = param2;
      }
      
      public function freeze(param1:Boolean = false) : *
      {
         if(!this.frozen)
         {
            this.frozen = true;
            this.var_600 = Data.getTimestamp();
            this.var_110 = new Bitmap(Blocks.iceBitmap);
            addChild(this.var_110);
            if(param1)
            {
               this.var_110.alpha = 1.75;
               this.var_455 = 0.01;
            }
            else
            {
               this.var_110.alpha = 1;
               this.var_455 = 0.025;
            }
            addEventListener(Event.ENTER_FRAME,this.method_153,false,0,true);
         }
      }
      
      public function onStand(param1:LocalCharacter) : *
      {
         var _loc2_:Point = null;
         if(!this.frozen && this.method_777() > 4 && param1.var_4.getBool(Character.SANTA) && this.blockCode != Objects.BLOCK_FINISH && this.blockCode != Objects.BLOCK_ICE && this.blockCode != Objects.BLOCK_VANISH && this.blockCode != Objects.BLOCK_CRUMBLE && this.blockCode != Objects.BLOCK_ARROW_UP && this.blockCode != Objects.BLOCK_ARROW_LEFT && this.blockCode != Objects.BLOCK_ARROW_RIGHT && this.blockCode != Objects.BLOCK_ARROW_DOWN && this.blockCode != Objects.BLOCK_MOVE)
         {
            this.freeze();
         }
         if(this.frozen)
         {
            param1.traction = 0.05;
         }
         if(this.isActive())
         {
            _loc2_ = this.method_18();
            param1.y = _loc2_.y + this.posY - y;
            param1.velY = 0;
            param1.grounded = true;
            if(this.safeStand)
            {
               param1.lastSafeX = _loc2_.x + 15;
               param1.lastSafeY = _loc2_.y;
               param1.var_407 = this.segX;
               param1.var_366 = this.segY;
            }
         }
         else
         {
            param1.grounded = false;
         }
      }
      
      public function onBump(param1:LocalCharacter) : *
      {
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         if(this.isActive())
         {
            _loc2_ = this.method_18();
            _loc3_ = Data.method_9(x - this.posX,y - this.posY,this.map.rotation);
            if(param1.crouching)
            {
               param1.y = _loc2_.y + this.size + _loc3_.y + param1.var_325 / 2;
            }
            else
            {
               param1.y = _loc2_.y + this.size + _loc3_.y + param1.var_325;
            }
            param1.velY *= -0.25;
            param1.var_4.setNumber(LocalCharacter.const_12,0);
            if(this.var_490)
            {
               this.method_315(0,-15);
            }
         }
      }
      
      public function onLeftHit(param1:LocalCharacter) : *
      {
         var _loc2_:Point = null;
         if(this.isActive())
         {
            _loc2_ = this.method_18();
            param1.x = _loc2_.x - param1.var_189;
            if(param1.velX > 0)
            {
               param1.velX *= -0.05;
            }
            if(param1.targetVelX > 0)
            {
               param1.targetVelX = 0;
            }
         }
      }
      
      public function onRightHit(param1:LocalCharacter) : *
      {
         var _loc2_:Point = null;
         if(this.isActive())
         {
            _loc2_ = this.method_18();
            param1.x = _loc2_.x + this.size + param1.var_189;
            if(param1.velX < 0)
            {
               param1.velX *= -0.05;
            }
            if(param1.targetVelX < 0)
            {
               param1.targetVelX = 0;
            }
         }
      }
      
      public function collidesOnFace(character:LocalCharacter, face:int = -1) : Boolean
      {
         return true;
      }
      
      public function onTouch(param1:LocalCharacter) : *
      {
      }
      
      public function onDamage(param1:Number) : *
      {
         param1 = Number(Data.numLimit(param1,-20,20));
         this.method_315(param1,0);
      }
      
      public function remoteActivate(param1:String = "") : *
      {
         this.activate(param1);
      }
      
      protected function localActivate(param1:String = "") : *
      {
         Main.socket.write("activate`" + this.segX + "`" + this.segY + "`" + param1);
         this.activate(param1);
      }
      
      protected function activate(param1:String = "") : *
      {
      }
      
      public function method_839(param1:Array) : *
      {
         var _loc2_:Number = Number(param1[0]);
         var _loc3_:Number = Number(param1[1]);
         this.hit(_loc2_,_loc3_);
      }
      
      private function method_315(param1:Number, param2:Number) : *
      {
         var _loc3_:Point = Data.method_9(param1,param2,this.map.rotation);
         this.hit(_loc3_.x,_loc3_.y);
      }
      
      private function hit(param1:Number, param2:Number) : *
      {
         var _loc4_:Point = null;
         this.var_177 = new Point(param1,param2);
         addEventListener(Event.ENTER_FRAME,this.method_161);
         var _loc3_:Number = Data.pythag(param1,param2) * 0.06;
         if(Math.abs(x - this.posX) < 1 && Math.abs(y - this.posY) < 1)
         {
            _loc4_ = this.method_18();
            SoundEffects.playGameSound(new ThumpSound(),_loc4_.x,_loc4_.y,_loc3_);
         }
      }
      
      private function method_153(param1:Event) : *
      {
         if(this.var_110 != null)
         {
            this.var_110.alpha -= this.var_455;
            if(this.var_110.alpha <= 0.05)
            {
               removeEventListener(Event.ENTER_FRAME,this.method_153);
               this.method_406();
               this.frozen = false;
            }
         }
      }
      
      private function method_161(param1:Event) : *
      {
         this.var_177.x *= 0.5;
         this.var_177.y *= 0.5;
         y += this.var_177.y;
         y += (this.posY - y) * 0.35;
         x += this.var_177.x;
         x += (this.posX - x) * 0.35;
         if(Math.abs(this.posY - y) < 0.25 && Math.abs(this.posY - x) < 0.25)
         {
            y = this.posY;
            x = this.posX;
            removeEventListener(Event.ENTER_FRAME,this.method_161);
         }
      }
      
      protected function move(param1:int, param2:int, param3:Map, ignorePlayers:Boolean = false) : *
      {
         if(this.map == null)
         {
            this.map = param3;
         }
         var _loc4_:Point = new Point(this.segX,this.segY);
         var _loc5_:Point = new Point(this.segX + param1,this.segY + param2);
         var _loc6_:Block;
         if((_loc6_ = this.map.getBlockFromSeg(_loc5_.x,_loc5_.y)) is PushBlock)
         {
            _loc6_.move(param1,param2,param3, ignorePlayers);
         }
         this.map.moveBlock(_loc4_,_loc5_, ignorePlayers);
      }
      
      private function method_406() : *
      {
         if(this.var_110 != null)
         {
            removeChild(this.var_110);
            this.var_110 = null;
         }
      }
      
      public function remove() : *
      {
         this.removed = true;
         this.active = false;
         removeEventListener(Event.ENTER_FRAME,this.method_153);
         removeEventListener(Event.ENTER_FRAME,this.method_161);
         this.map.removeBlock(this);
         this.map = null;
         this.method_406();
         this.var_177 = null;
         if(this.m != null)
         {
            removeChild(this.m);
            this.m.bitmapData = null;
            this.m = null;
         }
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}
