package page
{
   import com.jiggmin.data.*;
   import flash.events.Event;
   import flash.net.*;
   
   public class ArtifactHint
   {
       
      
      private var superLoader:SuperLoader;
      
      private var chatRoom:Chat;
      
      public function ArtifactHint(param1:Chat)
      {
         this.superLoader = new SuperLoader(true,SuperLoader.j);
         super();
         this.chatRoom = param1;
         this.superLoader.addEventListener(SuperLoader.d,this.parseHint);
      }
      
      public function load() : *
      {
         this.superLoader.load(new URLRequest(Main.baseURL + "/files/level_of_the_week.json"));
      }
      
      private function parseHint(param1:Event) : *
      {
         var _loc7_:Array = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:Array = null;
         var _loc11_:Object = null;
         var _loc2_:Object = this.superLoader.parsedData;
         if(!_loc2_.hasOwnProperty("current"))
         {
            return;
         }
         var _loc3_:Object = _loc2_.current;
         var _loc4_:Array = [_loc3_.level.title,_loc3_.level.id];
         var _loc5_:Array = [_loc3_.level.author.name,_loc3_.level.author.group];
         var _loc6_:* = "The current level of the week is " + this.chatRoom.makeLink("Level",_loc4_) + " by " + this.chatRoom.makeLink("Name",_loc5_) + "." + (!_loc3_.hasOwnProperty("first_finder") ? " See if you can find the hidden artifact!" : "");
         this.chatRoom.handleMessageFromArray(["Fred the G. Cactus","3,*",_loc6_],true);
         if(_loc3_.hasOwnProperty("first_finder"))
         {
            _loc7_ = [_loc3_.first_finder.name,_loc3_.first_finder.group];
            _loc8_ = "The first person to find the hidden artifact was " + this.chatRoom.makeLink("Name",_loc7_) + "!";
            this.chatRoom.handleMessageFromArray(["Fred the G. Cactus","3,*",_loc8_],true);
            _loc9_ = "";
            if(_loc3_.hasOwnProperty("bubbles_winner") && _loc3_.bubbles_winner.group == 0)
            {
               _loc9_ = "The bubble set will be awarded to the first person to find the artifact that doesn\'t have the set already!";
            }
            else if(_loc3_.hasOwnProperty("bubbles_winner") && _loc3_.first_finder.name != _loc3_.bubbles_winner.name)
            {
               _loc10_ = [_loc3_.bubbles_winner.name,_loc3_.bubbles_winner.group];
               _loc9_ = "Since they already have the bubble set, the prize was awarded to " + this.chatRoom.makeLink("Name",_loc10_) + " instead!";
            }
            if(_loc9_ != "")
            {
               this.chatRoom.handleMessageFromArray(["Fred the G. Cactus","3,*",_loc9_],true);
            }
         }
         if(_loc2_.hasOwnProperty("scheduled"))
         {
            _loc4_ = [(_loc11_ = _loc2_.scheduled).level.title,_loc11_.level.id];
            _loc5_ = [_loc11_.level.author.name,_loc11_.level.author.group];
            _loc6_ = "The next level of the week will be " + this.chatRoom.makeLink("Level",_loc4_) + " by " + this.chatRoom.makeLink("Name",_loc5_) + ", which will take effect on " + Data.getDateTimeStr(_loc11_.set_time,["long","short"]) + ".";
            this.chatRoom.handleMessageFromArray(["Fred the G. Cactus","3,*",_loc6_],true);
         }
      }
      
      public function remove() : *
      {
         this.superLoader.removeEventListener(SuperLoader.d,this.parseHint);
         this.superLoader.remove();
         this.superLoader = null;
         this.chatRoom = null;
      }
   }
}
