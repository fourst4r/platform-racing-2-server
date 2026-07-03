package replay
{
   import flash.utils.Dictionary;

   public class ReplayTrajectories
   {
      private static var trajectories:Dictionary = new Dictionary();

      public function ReplayTrajectories()
      {
      }

      public static function clear() : void
      {
         trajectories = new Dictionary();
      }

      public static function build(param1:Vector.<ReplayEvent>) : void
      {
         var states:Dictionary = new Dictionary();
         clear();
         if(param1 == null)
         {
            return;
         }
         var count:int = param1.length;
         for(var i:int = 0; i < count; i++)
         {
            var evt:ReplayEvent = param1[i];
            if(evt == null || evt.payload == null || evt.payload.length == 0)
            {
               continue;
            }
            var parts:Array = evt.payload.split("`");
            if(parts.length == 0)
            {
               continue;
            }
            var cmd:String = String(parts.shift());
            if(cmd == null || cmd.length == 0)
            {
               continue;
            }
            if(cmd.indexOf("p") == 0 && cmd.length > 1)
            {
               handleDelta(states, cmd.substr(1), parts, evt.timestamp);
            }
            else if(cmd.indexOf("exactPos") == 0 && cmd.length > 8)
            {
               handleTeleport(states, cmd.substr(8), parts, evt.timestamp);
            }
            else if(cmd.indexOf("var") == 0 && cmd.length > 3)
            {
               handleVar(states, cmd.substr(3), parts, evt.timestamp);
            }
         }
         for each(var state:ReplayTrajectoryBuilderState in states)
         {
            if(state == null)
            {
               continue;
            }
            if(state.trajectory == null || state.trajectory.isEmpty())
            {
               delete trajectories[state.tempId];
               continue;
            }
            state.trajectory.resetCursor();
         }
      }

      public static function getTrajectory(param1:int) : ReplayTrajectory
      {
         return trajectories[param1];
      }

      public static function resetAllCursors() : void
      {
         for each(var traj:ReplayTrajectory in trajectories)
         {
            if(traj != null)
            {
               traj.resetCursor();
            }
         }
      }

      private static function handleDelta(param1:Dictionary, param2:String, param3:Array, param4:int) : void
      {
         var state:ReplayTrajectoryBuilderState = getState(param1,param2);
         if(state == null || !state.hasAnchor)
         {
            return;
         }
         var dx:Number = parseNumber(param3.length > 0 ? param3[0] : 0);
         var dy:Number = parseNumber(param3.length > 1 ? param3[1] : 0);
         state.x += dx;
         state.y += dy;
         state.trajectory.addSample(param4,state.x,state.y,state.angle(),false);
      }

      private static function handleTeleport(param1:Dictionary, param2:String, param3:Array, param4:int) : void
      {
         var state:ReplayTrajectoryBuilderState = getState(param1,param2);
         if(state == null)
         {
            return;
         }
         state.x = parseNumber(param3.length > 0 ? param3[0] : 0);
         state.y = parseNumber(param3.length > 1 ? param3[1] : 0);
         state.hasAnchor = true;
         state.trajectory.addSample(param4,state.x,state.y,state.angle(),true);
      }

      private static function handleVar(param1:Dictionary, param2:String, param3:Array, param4:int) : void
      {
         var state:ReplayTrajectoryBuilderState = getState(param1,param2);
         if(state == null || param3.length < 2)
         {
            return;
         }
         var key:String = String(param3[0]);
         var value:String = String(param3[1]);
         var changed:Boolean = false;
         if(key == "rot")
         {
            state.rot = parseNumber(value);
            changed = true;
         }
         else if(key == "rotMod")
         {
            state.rotMod = parseNumber(value);
            changed = true;
         }
         if(changed && state.hasAnchor)
         {
            state.trajectory.addSample(param4,state.x,state.y,state.angle(),false);
         }
      }

      private static function getState(param1:Dictionary, param2:String) : ReplayTrajectoryBuilderState
      {
         var tempId:int = parseInt(param2,10);
         if(isNaN(tempId))
         {
            return null;
         }
         var state:ReplayTrajectoryBuilderState = param1[tempId];
         if(state == null)
         {
            state = new ReplayTrajectoryBuilderState();
            state.tempId = tempId;
            state.trajectory = new ReplayTrajectory();
            param1[tempId] = state;
            trajectories[tempId] = state.trajectory;
         }
         return state;
      }

      private static function parseNumber(param1:*) : Number
      {
         if(param1 === "" || param1 == null)
         {
            return 0;
         }
         var value:Number = Number(param1);
         if(isNaN(value))
         {
            return 0;
         }
         return value;
      }
   }
}

import replay.ReplayTrajectory;

class ReplayTrajectoryBuilderState
{
   public var tempId:int = 0;
   public var trajectory:ReplayTrajectory;
   public var x:Number = 0;
   public var y:Number = 0;
   public var rot:Number = 0;
   public var rotMod:Number = 0;
   public var hasAnchor:Boolean = false;

   public function ReplayTrajectoryBuilderState()
   {
   }

   public function angle() : Number
   {
      return this.rot + this.rotMod;
   }
}
