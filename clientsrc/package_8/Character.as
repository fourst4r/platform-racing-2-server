package package_8
{
   import com.jiggmin.data.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.geom.*;
   import flash.media.SoundChannel;
   import items.*;
   import sounds.*;
   
   public class Character extends Removable
   {
      
      public static const PROP:String = "p";
      
      public static const CROWN:String = "c";
      
      public static const COWBOY:String = "g";
      
      public static const SANTA:String = "s";
      
      public static const PARTY:String = "a";
      
      public static const TOP:String = "t";
      
      public static const JUMP_START:String = "h";
      
      public static const MOON:String = "m";
      
      public static const JIGG:String = "j";
      
      public static const ARTIFACT:String = "b";
      
      public static const JELLYFISH:String = "f";
      
      public static const CHEESE:String = "ch";
       
      
      private var var_387:class_127;
      
      private var var_140:SoundChannel;
      
      public var m:CharacterGraphic;
      
      public var var_301:MovieClip;
      
      private var characterStatesArray:Array;
      
      public var curWeapon:MovieClip;
      
      public var hat1:int;
      
      public var hat2:int = 1;
      
      public var hat3:int = 1;
      
      public var hat4:int = 1;
      
      public var head:int;
      
      public var body:int;
      
      public var feet:int;
      
      public var headColor:int;
      
      public var bodyColor:int;
      
      public var feetColor:int;
      
      public var hat1Color:int;
      
      public var hat2Color:int;
      
      public var hat3Color:int;
      
      public var hat4Color:int;
      
      public var headColor2:int = -1;
      
      public var bodyColor2:int = -1;
      
      public var feetColor2:int = -1;
      
      public var hat1Color2:int = -1;
      
      public var hat2Color2:int = -1;
      
      public var hat3Color2:int = -1;
      
      public var hat4Color2:int = -1;
      
      public var userName:String = "";
      
      public var groupStr:String = "0";
      
      public var item:int = 0;
      
      public var seg1:Point;
      
      public var seg2:Point;
      
      public var velX:Number = 0;
      
      public var velY:Number = 0;
      
      public var type:String = "remote";
      
      public var var_670:Number;
      
      protected var reversedControls:Boolean = false;
      
      public var state:String;
      
      public var var_269:Number = 0;
      
      public var tempID:int;
      
      protected var var_448:int = 5;
      
      protected var var_215:int = 0;
      
      protected var fadeOutStarted:Boolean = false;
      
      public var removed:Boolean = false;
      
      public var var_4:class_20;
      
      private var var_375:class_125;
      
      public function Character(param1:int = 1, param2:int = 1, param3:int = 1, param4:int = 1)
      {
         this.m = new CharacterGraphic();
         this.characterStatesArray = new Array(this.m.runAnim,this.m.standAnim,this.m.jumpAnim,this.m.superJumpAnim,this.m.bumpedAnim,this.m.crouchAnim,this.m.crouchWalkAnim,this.m.swimAnim,this.m.frozenSolidAnim);
         super();
         this.var_387 = new class_127(this);
         this.hat1 = param1;
         this.head = param2;
         this.body = param3;
         this.feet = param4;
         if(Data.getDateStr(new Date().getTime()) === "Apr 1")
         {
            this.reversedControls = true;
         }
         this.var_4 = new class_20();
         this.resetHats();
         this.changeState("stand");
         this.applyAppearance();
         addChild(this.m);
      }
      
      public function setColors(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int) : *
      {
         this.setHatColors(param1,param2);
         this.setHeadColors(param3,param4);
         this.setBodyColors(param5,param6);
         this.setFeetColors(param7,param8);
      }
      
      private function resetHats() : *
      {
         this.var_4.setBool(PROP,false);
         this.var_4.setBool(CROWN,false);
         this.var_4.setBool(COWBOY,false);
         this.var_4.setBool(SANTA,false);
         this.var_4.setBool(PARTY,false);
         this.var_4.setBool(TOP,false);
         this.var_4.setBool(JUMP_START,false);
         this.var_4.setBool(MOON,false);
         this.var_4.setBool(JIGG,false);
         this.var_4.setBool(ARTIFACT,false);
         this.var_4.setBool(JELLYFISH,false);
         this.var_4.setBool(CHEESE,false);
      }
      
      public function setHats(param1:Array) : *
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         this.hat1 = this.hat2 = this.hat3 = this.hat4 = 1;
         this.hat1Color = this.hat2Color = this.hat3Color = this.hat4Color = 16777215;
         this.hat1Color2 = this.hat2Color2 = this.hat3Color2 = this.hat4Color2 = -1;
         this.resetHats();
         var _loc2_:int = 1;
         var _loc3_:int = int(param1.length);
         while(_loc4_ < _loc3_)
         {
            _loc5_ = int(param1[_loc4_]);
            _loc6_ = int(param1[_loc4_ + 1]);
            _loc7_ = int(param1[_loc4_ + 2]);
            if(_loc2_ === 1)
            {
               this.hat1 = _loc5_;
               this.hat1Color = _loc6_;
               this.hat1Color2 = _loc7_;
            }
            else if(_loc2_ === 2)
            {
               this.hat2 = _loc5_;
               this.hat2Color = _loc6_;
               this.hat2Color2 = _loc7_;
            }
            else if(_loc2_ === 3)
            {
               this.hat3 = _loc5_;
               this.hat3Color = _loc6_;
               this.hat3Color2 = _loc7_;
            }
            else if(_loc2_ === 4)
            {
               this.hat4 = _loc5_;
               this.hat4Color = _loc6_;
               this.hat4Color2 = _loc7_;
            }
            if(_loc5_ === 4)
            {
               this.var_4.setBool(PROP,true);
            }
            else if(_loc5_ === 5)
            {
               this.var_4.setBool(COWBOY,true);
            }
            else if(_loc5_ === 6)
            {
               this.var_4.setBool(CROWN,true);
            }
            else if(_loc5_ === 7)
            {
               this.var_4.setBool(SANTA,true);
            }
            else if(_loc5_ === 8)
            {
               this.var_4.setBool(PARTY,true);
            }
            else if(_loc5_ === 9)
            {
               this.var_4.setBool(TOP,true);
            }
            else if(_loc5_ === 10)
            {
               this.var_4.setBool(JUMP_START,true);
            }
            else if(_loc5_ === 11)
            {
               this.var_4.setBool(MOON,true);
            }
            else if(_loc5_ === 13)
            {
               this.var_4.setBool(JIGG,true);
            }
            else if(_loc5_ === 14)
            {
               this.var_4.setBool(ARTIFACT,true);
            }
            else if(_loc5_ === 15)
            {
               this.var_4.setBool(JELLYFISH,true);
            }
            else if(_loc5_ === 16)
            {
               this.var_4.setBool(CHEESE,true);
            }
            _loc2_++;
            _loc4_ += 3;
         }
         this.applyAppearance();
      }
      
      public function setHatId(param1:Number) : *
      {
         this.hat1 = param1;
         this.applyAppearance();
      }
      
      public function setHeadId(param1:Number) : *
      {
         this.head = param1;
         this.applyAppearance();
      }
      
      public function setBodyId(param1:Number) : *
      {
         this.body = param1;
         this.applyAppearance();
      }
      
      public function setFeetId(param1:Number) : *
      {
         this.feet = param1;
         this.applyAppearance();
      }
      
      public function setHatColors(param1:int, param2:int, param3:int = 1) : *
      {
         param3 = int(Data.numLimit(param3,1,4));
         this["hat" + param3 + "Color"] = param1;
         this["hat" + param3 + "Color2"] = param2;
         this.applyAppearance();
      }
      
      public function setHeadColors(param1:int, param2:int) : *
      {
         this.headColor = param1;
         this.headColor2 = param2;
         this.applyAppearance();
      }
      
      public function setBodyColors(param1:int, param2:int) : *
      {
         this.bodyColor = param1;
         this.bodyColor2 = param2;
         this.applyAppearance();
      }
      
      public function setFeetColors(param1:int, param2:int) : *
      {
         this.feetColor = param1;
         this.feetColor2 = param2;
         this.applyAppearance();
      }
      
      public function setItem(param1:int) : *
      {
         this.item = param1;
         this.applyItem();
      }
      
      private function applyAppearance() : *
      {
         this.updatePartMC("head","head");
         this.updatePartMC("body","body");
         this.updatePartMC("foot1","feet");
         this.updatePartMC("foot2","feet");
         this.updatePartMC("hat1","hat1");
         this.updatePartMC("hat2","hat2");
         this.updatePartMC("hat3","hat3");
         this.updatePartMC("hat4","hat4");
         this.applyItem();
         this.hideHeadFeetIfFredBody();
         this.var_387.update();
      }
      
      private function updatePartMC(param1:String, param2:String) : *
      {
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:MovieClip = null;
         var _loc8_:int = 0;
         if(this.m != null)
         {
            _loc4_ = int(this[param2 + "Color"]);
            _loc5_ = int(this[param2 + "Color2"]);
            _loc6_ = param2;
            if(param2.indexOf("hat") != -1)
            {
               _loc6_ = "hat";
            }
            for each(_loc7_ in this.characterStatesArray)
            {
               _loc8_ = int(this[param2]);
               if(_loc6_ == "hat")
               {
                  if(this.body == 29)
                  {
                     _loc3_ = _loc7_.body[param2];
                  }
                  else
                  {
                     _loc3_ = _loc7_.head[param2];
                  }
               }
               else
               {
                  _loc3_ = _loc7_[param1];
               }
               _loc3_.gotoAndStop(_loc8_);
               _loc3_.colorMC.gotoAndStop(_loc8_);
               _loc3_.colorMC2.gotoAndStop(_loc8_);
               this.applyPartColor(_loc3_.colorMC,_loc4_);
               if((_loc5_ = _loc6_ == "hat" && _loc8_ == 16 && _loc5_ == -1 ? 0 : _loc5_) != -1)
               {
                  _loc3_.colorMC2.visible = true;
                  this.applyPartColor(_loc3_.colorMC2,_loc5_);
               }
               else
               {
                  _loc3_.colorMC2.visible = false;
               }
            }
         }
      }
      
      private function hideHeadFeetIfFredBody() : *
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this.characterStatesArray)
         {
            if(this.body == 29)
            {
               _loc1_.head.visible = false;
               _loc1_.foot1.visible = false;
               _loc1_.foot2.visible = false;
            }
            else
            {
               _loc1_.head.visible = true;
               _loc1_.foot1.visible = true;
               _loc1_.foot2.visible = true;
            }
         }
      }
      
      private function applyPartColor(param1:MovieClip, param2:int) : *
      {
         var _loc3_:ColorTransform = new ColorTransform();
         _loc3_.color = param2;
         param1.transform.colorTransform = _loc3_;
      }
      
      private function applyItem() : *
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this.characterStatesArray)
         {
            _loc1_.weapon.gotoAndStop(Items.getNameFromCode(this.item));
         }
      }
      
      public function getName() : String
      {
         return this.userName;
      }
      
      public function getGroup() : String
      {
         return this.groupStr;
      }
      
      protected function setNameColor(param1:int) : *
      {
         this.m.nameHolder.nameBox.textColor = param1;
      }
      
      public function getPos() : *
      {
         var _loc1_:Object = new Object();
         _loc1_.x = x;
         _loc1_.y = y;
         return _loc1_;
      }
      
      public function setPos(param1:Number, param2:Number) : *
      {
         x = param1;
         y = param2;
      }
      
      public function rotate(param1:String) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1 == "right")
         {
            _loc2_ = -y;
            _loc3_ = x;
         }
         else
         {
            _loc2_ = y;
            _loc3_ = -x;
         }
         x = _loc2_;
         y = _loc3_;
      }
      
      protected function method_58(param1:Number) : *
      {
         var _loc2_:Point = new Point(Math.floor(x / 30),Math.floor(y / 30));
         this.seg1 = Data.method_9(_loc2_.x,_loc2_.y,param1);
         this.seg2 = new Point(this.seg1.x,this.seg1.y - 1);
         if(param1 == 90)
         {
            --this.seg1.x;
            --this.seg2.x;
         }
         else if(Math.abs(param1) == 180)
         {
            --this.seg1.x;
            --this.seg2.x;
            ++this.seg1.y;
            ++this.seg2.y;
         }
         else if(param1 == -90)
         {
            ++this.seg1.y;
            ++this.seg2.y;
         }
      }
      
      public function method_51(param1:Number) : *
      {
         this.var_269 = param1;
         removeEventListener(Event.ENTER_FRAME,this.method_106);
         addEventListener(Event.ENTER_FRAME,this.method_106,false,0,true);
      }
      
      private function method_106(param1:Event) : *
      {
         var _loc2_:Number = this.var_269 % 8;
         if(!this.fadeOutStarted)
         {
            alpha = _loc2_ >= 4 ? 0.5 : 0.75;
         }
         --this.var_269;
         if(this.var_269 <= 0)
         {
            this.endRecovery();
         }
      }
      
      protected function endRecovery() : *
      {
         alpha = 1;
         removeEventListener(Event.ENTER_FRAME,this.method_106);
      }
      
      public function changeState(param1:String) : *
      {
         var _loc2_:MovieClip = null;
         if(this.state != param1)
         {
            if(this.state == "superJump")
            {
               this.method_820();
            }
            if(param1 == "superJump")
            {
               this.method_623();
            }
            if(param1 == "jump")
            {
               if(this.velY <= 0)
               {
                  SoundEffects.playGameSound(new JumpSound(),x,y,0.75);
               }
            }
            this.state = param1;
            if(this.m != null)
            {
               for each(_loc2_ in this.characterStatesArray)
               {
                  _loc2_.stop();
                  if(_loc2_.parent != null)
                  {
                     _loc2_.parent.removeChild(_loc2_);
                  }
               }
               _loc2_ = this.m[this.state + "Anim"];
               this.m.addChild(_loc2_);
               this.curWeapon = _loc2_.weapon;
               _loc2_.gotoAndPlay(1);
               this.var_301 = _loc2_;
            }
            this.var_387.update();
         }
      }
      
      public function djinnUpdateAlpha(param1:Number) : *
      {
         this.var_387.newAlpha(param1);
      }
      
      public function gainHeart() : *
      {
         SoundEffects.playGameSound(new BumpHappySound(),x,y,0.75);
         this.becomeInvincible(Main.instance.stage.frameRate * 5);
      }
      
      public function becomeInvincible(param1:int) : *
      {
         this.method_51(param1);
         this.method_200(new class_126(33,5000,this));
      }
      
      public function beginSparkles(param1:int = 5000) : *
      {
         SoundEffects.playGameSound(new SpeedUpSound(),x,y);
         this.method_200(new class_125(33,param1,this));
      }
      
      public function endSparkles(param1:Boolean = false) : *
      {
         if(param1 == true)
         {
            SoundEffects.playGameSound(new SlowDownSound(),x,y);
         }
         this.method_190();
      }
      
      protected function method_623() : *
      {
         addEventListener(Event.ENTER_FRAME,this.method_156,false,0,true);
      }
      
      protected function method_820() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.method_156);
         scaleY = 1;
      }
      
      private function method_156(param1:Event) : *
      {
         var _loc2_:Number = this.m.superJumpAnim.currentFrame / 2;
         scaleY = (Math.random() * _loc2_ + (100 - _loc2_ / 2)) / 100;
      }
      
      public function beginJet() : *
      {
         addEventListener(Event.ENTER_FRAME,this.method_207,false,0,true);
         if(this.curWeapon != null && this.curWeapon.jetPack != null)
         {
            this.curWeapon.jetPack.gotoAndStop("on");
         }
         if(this.var_140 != null)
         {
            this.var_140.stop();
         }
         this.var_140 = SoundEffects.playGameSound(new EngineSound(),x,y,0.6,0,999);
      }
      
      public function endJet() : *
      {
         var _loc1_:MovieClip = null;
         removeEventListener(Event.ENTER_FRAME,this.method_207);
         if(this.var_140 != null)
         {
            this.var_140.stop();
            this.var_140 = null;
         }
         for each(_loc1_ in this.characterStatesArray)
         {
            if(_loc1_.weapon.jetPack != null)
            {
               _loc1_.weapon.jetPack.gotoAndStop("off");
            }
         }
      }
      
      private function method_207(param1:Event) : *
      {
         var _loc2_:MovieClip = null;
         if(this.curWeapon != null && this.curWeapon.jetPack != null && this.curWeapon.jetPack.anim != null && this.var_140 != null)
         {
            this.curWeapon.jetPack.gotoAndStop("on");
            _loc2_ = this.curWeapon.jetPack.anim;
            if(_loc2_ != null && _loc2_.fire1 != null)
            {
               _loc2_.fire1.scaleY = Math.random() * 0.5 + 0.5;
               _loc2_.fire2.alpha = Math.random() * 0.5 + 0.5;
            }
         }
      }
      
      protected function getHighestHat() : Object
      {
         var hatNumber:int = 0;
         var hatColor:int = 0;
         var hatRemoved:Boolean = false;
         var slot:int = 4;
         while(slot >= 1)
         {
            if(this["hat" + slot] != 1)
            {
               hatNumber = int(this["hat" + slot]);
               hatColor = int(this["hat" + slot + "Color"]);
               this["hat" + slot] = 1;
               hatRemoved = true;
               break;
            }
            slot--;
         }
         if(hatRemoved)
         {
            this.applyAppearance();
         }
         var result:Object = new Object();
         result.hatNum = hatNumber;
         result.hatColor = hatColor;
         return result;
      }
      
      public function method_576() : *
      {
         this.method_200(new class_129(33,5000,this));
      }
      
      private function method_200(param1:class_125) : *
      {
         this.method_190();
         this.var_375 = param1;
      }
      
      private function method_190() : *
      {
         if(this.var_375 != null)
         {
            this.var_375.remove();
            this.var_375 = null;
         }
      }
      
      private function fadeOut(param1:Event) : *
      {
         alpha -= 0.02;
         if(alpha <= 0)
         {
            this.remove();
         }
      }
      
      public function beginRemove() : *
      {
         this.removeListeners();
         if(!this.fadeOutStarted && !this.removed)
         {
            this.fadeOutStarted = true;
            addEventListener(Event.ENTER_FRAME,this.fadeOut,false,0,true);
         }
      }
      
      protected function removeListeners() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.method_106);
         removeEventListener(Event.ENTER_FRAME,this.method_156);
         removeEventListener(Event.ENTER_FRAME,this.method_207);
      }
      
      override public function remove() : *
      {
         this.removeListeners();
         this.method_190();
         this.var_387.remove();
         if(!this.removed)
         {
            this.removed = this.fadeOutStarted = true;
            removeEventListener(Event.ENTER_FRAME,this.fadeOut);
            if(this.var_140 != null)
            {
               this.var_140.stop();
               this.var_140 = null;
            }
            this.m = null;
            this.curWeapon = null;
            this.characterStatesArray = new Array();
            this.var_4.remove();
            this.var_4 = null;
            super.remove();
         }
      }
   }
}
