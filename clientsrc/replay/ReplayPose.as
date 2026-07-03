package replay
{
   public class ReplayPose
   {
      public var x:Number = 0;
      public var y:Number = 0;
      public var angle:Number = 0;

      public function ReplayPose(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         this.x = param1;
         this.y = param2;
         this.angle = param3;
      }

      public function setTo(param1:Number, param2:Number, param3:Number) : ReplayPose
      {
         this.x = param1;
         this.y = param2;
         this.angle = param3;
         return this;
      }
   }
}
