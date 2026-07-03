package page
{
   import com.jiggmin.data.*;
   import package_4.*;
   import replay.ReplayManager;
   
   public class Chat extends Page
   {
       
      
      protected var existingMessages:String = "";
      
      protected var maxMessages:int = 40;
      
      protected var messages:int = 0;
      
      protected var htmlNameMaker:HTMLNameMaker;
      
      private var hint:ArtifactHint;
      
      private var cm:CommandHandler;
      
      public function Chat()
      {
         this.htmlNameMaker = new HTMLNameMaker();
         this.cm = CommandHandler.commandHandler;
         super();
         this.cm.defineCommand("systemChat",this.receiveSystemMessage);
         this.cm.defineCommand("chat",this.handleMessageFromArray);
      }
      
      override public function initialize() : *
      {
      }
      
      public function makeLink(param1:String, param2:Array) : *
      {
         if("make" + param1 in this.htmlNameMaker)
         {
            return this.htmlNameMaker["make" + param1](param2[0],param2[1]);
         }
         return "";
      }
      
      public function handleMessageFromArray(param1:Array, param2:Boolean = false) : *
      {
         var _loc3_:String = String(param1[0]);
         var _loc4_:String = String(param1[1]);
         var _loc5_:String = String(param1[2]);
         if(!param2)
         {
            // _loc5_ = String(Data.escapeString(_loc5_));
         }
         var _loc6_:String;
         var _loc7_:* = (_loc6_ = String(this.htmlNameMaker.makeName(_loc3_,_loc4_,"",true))) + "<font color=\'#666666\'>: " + _loc5_ + "</font><br/>";
         _loc7_ = param2 ? "<i>" + _loc7_ + "</i>" : _loc7_;
         this.displayMessage(_loc7_);
      }
      
      public function receiveSystemMessage(param1:Array) : *
      {
         this.displayMessage("<br/><i><font color=\'#3E8697\'>" + param1[0] + "</font></i><br/><br/>");
      }
      
      protected function sendMessage(param1:String) : *
      {
         param1 = param1.replace(String.fromCharCode(4),"");
         var _loc4_:String = null;
         var _loc2_:* = param1.toLowerCase();
         var _loc3_:* = Data.trimWhitespace(_loc2_);
         if(_loc2_.indexOf("/view ") == 0)
         {
            _loc4_ = param1.substr(6);
            new PlayerPopup(_loc4_);
         }
         else if(_loc3_ == "/hint" || _loc3_ == "/lotw" || _loc3_ == "/arti")
         {
            if(this.hint == null)
            {
               this.hint = new ArtifactHint(this);
            }
            this.hint.load();
         }
         else if(param1.indexOf("/guild ") == 0)
         {
            new GuildPopup(0,param1.substr(7));
         }
         else if(param1.indexOf("/pm ") == 0)
         {
            new SendMessagePopup(param1.substr(4));
         }
         else if(param1.indexOf("/level ") == 0)
         {
            new LevelInfoPopup(param1.substr(7));
         }
         else if(_loc3_ == "/watch" || _loc2_.indexOf("/watch ") == 0)
         {
            var replayId:String = "";
            if(_loc2_.indexOf("/watch ") == 0)
            {
               replayId = Data.trimWhitespace(param1.substr(7));
            }
            if(replayId != "")
            {
               ReplayManager.playReplay(replayId,"",false);
            }
            else
            {
               ReplayManager.promptReplayFile();
            }
         }
         else
         {
            param1 = param1.replace("","");
            param1 = param1.replace("\n","");
            if(param1 != "")
            {
               Main.socket.write("chat`" + param1);
            }
         }
      }
      
      protected function displayMessage(param1:String) : *
      {
         ++this.messages;
         if(this.messages > this.maxMessages)
         {
            this.existingMessages = this.existingMessages.substr(this.existingMessages.indexOf("<br/>") + 5);
         }
         this.existingMessages += param1;
         this.showMessages();
      }
      
      protected function showMessages() : *
      {
      }
      
      override public function remove() : *
      {
         this.cm.defineCommand("systemChat",null);
         this.cm.defineCommand("chat",null);
         this.htmlNameMaker.remove();
         if(this.hint != null)
         {
            this.hint.remove();
            this.hint = null;
         }
         super.remove();
      }
   }
}
