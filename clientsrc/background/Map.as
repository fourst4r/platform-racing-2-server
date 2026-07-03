package background
{
   import blocks.*;
   import com.jiggmin.data.*;
   import flash.geom.*;
   import flash.utils.*;
   import package_6.*;
   import package_8.Character;
   import package_9.*;
   
   public class Map extends BlockBackground
   {
       
      
      private var startBlockNum:int = 0;
      
      private var miniMap:MiniMap;
      
      private var moveInterval:uint;
      
      private var segSize:Number = 30;
      
      public var maxY:Number = -9999999;
      
      public var minY:Number = 9999999;
      
      public var maxX:Number = -9999999;
      
      public var minX:Number = 9999999;
      
      private var moveBlocksArray:Vector.<MoveBlock>;
      
      private var startTime:int;
      
      private var moves:int = 0;
      
      private var moveTime:int = 5000;
      
      private var rand:Random;
      
      private var placedEggs:int = 0;
      
      private var eggPtsArray:Array;
      
      private var moveBlockIntervalTimers:Object = {}; // interval (Number) -> timer id
      private var moveBlockIntervalGroups:Object = {}; // interval (Number) -> [MoveBlock, ...]
      
      public function Map(param1:MiniMap, param2:Course)
      {
         this.moveBlocksArray = new Vector.<MoveBlock>();
         this.rand = new Random(1);
         this.eggPtsArray = new Array();
         this.miniMap = param1;
         super(param2);
         CommandHandler.commandHandler.defineCommand("activate",this.activate);
      }
      
      public function activate(param1:Array) : *
      {
         var _loc2_:int = int(param1[0]);
         var _loc3_:int = int(param1[1]);
         var _loc4_:String = String(param1[2]);
         var _loc5_:Block;
         if((_loc5_ = getBlockFromSeg(_loc2_,_loc3_)) != null)
         {
            _loc5_.remoteActivate(_loc4_);
         }
      }
      
      override protected function addStartPositions() : *
      {
      }
      
      public function placeBlock(param1:int, param2:Number, param3:Number) : *
      {
         this.attachObject(param1,param2,param3);
      }
      
      override protected function attachObject(param1:int, param2:int, param3:int, param4:String = "") : *
      {
         var _loc6_:Block = null;
         var _loc7_:FinishBlock = null;
         var _loc8_:int = 0;
         if(param1 < 100)
         {
            param1 += 100;
         }
         var _loc5_:Point = getSegFromPos(param2,param3);
         if(param1 == Objects.BLOCK_MINION_EGG)
         {
            this.eggPtsArray.push(new Point(param2,param3));
         }
         else if((_loc6_ = Block(Objects.getFromCode(param1))) is StartBlock)
         {
            this.setStartPos(this.startBlockNum,param2 + 15,param3 + 15);
            ++this.startBlockNum;
         }
         else
         {
            if(_loc6_ is FinishBlock)
            {
               _loc7_ = FinishBlock(_loc6_);
               this.addFinish(_loc7_.getId(),param2 + 15,param3 + 15);
            }
            if(_loc6_.hasOptions && param4 != "")
            {
               _loc6_.applyOptions(param4);
            }
            addToBlockArray(_loc6_, int(_loc5_.x), int(_loc5_.y));
            if(!_loc6_.isInitialized())
            {
               _loc6_.initialize(_loc5_.x,_loc5_.y,this);
            }
            if(method_32(_loc5_.x,_loc5_.y))
            {
               addChild(_loc6_);
            }
            if(_loc6_ is MoveBlock)
            {
               this.moveBlocksArray.push(_loc6_);
            }
            if(_loc6_ is TeleportBlock)
            {
               _loc8_ = int(_loc6_.getColor());
               if(!Course.course.teleportBlocks.hasOwnProperty(_loc8_))
               {
                  Course.course.teleportBlocks[_loc8_] = [];
               }
               Course.course.teleportBlocks[_loc8_].push(_loc6_);
               _loc6_.blockNum = Course.course.teleportBlocks[_loc8_].length - 1;
            }
            this.miniMap.method_680(param1,param2,param3);
         }
         if(param3 > this.maxY)
         {
            this.maxY = param3;
         }
         else if(param3 < this.minY)
         {
            this.minY = param3;
         }
         if(param2 > this.maxX)
         {
            this.maxX = param2;
         }
         else if(param2 < this.minX)
         {
            this.minX = param2;
         }
      }
      
      private function placeEggs() : *
      {
         var _loc1_:Point = null;
         for each(_loc1_ in this.eggPtsArray)
         {
            this.attachEgg(_loc1_.x + 15,_loc1_.y + 15);
         }
         this.eggPtsArray = new Array();
      }
      
      private function attachEgg(param1:int, param2:int) : *
      {
         var _loc3_:Egg = null;
         if(this.placedEggs < 25)
         {
            _loc3_ = new Egg();
            _loc3_.posX = param1 + 15;
            _loc3_.posY = param2 + 15;
            _loc3_.rot = 0;
            _loc3_.setLimits();
            ++this.placedEggs;
         }
      }
      
      private function setStartPos(param1:int, param2:int, param3:int) : *
      {
         Course.course.addStartPos(param1,new Point(param2,param3));
      }
      
      private function addFinish(param1:int, param2:int, param3:int) : *
      {
         Course.course.finishBlocks.push({
            "id":param1,
            "x":param2,
            "y":param3
         });
      }
      
      override public function draw(param1:Number = 50) : *
      {
         super.draw(param1);
         if(var_39 >= saveArray.length)
         {
            this.miniMap.rasterize();
         }
      }
      
      public function method_578() : *
      {
         this.startTime = new Date().time;
         this.determineMoveBlockDirection();
         this.placeEggs();
      }
      
      private function clearMoveBlockIntervalTimers():void {
         for (var key:String in moveBlockIntervalTimers) {
            clearTimeout(moveBlockIntervalTimers[key]);
         }
         moveBlockIntervalTimers = {};
         moveBlockIntervalGroups = {};
      }
      
      private function determineMoveBlockDirection() : *
      {
         clearMoveBlockIntervalTimers();

         // Group blocks by interval
         var randomBlocks:Array = [];
         moveBlockIntervalGroups = {};
         for (var i:int = 0; i < this.moveBlocksArray.length; i++) {
            var block:MoveBlock = this.moveBlocksArray[i];
            if (block.isPatternMode()) {
               var interval:Number = block.getInterval();
               var key:String = String(interval);
               if (!moveBlockIntervalGroups[key]) moveBlockIntervalGroups[key] = [];
               moveBlockIntervalGroups[key].push(block);
               block.primeDirection();
            } else {
               randomBlocks.push(block);
               var dir:int = int(this.rand.nextMinMax(0,4));
               block.setDirection(dir);
            }
         }

         var mapRef:Map = this;

         // factory that captures the blocks array, interval and key for each group
         function makeTick(blocks:Array, intv:Number, key:String):Function {
            return function():void {
               
               // --- PHASE 1: Calculate intended moves ---
               var intended:Array = [];
               var occupied:Object = {};
               var movingFrom:Object = {}; // key: "x_y" -> intended move object

               for each (var b:MoveBlock in blocks) {
                  if (b.isSleeping()) continue;
                  var seg:Point = b.getSeg();
                  if (!seg) continue;
                  var fromX:int = seg.x;
                  var fromY:int = seg.y;
                  var toX:int = fromX;
                  var toY:int = fromY;
                  var dir:int = b.getDirection();
                  if (dir == 3) { toX -= 1; }
                  else if (dir == 2) { toX += 1; }
                  else if (dir == 1) { toY -= 1; }
                  else if (dir == 0) { toY += 1; }
                  var moveObj = {block:b, from:{x:fromX, y:fromY}, to:{x:toX, y:toY}, dir:dir, allowed:false};
                  intended.push(moveObj);
                  occupied[fromX + "_" + fromY] = b;
                  movingFrom[fromX + "_" + fromY] = moveObj;
               }

               // Group intended moves by direction
               var dirGroups:Object = { "0":[], "1":[], "2":[], "3":[] };
               for each (var mv in intended) {
                  dirGroups[String(mv.dir)].push(mv);
               }

               // processing order: W(3), S(0), E(2), N(1)
               var processOrder:Array = [3,0,2,1];

               // helper: sorting for a given direction
               function sortForDir(arr:Array, d:int):void {
                  if (d == 2) { // E: rightmost first, tie top->bottom
                     arr.sort(function(a,b):int { return (b.from.x - a.from.x) != 0 ? (b.from.x - a.from.x) : (a.from.y - b.from.y); });
                  } else if (d == 3) { // W: leftmost first, tie top->bottom
                     arr.sort(function(a,b):int { return (a.from.x - b.from.x) != 0 ? (a.from.x - b.from.x) : (a.from.y - b.from.y); });
                  } else if (d == 1) { // N: topmost first, tie left->right
                     arr.sort(function(a,b):int { return (a.from.y - b.from.y) != 0 ? (a.from.y - b.from.y) : (a.from.x - b.from.x); });
                  } else if (d == 0) { // S: bottommost first, tie left->right
                     arr.sort(function(a,b):int { return (b.from.y - a.from.y) != 0 ? (b.from.y - a.from.y) : (a.from.x - b.from.x); });
                  }
               }

               // For each direction group: sort, validate (updating occupied), then perform moves
               for each (var d:int in processOrder) {
                  var group:Array = dirGroups[String(d)];
                  if (group == null || group.length == 0) continue;

                  sortForDir(group, d);

                  for each (var item in group) {
                     var keyTo:String = item.to.x + "_" + item.to.y;
                     var keyFrom:String = item.from.x + "_" + item.from.y;

                     // Check if destination is occupied by a block
                     var blockOccupied:Boolean = false;
                     var occupyingBlock = null;
                     if (blockArray[item.to.x] && blockArray[item.to.x][item.to.y] != null) {
                        occupyingBlock = blockArray[item.to.x][item.to.y];
                        blockOccupied = true;
                     }

                     // If occupied, allow move only if the occupying block is also moving away this tick
                     var canMoveIn:Boolean = true;
                     if (blockOccupied) {
                        var occupyingKey = keyTo;
                        var occupyingMove = movingFrom[occupyingKey];
                        if (!occupyingMove || occupyingMove.block == item.block || occupyingMove.allowed === false) {
                           canMoveIn = false;
                        }
                     }

                     if (!canMoveIn) continue;
                     if (occupied[keyTo] && occupied[keyTo] !== item.block) continue;

                     item.allowed = true;
                     occupied[keyTo] = item.block;
                     if (occupied[keyFrom] == item.block) {
                        delete occupied[keyFrom];
                     }
                  }

                  // Perform allowed moves for this group in sorted order
                  for each (var moveItem in group) {
                     var tKey:String = moveItem.to.x + "_" + moveItem.to.y;
                     var advanced:Boolean = false;
                     if (moveItem.allowed) {
                        // compute source and destination segments
                        var fromSeg:Point = new Point(moveItem.from.x, moveItem.from.y);
                        var toSeg:Point = new Point(moveItem.to.x, moveItem.to.y);
                        var dx:int = toSeg.x - fromSeg.x;
                        var dy:int = toSeg.y - fromSeg.y;

                        // If there's a PushBlock at destination, let it handle pushing first
                        var destBlock:Block = mapRef.getBlockFromSeg(toSeg.x, toSeg.y);
                        if(destBlock is PushBlock) {
                           PushBlock(destBlock).move(dx, dy, mapRef);
                        }

                        // Now attempt the move, ignoring players (they shouldn't block platform sync)
                        var canMove:Boolean = mapRef.testMove(toSeg.x, toSeg.y, true);
                        if(canMove) {
                           mapRef.moveBlock(fromSeg, toSeg, true);
                           advanced = true;
                        }
                     } else {
                        // Check sleep conditions for single-instruction blocks
                        if (moveItem.block.isPatternMode() && 
                            moveItem.block.getPattern().length == 1) {
                           var destBlock:Block = mapRef.getBlockFromSeg(moveItem.to.x, moveItem.to.y);
                           if (destBlock != null) {
                              var isMovableBlock:Boolean = (destBlock is PushBlock) || 
                                                         (destBlock is BrickBlock) ||
                                                         (destBlock is MineBlock) ||
                                                         (destBlock is CrumbleBlock) ||
                                                         (destBlock is MoveBlock && !MoveBlock(destBlock).isSleeping());
                              if (!isMovableBlock) {
                                 moveItem.block.setSleeping(true);
                                 continue;
                              }
                           }
                        }
                     }
                     if (advanced || !moveItem.block.isRigid()) {
                        moveItem.block.nextDirection();
                     }
                  }
               }

               // reschedule tick
               moveBlockIntervalTimers[key] = setTimeout(makeTick(blocks, intv, key), 1000 * intv);
            };
         }

         // Set timers for each interval group using the factory to avoid shared-variable capture
         for (var intervalStr:String in moveBlockIntervalGroups) {
            var blocksArr:Array = moveBlockIntervalGroups[intervalStr];
            var iv:Number = Number(intervalStr);
            var tick:Function = makeTick(blocksArr, iv, intervalStr);
            moveBlockIntervalTimers[intervalStr] = setTimeout(tick, 1000 * iv);
         }

         // For random-mode blocks keep original behavior:
         if (randomBlocks.length > 0) {
            this.setMoveInterval(this.doMoveBlocks, 1000);
         }
      }
      
      private function doMoveBlocks() : *
      {
         var _loc3_:MoveBlock = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.moveBlocksArray.length)
         {
            _loc3_ = this.moveBlocksArray[_loc1_];
            if(!_loc3_.isPatternMode())
            {
               _loc3_.shift(this);
            }
            _loc1_++;
         }
         var _loc2_:int = this.startTime + this.moves * this.moveTime - new Date().time;
         if(_loc2_ < 1)
         {
            _loc2_ = 1;
         }
         this.setMoveInterval(this.determineMoveBlockDirection,_loc2_ + this.moveTime);
         ++this.moves;
      }
      
      override public function testMove(param1:int, param2:int, ignorePlayers:Boolean = false) : Boolean
      {
         // If destination contains a block, it's blocked
         if (!(blockArray[param1] == null || blockArray[param1][param2] == null)) {
            return false;
         }

         // Check if any players are in the destination cell
         var blockPixelY:Number = param2 * this.segSize;
         var tolerance:Number = 8; // tweak as needed

         for each (var ch:Character in Course.course.playerArray) {
            if (ch == null || ch.removed) continue;
            if ((ch.seg1 != null && ch.seg1.x == param1 && ch.seg1.y == param2) ||
                (ch.seg2 != null && ch.seg2.x == param1 && ch.seg2.y == param2)) {
                // If player is standing on top, allow move
                if (ch.y <= blockPixelY + tolerance) {
                    continue;
                }
                // Otherwise, block move
                return false;
            }
         }

         return true;
      }
      
      public override function characterOccupiesSpace(param1:int, param2:int) : Boolean
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
      
      private function setMoveInterval(param1:Function, param2:int) : *
      {
         this.clearMoveInterval();
         this.moveInterval = setTimeout(param1,param2);
      }
      
      public function clearMoveInterval() : *
      {
         clearTimeout(this.moveInterval);
      }
      
      override public function clear() : *
      {
         var _loc1_:Block = null;
         while(numChildren > 0)
         {
            _loc1_ = Block(getChildAt(0));
            _loc1_.remove();
         }
         var_39 = 0;
         blockArray = new Array();
         objArray = new Array();
         clearMoveBlockIntervalTimers();
      }
      
      override public function remove() : *
      {
         CommandHandler.commandHandler.defineCommand("activate",null);
         this.moveBlocksArray = null;
         this.clearMoveInterval();
         this.miniMap = null;
         clearMoveBlockIntervalTimers();
         super.remove();
      }
      
      public function removeMoveBlock(block:MoveBlock):void {
         // Remove from moveBlocksArray
         var idx:int = this.moveBlocksArray.indexOf(block);
         if (idx != -1) {
            this.moveBlocksArray.splice(idx, 1);
         }
         
         // Remove from interval groups
         for (var key:String in moveBlockIntervalGroups) {
            var group:Array = moveBlockIntervalGroups[key];
            idx = group.indexOf(block);
            if (idx != -1) {
               group.splice(idx, 1);
               // If group is empty, clear its timer
               if (group.length == 0) {
                  clearTimeout(moveBlockIntervalTimers[key]);
                  delete moveBlockIntervalTimers[key];
                  delete moveBlockIntervalGroups[key];
               }
            }
         }
      }
   }
}
