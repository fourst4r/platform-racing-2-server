package replay
{
   public class ReplayLeaderboardEntry
   {
      public var replayId:String;
      public var rank:int;
      public var timeMs:int;
      public var displayTime:String;
      public var participants:Array;
      public var createdAt:Number;
      public var canWatch:Boolean;
      public var hidden:Boolean;
      public var hiddenAtMs:Number;
      public var hiddenByUserId:int;

      public function ReplayLeaderboardEntry()
      {
         this.participants = [];
         this.displayTime = "";
         this.canWatch = true;
         this.hidden = false;
         this.hiddenAtMs = 0;
         this.hiddenByUserId = 0;
      }
   }
}
