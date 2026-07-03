package background
{
   import com.jiggmin.data.*;
   import flash.display.DisplayObject;
   import flash.geom.*;
   import levelEditor.*;
   import page.*;
   import package_8.Character;
   import package_6.Course;
   
   public class BlockBackground extends ObjectBackground
   {
       
      
      private var segSize:Number = 30;
      
      protected var blockArray:Array;
      
      public var blocksAttached:int = 0;
      
      public function BlockBackground(param1:GamePage)
      {
         this.blockArray = new Array();
         super(param1);
         this.addStartPositions();
         segMult = this.segSize;
         var_379 = -100;
      }
      
      protected function addStartPositions() : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc1_:Number = Number(Objects.BLOCK_START1);
         while(_loc1_ <= Objects.BLOCK_START4)
         {
            _loc2_ = _loc1_ * this.segSize + 10000;
            _loc3_ = this.segSize * 2 + 10000;
            this.addObject(_loc1_,_loc2_,_loc3_);
            _loc1_++;
         }
      }
      
      override public function addObject(param1:int, param2:int, param3:int, param4:String = "") : *
      {
         if(this.isOpen(param2,param3))
         {
            super.addObject(param1,param2,param3,param4);
         }
      }
      
      override protected function attachObject(param1:int, param2:int, param3:int, param4:String = "") : *
      {
         param1 += param1 < 100 ? 100 : 0;
         var _loc5_:BlockObject = new BlockObject(param1,param2,param3,param4);
         objArray.push(_loc5_);
         ++this.blocksAttached;

         var blockX:int = Math.round(param2 / this.segSize);
         var blockY:int = Math.round(param3 / this.segSize);
         this.addToBlockArray(_loc5_, blockX, blockY);
         if(method_32(blockX, blockY))
         {
            addChild(_loc5_);
         }
      }
      
      override public function setPos(param1:Number, param2:Number) : *
      {
         super.setPos(param1,param2);
         var _loc3_:Point = Data.method_9(GamePage.course.posX,GamePage.course.posY,rotation);
         var _loc4_:Point = this.getSegFromPos(_loc3_.x,_loc3_.y);
         method_118(-_loc4_.x,-_loc4_.y,11,9,8,6,this,this.blockArray);
      }
      
      override public function undo() : *
      {
         if(saveArray.length > 4)
         {
            super.undo();
         }
      }
      
      public function addToBlockArray2(param1:DisplayObject, param2:Point) : *
      {
         if(this.blockArray[param2.x] == null)
         {
            this.blockArray[param2.x] = new Array();
         }
         this.blockArray[param2.x][param2.y] = param1;
      }

      public function addToBlockArray(block:DisplayObject, x:int, y:int) : void
      {
         var col:Array = this.blockArray[x];
         if (col == null) {
            this.blockArray[x] = col = [];
         }
         col[y] = block;
      }
      
      public function getAllBlocksOfType(param1:Class) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:Array = [];
         for(_loc3_ in this.blockArray)
         {
            for(_loc4_ in this.blockArray[_loc3_])
            {
               if(this.blockArray[_loc3_][_loc4_] != null && this.blockArray[_loc3_][_loc4_].m is param1)
               {
                  _loc2_.push(this.blockArray[_loc3_][_loc4_]);
               }
            }
         }
         return _loc2_;
      }
      
      public function getBlockAt(param1:Number, param2:Number) : BlockObject
      {
         var _loc3_:int = int(Math.round(param1 / this.segSize));
         var _loc4_:int = int(Math.round(param2 / this.segSize));
         var _loc5_:Array;
         if((_loc5_ = this.blockArray[_loc3_]) != null)
         {
            return BlockObject(_loc5_[_loc4_]);
         }
         return null;
      }
      
      public function isOpen(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:int = int(Math.round(param1 / this.segSize));
         var _loc4_:int = int(Math.round(param2 / this.segSize));
         var _loc5_:BlockObject;
         return (_loc5_ = this.getBlockFromSeg(_loc3_,_loc4_)) == null;
      }
      
      public function getBlockFromPos(param1:Number, param2:Number, param3:Boolean = false) : *
      {
         var _loc4_:Point = param3 ? Data.method_9(param1,param2,rotation) : new Point(param1,param2);
         var _loc5_:Point = this.getSegFromPos(_loc4_.x,_loc4_.y);
         return this.getBlockFromSeg(_loc5_.x,_loc5_.y);
      }
      
      public function getBlockFromSeg(param1:int, param2:int) : *
      {
         var _loc3_:Array = this.blockArray.length >= param1 ? this.blockArray[param1] : null;
         return _loc3_ != null ? _loc3_[param2] : null;
      }
      
      override public function removeObjectsTouchingPoint(param1:Number, param2:Number) : *
      {
         var _loc3_:Point = this.globalToLocal(new Point(param1,param2));
         var _loc4_:BlockObject;
         if((_loc4_ = this.getBlockAt(_loc3_.x - 15,_loc3_.y - 15)) != null && _loc4_.deleteable)
         {
            recordDelete(_loc4_);
            _loc4_.remove();
         }
      }
      
      override protected function moveDrawObject(param1:String) : *
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:Array = param1.split(";");
         var _loc3_:Number = Number(_loc2_[0]);
         var _loc4_:BlockObject;
         if((_loc4_ = BlockObject(objArray[_loc3_])) != null)
         {
            _loc5_ = Number(_loc2_[1]);
            _loc6_ = Number(_loc2_[2]);
            this.moveBlock(new Point(_loc4_.segX,_loc4_.segY),this.getSegFromPos(_loc5_,_loc6_));
         }
      }
      
      override protected function drawText(param1:String) : *
      {
      }
      
      public function getSegFromPos(param1:Number, param2:Number) : Point
      {
         var _loc3_:Number = Math.floor(param1 / this.segSize);
         var _loc4_:Number = Math.floor(param2 / this.segSize);
         return new Point(_loc3_,_loc4_);
      }
      
      public function getPosFromSeg(param1:Number, param2:Number) : Point
      {
         var _loc3_:Number = param1 * this.segSize;
         var _loc4_:Number = param2 * this.segSize;
         return new Point(_loc3_,_loc4_);
      }
      
      public function getStartPos() : Point
      {
         var _loc1_:BlockObject = objArray[0];
         return new Point(_loc1_.x,_loc1_.y);
      }
      
      public function removeBlock(param1:*) : *
      {
         var _loc2_:Point = param1.getSeg();
         if(this.blockArray[_loc2_.x] != null)
         {
            this.blockArray[_loc2_.x][_loc2_.y] = null;
         }
         var _loc3_:int = objArray.indexOf(param1);
         if(_loc3_ != -1)
         {
            objArray.splice(_loc3_,1);
         }
      }
      
      public function moveBlock(param1:Point, param2:Point, ignorePlayers:Boolean = false) : Point
      {
         var srcX:int = int(param1.x);
         var srcY:int = int(param1.y);
         var dstX:int = int(param2.x);
         var dstY:int = int(param2.y);

         var _loc3_:DisplayObject = null;
         if(this.blockArray[srcX] != null)
         {
            _loc3_ = this.blockArray[srcX][srcY];
            var canMove:Boolean = _loc3_ != null && this.testMove(dstX,dstY,ignorePlayers);
            if(canMove)
            {
               this.addToBlockArray(null, srcX, srcY);
               this.addToBlockArray(_loc3_, dstX, dstY);
               _loc3_.setSeg(param2.x,param2.y);
               if(method_32(param2.x,param2.y))
               {
                  addChild(_loc3_);
               }
               else if(_loc3_.parent != null)
               {
                  _loc3_.parent.removeChild(_loc3_);
               }
               param1.x = param2.x;
               param1.y = param2.y;
            }
         }
         return param1;
      }
      
      public function testMove(param1:int, param2:int, ignorePlayers:Boolean = false) : Boolean
      {
         if (ignorePlayers) {
            return blockArray[param1] == null || blockArray[param1][param2] == null;
         }
         return (blockArray[param1] == null || blockArray[param1][param2] == null) && !this.characterOccupiesSpace(param1,param2);
      }

      public function characterOccupiesSpace(param1:int, param2:int) : Boolean
      {
         var _loc3_:Character = null;
         if(Course.course != null)
         {
            for each(_loc3_ in Course.course.playerArray)
            {
               if(_loc3_ != null && !_loc3_.removed && (_loc3_.seg1 != null && _loc3_.seg1.x == param1 && _loc3_.seg1.y == param2 || _loc3_.seg2 != null && _loc3_.seg2.x == param1 && _loc3_.seg2.y == param2))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      override public function clear() : *
      {
         super.clear();
         this.blockArray = new Array();
      }
      
      override public function remove() : *
      {
         this.clear();
         super.remove();
      }
   }
}
