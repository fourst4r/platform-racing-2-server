package background
{
   import com.jiggmin.data.*;
   import flash.display.DisplayObject;
   import package_9.*;
   import page.GamePage;
   import sounds.*;
   
   public class EffectBackground extends Background
   {
      
      public static var instance:EffectBackground;
      
      public var blockPieceSystem:BlockPieceSystem;
       
      
      public function EffectBackground(param1:GamePage)
      {
         EffectBackground.instance = this;
         mouseEnabled = false;
         mouseChildren = false;
         tabEnabled = false;
         tabChildren = false;
         focusRect = false;
         CommandHandler.commandHandler.defineCommand("addEffect",this.addEffect);
         super(param1);
         this.blockPieceSystem = new BlockPieceSystem(this);
         addChild(this.blockPieceSystem);
      }
      
      public function addEffect(param1:Array) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc4_:String = String(param1[0]);
         var _loc5_:int = int(param1[1]);
         var _loc6_:int = int(param1[2]);
         if(_loc4_ == "Laser" || _loc4_ == "Slash")
         {
            _loc7_ = String(param1[3]);
         }
         else
         {
            _loc8_ = int(param1[3]);
         }
         if(_loc4_ == "Laser")
         {
            _loc2_ = int(param1[4]);
            _loc3_ = int(param1[5]);
            new LaserShot(_loc5_,_loc6_,_loc7_,_loc2_,_loc3_);
         }
         else if(_loc4_ == "Slash")
         {
            _loc3_ = int(param1[4]);
            new Slash(_loc5_,_loc6_,_loc7_,_loc3_);
         }
         else if(_loc4_ == "Mine")
         {
            new MineAppear(_loc5_,_loc6_);
         }
         else if(_loc4_ == "Hat")
         {
            _loc9_ = int(param1[4]);
            _loc10_ = int(param1[5]);
            _loc11_ = int(param1[6]);
            _loc12_ = int(param1[7]);
            new Hat(_loc5_,_loc6_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_);
         }
         else if(_loc4_ == "IceWave")
         {
            _loc2_ = int(param1[4]);
            _loc3_ = int(param1[5]);
            this.generateIceWaveShots(_loc5_,_loc6_,_loc8_,_loc2_,_loc3_);
         }
         else if(_loc4_ == "Teleport")
         {
            new TeleportPop(_loc5_,_loc6_);
         }
      }
      
      private function generateIceWaveShots(param1:int, param2:int, param3:int, param4:int, param5:int) : *
      {
         new IceWaveShot(param1,param2,param3,param4,param5,param3);
         new IceWaveShot(param1,param2,param3 + 30,param4,param5,param3);
         new IceWaveShot(param1,param2,param3 - 30,param4,param5,param3);
         SoundEffects.playGameSound(new IceWaveSound(),param1,param2,1.5);
      }
      
      override public function clear() : *
      {
         if(this.blockPieceSystem != null)
         {
            this.blockPieceSystem.clear();
         }
         while(numChildren > 0)
         {
            var child:DisplayObject = getChildAt(numChildren - 1);
            if(child == this.blockPieceSystem)
            {
               removeChild(child);
               continue;
            }
            Removable(child).remove();
         }
         if(this.blockPieceSystem != null && this.blockPieceSystem.parent == null)
         {
            addChild(this.blockPieceSystem);
         }
      }
      
      override public function remove() : *
      {
         this.clear();
         if(this.blockPieceSystem != null)
         {
            this.blockPieceSystem.remove();
            this.blockPieceSystem = null;
         }
         EffectBackground.instance = null;
         CommandHandler.commandHandler.defineCommand("addEffect",null);
         super.remove();
      }
   }
}
