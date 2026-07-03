package replay
{
   public class ReplayEvent
   {
      public var delta:int;
      public var timestamp:int;
      public var payload:String;

      public function ReplayEvent(param1:int, param2:int, param3:String)
      {
         this.delta = param1;
         this.timestamp = param2;
         this.payload = param3;
      }
   }
}
