package background
{
   import com.jiggmin.data.*;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.*;
   import flash.utils.*;
   import levelEditor.*;
   import package_4.*;
   import package_6.*;
   import page.GamePage;
   
   public class Background extends Sprite
   {
       
      
      protected var course:GamePage;
      
      private var var_394:uint;
      
      private var bgColor:Number = 13092571;
      
      public var scale:Number = 1;
      
      public var saveArray:Array;
      
      public var redoArray:Array;
      
      protected var var_39:Number = 0;
      
      protected var var_104:int;
      
      protected var var_141:int;
      
      protected var var_118:int;
      
      protected var var_120:int;
      
      public function Background(param1:GamePage)
      {
         this.saveArray = new Array();
         this.redoArray = new Array();
         super();
         this.course = param1;
         this.setScale(1);
      }
      
      public function setScale(param1:Number) : *
      {
         this.scale = param1;
         scaleX = scaleY = param1;
         this.method_59();
      }
      
      public function setColor(param1:Number) : *
      {
         this.bgColor = param1;
         this.method_59();
      }
      
      public function setPos(param1:Number, param2:Number) : *
      {
         x = Math.round(param1 * this.scale);
         y = Math.round(param2 * this.scale);
      }
      
      public function focusNone() : *
      {
         this.method_22();
         alpha = 1;
      }
      
      public function focusOn() : *
      {
         alpha = 1;
         mouseEnabled = true;
         mouseChildren = true;
      }
      
      public function method_22() : *
      {
         alpha = 0.25;
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function recordAction(param1:String) : *
      {
         var _loc2_:LevelEditorMenu = null;
         this.saveArray.push(param1);
         this.redoArray = new Array();
         if(LevelEditor.editor != null)
         {
            _loc2_ = LevelEditor.editor.menu;
            _loc2_.m.undoButton.enabled = true;
            _loc2_.m.redoButton.enabled = false;
         }
      }
      
      protected function method_59() : *
      {
         var _loc1_:Object = ColorUtil.hex24ToRGB(this.bgColor);
         var _loc2_:Number = (1 - this.scale) * 0.4 + 0.1;
         var _loc3_:ColorTransform = new ColorTransform(1 - _loc2_,1 - _loc2_,1 - _loc2_,1,_loc1_.red * _loc2_,_loc1_.green * _loc2_,_loc1_.blue * _loc2_,0);
         transform.colorTransform = _loc3_;
      }
      
      public function undo() : *
      {
         if(this.saveArray.length > 0)
         {
            this.redoArray.push(this.saveArray.pop());
         }
         this.clear();
         this.draw();
      }
      
      public function redo() : *
      {
         if(this.redoArray.length > 0)
         {
            this.saveArray.push(this.redoArray.pop());
         }
         this.clear();
         this.draw();
      }
      
      public function clear() : *
      {
         this.var_39 = 0;
         clearTimeout(this.var_394);
      }
      
      public function draw(param1:Number = 100) : *
      {
         var thisLayer:Background = null;
         var _arg_1:Number = param1;
         if(this.var_39 < this.saveArray.length)
         {
            if(this is DrawableBackground)
            {
               thisLayer = this;
               this.var_394 = setTimeout(function():*
               {
                  var msg:* = undefined;
                  var openPopups:* = undefined;
                  try
                  {
                     draw(_arg_1);
                  }
                  catch(e:Error)
                  {
                     msg = "Error: Some art didn\'t load correctly. ";
                     msg += Course.course is Game ? "Don\'t worry! You can still play the level." : "This could be because there\'s too much art on your level. Saving the level now may cause permanent damage to its playability. Try undoing your recent changes until you don\'t get this error, and then saving your work.";
                     msg += "\n\nIf this persists, please contact a member of the PR2 staff team.";
                     openPopups = Popup.getOpen();
                     if(openPopups.length == 0 || openPopups.length == 1 && openPopups[0] is PrizePopup)
                     {
                        new MessagePopup(msg);
                     }
                     course.finishDrawing(thisLayer);
                  }
               },10);
            }
            else
            {
               this.var_394 = setTimeout(this.draw,10,_arg_1);
            }
         }
         else
         {
            this.course.finishDrawing(this);
         }
      }
      
      public function getSaveString() : String
      {
         return this.saveArray.join(",");
      }
      
      public function setSaveString(param1:String, param2:Boolean = true) : *
      {
         this.saveArray = param1 != "" && param1 != "," && param1 != null ? param1.split(",") : new Array();
         this.clear();
         this.draw();
      }
      
      public function remove() : *
      {
         this.course = null;
         clearTimeout(this.var_394);
         this.saveArray = new Array();
         this.redoArray = new Array();
         parent.removeChild(this);
      }
      
      protected function method_118(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:DisplayObjectContainer, param8:Array) : *
      {
         var _loc9_:int = 0;
         var _loc10_:Point = Data.method_9(param3,param5,rotation);
         var _loc11_:Point = Data.method_9(param4,param6,rotation);
         param3 = Math.abs(_loc10_.x);
         param4 = Math.abs(_loc11_.x);
         param5 = Math.abs(_loc10_.y);
         param6 = Math.abs(_loc11_.y);
         var _loc12_:Number = 1 / scaleX * (1 / this.course.scale);
         param3 = Math.ceil(param3 * _loc12_);
         param4 = Math.ceil(param4 * _loc12_);
         param5 = Math.ceil(param5 * _loc12_);
         param6 = Math.ceil(param6 * _loc12_);
         var _loc13_:int = param1 - param3;
         var _loc14_:int = param1 + param4;
         var _loc15_:int = param2 - param5;
         var _loc16_:int = param2 + param6;
         if(Math.abs(_loc13_ - this.var_104) > 5 || Math.abs(_loc14_ - this.var_141) > 5 || Math.abs(_loc15_ - this.var_118) > 5 || Math.abs(_loc16_ - this.var_120) > 5)
         {
            _loc9_ = 0;
            while(this.var_104 + _loc9_ <= this.var_141)
            {
               this.method_64(this.var_104 + _loc9_,this.var_118,this.var_120,param7,param8,"remove");
               _loc9_++;
            }
            _loc9_ = 0;
            while(_loc13_ + _loc9_ <= _loc14_)
            {
               this.method_64(_loc13_ + _loc9_,_loc15_,_loc16_,param7,param8,"add");
               _loc9_++;
            }
         }
         else
         {
            _loc9_ = 0;
            while(this.var_104 + _loc9_ != _loc13_)
            {
               if(this.var_104 < _loc13_)
               {
                  this.method_64(this.var_104 + _loc9_,this.var_118,this.var_120,param7,param8,"remove");
                  _loc9_++;
               }
               else
               {
                  _loc9_--;
                  this.method_64(this.var_104 + _loc9_,_loc15_,_loc16_,param7,param8,"add");
               }
            }
            _loc9_ = 0;
            while(this.var_141 + _loc9_ != _loc14_)
            {
               if(this.var_141 < _loc14_)
               {
                  this.method_64(this.var_141 + ++_loc9_,_loc15_,_loc16_,param7,param8,"add");
               }
               else
               {
                  this.method_64(this.var_141 + _loc9_,this.var_118,this.var_120,param7,param8,"remove");
                  _loc9_--;
               }
            }
            _loc9_ = 0;
            while(this.var_118 + _loc9_ != _loc15_)
            {
               if(this.var_118 < _loc15_)
               {
                  this.method_94(this.var_118 + _loc9_,this.var_104,this.var_141,param7,param8,"remove");
                  _loc9_++;
               }
               else
               {
                  _loc9_--;
                  this.method_94(this.var_118 + _loc9_,_loc13_,_loc14_,param7,param8,"add");
               }
            }
            _loc9_ = 0;
            while(this.var_120 + _loc9_ != _loc16_)
            {
               if(this.var_120 < _loc16_)
               {
                  this.method_94(this.var_120 + ++_loc9_,_loc13_,_loc14_,param7,param8,"add");
               }
               else
               {
                  this.method_94(this.var_120 + _loc9_,this.var_104,this.var_141,param7,param8,"remove");
                  _loc9_--;
               }
            }
         }
         this.var_104 = _loc13_;
         this.var_141 = _loc14_;
         this.var_118 = _loc15_;
         this.var_120 = _loc16_;
      }
      
      protected function method_94(param1:int, param2:int, param3:int, param4:DisplayObjectContainer, param5:Array, param6:String) : *
      {
         var _loc7_:int = param2;
         while(_loc7_ <= param3)
         {
            this.method_447(_loc7_,param1,param4,param6,param5);
            _loc7_++;
         }
      }
      
      protected function method_64(param1:int, param2:int, param3:int, param4:DisplayObjectContainer, param5:Array, param6:String) : *
      {
         var _loc7_:int = param2;
         while(_loc7_ <= param3)
         {
            this.method_447(param1,_loc7_,param4,param6,param5);
            _loc7_++;
         }
      }
      
      protected function method_447(param1:int, param2:int, param3:DisplayObjectContainer, param4:String, param5:Array = null) : *
      {
         var _loc6_:DisplayObject = null;
         if(param5[param1] != null && param5[param1][param2] != null)
         {
            _loc6_ = param5[param1][param2];
            if(param4 == "add")
            {
               param3.addChild(_loc6_);
            }
            else if(_loc6_.parent == param3)
            {
               param3.removeChild(_loc6_);
            }
         }
      }
      
      public function method_32(param1:int, param2:int) : Boolean
      {
         return param1 >= this.var_104 && param1 <= this.var_141 && param2 >= this.var_118 && param2 <= this.var_120;
      }
   }
}
