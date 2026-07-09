package package_8
{
   import background.Map;
   import blocks.*;
   import com.jiggmin.data.*;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.geom.*;
   import flash.ui.*;
   import flash.utils.*;
   import items.*;
   import package_6.*;
   import package_9.*;
   import page.*;
   import sounds.*;
   
   public class LocalCharacter extends Character
   {
      
      public static const const_12:String = "njv";
      
      public static const SuperJump:String = "nj";
      
      public static const DefaultGravity:String = "gr";
      
      public static const GravityMultiplied:String = "grm";
       
      
      private var socket:PR2Socket;
      
      private var cm:CommandHandler;
      
      private var course:Course;
      
      private var map:Map;
      
      private var mapDot:MiniMapDot;
      
      private var itemDisplay:ItemDisplay;
      
      private var var_573:uint;
      
      private var var_535:uint;
      
      private var var_390:DisplayObject;
      
      private var speedStat:int;
      
      private var accelStat:int;
      
      private var jumpnStat:int;
      
      public var accel:Number;
      
      public var maxVelX:Number;
      
      public var targetVelX:Number = 0;
      
      public var var_669:Number = 0;
      
      private var var_523:Number = 0.35;
      
      private var var_599:Number = 1;
      
      public var traction:Number;
      
      public var var_524:Number;
      
      public var var_189:Number = 10;
      
      public var var_325:Number = 55;
      
      public var lastSafeX:Number = 0;
      
      public var lastSafeY:Number = 0;
      
      public var var_407:int;
      
      public var var_366:int;
      
      public var var_157:Number = 28;
      
      private var initialized:Boolean = false;
      
      public var testMode:Boolean = false;
      
      public var grounded:Boolean = false;
      
      public var crouching:Boolean = false;
      
      public var up:Boolean = false;
      
      public var down:Boolean = false;
      
      public var right:Boolean = false;
      
      public var left:Boolean = false;
      
      public var space:Boolean = false;
      
      private var friction:Number = 0.985;
      
      private var var_281:Boolean = false;
      
      private var var_150:Number = 0;
      
      private var segSize:Number = 30;
      
      private var hurtTime:Number = 0;
      
      private var squashedTime:Number = 0;
      
      private var stingCooldown:int = 135;
      
      public var var_240:Number = 0;
      
      private var var_630:Block = null;
      
      private var var_469:Block = null;
      
      private var var_657:Block = null;
      
      private var var_329:Block = null;
      
      private var var_658:Block = null;
      
      private var var_296:Block = null;
      
      private var var_654:Block = null;
      
      private var var_262:Block = null;
      
      private var var_631:Block = null;
      
      private var var_306:Block = null;
      
      private var var_297:Block = null;
      
      public var mode:String = "wait";
      
      private var curItem:Item;
      
      private var speedBurst:SpeedBurst;
      
      private var life:int = 3;
      
      private var invincible:Boolean = false;
      
      private var frozenSolid:Boolean = false;
      
      private var unfreezeTimer:uint;
      
      private var var_530:Number;
      
      private var exactX:int;
      
      private var exactY:int;
      
      private var var_577:String;
      
      private var var_623:int;
      
      private var exactPosNextUpdate:Boolean = false;
      
      private var altCtrl:Object;
      
      private var startingStats:Array = null;

      private var reconnectPaused:Boolean = false;

      public var swimAccelXMultiplier:Number = 0.5;
      public var swimAccelYMultiplier:Number = 0.65;
      public var swimVelDamping:Number = 0.92;
      
      public function LocalCharacter(param1:int, param2:Course, param3:Map, param4:MovieClip, param5:ItemDisplay, param6:Number, param7:int = 50, param8:int = 50, param9:int = 50, param10:int = 1, param11:int = 1, param12:int = 1, param13:int = 1, param14:String = "0")
      {
         this.socket = Main.socket;
         this.cm = CommandHandler.commandHandler;
         this.var_573 = setInterval(this.setEPNU,5000);
         this.var_535 = setInterval(this.ensureCowboyStats,250);
         this.var_390 = parent;
         this.traction = this.var_523;
         this.var_524 = this.var_599;
         this.altCtrl = Settings.getValue(Settings.ALTERNATE_CONTROLS,Settings.DEFAULT_ALT_CONTROLS);
         super(param10,param11,param12,param13);
         var_4.setNumber(const_12,0);
         var_4.setNumber(SuperJump,0);
         var_4.setNumber(DefaultGravity,0.7);
         this.setStats(param7,param8,param9);
         this.setGravity(param6);
         this.tempID = param1;
         this.course = param2;
         this.map = param3;
         this.mapDot = param4;
         this.itemDisplay = param5;
         type = "local";
         this.mapDot.setTempID(this.tempID,true);
         super.userName = Main.loggedInAs;
         super.groupStr = param14;
         if(Main.instance.kongAPI != null && Main.instance.kongAPI.stats != null)
         {
            if(param11 == 17 && param12 == 13 && param13 == 12)
            {
               Main.instance.kongAPI.stats.submit("Stickman",1);
            }
            if(param11 == 14 && param12 == 11 && param13 == 11)
            {
               Main.instance.kongAPI.stats.submit("Invisiman",1);
            }
            if(param11 == 11 && param12 == 10 && param13 == 10)
            {
               Main.instance.kongAPI.stats.submit("Birdman",1);
            }
         }
         this.cm.defineCommand("zap",this.zap);
         this.cm.defineCommand("setHats" + this.tempID.toString(),this.setHats);
         this.cm.defineCommand("squash" + this.tempID.toString(),this.squash);
         this.cm.defineCommand("sting" + this.tempID.toString(),this.sting);
      }
      
      public function init() : *
      {
         if(!this.initialized && !removed && !fadeOutStarted)
         {
            this.initialized = true;
            addEventListener(Event.ENTER_FRAME,this.go,false,0,true);
            this.setMode("land");
            this.exactPosNextUpdate = true;
            this.socket.write("p`0`0");
         }
      }
      
      public function setStats(param1:int, param2:int, param3:int, param4:Boolean = false) : *
      {
         this.speedStat = Data.numLimit(param1,0,100);
         this.accelStat = Data.numLimit(param2,0,100);
         this.jumpnStat = Data.numLimit(param3,0,100);
         if(!(this.curItem is SpeedBurst && this.curItem.isUsed()) || param4)
         {
            this.maxVelX = 2 + this.speedStat / 10;
            this.accel = 0.2 + this.accelStat / 60;
            this.ensureSantaStats();
         }
         var_4.setNumber(SuperJump,2 + this.jumpnStat / 40);
         if(Course.course != null && Course.course.statsDisplay != null)
         {
            Course.course.statsDisplay.setStats(this.speedStat,this.accelStat,this.jumpnStat);
         }
         if(this.startingStats == null && Course.course != null)
         {
            this.startingStats = [this.speedStat,this.accelStat,this.jumpnStat];
         }
      }
      
      public function resetStats() : *
      {
         this.setStats(this.speedStat,this.accelStat,this.jumpnStat,true);
      }
      
      public function resetStatsToStart() : *
      {
         this.setStats(this.startingStats[0],this.startingStats[1],this.startingStats[2]);
      }
      
      public function statsChange(param1:int) : *
      {
         this.speedStat += param1;
         this.accelStat += param1;
         this.jumpnStat += param1;
         this.setStats(this.speedStat,this.accelStat,this.jumpnStat);
      }
      
      public function getStats() : *
      {
         return {
            "speed":this.speedStat,
            "acceleration":this.accelStat,
            "jumping":this.jumpnStat
         };
      }

      public function rebindSocket() : void
      {
         this.socket = Main.socket;
      }

      public function setReconnectPaused(param1:Boolean) : void
      {
         this.reconnectPaused = param1;
         if(param1)
         {
            this.up = this.down = this.left = this.right = this.space = false;
            this.targetVelX = 0;
            this.velX = 0;
            this.velY = 0;
         }
      }
      
      public function setGravity(param1:Number) : *
      {
         var_4.setNumber(GravityMultiplied,var_4.getNumber(DefaultGravity) * param1);
      }
      
      private function resetGravity() : *
      {
         var_4.setNumber(GravityMultiplied,var_4.getNumber(DefaultGravity) * GamePage.course.gravity);
      }
      
      public function squash(param1:Array) : *
      {
         if(this.mode != "squashed" && var_269 <= 0)
         {
            this.setMode("squashed");
            SoundEffects.playGameSound(new SquashSound(),x,y,0.66);
         }
      }
      
      public function sting(param1:Array) : *
      {
         var _loc2_:Character = this.course.playerArray[param1[0]];
         if(_loc2_ == null || _loc2_ is LocalCharacter || _loc2_.tempID == this.tempID)
         {
            return;
         }
         var _loc3_:Object = _loc2_.getPos();
         var _loc4_:String = _loc3_.x < x ? "left" : (_loc3_.x > x ? "right" : "");
         new Sting(this,_loc4_);
         if(!var_4.getBool(PARTY) && !var_4.getBool(JELLYFISH))
         {
            this.setMode("hurt");
         }
      }
      
      public function zap(param1:Array) : *
      {
         var _loc2_:Character = null;
         for each(_loc2_ in this.course.playerArray)
         {
            if(param1[0] != _loc2_.tempID)
            {
               new Zap(_loc2_,true,false,false);
            }
         }
         if(param1[0] == this.tempID)
         {
            return;
         }
         new Zap(this,true);
         if(!var_4.getBool(PARTY))
         {
            this.setMode("hurt");
         }
      }
      
      private function go(param1:Event) : *
      {
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = x = Math.round(x);
         var _loc3_:int = y = Math.round(y);
         if(this.map != null)
         {
            _loc4_ = Data.method_9(_loc2_,_loc3_,this.map.rotation);
            this.mapDot.x = _loc4_.x;
            this.mapDot.y = _loc4_.y;
         }
         method_58(this.map.rotation);
         --this.hurtTime;
         ++var_215;
         if(var_215 >= var_448)
         {
            if(Boolean(this.playersInPosUpdateRange()) || var_215 >= 16)
            {
               var_215 = 0;
               _loc5_ = _loc2_ - this.exactX;
               _loc6_ = _loc3_ - this.exactY;
               this.exactX = _loc2_;
               this.exactY = _loc3_;
               if(_loc5_ != 0 || _loc6_ != 0)
               {
                  this.socket.write("p`" + _loc5_ + "`" + _loc6_);
               }
               if(this.exactPosNextUpdate)
               {
                  this.exactPosNextUpdate = false;
                  this.socket.write("exact_pos`" + _loc2_ + "`" + _loc3_);
               }
            }
            if(this.var_530 != scaleX)
            {
               this.var_530 = scaleX;
               this.socket.write("set_var`scaleX`" + scaleX);
            }
            if(this.var_577 != state)
            {
               this.var_577 = state;
               this.socket.write("set_var`state`" + state);
            }
            if(this.var_390 != parent)
            {
               this.var_390 = parent;
               if(parent == Course.course.frontBackground)
               {
                  this.socket.write("set_var`parent`frontBackground");
               }
               else
               {
                  this.socket.write("set_var`parent`backBackground");
               }
            }
            if(Items.getCodeFromItem(this.curItem) != this.var_623)
            {
               this.var_623 = Items.getCodeFromItem(this.curItem);
               this.socket.write("set_var`item`" + Items.getCodeFromItem(this.curItem));
            }
         }
         if(velY > 0 && var_4.getBool(JIGG))
         {
            this.maybeSquash();
         }
         if(this.stingCooldown > 0)
         {
            --this.stingCooldown;
         }
         else if(var_4.getBool(JELLYFISH) && Data.rand(1,35) === 1)
         {
            this.maybeSting();
         }
      }
      
      private function setEPNU() : *
      {
         this.exactPosNextUpdate = true;
      }
      
      private function maybeSquash() : *
      {
         var _loc1_:Character = null;
         for each(_loc1_ in this.course.playerArray)
         {
            if(_loc1_ is RemoteCharacter && _loc1_.state != "crouch" && _loc1_.state != "crouchWalk" && _loc1_.x > x - 20 && _loc1_.x < x + 20 && _loc1_.y > y + 35 && _loc1_.y < y + 65 && _loc1_.rotation == this.rotation)
            {
               _loc1_.changeState("crouch");
               SoundEffects.playGameSound(new SquashSound(),x,y,0.66);
               this.socket.write("squash`" + _loc1_.tempID + "`" + x + "`" + y);
               velY = -3;
               this.grounded = true;
            }
         }
      }
      
      private function maybeSting() : *
      {
         var _loc1_:Character = null;
         for each(_loc1_ in this.course.playerArray)
         {
            if(_loc1_ is RemoteCharacter && _loc1_.state != "bumped" && _loc1_.x > x - 75 && _loc1_.x < x + 75 && _loc1_.y > y - 100 && _loc1_.y < y + 100)
            {
               Main.socket.write("sting`" + _loc1_.tempID + "`" + x + "`" + y);
               this.stingCooldown = 135;
            }
         }
      }
      
      private function waitGo(param1:Event) : *
      {
         this.position();
         this.method_76();
      }
      
      private function hurtGo(param1:Event) : *
      {
         this.targetVelX = 0;
         this.position();
         this.method_76();
         if(this.hurtTime <= 0)
         {
            this.setMode("land");
         }
      }
      
      private function frozenSolidGo(param1:Event) : *
      {
         this.targetVelX = 0;
         this.position();
         this.method_76();
         this.updateKeys();
         if(!this.removed)
         {
            if(this.up && this.grounded && !this.crouching)
            {
               velY -= var_4.getNumber(SuperJump);
            }
            if(!this.frozenSolid)
            {
               this.setMode("land");
            }
            else
            {
               changeState("frozenSolid");
            }
         }
      }
      
      // Duplicated function for backwards compatibility.
      private function frozenSolid2Go(param1:Event) : *
      {
         this.targetVelX = 0;
         this.position();
         this.method_76();
         this.updateKeys();
         if(!this.removed)
         {
            if(this.up && this.grounded && !this.crouching)
            {
               velY -= var_4.getNumber(SuperJump);
            }
            if(!this.frozenSolid)
            {
               this.setMode("land");
            }
            else
            {
               changeState("frozenSolid");
            }
         }
      }
      
      private function squashedGo(param1:Event) : *
      {
         this.crouching = true;
         this.landGo(param1);
         --this.squashedTime;
         if(this.squashedTime <= 0)
         {
            velY = -5;
            this.setMode("land");
         }
      }
      
      private function freezeGo(param1:Event) : *
      {
      }
      
      private function waterGo(param1:Event) : *
      {
         this.updateKeys();
         if(this.right)
         {
            velX += this.accel * this.swimAccelXMultiplier;
         }
         if(this.left)
         {
            velX -= this.accel * this.swimAccelXMultiplier;
         }
         if(this.down)
         {
            velY += this.accel * this.swimAccelYMultiplier;
         }
         if(this.up)
         {
            velY -= this.accel * this.swimAccelYMultiplier;
         }
         velY += var_4.getNumber(DefaultGravity) * 0.25;
         velX *= swimVelDamping;
         velY *= swimVelDamping;
         velX = Data.numLimit(velX,-this.var_157,this.var_157);
         velY = Data.numLimit(velY,-this.var_157,this.var_157);
         x += velX;
         y += velY;
         this.method_76();
         --this.var_240;
         if(var_4.getBool(COWBOY) && !this.grounded)
         {
            this.var_240 = 1;
         }
         if(this.var_240 <= 0)
         {
            if(this.up)
            {
               velY -= var_4.getNumber(SuperJump) * 0.5;
               var_4.setNumber(const_12,-var_4.getNumber(SuperJump) * 0.5);
               this.var_281 = true;
            }
            if (this.mode != "frozenSolid2")
            {
               this.setMode("land");
            }
         }
      }
      
      private function landGo(param1:Event) : *
      {
         this.updateKeys();
         if(this.right)
         {
            this.targetVelX += this.accel;
         }
         if(this.left)
         {
            this.targetVelX -= this.accel;
         }
         if(!this.right && !this.left)
         {
            this.targetVelX = 0;
         }
         if(this.up)
         {
            if(this.grounded && !this.crouching)
            {
               this.var_281 = true;
               velY -= var_4.getNumber(SuperJump);
               var_4.setNumber(const_12,-var_4.getNumber(SuperJump));
            }
            else if(this.var_281)
            {
               velY += var_4.getNumber(const_12);
               var_4.setNumber(const_12,var_4.getNumber(const_12) * 0.75);
            }
         }
         else
         {
            this.var_281 = false;
         }
         if(this.down)
         {
            if(!this.crouching)
            {
               if(!this.grounded)
               {
                  velY += 0.5;
                  this.var_150 = 0;
               }
               else
               {
                  if(this.var_150 < 100)
                  {
                     this.var_150 += 2;
                  }
                  if(this.var_150 > 25)
                  {
                     this.targetVelX = 0;
                  }
               }
            }
         }
         else
         {
            if(this.var_150 > 25)
            {
               velY = -this.var_150 * 0.24;
               this.var_281 = false;
               SoundEffects.playSound(new SuperJumpSound(),1 * (Settings.soundLevel / 100));
            }
            this.var_150 = 0;
         }
         this.position();
         scaleY = 1;
         if(!this.grounded)
         {
            changeState("jump");
         }
         else if(this.var_150 > 25)
         {
            changeState("superJump");
         }
         else if(this.left || this.right)
         {
            changeState(this.crouching ? "crouchWalk" : "run");
         }
         else
         {
            changeState(this.crouching ? "crouch" : "stand");
         }
         this.method_76();
         if(var_4.getBool(COWBOY) && !this.grounded)
         {
            this.var_240 = 2;
            this.setMode("water");
            changeState("swim");
         }
      }
      
      private function updateKeys() : *
      {
         var _loc1_:Boolean = false;
         this.up = this.down = this.right = this.left = this.space = false;

         if(this.reconnectPaused || RaceReconnectController.isInputBlocked())
         {
            if(this.curItem != null)
            {
               this.curItem.setSpace(false);
            }
            return;
         }

         if (Course.course != null && Course.course.isSpectating)
         {
            // don't allow movement when spectating
            return;
         }

         if(Main.stage.focus == null || Main.stage.focus != RaceChat.textBox)
         {
            if(Keys.isPressed(Keyboard.RIGHT) || Keys.isPressed(this.altCtrl.right))
            {
               this.right = true;
               scaleX = 1;
            }
            if(Keys.isPressed(Keyboard.LEFT) || Keys.isPressed(this.altCtrl.left))
            {
               this.left = true;
               scaleX = -1;
            }
            if(Keys.isPressed(Keyboard.UP) || Keys.isPressed(this.altCtrl.up))
            {
               this.up = true;
            }
            if(Keys.isPressed(Keyboard.DOWN) || Keys.isPressed(this.altCtrl.down))
            {
               this.down = true;
            }
            if(Keys.isPressed(Keyboard.SPACE) || Keys.isPressed(this.altCtrl.item))
            {
               this.space = true;
            }
         }
         if(reversedControls)
         {
            _loc1_ = this.right;
            this.right = this.left;
            this.left = _loc1_;
         }
         if(this.curItem != null)
         {
            this.curItem.setSpace(this.curItem is JetPack && this.crouching ? false : this.space);
         }
      }
      
      private function position() : *
      {
         var _loc1_:Number = NaN;
         var _loc2_:Point = null;
         var _loc3_:int = 0;
         if(this.reconnectPaused)
         {
            return;
         }
         if(this.map != null)
         {
            if(this.course != null)
            {
               if (parent != this.course.frontBackground)
                  this.course.frontBackground.addChild(this);
               else
                  // force LocalCharacter to the front
                  this.course.frontBackground.setChildIndex(this, this.course.frontBackground.numChildren - 1);
            }
            
            velY += var_4.getNumber(GravityMultiplied);
            if(this.up && var_4.getBool(PROP) && velY > 0)
            {
               velY *= 0.85;
            }
            this.targetVelX *= this.friction;
            if(this.crouching)
            {
               this.targetVelX *= 0.7;
            }
            this.targetVelX = Data.numLimit(this.targetVelX,-this.maxVelX,this.maxVelX);
            _loc1_ = Math.abs(velX) / this.var_157;
            _loc1_ = 1 - _loc1_;
            _loc1_ *= 0.9;
            _loc1_ += 0.1;
            this.traction *= !!this.frozenSolid ? 0 : _loc1_;
            velX += (this.targetVelX - velX) * this.traction;
            velX = Data.numLimit(velX,-this.var_157,this.var_157);
            velY = Data.numLimit(velY,-this.var_157,this.var_157);
            x += velX;
            y += velY;
            _loc2_ = Data.method_9(x,y,this.map.rotation);
            _loc3_ = 500;
            if(_loc2_.y > this.map.maxY + _loc3_ && this.map.rotation == 0 || _loc2_.y < this.map.minY - _loc3_ && Math.abs(this.map.rotation) == 180 || _loc2_.x > this.map.maxX + _loc3_ && this.map.rotation == 90 || _loc2_.x < this.map.minX - _loc3_ && this.map.rotation == -90)
            {
               this.returnToLastSafeSpot();
            }
            if(this.course.gameMode === Modes.hat && this.course.looseHats.length > 0)
            {
               this.checkLooseHats();
            }
            this.traction = this.var_523;
            this.var_524 = this.var_599;
         }
      }
      
      public function returnToLastSafeSpot() : *
      {
         x = this.lastSafeX;
         y = this.lastSafeY;
         velX = 0;
         velY = 0;
         this.bumpPlayer();
      }
      
      private function checkLooseHats() : *
      {
         var _loc1_:Hat = null;
         var _loc2_:Point = null;
         var _loc3_:int = 0;
         for each(_loc1_ in this.course.looseHats)
         {
            _loc2_ = _loc1_.getPos();
            _loc3_ = _loc1_.getRot();
            _loc2_ = Data.method_9(_loc2_.x,_loc2_.y,_loc3_);
            if(_loc2_.y > this.map.maxY + 500 && _loc3_ == 0 || _loc2_.y < this.map.minY - 500 && Math.abs(_loc3_) == 180 || _loc2_.x > this.map.maxX + 500 && _loc3_ == 90 || _loc2_.x < this.map.minX - 500 && _loc3_ == -90)
            {
               this.returnHatToStart(_loc1_.getId());
            }
         }
      }
      
      private function returnHatToStart(param1:int) : *
      {
         var _loc2_:Hat = this.course.looseHats[param1];
         if(_loc2_ != null)
         {
            _loc2_.returningToStart();
            Main.socket.write("hat_to_start`" + param1);
         }
      }
      
      private function method_76() : *
      {
         var _loc1_:Block = null;
         var _loc2_:Block = null;
         var _loc3_:Block = null;
         var _loc4_:Number = NaN;
         if(this.map != null)
         {
            this.method_41();
            this.method_261();
            if(var_4.getBool(SANTA))
            {
               _loc3_ = this.map.getBlockFromPos(x,y,true);
               if(_loc3_ != null && (_loc3_ is WaterBlock && this.mode != "water" || _loc3_ is SafetyBlock))
               {
                  _loc3_.onStand(this);
               }
            }
            if(velX >= -1)
            {
               if(this.var_296 != null && this.getBlock(this.var_296.getPosX() - 30,this.var_296.getPosY()) == null)
               {
                  this.var_296.onLeftHit(this);
                  this.method_41();
               }
            }
            if(velX <= 1)
            {
               if(this.var_329 != null && this.getBlock(this.var_329.getPosX() + 30,this.var_329.getPosY()) == null)
               {
                  this.var_329.onRightHit(this);
                  this.method_41();
               }
            }
            if(velY < 0)
            {
               if(this.grounded)
               {
                  this.crouching = true;
               }
               if(this.mode != "water" && this.var_262 != null && this.getBlock(this.var_262.getPosX(),this.var_262.getPosY() + 30) == null)
               {
                  this.var_262.onBump(this);
                  this.method_41();
               }
               else if(this.mode != "water" && this.var_306 != null && this.getBlock(this.var_306.getPosX(),this.var_306.getPosY() + 30) == null)
               {
                  this.var_306.onBump(this);
                  this.method_41();
               }
               else if(this.var_297 != null && this.getBlock(this.var_297.getPosX(),this.var_297.getPosY() + 30) == null)
               {
                  this.var_297.onBump(this);
                  this.method_41();
               }
            }
            if(!this.grounded)
            {
               this.method_261();
            }
            _loc1_ = null;
            _loc2_ = null;
            this.crouching = false;
            if(this.grounded == true)
            {
               _loc1_ = this.getBlock(x,y - 40,true,false,Block.FACE_BOTTOM);
               _loc2_ = this.getBlock(x,y - 10,true,false,Block.FACE_BOTTOM);
               if(_loc1_ != null && _loc2_ == null)
               {
                  this.crouching = true;
                  if(this.up)
                  {
                     _loc4_ = y;
                     _loc1_.onBump(this);
                     y = !(_loc1_ is TeleportBlock) ? _loc4_ : y;
                     velY = 0;
                  }
                  if(velY < 0)
                  {
                     velY = 0;
                  }
               }
            }
            _loc1_ = this.map.getBlockFromPos(x,y - 15,true);
            if(_loc1_ != null)
            {
               _loc1_.onTouch(this);
            }
            if(!this.crouching)
            {
               _loc1_ = this.map.getBlockFromPos(x,y - 45,true);
               if(_loc1_ != null)
               {
                  _loc1_.onTouch(this);
               }
            }
         }
      }
      
      private function method_261() : *
      {
         if(this.var_469 != null && (this.var_262 == null || this.var_262 is OneWayBlock))
         {
            this.var_469.onStand(this);
            this.method_41();
            this.grounded = true;
         }
         else
         {
            this.grounded = false;
         }
      }
      
      private function method_41() : *
      {
         if(y < 0)
         {
            y += 0.001;
         }
         this.var_630 = this.getBlock(x - this.var_189,y,true,true,Block.FACE_TOP);
         this.var_469 = this.getBlock(x,y,true,true,Block.FACE_TOP);
         this.var_657 = this.getBlock(x + this.var_189,y,true,true,Block.FACE_TOP);
         this.var_329 = this.getBlock(x - this.var_189,y - 10,true,false,Block.FACE_RIGHT);
         this.var_658 = this.getBlock(x,y - 10,true,false,Block.FACE_BOTTOM);
         this.var_296 = this.getBlock(x + this.var_189,y - 10,true,false,Block.FACE_LEFT);
         this.var_654 = this.getBlock(x - this.var_189,y - 30,true,false,Block.FACE_BOTTOM);
         this.var_262 = this.getBlock(x,y - 30,true,false,Block.FACE_BOTTOM);
         this.var_631 = this.getBlock(x + this.var_189,y - 30,true,false,Block.FACE_BOTTOM);
         this.var_306 = this.getBlock(x,y - this.var_325 + 30,true,false,Block.FACE_BOTTOM);
         this.var_297 = this.getBlock(x,y - this.var_325,true,false,Block.FACE_BOTTOM);
      }
      
      private function getBlock(param1:Number, param2:Number, param3:Boolean = true, param4:Boolean = false, param5:int = -1) : Block
      {
         var _loc5_:Block = null;
         if(this.map != null)
         {
            if((_loc5_ = this.map.getBlockFromPos(param1,param2,param3)) == null || !_loc5_.isActive() || !_loc5_.collidesOnFace(this,param5) || param5 == Block.FACE_BOTTOM && velY > 0 && _loc5_ is OneWayBlock || var_4.getBool(TOP) && _loc5_ is VanishBlock && !param4)
            {
               return null;
            }
            return _loc5_;
         }
         return null;
      }
      
      public function setMode(param1:String) : *
      {
         if(this.mode != param1)
         {
            removeEventListener(Event.ENTER_FRAME,this[this.mode + "Go"]);
            addEventListener(Event.ENTER_FRAME,this[param1 + "Go"],false,0,true);
            this.mode = param1;
            this.targetVelX = 0;
            if(this.mode == "hurt")
            {
               changeState("bumped");
               this.bumpPlayer();
            }
            if(this.mode == "water" && this.state != "bumped")
            {
               changeState("swim");
            }
            if(this.mode == "squashed")
            {
               this.squashedTime = 60;
               method_51(70);
            }
         }
      }
      
      private function bumpPlayer() : *
      {
         if(this.hurtTime <= 0)
         {
            this.hurtTime = 60;
            method_51(65);
            if(this.course.gameMode == "deathmatch")
            {
               --this.life;
               this.setLife(this.life);
               if(this.life <= 0)
               {
                  this.course.finish();
               }
            }
         }
      }
      
      override public function gainHeart() : *
      {
         super.gainHeart();
         ++this.life;
         this.setLife(this.life);
         Main.socket.write("heart`");
      }
      
      public function setLife(param1:int) : *
      {
         this.life = Data.numLimit(param1,0,15);
         this.course.setLife(this.life);
      }
      
      override public function becomeInvincible(param1:int) : *
      {
         super.becomeInvincible(param1);
         this.hurtTime = param1;
         this.invincible = true;
      }
      
      override protected function endRecovery() : *
      {
         super.endRecovery();
         this.invincible = false;
      }
      
      public function hit(param1:Number = 0, param2:Number = 0) : *
      {
         var _loc3_:Object = null;
         if((!var_4.getBool(CROWN) || this.course.gameMode == Modes.dm || this.course.gameMode == Modes.hat) && !this.invincible)
         {
            velX += param1;
            velY += param2;
            if(!var_4.getBool(CROWN))
            {
               method_51(50);
               if(!this.frozenSolid)
               {
                  this.setMode("hurt");
               }
            }
            if(this.map != null && !this.testMode)
            {
               _loc3_ = getHighestHat();
               if(_loc3_.hatNum != 1 && _loc3_.hatNum != 0 && _loc3_.hatNum != null)
               {
                  Main.socket.write("loose_hat`" + x + "`" + (y - 50) + "`" + this.map.rotation);
               }
            }
         }
      }
      
      override public function setPos(param1:Number, param2:Number) : *
      {
         this.lastSafeX = param1;
         this.lastSafeY = param2;
         super.setPos(param1,param2);
         this.exactX = param1;
         this.exactY = param2;
         this.exactPosNextUpdate = true;
         Course.course.posX = -param1;
         Course.course.posY = -param2;
         Course.course.setPos(-param1,-param2);
      }
      
      override public function setItem(param1:int) : *
      {
         super.setItem(param1);
         if(this.itemDisplay != null)
         {
            this.itemDisplay.setItem(Items.getNameFromCode(param1));
         }
         if(this.curItem != null)
         {
            if(param1 == Items.jetPack && this.curItem is JetPack)
            {
               this.curItem.replenishFuel(this);
               return;
            }
            this.curItem.remove();
            this.curItem = null;
         }
         this.curItem = Items.getFromCode(param1,this);
      }

      public function setItemUses(uses:int):void
      {
         if (this.curItem != null)
         {
            trace("Setting uses for current item to " + uses);
            this.curItem.setUses(uses);
         }
      }
      
      public function setAmmo(param1:int) : *
      {
         if(this.itemDisplay != null)
         {
            this.itemDisplay.setAmmo(param1);
         }
      }
      
      public function setRotation(param1:Number) : *
      {
         rotation = Math.round(param1);
         this.socket.write("set_var`rotMod`" + rotation);
      }
      
      override public function rotate(param1:String) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         super.rotate(param1);
         if(param1 == "right")
         {
            _loc2_ = -this.lastSafeY;
            _loc3_ = this.lastSafeX;
         }
         else
         {
            _loc2_ = this.lastSafeY;
            _loc3_ = -this.lastSafeX;
         }
         this.lastSafeX = _loc2_;
         this.lastSafeY = _loc3_;
         this.setMode("land");
         this.course.posX = -x;
         this.course.posY = -y + 50;
         this.course.setPos(-x,-y + 50);
         this.socket.write("set_var`rot`" + -this.map.rotation);
         this.exactPosNextUpdate = true;
      }
      
      private function playersInPosUpdateRange() : Boolean
      {
         return true;
         // return Course.course.playerArray.length > 1;
      }
      
      override public function beginSparkles(param1:int = 5000) : *
      {
         this.socket.write("set_var`sparkle`1");
         super.beginSparkles(param1);
      }
      
      override public function endSparkles(param1:Boolean = false) : *
      {
         this.socket.write("set_var`sparkle`0");
         super.endSparkles(param1);
      }
      
      override public function beginJet() : *
      {
         this.socket.write("set_var`jet`1");
         super.beginJet();
      }
      
      override public function endJet() : *
      {
         this.socket.write("set_var`jet`0");
         super.endJet();
      }
      
      override public function beginRemove() : *
      {
         if(this.socket != null)
         {
            this.setMode("freeze");
            this.socket.write("set_var`beginRemove`1");
            super.beginRemove();
         }
      }
      
      override public function setHats(param1:Array) : *
      {
         var _loc8_:CourseTimer = null;
         var _loc9_:Zap = null;
         var _loc2_:Boolean = var_4.getBool(JUMP_START);
         var _loc3_:Boolean = var_4.getBool(COWBOY);
         var _loc4_:Boolean = var_4.getBool(MOON);
         var _loc5_:Boolean = var_4.getBool(SANTA);
         var _loc6_:Boolean = var_4.getBool(ARTIFACT);
         var _loc7_:Boolean = Items.getCodeFromItem(this.curItem) != Items.speedBurst || Items.getCodeFromItem(this.curItem) == Items.speedBurst && !this.curItem.isUsed();
         super.setHats(param1);
         if(_loc4_ && !var_4.getBool(MOON))
         {
            this.resetGravity();
         }
         if(_loc3_ && !var_4.getBool(COWBOY) && _loc7_)
         {
            this.resetStats();
         }
         if(_loc5_ && !var_4.getBool(SANTA) && _loc7_)
         {
            this.resetStats();
         }
         if(_loc6_ && !var_4.getBool(ARTIFACT))
         {
            if(Items.getCodeFromItem(this.curItem) == Items.speedBurst)
            {
               this.setItem(0);
            }
            if(Data.getDateStr(new Date().getTime()) !== "Apr 1")
            {
               reversedControls = false;
            }
         }
         this.ensureCowboyStats();
         if(var_4.getBool(SANTA))
         {
            if(!_loc5_)
            {
               this.ensureSantaStats();
            }
         }
         if(var_4.getBool(JUMP_START))
         {
            if(!_loc2_)
            {
               this.setItem(Items.speedBurst);
               SpeedBurst(this.curItem).duration = 2000;
               this.curItem.useItem();
            }
         }
         if(var_4.getBool(MOON))
         {
            if(!_loc4_)
            {
               this.setGravity(GamePage.course.gravity * 0.85);
            }
         }
         if(var_4.getBool(ARTIFACT))
         {
            if(!_loc6_)
            {
               this.setItem(Items.speedBurst);
               SpeedBurst(this.curItem).duration = 30000;
               this.curItem.useItem();
               if((_loc8_ = Course.course.timer).getMS() > 30)
               {
                  _loc8_.setTime(30);
                  _loc8_.init();
               }
               (_loc9_ = new Zap(this,false,false)).transform.colorTransform = new ColorTransform(1,1,1,1,0,0,255,0);
               SoundEffects.playSound(new YeahSound(),1 * (Settings.soundLevel / 100));
               Course.course.musicSelection.dropdown.gotArtifact();
               reversedControls = true;
            }
         }
      }
      
      private function ensureCowboyStats() : *
      {
         if(var_4.getBool(COWBOY))
         {
            this.maxVelX = this.maxVelX < 12 ? 12 : this.maxVelX;
            this.accel = this.accel < 1.86 ? 1.86 : this.accel;
            var_4.setNumber(SuperJump,4.5);
         }
      }
      
      private function ensureSantaStats() : *
      {
         if(var_4.getBool(SANTA))
         {
            this.maxVelX += 1;
         }
      }
      
      public function isFrozen() : Boolean
      {
         return this.frozenSolid;
      }
      
      public function freeze() : *
      {
         if(this.mode != "frozenSolid" && state != "frozenSolid" && !this.frozenSolid)
         {
            this.frozenSolid = true;
            clearTimeout(this.unfreezeTimer);
            this.unfreezeTimer = setTimeout(this.unfreeze,2000);
            this.setMode("frozenSolid");
         }
      }

      // Edited duplicate function for backwards compatibility.
      public function freeze2() : *
      {
         if(this.mode != "frozenSolid" && this.mode != "frozenSolid2" 
            && state != "frozenSolid" && this.state != "frozenSolid2"
            && !this.frozenSolid)
         {
            this.frozenSolid = true;
            clearTimeout(this.unfreezeTimer);
            this.unfreezeTimer = setTimeout(this.unfreeze,2000);
            this.setMode("frozenSolid2");
         }
      }
      
      private function unfreeze() : *
      {
         clearTimeout(this.unfreezeTimer);
         this.frozenSolid = false;
      }
      
      public function inLE() : *
      {
         return this.course is TestCourse;
      }
      
      override protected function removeListeners() : *
      {
         super.removeListeners();
         removeEventListener(Event.ENTER_FRAME,this.landGo);
         removeEventListener(Event.ENTER_FRAME,this.waitGo);
         removeEventListener(Event.ENTER_FRAME,this.hurtGo);
         removeEventListener(Event.ENTER_FRAME,this.squashedGo);
         removeEventListener(Event.ENTER_FRAME,this.freezeGo);
         removeEventListener(Event.ENTER_FRAME,this.waterGo);
         removeEventListener(Event.ENTER_FRAME,this.go);
         clearInterval(this.var_573);
         clearInterval(this.var_535);
         clearTimeout(this.unfreezeTimer);
      }
      
      override public function remove() : *
      {
         this.setItem(0);
         this.socket = null;
         if(this.cm != null)
         {
            this.cm.defineCommand("setHats" + tempID.toString(),null);
            this.cm.defineCommand("zap",null);
            this.cm.defineCommand("squash" + tempID.toString(),null);
            this.cm.defineCommand("sting" + this.tempID.toString(),null);
            this.cm = null;
         }
         this.course = null;
         this.map = null;
         if(this.mapDot != null)
         {
            if(this.mapDot.parent != null)
            {
               this.mapDot.parent.removeChild(this.mapDot);
            }
            this.mapDot = null;
         }
         this.itemDisplay = null;
         this.var_390 = null;
         this.curItem = null;
         super.remove();
      }
   }
}
