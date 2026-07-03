package page
{
   import background.*;
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.URLVariables;
   import flash.text.*;
   import flash.ui.*;
   import items.*;
   import package_22.*;
   import package_4.*;
   
   public class GamePage extends Page
   {
      
      public static var course:GamePage;
       
      
      private var segSize:int = 30;
      
      public var allowedItems:Vector.<int>;
      
      public var badHats:Vector.<int>;
      
      public var var_14:Sprite;
      
      protected var color:Number = 12303325;
      
      protected var var_133:Array;
      
      protected var zoom:Number = 1;
      
      public var scale:Number = 1;
      
      public var credits:Array;
      
      public var levelID:String;
      
      public var updatedTime:Number;
      
      public var title:String = "";
      
      public var note:String = "";
      
      public var song:String = "";
      
      public var gravity:String = "1";
      
      public var maxTime:String = "120";
      
      public var gameMode:String = "race";
      
      public var cowboyChance:String = "5";
      
      private var accel:Number = 10;
      
      private var friction:Number = 0.6;
      
      private var velX:Number = 0;
      
      private var velY:Number = 0;
      
      public var posX:Number = -20000;
      
      public var posY:Number = -20000;
      
      public var var_239:int = 60000;
      
      public var var_362:int = 60000;
      
      public var drawing:Boolean = false;
      
      protected var altCtrl:Object;
      
      private var rasterStopNotified:Boolean = false;
      
      public function GamePage()
      {
         this.var_14 = new Sprite();
         this.var_133 = new Array();
         this.credits = new Array();
         this.altCtrl = Settings.getValue(Settings.ALTERNATE_CONTROLS,Settings.DEFAULT_ALT_CONTROLS);
         super();
      }
      
      override public function initialize() : *
      {
         GamePage.course = this;
         x = 550 / 2;
         y = 400 / 2;
         addChild(this.var_14);
         Main.stage.focus = Main.stage;
         super.initialize();
         this.setItems("all");
         this.setBadHats("");
         if(CourseMenu.instance != null)
         {
            CourseMenu.instance.staticCloseMenu();
         }
      }
      
      protected function attachBackgrounds() : *
      {
      }
      
      protected function removeBackgrounds() : *
      {
      }
      
      public function setPos(param1:Number, param2:Number) : *
      {
      }
      
      public function setColor(param1:Number = 0) : *
      {
         this.color = param1;
      }
      
      public function getColor() : int
      {
         return this.color;
      }
      
      public function setSaveString(param1:String) : *
      {
      }
      
      public function startDrawing(param1:Background) : *
      {
         var _loc2_:int = int(this.var_133.indexOf(param1));
         if(_loc2_ == -1)
         {
            this.var_133.push(param1);
         }
         this.drawing = true;
      }
      
      public function finishDrawing(param1:Background) : *
      {
         var _loc2_:int = int(this.var_133.indexOf(param1));
         if(param1 is DrawableBackground && param1.stoppedRasterizing && !this.rasterStopNotified)
         {
            new MessagePopup("Error: Some art didn\'t load correctly. Don\'t worry! You can still play the level.\n\nYou can prevent this in the future by enabling lossless art quality in the options menu.");
            this.rasterStopNotified = true;
         }
         if(_loc2_ != -1)
         {
            this.var_133.splice(_loc2_,1);
         }
         if(this.var_133.length <= 0)
         {
            this.drawing = false;
         }
      }
      
      public function goodToDraw(param1:Background) : Boolean
      {
         return this.var_133[0] == param1 || this.var_133.length <= 0;
      }
      
      public function getCredits() : String
      {
         return this.credits.join("`");
      }
      
      public function setCredits(param1:String) : *
      {
         param1 = param1 == null ? "" : param1;
         this.credits = param1.split("`");
      }
      
      public function setGravity(param1:String) : *
      {
         this.gravity = param1;
      }
      
      public function setMaxTime(param1:String) : *
      {
         var _loc2_:String = param1;
         if(_loc2_ == 999 && this.updatedTime < 1358640000)
         {
            _loc2_ = "0";
         }
         this.maxTime = param1;
      }
      
      public function setSong(param1:String) : *
      {
         this.song = param1;
      }
      
      public function setGameMode(param1:String) : *
      {
         this.gameMode = param1 === "eggs" ? "egg" : param1;
      }
      
      public function setCowboyChance(param1:String) : *
      {
         var _loc2_:int = 5;
         if(param1 != null && param1 != "")
         {
            _loc2_ = int(parseInt(param1));
            _loc2_ = int(Data.numLimit(_loc2_,0,100));
         }
         param1 = _loc2_.toString();
         this.cowboyChance = param1;
      }
      
      public function setItems(param1:String) : *
      {
         var _loc2_:Array = null;
         var _loc3_:* = undefined;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         if(param1 == "")
         {
            this.allowedItems = new Vector.<int>();
         }
         else if(param1 == "all" || param1 == null)
         {
            this.allowedItems = Items.getAllCodes();
         }
         else
         {
            this.allowedItems = new Vector.<int>();
            _loc2_ = param1.split("`");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if((_loc4_ = String(_loc2_[_loc3_])).length > 1)
               {
                  _loc5_ = int(Items.getCodeFromName(_loc4_));
               }
               else
               {
                  _loc5_ = Number(_loc4_);
               }
               if(!isNaN(_loc5_) && _loc5_ >= 1 && _loc5_ <= Items.getAllCodes().length)
               {
                  this.allowedItems.push(_loc5_);
               }
               _loc3_++;
            }
         }
      }
      
      public function setBadHats(param1:String) : *
      {
         var _loc4_:int = 0;
         this.badHats = new Vector.<int>();
         if(param1 == "" || param1 == null)
         {
            return;
         }
         var _loc2_:Array = param1.split(",");
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = Number(_loc2_[_loc3_]);
            if(!isNaN(_loc4_) && _loc4_ > 1 && _loc4_ <= Parts.getPartArray("HAT").length + 1)
            {
               this.badHats.push(_loc4_);
            }
            _loc3_++;
         }
      }
      
      public function setVariables(param1:URLVariables) : *
      {
         this.updatedTime = param1.time is Array ? Number(param1.time[0]) : Number(param1.time);
         this.setCredits(param1.credits);
         this.setSaveString(this.method_645(param1.data));
         this.title = param1.title;
         this.note = param1.note;
         this.setSong(param1.song);
         this.setGameMode(param1.gameMode == null ? "race" : String(param1.gameMode));
         this.setCowboyChance(param1.cowboyChance);
         var _loc2_:* = String(param1.gravity);
         var _loc3_:Number = Number(_loc2_);
         if(isNaN(_loc3_))
         {
            _loc3_ = 0;
         }
         _loc3_ = Number(Data.numLimit(_loc3_,-99,99));
         _loc2_ = String(_loc3_);
         if(_loc2_.indexOf(".") == -1)
         {
            _loc2_ += ".0";
         }
         this.setGravity(_loc2_);
         var _loc4_:String = String(param1.max_time);
         var _loc5_:Number = Number(_loc4_);
         _loc5_ = Number(Data.numLimit(_loc5_,0,9999));
         _loc4_ = String(_loc5_);
         this.setMaxTime(_loc4_);
         this.setItems(param1.items);
         this.setBadHats(param1.badHats);
         this.levelID = param1.level_id;
      }
      
      public function validateSaveString(param1:String) : String
      {
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc2_:Array = new Array("credits=","data=","title=","note=","song=","gravity=","max_time=","items=","level_id=","live=","time=","min_level=","level_id=","has_pass=","gameMode=","version=","user_id=","cowboyChance=","badHats=");
         var _loc3_:* = "";
         param1 = param1.replace(/&/g,"and");
         var _loc4_:Array = param1.split("and");
         for each(_loc5_ in _loc4_)
         {
            _loc6_ = false;
            for each(_loc7_ in _loc2_)
            {
               if((_loc9_ = _loc5_.substr(0,_loc7_.length)) == _loc7_)
               {
                  _loc6_ = true;
                  break;
               }
            }
            _loc8_ = "and";
            if(_loc6_)
            {
               _loc8_ = "&";
            }
            if(_loc3_ == "")
            {
               _loc8_ = "";
            }
            _loc3_ += _loc8_ + _loc5_;
         }
         return _loc3_;
      }
      
      protected function method_645(param1:String) : String
      {
         var _loc2_:Array = param1.split("`");
         var _loc3_:String = String(_loc2_[0]);
         if(_loc3_ == "m1" || _loc3_ == "m2" || _loc3_ == "m3" || _loc3_ == "m4")
         {
            _loc2_.splice(0,1);
            _loc2_[0] = Number("0x" + _loc2_[0]);
            if(_loc3_ == "m1")
            {
               _loc2_[1] = this.decodeObjectString(_loc2_[1]);
               _loc2_[2] = this.decodeObjectString(_loc2_[2]);
               _loc2_[3] = this.decodeObjectString(_loc2_[3]);
               _loc2_[4] = this.decodeObjectString(_loc2_[4]);
            }
            else if(_loc3_ == "m2" || _loc3_ == "m3" || _loc3_ == "m4")
            {
               if(_loc3_ == "m2")
               {
                  _loc2_[1] = this.decodeObjectString2(_loc2_[1]);
               }
               else if(_loc3_ == "m3")
               {
                  _loc2_[1] = this.decodeObjectString2(_loc2_[1],this.segSize);
               }
               else
               {
                  _loc2_[1] = this.decodeBlockString(_loc2_[1]);
               }
               _loc2_[2] = this.decodeObjectString2(_loc2_[2]);
               _loc2_[3] = this.decodeObjectString2(_loc2_[3]);
               _loc2_[4] = this.decodeObjectString2(_loc2_[4]);
               _loc2_[9] = this.decodeObjectString2(_loc2_[9]);
               _loc2_[10] = this.decodeObjectString2(_loc2_[10]);
            }
            return _loc2_.join("`");
         }
         return param1;
      }
      
      private function decodeObjectString(param1:String) : String
      {
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc2_:Array = param1.split(",");
         var _loc3_:Array = _loc2_.shift().split(";");
         var _loc4_:Number = Number("0x" + _loc3_[0]);
         var _loc5_:Number = Number("0x" + _loc3_[1]);
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc6_].split(";");
            _loc7_ = Number("0x" + _loc3_[0]);
            _loc8_ = Number("0x" + _loc3_[1]) + _loc4_;
            _loc9_ = Number("0x" + _loc3_[2]) + _loc5_;
            _loc2_[_loc6_] = "o" + _loc7_ + ";" + _loc8_ + ";" + _loc9_;
            if(_loc3_[3] != null)
            {
               _loc10_ = Number("0x" + _loc3_[3]) / 100;
               _loc11_ = Number("0x" + _loc3_[4]) / 100;
               _loc2_[_loc6_] = _loc2_[_loc6_] + ";" + _loc10_ + ";" + _loc11_;
            }
            _loc6_++;
         }
         return _loc2_.join(",");
      }
      
      private function decodeObjectString2(param1:String, param2:int = 1) : String
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Array = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:String = null;
         var _loc15_:int = 0;
         var _loc5_:Array = param1 == null || param1 == "" ? new Array() : param1.split(",");
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(_loc5_.length > 0)
         {
            _loc10_ = 0;
            while(_loc10_ < _loc5_.length)
            {
               _loc3_ = _loc4_ = 0;
               _loc11_ = _loc5_[_loc10_].split(";");
               _loc12_ = Number(_loc11_[0]);
               _loc13_ = Number(_loc11_[1]);
               _loc8_ += _loc12_;
               _loc9_ += _loc13_;
               if(_loc11_[2] == "t")
               {
                  _loc14_ = String(_loc11_[3]);
                  _loc15_ = int(_loc11_[4]);
                  _loc3_ = Number(_loc11_[5]);
                  _loc4_ = Number(_loc11_[6]);
                  _loc5_[_loc10_] = "u" + _loc14_ + ";" + _loc8_ + ";" + _loc9_ + ";" + _loc15_ + ";" + _loc3_ + ";" + _loc4_;
               }
               else
               {
                  if(_loc11_[4] != null)
                  {
                     _loc7_ = int(_loc11_[2]);
                     _loc3_ = Number(_loc11_[3]) / 100;
                     _loc4_ = Number(_loc11_[4]) / 100;
                  }
                  else if(_loc11_[3] != null)
                  {
                     _loc3_ = Number(_loc11_[2]) / 100;
                     _loc4_ = Number(_loc11_[3]) / 100;
                  }
                  else if(_loc11_[2] != null)
                  {
                     _loc7_ = int(_loc11_[2]);
                  }
                  _loc5_[_loc10_] = "o" + _loc7_ + ";" + _loc8_ * param2 + ";" + _loc9_ * param2;
                  if(_loc3_ != 0 && _loc4_ != 0)
                  {
                     _loc5_[_loc10_] += ";" + _loc3_ + ";" + _loc4_;
                  }
               }
               _loc10_++;
            }
            _loc6_ = _loc5_.join(",");
         }
         return _loc6_;
      }
      
      private function decodeBlockString(encodedBlocks:String) : String
      {
         // Decodes delta-encoded block entries (dx;dy;type;extra) into absolute "o" entries using segSize.
         var decodedBlocks:String = null;
         var blockType:int = 0;
         var index:int = 0;
         var parts:Array = null;
         var deltaX:int = 0;
         var deltaY:int = 0;
         var extraData:String = null;
         var blockEntries:Array = encodedBlocks == null || encodedBlocks == "" ? new Array() : encodedBlocks.split(",");
         var gridX:int = 0;
         var gridY:int = 0;
         if(blockEntries.length > 0)
         {
            index = 0;
            while(index < blockEntries.length)
            {
               parts = blockEntries[index].split(";");
               deltaX = Number(parts[0]);
               deltaY = Number(parts[1]);
               gridX += deltaX;
               gridY += deltaY;
               if(parts[2] != null)
               {
                  blockType = int(parts[2]);
               }
               extraData = "";
               if(parts[3] != null)
               {
                  extraData = ";" + parts[3];
               }
               blockEntries[index] = "o" + blockType + ";" + gridX * this.segSize + ";" + gridY * this.segSize + extraData;
               index++;
            }
            decodedBlocks = blockEntries.join(",");
         }
         return decodedBlocks;
      }
      
      protected function glideToScale(param1:Event) : *
      {
         Main.stage.quality = StageQuality.LOW;
         this.scale += (this.zoom - this.scale) * 0.3;
         if(Math.abs(this.scale - this.zoom) <= 0.001)
         {
            this.finishGlide();
         }
         scaleX = scaleY = this.scale;
      }
      
      protected function finishGlide() : *
      {
         Main.stage.quality = StageQuality.HIGH;
         this.scale = this.zoom;
         removeEventListener(Event.ENTER_FRAME,this.glideToScale);
      }
      
      public function setZoom(param1:Number) : *
      {
         if(this.zoom != param1)
         {
            removeEventListener(Event.ENTER_FRAME,this.glideToScale);
            addEventListener(Event.ENTER_FRAME,this.glideToScale);
            this.zoom = param1;
         }
      }
      
      protected function keyScroll(param1:Event) : *
      {
         if(!(Main.stage.focus is TextField))
         {
            this.accel = Keys.isPressed(Keyboard.SHIFT) ? 20 : 10;
            if(Keys.isPressed(Keyboard.DOWN) || Keys.isPressed(this.altCtrl.down))
            {
               this.velY -= this.accel;
            }
            if(Keys.isPressed(Keyboard.UP) || Keys.isPressed(this.altCtrl.up))
            {
               this.velY += this.accel;
            }
            if(Keys.isPressed(Keyboard.LEFT) || Keys.isPressed(this.altCtrl.left))
            {
               this.velX += this.accel;
            }
            if(Keys.isPressed(Keyboard.RIGHT) || Keys.isPressed(this.altCtrl.right))
            {
               this.velX -= this.accel;
            }
            this.velX *= this.friction;
            this.velY *= this.friction;
            this.posX += this.velX * 1 / scaleX;
            this.posY += this.velY * 1 / scaleY;
         }
         this.setPos(this.posX,this.posY);
      }
      
      override public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.glideToScale);
         this.removeBackgrounds();
         super.remove();
         GamePage.course = null;
      }
   }
}
