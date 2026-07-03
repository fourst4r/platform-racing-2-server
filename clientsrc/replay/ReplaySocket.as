package replay
{
   import com.jiggmin.data.PR2Socket;

   public class ReplaySocket extends PR2Socket
   {
      private var player:ReplayPlayer;

      public function ReplaySocket(param1:ReplayPlayer)
      {
         super();
         this.player = param1;
      }

      override public function write(param1:String) : *
      {
         return null;
      }

      override public function getMS() : Number
      {
         return this.player != null ? this.player.currentTimeMs : 0;
      }

      override public function get connected() : Boolean
      {
         return false;
      }

      override public function close() : void
      {
      }

      override public function remove() : *
      {
         return null;
      }
   }
}
