package blocks
{
   import blocks.options.*;
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.geom.Point;
   import flash.utils.*;
   import package_6.*;
   import package_8.LocalCharacter;
   import package_9.*;
   
   public dynamic class TeleportBlock extends SupplyBlock
   {
      
      public static const DEFAULT_COLOR:int = 16744272;
       
      
      public var blockNum:int;
      
      private var color:int = 16744272;
      
      private var blockBG:Bitmap;
      
      private var resetTimeout:uint;
      
      public function TeleportBlock()
      {
         this.blockBG = new Bitmap();
         optionsMenu = TeleportBlockOptions;
         addChild(this.blockBG);
         this.setColor();
         super(Objects.BLOCK_TELEPORT);
         safeStand = false;
      }
      
      public static function resetAll() : *
      {
         var _loc1_:Array = null;
         var _loc2_:TeleportBlock = null;
         for each(_loc1_ in Course.course.teleportBlocks)
         {
            for each(_loc2_ in _loc1_)
            {
               _loc2_.clearResetTimeout();
               _loc2_.resetSupply();
               TeleportBlock["DISABLED_" + _loc2_.getColor()] = false;
            }
         }
         Course.course.teleportBlocks = {};
      }
      
      public function getColor() : *
      {
         return options != "" ? int(options) : DEFAULT_COLOR;
      }
      
      public function setColor(param1:int = 16744272) : *
      {
         this.color = param1;
         this.blockBG.bitmapData = new BitmapData(30,30,false,this.color);
      }
      
      public function applyOptions(param1:String) : *
      {
         this.setColor(param1);
         options = int(param1) != DEFAULT_COLOR ? param1 : "";
      }
      
      protected function disable() : *
      {
         uses = 0;
         method_789();
      }
      
      override public function onStand(param1:LocalCharacter) : *
      {
         super.onStand(param1);
         this.maybeTeleport(param1);
      }
      
      override public function onLeftHit(param1:LocalCharacter) : *
      {
         super.onLeftHit(param1);
         this.maybeTeleport(param1);
      }
      
      override public function onRightHit(param1:LocalCharacter) : *
      {
         super.onRightHit(param1);
         this.maybeTeleport(param1);
      }
      
      override public function onBump(param1:LocalCharacter) : *
      {
         var _loc2_:int = param1.y;
         super.onBump(param1);
         if(param1.crouching)
         {
            param1.y = _loc2_;
         }
         this.maybeTeleport(param1);
      }
      
      private function maybeTeleport(param1:LocalCharacter) : *
      {
         if(!frozen && TeleportBlock["DISABLED_" + this.color] !== true)
         {
            TeleportBlock["DISABLED_" + this.color] = true;
            super.maybeUseSupply(param1);
         }
      }
      
      override protected function useSupply(param1:LocalCharacter) : *
      {
         var blocksOfThisColor:Array;
         var destBlock:TeleportBlock;
         var i:int;
         var blockPos:Point = null;
         var newBlockPos:Point = null;
         var player:LocalCharacter = param1;
         super.useSupply(player);
         blocksOfThisColor = Course.course.teleportBlocks[this.color];
         destBlock = blocksOfThisColor != null && blocksOfThisColor.length > 1 ? blocksOfThisColor[this.blockNum + 1 >= blocksOfThisColor.length ? 0 : this.blockNum + 1] : this;
         i = 0;
         while(i < blocksOfThisColor.length)
         {
            if(blocksOfThisColor[i] != this)
            {
               blocksOfThisColor[i].disable();
            }
            i++;
         }
         new TeleportPop(player.x,player.y - 25);
         Main.socket.write("add_effect`Teleport`" + player.x + "`" + (player.y - 25));
         blockPos = method_18();
         newBlockPos = destBlock.method_18();
         player.x += newBlockPos.x - blockPos.x;
         player.y += newBlockPos.y - blockPos.y;
         new TeleportPop(player.x,player.y - 25);
         Main.socket.write("add_effect`Teleport`" + player.x + "`" + (player.y - 25));
         this.resetTimeout = setTimeout(function():*
         {
            resetAllOfColor();
         },3000);
      }
      
      public function clearResetTimeout() : *
      {
         clearTimeout(this.resetTimeout);
      }
      
      private function resetAllOfColor() : *
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         this.clearResetTimeout();
         if(Course.course != null)
         {
            _loc1_ = Course.course.teleportBlocks[this.color];
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               _loc1_[_loc2_].resetSupply();
               _loc2_++;
            }
         }
         TeleportBlock["DISABLED_" + this.color] = false;
      }
      
      override public function remove() : *
      {
         this.clearResetTimeout();
         delete TeleportBlock["DISABLED_" + this.color];
         removeChild(this.blockBG);
         super.remove();
      }
   }
}
