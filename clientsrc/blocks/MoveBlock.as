package blocks
{
   import background.Map;
   import com.jiggmin.data.*;
   import blocks.options.MoveBlockOptions;
   import flash.geom.*;
   
   public class MoveBlock extends Block
   {
      
      private var arrow:MoveArrow;
      
      private var dir:int;
      
      private var pattern:String = "";  // Empty string means random mode
      private var patternIndex:int = 0;
      private var moveInterval:Number = 1;
      private var loopPattern:Boolean = true;
      private var rigid:Boolean = false;
      
      private var sleeping:Boolean = false;
      private var sleepColor:ColorTransform = new ColorTransform(0.5, 0.5, 0.5);
      private var normalColor:ColorTransform = new ColorTransform();

      public function setSleeping(sleep:Boolean):void {
         if (this.sleeping == sleep) return;
         
         this.sleeping = sleep;
         this.transform.colorTransform = sleep ? sleepColor : normalColor;
         
         if (sleep) {
            // Remove from interval group when going to sleep
            if (this.map is Map) {
               Map(this.map).removeMoveBlock(this);
            }
            this.removeArrow();
         } else {
            this.displayArrow();
         }
      }

      public function MoveBlock()
      {
         this.arrow = new MoveArrow();
         optionsMenu = MoveBlockOptions;
         super(Objects.BLOCK_MOVE);
         safeStand = false;
      }

      public function getDirection():int
      {
         return this.dir;
      }
      
      public function setDirection(param1:int) : *
      {
         this.dir = param1;
         this.displayArrow();
      }
      
      public function getPattern():String {
         return this.pattern;
      }

      public function shift(param1:Map) : *
      {
         // Skip if sleeping
         if (this.sleeping) return;

         // Normal movement logic
         this.removeArrow();
         if(this.dir == 3) { move(-1,0,param1,true); }
         else if(this.dir == 2) { move(1,0,param1,true); }
         else if(this.dir == 1) { move(0,-1,param1,true); }
         else if(this.dir == 0) { move(0,1,param1,true); }
      }
      
      private function displayArrow() : *
      {
         addChild(this.arrow);
         this.arrow.x = this.arrow.y = 15;
         if(this.dir == 3)
         {
            this.arrow.rotation = 270;
         }
         else if(this.dir == 2)
         {
            this.arrow.rotation = 90;
         }
         else if(this.dir == 1)
         {
            this.arrow.rotation = 0;
         }
         else if(this.dir == 0)
         {
            this.arrow.rotation = 180;
         }
      }
      
      private function removeArrow() : *
      {
         if(this.arrow.parent != null)
         {
            this.arrow.parent.removeChild(this.arrow);
         }
      }
      
      public function isSleeping():Boolean {
         return this.sleeping;
      }
      
      override public function remove() : *
      {
         this.removeArrow();
         super.remove();
      }

      public function applyOptions(param1:String):* {
         this.loopPattern = true;
         this.rigid = false;
         if(param1 != "") {
            var opts:Array = param1.split(":");
            this.pattern = opts[0];
            if (opts.length > 1 && opts[1] != null && opts[1] != "") {
               this.moveInterval = Number(opts[1]);
               if (isNaN(this.moveInterval) || this.moveInterval <= 0) {
                  this.moveInterval = 1;
               }
            } else {
               this.moveInterval = 1;
            }
            var bitFlags:int = 1;
            if (opts.length > 2 && opts[2] != null && opts[2] != "") {
               var numericFlags:Number = Number(opts[2]);
               if (!isNaN(numericFlags)) {
                  bitFlags = int(numericFlags);
               }
            }
            this.loopPattern = (bitFlags & 1) != 0;
            this.rigid = (bitFlags & 2) != 0;
         } else {
            this.pattern = "";
            this.moveInterval = 1;
         }
         this.options = param1;
         this.patternIndex = 0;
         this.primeDirection();
      }

      public function getInterval():Number {
         return this.moveInterval;
      }
      
      public function setDirectionByPattern(param1:String):* {
         switch(param1) {
            case "N": this.dir = 1; break;
            case "S": this.dir = 0; break;
            case "E": this.dir = 2; break;
            case "W": this.dir = 3; break;
         }
         this.displayArrow();
      }

      public function isPatternMode():Boolean {
         return this.pattern != "";
      }

      public function primeDirection():void {
         if(this.pattern.length == 0) {
            return;
         }
         if(this.patternIndex >= this.pattern.length) {
            if(this.loopPattern) {
               this.patternIndex = 0;
            } else {
               this.setSleeping(true);
               return;
            }
         }
         this.setDirectionByPattern(this.pattern.charAt(this.patternIndex));
      }

      public function isRigid():Boolean {
         return this.rigid;
      }

      public function nextDirection():void {
         if(this.pattern.length == 0) {
            return;
         }
         this.patternIndex++;
         this.primeDirection();
      }
   }
}
