package package_6
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import lobby.*;
   import package_4.Popup;
   import ui.*;
   import menu.LoginPage;
   
   public class FinishedPage extends Popup
   {
       
      
      private var m:FinishedPageGraphic;
      
      private var stars:RatingSelect;
      
      private var cm:CommandHandler;
      
      private var curAwardLine:int = 1;
      
      private var game:Game;
      
      private var expGain:ExpGain;
      
      public function FinishedPage(param1:Game)
      {
         var _loc2_:Array = null;
         this.m = new FinishedPageGraphic();
         this.cm = CommandHandler.commandHandler;
         this.expGain = new ExpGain();
         super();
         this.game = param1;
         this.m.return_bt.addEventListener(MouseEvent.CLICK,this.clickReturn);
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose);
         addChild(this.m);
         this.stars = new RatingSelect(this.game.getCourseID());
         this.stars.x = 6;
         this.stars.y = 87;
         addChild(this.stars);
         this.expGain.x = 0;
         this.expGain.y = 47;
         addChild(this.expGain);
         for each(_loc2_ in this.game.var_463)
         {
            this.award(_loc2_);
         }
         if(this.game.var_347 != 0)
         {
            this.setExpGain(this.game.var_452,this.game.var_465,this.game.var_347);
         }
      }
      
      public function award(param1:Array) : *
      {
         this.m["bonus" + this.curAwardLine].text = param1[0];
         this.m["exp" + this.curAwardLine].text = param1[1];
         ++this.curAwardLine;
      }
      
      public function setExpGain(param1:int, param2:int, param3:int) : *
      {
         this.m.expTotal.text = "+ " + (param2 - param1);
         this.expGain.start(param1,param2,param3);
         if(Main.instance.kongAPI != null)
         {
            Main.instance.kongAPI.stats.submit("Exp Gained at Once",param2 - param1);
         }
      }
      
      private function clickReturn(param1:MouseEvent) : *
      {
         if(Main.socket.connected)
         {
            Main.socket.write("set_game_room`none");
            Main.pageHolder.changePage(new Lobby());
         }
         else
         {
            // In case of DC during level.
            Main.pageHolder.changePage(new LoginPage());
         }
         startFadeOut();
      }
      
      private function clickClose(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.game.var_202 = null;
         this.expGain.remove();
         this.m.return_bt.removeEventListener(MouseEvent.CLICK,this.clickReturn);
         this.m.close_bt.removeEventListener(MouseEvent.CLICK,this.clickClose);
         super.remove();
      }
   }
}
