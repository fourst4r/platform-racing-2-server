package replay
{
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import Main;

   public class ReplayLeaderboardData
   {
      public static const FULL_COUNT:int = 1000;

      public static function buildRequest(levelId:String, isPr2Hub:Boolean, count:int, includeHidden:Boolean, includeParticipants:Boolean = true) : URLRequest
      {
         var vars:URLVariables = new URLVariables();
         vars.level_id = levelId;
         vars.is_pr2hub = isPr2Hub ? "1" : "0";
         vars.count = count;
         vars.rand = Math.random();
         if(includeParticipants)
         {
            vars.include_participants = 1;
         }
         if(includeHidden)
         {
            vars.include_hidden = 1;
         }
         if(Main.token != null && Main.token.length > 0)
         {
            vars.token = Main.token;
         }
         var request:URLRequest = new URLRequest(Main.baseURL + "/replays_leaderboard.php");
         request.method = URLRequestMethod.GET;
         request.data = vars;
         return request;
      }

      public static function getErrorMessage(response:Object, fallback:String) : String
      {
         if(response != null && response.success === false)
         {
            return response.error != null ? String(response.error) : fallback;
         }
         return null;
      }

      public static function getRowsForMode(response:Object, mode:String) : Array
      {
         if(response == null)
         {
            return [];
         }
         if(response.replays != null && response.replays[mode] is Array)
         {
            return (response.replays[mode] as Array).concat();
         }
         if(mode == "solo" && response.entries is Array)
         {
            return (response.entries as Array).concat();
         }
         return [];
      }

      public static function getVisibleRows(rows:Array) : Array
      {
         var visibleRows:Array = [];
         var row:Object = null;
         if(rows == null)
         {
            return visibleRows;
         }
         for each(row in rows)
         {
            if(!isReplayHidden(row))
            {
               visibleRows.push(row);
            }
         }
         return visibleRows;
      }

      public static function limitRows(rows:Array, count:int) : Array
      {
         if(rows == null)
         {
            return [];
         }
         if(count <= 0 || rows.length <= count)
         {
            return rows.concat();
         }
         return rows.slice(0, count);
      }

      public static function buildEntry(row:Object, rank:int, includeRank:Boolean = true) : ReplayLeaderboardEntry
      {
         var entry:ReplayLeaderboardEntry = new ReplayLeaderboardEntry();
         entry.rank = rank;
         entry.replayId = getReplayId(row);
         entry.timeMs = row != null && row.first_finish_time_ms != null ? int(row.first_finish_time_ms) : 0;
         entry.displayTime = buildDisplayTime(row, entry.rank, entry.timeMs, includeRank);
         entry.participants = extractParticipants(row);
         entry.createdAt = row != null && row.created_at_ms != null ? Number(row.created_at_ms) : 0;
         entry.canWatch = row == null || row.can_watch == null || readBoolean(row.can_watch);
         entry.hidden = isReplayHidden(row);
         entry.hiddenAtMs = row != null && row.hidden_at_ms != null ? Number(row.hidden_at_ms) : 0;
         entry.hiddenByUserId = row != null && row.hidden_by_user_id != null ? int(row.hidden_by_user_id) : 0;
         return entry;
      }

      public static function getReplayId(row:Object) : String
      {
         if(row == null)
         {
            return "";
         }
         if(row.id != null)
         {
            return String(row.id);
         }
         if(row.replay_id != null)
         {
            return String(row.replay_id);
         }
         if(row.replayId != null)
         {
            return String(row.replayId);
         }
         return "";
      }

      public static function isReplayHidden(row:Object) : Boolean
      {
         return row != null && readBoolean(row.hidden);
      }

      public static function readBoolean(value:*) : Boolean
      {
         var text:String = null;
         if(value is Boolean)
         {
            return Boolean(value);
         }
         if(value is Number || value is int || value is uint)
         {
            return Number(value) != 0;
         }
         if(value == null)
         {
            return false;
         }
         text = String(value).toLowerCase();
         return text == "1" || text == "true" || text == "yes";
      }

      private static function extractParticipants(row:Object) : Array
      {
         var result:Array = [];
         var participants:Array = null;
         var participant:Object = null;
         if(row == null)
         {
            return result;
         }
         if(row.participants is Array)
         {
            participants = row.participants as Array;
            for each(participant in participants)
            {
               if(participant is String)
               {
                  result.push(String(participant));
               }
               else if(participant != null && participant.username != null)
               {
                  result.push(String(participant.username));
               }
            }
         }
         else if(row.first_finisher_name != null)
         {
            result.push(String(row.first_finisher_name));
         }
         return result;
      }

      private static function buildDisplayTime(row:Object, rank:int, timeMs:int, includeRank:Boolean) : String
      {
         var timeText:String = formatTime(timeMs);
         if(row != null && row.mode === "objective" && int(row.best_objectives_hit) > 0)
         {
            timeText = "[" + int(row.best_objectives_hit) + "] " + timeText;
         }
         if(includeRank)
         {
            timeText = "#" + rank + " " + timeText;
         }
         return timeText;
      }

      private static function formatTime(totalMilliseconds:int) : String
      {
         var totalSeconds:Number = totalMilliseconds / 1000;
         var minutes:int = int(totalSeconds / 60);
         var seconds:Number = totalSeconds % 60;
         var ms:int = Math.round((totalMilliseconds % 1000) / 10);
         var secStr:String = seconds < 10 ? "0" + int(seconds) : int(seconds).toString();
         var msStr:String = ("00" + ms).substr(-2);
         return minutes + ":" + secStr + "." + msStr;
      }
   }
}
