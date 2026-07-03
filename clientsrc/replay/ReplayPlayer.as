package replay
{
   import flash.events.Event;
   import flash.utils.getTimer;
   import Main;

   public class ReplayPlayer
   {
      private static const SPEEDS:Array = [0.5,1,2];

      private var events:Vector.<ReplayEvent>;
      private var feeder:ReplayCommandFeeder;
      private var onFinish:Function;
      private var enterFrameAttached:Boolean = false;

      public var totalDuration:int = 0;
      public var currentTimeMs:int = 0;

      private var index:int = 0;
      private var playing:Boolean = false;
      private var speedIndex:int = 1;
      private var lastTick:int = 0;

      public function ReplayPlayer(param1:Vector.<ReplayEvent>, param2:ReplayCommandFeeder, param3:Function)
      {
         this.events = param1 != null ? param1 : new Vector.<ReplayEvent>();
         this.feeder = param2;
         this.onFinish = param3;
         ReplayClock.activate();
         ReplayClock.setNow(0);
         if(this.events.length > 0)
         {
            this.totalDuration = this.events[this.events.length - 1].timestamp;
         }
      }

      public function play() : void
      {
         if(this.playing)
         {
            return;
         }
         this.playing = true;
         this.lastTick = getTimer();
         this.attachEnterFrame();
      }

      public function pause() : void
      {
         if(!this.playing)
         {
            return;
         }
         this.playing = false;
      }

      public function togglePlay() : Boolean
      {
         if(this.playing)
         {
            this.pause();
         }
         else
         {
            this.play();
         }
         return this.playing;
      }

      public function get isPlaying() : Boolean
      {
         return this.playing;
      }

      public function cycleSpeed() : Number
      {
         this.speedIndex = (this.speedIndex + 1) % SPEEDS.length;
         return this.currentSpeed;
      }

      public function get currentSpeed() : Number
      {
         return SPEEDS[this.speedIndex];
      }

      public function stepForward() : void
      {
         if(this.events.length == 0 || this.index >= this.events.length)
         {
            return;
         }
         var evt:ReplayEvent = this.events[this.index];
         ++this.index;
         this.currentTimeMs = evt.timestamp;
         ReplayClock.setNow(evt.timestamp);
         this.feeder.dispatch(evt.payload);
      }

      public function reset() : void
      {
         this.currentTimeMs = 0;
         this.index = 0;
         this.playing = false;
         this.speedIndex = 1;
         ReplayClock.setNow(0);
      }

      public function primeInitialEvents() : void
      {
         this.dispatchUntil(0);
      }

      public function dispose() : void
      {
         this.detachEnterFrame();
         this.events = null;
         this.feeder = null;
         this.onFinish = null;
         ReplayClock.deactivate();
      }

      private function attachEnterFrame() : void
      {
         if(!this.enterFrameAttached)
         {
            Main.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
            this.enterFrameAttached = true;
         }
      }

      private function detachEnterFrame() : void
      {
         if(this.enterFrameAttached)
         {
            Main.stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            this.enterFrameAttached = false;
         }
      }

      private function onEnterFrame(param1:Event) : void
      {
         if(!this.playing)
         {
            return;
         }
         var now:int = getTimer();
         var delta:int = now - this.lastTick;
         this.lastTick = now;
         if(delta < 0)
         {
            delta = 0;
         }
         this.currentTimeMs += delta * this.currentSpeed;
         if(this.currentTimeMs > this.totalDuration)
         {
            this.currentTimeMs = this.totalDuration;
         }
         this.dispatchUntil(this.currentTimeMs);
         if(this.currentTimeMs >= this.totalDuration)
         {
            this.pause();
            if(this.onFinish != null)
            {
               this.onFinish();
            }
         }
      }

      private function dispatchUntil(param1:int) : void
      {
         while(this.index < this.events.length)
         {
            var evt:ReplayEvent = this.events[this.index];
            if(evt.timestamp > param1)
            {
               break;
            }
            ReplayClock.setNow(evt.timestamp);
            this.feeder.dispatch(evt.payload);
            ++this.index;
         }
         ReplayClock.setNow(param1);
      }
   }
}
