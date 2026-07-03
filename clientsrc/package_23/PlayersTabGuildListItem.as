package package_23
{
   import com.jiggmin.data.*;
   
   public class PlayersTabGuildListItem extends PlayersTabListItem
   {
       
      
      public var guildName:String;
      
      public var activeMembers:int;
      
      public var gpToday:int;
      
      public function PlayersTabGuildListItem(param1:String, param2:int, param3:int, param4:int)
      {
         super();
         this.guildName = param1;
         this.activeMembers = param3;
         this.gpToday = param4;
         m.nameBox.htmlText = htmlNameMaker.makeGuild(this.guildName,param2);
         m.rankBox.text = Data.formatNumber(this.gpToday);
         m.hatBox.text = this.activeMembers.toString();
      }
   }
}
