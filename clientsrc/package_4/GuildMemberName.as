package package_4
{
   import com.jiggmin.data.*;
   
   public class GuildMemberName extends Removable
   {
       
      
      private var m:GuildMemberNameGraphic;
      
      private var htmlNameMaker:HTMLNameMaker;
      
      public function GuildMemberName(param1:Object, param2:Boolean)
      {
         this.m = new GuildMemberNameGraphic();
         this.htmlNameMaker = new HTMLNameMaker();
         super();
         addChild(this.m);
         this.m.nameBox.htmlText = this.htmlNameMaker.makeName(param1.name,param1.group,"",true);
         this.m.gpTodayBox.text = Data.formatNumber(param1.gp_today);
         this.m.gpTotalBox.text = Data.formatNumber(param1.gp_total);
         if(param2)
         {
            this.m.hat.gotoAndStop(6);
            this.m.hat.colorMC.gotoAndStop(6);
            this.m.hat.colorMC2.gotoAndStop(6);
            this.m.nameBox.x += 14;
            this.m.nameBox.width -= 14;
         }
         this.htmlNameMaker.listenForLink(this.m.nameBox);
      }
      
      override public function remove() : *
      {
         this.htmlNameMaker.remove();
         this.htmlNameMaker = null;
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
