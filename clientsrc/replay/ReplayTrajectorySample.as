package replay
{
   public class ReplayTrajectorySample
   {
      public var t:int;
      public var x:Number;
      public var y:Number;
      public var angle:Number;
      public var teleport:Boolean;

      public function ReplayTrajectorySample(param1:int = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Boolean = false)
      {
         this.t = param1;
         this.x = param2;
         this.y = param3;
         this.angle = param4;
         this.teleport = param5;
      }
   }
}
