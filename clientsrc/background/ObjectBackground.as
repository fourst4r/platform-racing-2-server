package background
{
   import com.jiggmin.data.*;
   import flash.display.Sprite;
   import levelEditor.*;
   import package_4.*;
   import page.GamePage;
   import flash.utils.getTimer;
   
   public class ObjectBackground extends Background
   {
       
      
      public var objCanvas:Sprite;
      
      public var objArray:Array;
      
      private var objLimit:int = 50000;
      
      protected var var_0379:int = 0;
      
      protected var segMult:int = 1;
      
      public function ObjectBackground(param1:GamePage)
      {
         this.objArray = new Array();
         this.objCanvas = this;
         super(param1);
      }
      
      public function addObject(param1:int, param2:int, param3:int, param4:String = "") : *
      {
         if(this.objArray.length < this.objLimit)
         {
            this.attachObject(param1,param2,param3);
            this.recordAddObject(param1,param2,param3);
         }
         else
         {
            LevelEditor.editor.menu.reset();
            new MessagePopup("Error: Object limit reached.");
         }
      }
      
      protected function attachObject(param1:int, param2:int, param3:int, param4:String = "") : *
      {
         var _loc5_:DrawObject = new DrawObject(param1,param2,param3);
         this.objCanvas.addChild(_loc5_);
         this.objArray.push(_loc5_);
      }
      
      public function addText(param1:String, param2:int, param3:int, param4:int, param5:Boolean = false) : TextObject
      {
         var _loc6_:TextObject = null;
         if(this.objArray.length < this.objLimit)
         {
            _loc6_ = new TextObject(param1,param2,param3,param4);
            this.objCanvas.addChild(_loc6_);
            this.objArray.push(_loc6_);
            if(param5)
            {
               this.recordAddText(_loc6_.getEscapedText(),param2,param3,param4);
            }
            return _loc6_;
         }
         return null;
      }
      
      public function recordAddObject(param1:int, param2:int, param3:int) : *
      {
         recordAction("o" + param1 + ";" + param2 + ";" + param3);
      }
      
      public function recordAddText(param1:String, param2:int, param3:int, param4:int) : *
      {
         recordAction("u" + param1 + ";" + param2 + ";" + param3 + ";" + param4 + ";100;100");
      }
      
      public function recordChangeText(param1:TextObject) : *
      {
         var _loc2_:int = this.objArray.indexOf(param1);
         recordAction("y" + _loc2_ + ";" + param1.getEscapedText() + ";" + param1.getColor());
      }
      
      public function recordMove(param1:DrawObject) : *
      {
         var _loc2_:int = this.objArray.indexOf(param1);
         recordAction("m" + _loc2_ + ";" + param1.x + ";" + param1.y);
      }
      
      public function recordDelete(param1:DrawObject) : *
      {
         var _loc2_:int = this.objArray.indexOf(param1);
         recordAction("d" + _loc2_);
      }
      
      public function recordResize(param1:DrawObject) : *
      {
         var _loc2_:int = this.objArray.indexOf(param1);
         recordAction("r" + _loc2_ + ";" + param1.scaleX + ";" + param1.scaleY);
      }
      
      override public function draw(frameBudget:Number = 50) : *
      {
         course.startDrawing(this);
         if(course.goodToDraw(this))
         {
            var start:int = getTimer();
            while (var_39 < saveArray.length) {
               var entry:String = saveArray[var_39];
               var c:int = entry.charCodeAt(0);

               switch (c) {
                  case 111: /* 'o' */ placeObject(entry.substr(1)); break;
                  case 109: /* 'm' */ moveDrawObject(entry.substr(1)); break;
                  case 100: /* 'd' */ deleteObject(entry.substr(1)); break;
                  case 114: /* 'r' */ resizeObject(entry.substr(1)); break;
                  case 117: /* 'u' */ drawText(entry.substr(1)); break;
                  case 121: /* 'y' */ updateText(entry.substr(1)); break;
               }

               ++var_39;
               if ((var_39 & 31) == 0) { // every 32 entries
                  if (getTimer() - start > 50) break;
               }
            }
         }
         super.draw(frameBudget);
      }
      
      protected function drawText(param1:String) : *
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:TextObject = null;
         if(this.objArray.length < this.objLimit)
         {
            _loc2_ = param1.split(";");
            _loc3_ = String(_loc2_[0]);
            _loc4_ = int(_loc2_[1]);
            _loc5_ = int(_loc2_[2]);
            _loc6_ = int(_loc2_[3]);
            _loc7_ = Number(_loc2_[4]) / 100;
            _loc8_ = Number(_loc2_[5]) / 100;
            (_loc9_ = this.addText(_loc3_,_loc4_,_loc5_,_loc6_)).scaleX = _loc7_;
            _loc9_.scaleY = _loc8_;
         }
      }
      
      protected function placeObject(param1:String) : *
      {
         var _loc2_:Array = null;
         if(this.objArray.length < this.objLimit)
         {
            _loc2_ = param1.split(";");
            this.attachObject(int(_loc2_[0]),Number(_loc2_[1]),Number(_loc2_[2]),this is BlockBackground && _loc2_[3] != null ? String(_loc2_[3]) : "");
            if(_loc2_[4] != null)
            {
               this.resizeObject(this.objArray.length - 1 + ";" + _loc2_[3] + ";" + _loc2_[4]);
            }
         }
      }
      
      protected function moveDrawObject(param1:String) : *
      {
         var _loc2_:Array = param1.split(";");
         var _loc3_:DrawObject = DrawObject(this.objArray[Number(_loc2_[0])]);
         if(_loc3_ != null)
         {
            _loc3_.x = Number(_loc2_[1]);
            _loc3_.y = Number(_loc2_[2]);
         }
      }
      
      protected function updateText(param1:String) : *
      {
         var _loc2_:Array = param1.split(";");
         var _loc3_:int = int(_loc2_[0]);
         var _loc4_:String = String(_loc2_[1]);
         var _loc5_:int = int(_loc2_[2]);
         var _loc6_:TextObject;
         (_loc6_ = TextObject(this.objArray[_loc3_])).showParsedText(_loc4_);
         _loc6_.setColor(_loc5_);
      }
      
      protected function deleteObject(param1:String) : *
      {
         var _loc2_:DrawObject = DrawObject(this.objArray[int(param1)]);
         if(_loc2_.displayCode != Objects.BLOCK_START1 && _loc2_.displayCode != Objects.BLOCK_START2 && _loc2_.displayCode != Objects.BLOCK_START3 && _loc2_.displayCode != Objects.BLOCK_START4)
         {
            _loc2_.remove();
         }
      }
      
      protected function resizeObject(param1:String) : *
      {
         var _loc5_:Number = NaN;
         var _loc2_:Array = param1.split(";");
         var _loc3_:Number = Number(_loc2_[0]);
         var _loc4_:Number = Number(_loc2_[1]);
         _loc5_ = Number(_loc2_[2]);
         var _loc6_:DrawObject;
         (_loc6_ = DrawObject(this.objArray[_loc3_])).scaleX = _loc4_;
         _loc6_.scaleY = _loc5_;
      }
      
      override public function getSaveString() : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:DrawObject = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:BlockObject = null;
         var _loc17_:String = null;
         var _loc18_:TextObject = null;
         var _loc1_:String = "";
         if(this.objArray.length > 0)
         {
            _loc5_ = "";
            _loc6_ = new Array();
            _loc7_ = 0;
            while(_loc7_ < this.objArray.length)
            {
               if((_loc8_ = this.objArray[_loc7_]) != null)
               {
                  _loc9_ = int(_loc8_.x / this.segMult);
                  _loc10_ = int(_loc8_.y / this.segMult);
                  _loc11_ = _loc9_ - _loc13_;
                  _loc12_ = _loc10_ - _loc14_;
                  _loc13_ = _loc9_;
                  _loc14_ = _loc10_;
                  _loc15_ = _loc8_.displayCode + this.var_0379;
                  _loc5_ = _loc11_ + ";" + _loc12_;
                  if(_loc8_ is BlockObject && this is BlockBackground)
                  {
                     _loc17_ = (_loc16_ = BlockObject(_loc8_)).getOptionsString();
                     if(_loc15_ != _loc2_ || _loc17_ != "")
                     {
                        _loc2_ = _loc15_;
                        _loc5_ += ";" + _loc15_;
                        if(_loc17_ != null && _loc17_ != "")
                        {
                           _loc5_ += ";" + _loc17_;
                        }
                     }
                  }
                  else
                  {
                     if(_loc15_ != _loc2_)
                     {
                        _loc2_ = _loc15_;
                        _loc5_ += ";" + _loc15_;
                     }
                     if(_loc8_.scaleX != 1 || _loc8_.scaleY != 1)
                     {
                        _loc3_ = _loc8_.scaleX * 100;
                        _loc4_ = _loc8_.scaleY * 100;
                        _loc5_ += ";" + _loc3_ + ";" + _loc4_;
                     }
                     if(_loc8_ is TextObject)
                     {
                        _loc3_ = _loc8_.scaleX * 100;
                        _loc4_ = _loc8_.scaleY * 100;
                        if((_loc18_ = TextObject(_loc8_)).getText() != "" && _loc18_.getText() != " ")
                        {
                           _loc5_ = _loc11_ + ";" + _loc12_ + ";" + "t" + ";" + _loc18_.getEscapedText() + ";" + _loc18_.getColor() + ";" + _loc3_ + ";" + _loc4_;
                        }
                        else
                        {
                           _loc5_ = "";
                        }
                     }
                  }
                  if(_loc5_ != "")
                  {
                     _loc6_.push(_loc5_);
                  }
               }
               _loc7_++;
            }
            _loc1_ = _loc6_.join(",");
         }
         return _loc1_;
      }
      
      override public function setSaveString(param1:String, param2:Boolean = true) : *
      {
         this.clear();
         if(param1 != null)
         {
            saveArray = param1.split(",");
            this.draw();
         }
      }
      
      public function removeObjectsTouchingPoint(param1:Number, param2:Number) : *
      {
         var _loc4_:DrawObject = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.objArray.length)
         {
            if((_loc4_ = this.objArray[_loc3_]) != null && _loc4_.deleteable && _loc4_.hitTestPoint(param1,param2,true))
            {
               this.recordDelete(_loc4_);
               _loc4_.remove();
            }
            _loc3_++;
         }
      }
      
      public function method_771(param1:*) : *
      {
         var _loc2_:int = this.objArray.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.objArray.splice(_loc2_,1);
         }
      }
      
      override public function clear() : *
      {
         var _loc2_:DrawObject = null;
         var _loc1_:int = int(this.objArray.length - 1);
         while(_loc1_ >= 0)
         {
            _loc2_ = this.objArray[_loc1_];
            _loc2_.remove();
            _loc1_--;
         }
         this.objArray = new Array();
         super.clear();
      }
      
      override public function remove() : *
      {
         this.clear();
         this.objCanvas = null;
         super.remove();
      }
   }
}
