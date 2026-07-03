package replay
{
   public class ReplayData
   {
      public var meta:Object;
      public var levelText:String;
      public var events:Vector.<ReplayEvent>;
      public var totalDuration:int;

      public function ReplayData()
      {
         this.events = new Vector.<ReplayEvent>();
      }
   }
}
