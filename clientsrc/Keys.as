package
{
   import flash.display.Stage;
   import flash.events.*;
   
   public class Keys
   {
      
      private static var initialized:Boolean = false;
      
      // tracks currently held keys
      private static var keys:Object = new Object();
      
      // tracks keys that have been pressed-and-released since last query
      private static var justPressedMap:Object = new Object();
       
      
      public function Keys()
      {
         super();
      }
      
      public static function initialize(param1:Stage) : *
      {
         param1.addEventListener(KeyboardEvent.KEY_DOWN,keyPressed);
         param1.addEventListener(KeyboardEvent.KEY_UP,keyReleased);
         param1.addEventListener(Event.DEACTIVATE,resetKeys);
         param1.addEventListener(FocusEvent.FOCUS_OUT,resetKeys);
         initialized = true;
      }
      
      public static function isPressed(param1:uint) : Boolean
      {
         if(!initialized)
         {
            return false;
         }
         return Boolean(param1 in keys);
      }
      
      // Returns true once if the key was pressed and then released since last call.
      public static function justPressed(param1:uint) : Boolean
      {
         if(!initialized)
         {
            return false;
         }
         if(param1 in justPressedMap)
         {
            delete justPressedMap[param1];
            return true;
         }
         return false;
      }
      
      private static function keyPressed(param1:KeyboardEvent) : *
      {
         keys[param1.keyCode] = true;
      }
      
      private static function keyReleased(param1:KeyboardEvent) : *
      {
         if(param1.keyCode in keys)
         {
            // record that this key was pressed-and-released
            justPressedMap[param1.keyCode] = true;
            delete keys[param1.keyCode];
         }
      }
      
      private static function resetKeys(param1:*) : *
      {
         keys = new Object();
         justPressedMap = new Object();
      }
   }
}
