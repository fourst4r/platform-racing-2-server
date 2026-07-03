package package_4
{
   import flash.events.Event;
   import flash.net.*;
   
   public class GuildJoinPopup extends UploadingPopup
   {
       
      
      public function GuildJoinPopup(param1:int)
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.guild_id = param1;
         var _loc3_:URLRequest = new URLRequest(Main.baseURL + "/guild_join.php");
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         super(_loc3_,SuperLoader.j);
         m.textBox.text = "Joining guild...";
      }
      
      override protected function parsedDataHandler(param1:Event) : *
      {
         var _loc2_:Object = loader.parsedData;
         Main.guild = _loc2_.guild_id;
         Main.emblem = _loc2_.emblem;
         Main.guildName = _loc2_.guild_name;
         Main.guildOwner = 0;
         super.parsedDataHandler(param1);
      }
   }
}
