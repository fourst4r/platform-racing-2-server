package replay
{
   public class ReplayTrajectory
   {
      private static const TELEPORT_DISTANCE_SQ:Number = 200 * 200;

      private var samples:Vector.<ReplayTrajectorySample>;
      private var lastIndex:int;

      public function ReplayTrajectory()
      {
         this.samples = new Vector.<ReplayTrajectorySample>();
         this.lastIndex = 0;
      }

      public function addSample(param1:int, param2:Number, param3:Number, param4:Number, param5:Boolean) : void
      {
         if(this.samples.length > 0)
         {
            var prev:ReplayTrajectorySample = this.samples[this.samples.length - 1];
            if(prev.t == param1)
            {
               prev.x = param2;
               prev.y = param3;
               prev.angle = param4;
               prev.teleport = prev.teleport || param5;
               return;
            }
            if(param1 < prev.t)
            {
               // out of order insert: append and sort minimally
               var sample:ReplayTrajectorySample = new ReplayTrajectorySample(param1,param2,param3,param4,param5);
               this.samples.push(sample);
               this.samples.sort(this.sortSamples);
               return;
            }
         }
         this.samples.push(new ReplayTrajectorySample(param1,param2,param3,param4,param5));
      }

      private function sortSamples(param1:ReplayTrajectorySample, param2:ReplayTrajectorySample) : int
      {
         if(param1.t < param2.t)
         {
            return -1;
         }
         if(param1.t > param2.t)
         {
            return 1;
         }
         return 0;
      }

      public function isEmpty() : Boolean
      {
         return this.samples.length == 0;
      }

      public function resetCursor() : void
      {
         this.lastIndex = 0;
      }

      public function evaluate(param1:int, param2:ReplayPose = null) : ReplayPose
      {
         var s0:ReplayTrajectorySample = null;
         var s1:ReplayTrajectorySample = null;
         var span:int = 0;
         var alpha:Number = NaN;
         var dx:Number = NaN;
         var dy:Number = NaN;
         if(param2 == null)
         {
            param2 = new ReplayPose();
         }
         if(this.samples.length == 0)
         {
            return param2.setTo(0,0,0);
         }
         var len:int = this.samples.length;
         var idx:int = this.lastIndex;
         if(idx < 0 || idx >= len)
         {
            idx = 0;
         }
         // rewind if needed
         while(idx > 0 && param1 < this.samples[idx].t)
         {
            idx--;
         }
         // advance while the next sample is still <= time
         while(idx + 1 < len && param1 >= this.samples[idx + 1].t)
         {
            idx++;
         }
         this.lastIndex = idx;
         s0 = this.samples[idx];
         if(idx == len - 1 || param1 <= s0.t)
         {
            return param2.setTo(s0.x,s0.y,s0.angle);
         }
         s1 = this.samples[idx + 1];
         if(s1.teleport)
         {
            if(param1 < s1.t)
            {
               return param2.setTo(s0.x,s0.y,s0.angle);
            }
            return param2.setTo(s1.x,s1.y,s1.angle);
         }
         dx = s1.x - s0.x;
         dy = s1.y - s0.y;
         if(dx * dx + dy * dy > TELEPORT_DISTANCE_SQ)
         {
            if(param1 < s1.t)
            {
               return param2.setTo(s0.x,s0.y,s0.angle);
            }
            return param2.setTo(s1.x,s1.y,s1.angle);
         }
         span = s1.t - s0.t;
         alpha = span > 0 ? (param1 - s0.t) / span : 0;
         if(alpha < 0)
         {
            alpha = 0;
         }
         else if(alpha > 1)
         {
            alpha = 1;
         }
         var x:Number = s0.x + dx * alpha;
         var y:Number = s0.y + dy * alpha;
         var angle:Number = this.lerpAngle(s0.angle,s1.angle,alpha);
         return param2.setTo(x,y,angle);
      }

      private function lerpAngle(param1:Number, param2:Number, param3:Number) : Number
      {
         var delta:Number = param2 - param1;
         while(delta > 180)
         {
            delta -= 360;
         }
         while(delta < -180)
         {
            delta += 360;
         }
         return param1 + delta * param3;
      }
   }
}
