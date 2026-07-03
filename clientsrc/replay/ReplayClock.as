package replay
{
   public class ReplayClock
   {
      private static var _nowMs:int = 0;
      private static var _active:Boolean = false;

      public function ReplayClock()
      {
      }

      public static function get nowMs() : int
      {
         return _nowMs;
      }

      public static function setNow(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         _nowMs = param1;
      }

      public static function activate() : void
      {
         _active = true;
         _nowMs = 0;
      }

      public static function deactivate() : void
      {
         _active = false;
         _nowMs = 0;
      }

      public static function get isActive() : Boolean
      {
         return _active;
      }
   }
}
