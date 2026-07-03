package replay
{
   import com.jiggmin.data.CommandHandler;

   public class ReplayCommandFeeder
   {
      private var handler:CommandHandler;

      public function ReplayCommandFeeder()
      {
         this.handler = CommandHandler.commandHandler;
      }

      public function dispatch(args:String) : Boolean
      {
         if(args == null || args.length == 0)
         {
            return false;
         }
         var parts:Array = args.split("`");
         if(parts.length == 0)
         {
            return false;
         }
         var cmd:String = String(parts.shift());
         return this.handler.dispatchDirect(cmd,parts);
      }

      public function dispatchMany(args:Array) : int
      {
         if(args == null || args.length == 0)
         {
            return 0;
         }
         var batch:Array = [];
         for(var i:int = 0; i < args.length; i++)
         {
            var payload:String = args[i];
            if(payload == null || payload.length == 0)
            {
               continue;
            }
            var pieces:Array = payload.split("`");
            if(pieces.length == 0)
            {
               continue;
            }
            var cmd:String = String(pieces.shift());
            batch.push({cmd:cmd, args:pieces});
         }
         return this.handler.dispatchManyDirect(batch);
      }
   }
}
