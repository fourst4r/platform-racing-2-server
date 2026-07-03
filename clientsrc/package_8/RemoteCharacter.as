package package_8
{
   import background.Map;
   import blocks.*;
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import package_6.*;
   import package_9.*;
   
   public class RemoteCharacter extends Character
   {
       
      
      private var var_19:Array;
      
      private var commandHandler:CommandHandler;
      
      private var mapDot:MiniMapDot;
      
       private var map:Map;
       
       private var var_180:Number = 1;

       private var reconnectPending:Boolean = false;
      
      private var posX:Number = 0;
      
      private var posY:Number = 0;
      
      private var lastX:Number = 0;
      
      private var lastY:Number = 0;
      
      private var rot:int = 0;
      
      private var rotMod:int = 0;
      
      private var var_189:Number = 10;
      
      private var var_325:Number = 55;
      
      public function RemoteCharacter(param1:int, param2:MiniMapDot, param3:String, param4:int, param5:int, param6:int, param7:int, param8:String = "0")
      {
         this.var_19 = new Array();
         this.commandHandler = CommandHandler.commandHandler;
         this.map = Course.course.blockBackground;
         super(param4,param5,param6,param7);
         this.tempID = param1;
         this.mapDot = param2;
         this.mapDot.setTempID(this.tempID);
         super.groupStr = param8;
         this.var_180 = var_448 + 1;
         super.userName = m.nameHolder.nameBox.text = m.nameHolder.nameBox2.text = param3;
         setNameColor(this.mapDot.getColor(this.tempID));
         this.applyReconnectPendingVisual();
         this.commandHandler.defineCommand("p" + this.tempID.toString(),this.pos);
         this.commandHandler.defineCommand("var" + this.tempID.toString(),this.method_801);
         this.commandHandler.defineCommand("exactPos" + this.tempID.toString(),this.method_667);
         this.commandHandler.defineCommand("setHats" + this.tempID.toString(),setHats);
         this.commandHandler.defineCommand("heart" + this.tempID,this.method_662);
         this.commandHandler.defineCommand("sting" + this.tempID,this.sting);
         addEventListener(Event.ENTER_FRAME,this.go,false,0,true);
      }
      
      private function go(param1:Event) : *
      {
         var _loc2_:int = 0;
         var _loc3_:Point = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:Point = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(this.var_19.length > 0)
         {
            this.var_180 -= 0.01;
            _loc2_ = 0;
            while(_loc2_ < this.var_19.length)
            {
               if((_loc5_ = this.var_19[_loc2_]).pos != null)
               {
                  _loc7_ = (_loc6_ = _loc5_.pos).x / (_loc2_ + 1);
                  _loc8_ = _loc6_.y / (_loc2_ + 1);
                  this.posX += _loc7_;
                  this.posY += _loc8_;
                  _loc6_.x -= _loc7_;
                  _loc6_.y -= _loc8_;
                  break;
               }
               _loc2_++;
            }
            _loc3_ = Data.method_9(this.posX,this.posY,-(this.map.rotation + this.rot));
            velX = this.lastX - x;
            velY = this.lastY - y;
            this.lastX = x;
            this.lastY = y;
            x = _loc3_.x;
            y = _loc3_.y;
            _loc3_ = Data.method_9(this.posX,this.posY,-this.rot);
            this.mapDot.x = _loc3_.x;
            this.mapDot.y = _loc3_.y;
            method_58(this.map.rotation);
            rotation = this.map.rotation + this.rot + this.rotMod;
            if((_loc4_ = this.var_19.shift()).state != null)
            {
               changeState(_loc4_.state);
            }
            if(_loc4_.scaleX != null)
            {
               this.setScaleX(int(_loc4_.scaleX));
            }
            if(_loc4_.parent != null)
            {
               if(Course.course[_loc4_.parent] != null)
               {
                  Sprite(Course.course[_loc4_.parent]).addChild(this);
               }
            }
            if(_loc4_.x != null)
            {
               this.posX = _loc4_.x;
               this.posY = _loc4_.y;
            }
            if(_loc4_.rotMod != null)
            {
               this.rotMod = int(_loc4_.rotMod);
            }
            if(_loc4_.rot != null)
            {
               this.rot = _loc4_.rot;
            }
            if(_loc4_.item != null)
            {
               setItem(_loc4_.item);
            }
            if(_loc4_.sparkle != null)
            {
               if(_loc4_.sparkle == "1")
               {
                  beginSparkles();
               }
               else
               {
                  endSparkles();
               }
            }
             if(_loc4_.jet != null)
             {
                if(_loc4_.jet == "1")
                {
                   beginJet();
               }
               else
               {
                   endJet();
                }
             }
             if(_loc4_.reconnectPending != null)
             {
                this.setReconnectPending(String(_loc4_.reconnectPending) == "1");
             }
             if(_loc4_.beginRemove != null)
             {
                beginRemove();
             }
            if(this.var_19.length > this.var_180)
            {
               this.go(new Event(Event.ENTER_FRAME));
            }
         }
         else
         {
            this.var_180 += 0.08;
         }
         if(this.var_180 > 10)
         {
            this.var_180 = 10;
         }
         this.method_76();
      }
      
      public function setScaleX(param1:Number) : *
      {
         scaleX = m.nameHolder.scaleX = param1;
      }
      
      public function setScaleY(param1:Number) : *
      {
      }
      
      public function pos(param1:Array) : *
      {
         var _loc2_:Point = param1[0] == "" ? new Point(0,0) : new Point(param1[0],param1[1]);
         var _loc3_:int = 1;
         while(_loc3_ < var_448)
         {
            this.var_19.push(new Object());
            _loc3_++;
         }
         var _loc4_:Object;
         (_loc4_ = new Object()).pos = _loc2_;
         this.var_19.push(_loc4_);
      }
      
      public function method_801(param1:Array) : *
      {
         var _loc2_:Object = null;
         var _loc3_:String = String(param1[0]);
         var _loc4_:String = String(param1[1]);
         if(this.var_19.length > 0)
         {
            if(this.var_19[this.var_19.length - 1][_loc3_] != null)
            {
               if(this.var_19.length >= 2)
               {
                  this.var_19[this.var_19.length - 2][_loc3_] = this.var_19[this.var_19.length - 1][_loc3_];
               }
            }
            this.var_19[this.var_19.length - 1][_loc3_] = _loc4_;
         }
         else
         {
            _loc2_ = new Object();
            _loc2_[_loc3_] = _loc4_;
            this.var_19.push(_loc2_);
         }
      }

      private function setReconnectPending(param1:Boolean) : *
      {
         if(this.reconnectPending == param1)
         {
            return;
         }
         this.reconnectPending = param1;
         this.applyReconnectPendingVisual();
      }

      private function applyReconnectPendingVisual() : *
      {
         var _loc1_:ColorTransform = null;
         if(this.reconnectPending)
         {
            _loc1_ = new ColorTransform(0.45,0.45,0.45,0.85,60,60,60,0);
         }
         else
         {
            _loc1_ = new ColorTransform();
         }
         transform.colorTransform = _loc1_;
         if(this.mapDot != null)
         {
            this.mapDot.transform.colorTransform = _loc1_;
         }
      }
      
      public function method_667(param1:Array) : *
      {
         var _loc2_:int = int(param1[0]);
         var _loc3_:int = int(param1[1]);
         if(this.var_19.length > 0)
         {
            this.var_19[this.var_19.length - 1].x = _loc2_;
            this.var_19[this.var_19.length - 1].y = _loc3_;
         }
         else
         {
            this.setPos(_loc2_,_loc3_);
         }
      }
      
      override public function setPos(param1:Number, param2:Number) : *
      {
         super.setPos(param1,param2);
         this.posX = param1;
         this.posY = param2;
         method_58(this.map.rotation);
      }
      
      private function sting(param1:Array) : *
      {
         var _loc2_:Character = Course.course.playerArray[param1[0]];
         if(_loc2_ == null || _loc2_.tempID == this.tempID)
         {
            return;
         }
         var _loc3_:int = int(_loc2_.getPos().x);
         var _loc4_:String = _loc3_ < x ? "left" : (_loc3_ > x ? "right" : "");
         new Sting(this,_loc4_);
      }
      
      private function method_76() : *
      {
         var _loc1_:Number = this.posX - this.lastX;
         var _loc2_:Number = this.posY - this.lastY;
         if(_loc2_ <= 0)
         {
            this.method_128(x,y - this.var_325 - 1);
         }
         if(_loc2_ >= 0)
         {
            this.method_128(x,y + 1);
         }
         if(_loc1_ >= 0)
         {
            this.method_128(x + this.var_189 + 1,y - 10);
         }
         if(_loc1_ <= 0)
         {
            this.method_128(x - this.var_189 - 1,y - 10);
         }
      }
      
      private function method_128(param1:int, param2:int) : *
      {
         var _loc4_:Block = null;
         var _loc3_:Point = Data.method_9(param1 / 30,param2 / 30,this.map.rotation);
         if(this.map.method_32(_loc3_.x,_loc3_.y))
         {
            if((_loc4_ = Block(this.map.getBlockFromSeg(_loc3_.x,_loc3_.y))) is ArrowBlock)
            {
               ArrowBlock(_loc4_).method_87();
            }
            if(_loc4_ is VanishBlock)
            {
               _loc4_.remoteActivate();
            }
            if(_loc4_ is WaterBlock)
            {
               WaterBlock(_loc4_).method_584();
            }
         }
      }
      
      public function method_662(param1:Array) : *
      {
         gainHeart();
      }
      
      override public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.go);
         if(this.commandHandler != null)
         {
            this.commandHandler.defineCommand("p" + tempID.toString(),null);
            this.commandHandler.defineCommand("var" + tempID.toString(),null);
            this.commandHandler.defineCommand("exactPos" + tempID.toString(),null);
            this.commandHandler.defineCommand("setHats" + tempID.toString(),null);
            this.commandHandler.defineCommand("heart" + tempID,null);
            this.commandHandler.defineCommand("sting" + this.tempID,null);
         }
         if(this.mapDot != null)
         {
            if(this.mapDot.parent != null)
            {
               this.mapDot.parent.removeChild(this.mapDot);
            }
            this.mapDot = null;
         }
         this.var_19 = null;
         this.map = null;
         this.commandHandler = null;
         super.remove();
      }
   }
}
