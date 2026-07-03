package package_4
{
   import com.jiggmin.data.*;
   import flash.events.*;
   
   public class TempModMenu extends Removable
   {
       
      
      private var m:TempModMenuGraphic;
      
      private var target:Popup;
      
      private var userName:String;
      
      public function TempModMenu(param1:String, param2:Popup)
      {
         this.m = new TempModMenuGraphic();
         super();
         this.userName = param1;
         this.target = param2;
         this.m.warning1Button.addEventListener(MouseEvent.CLICK,this.clickWarning1,false,0,true);
         this.m.warning2Button.addEventListener(MouseEvent.CLICK,this.clickWarning2,false,0,true);
         this.m.warning3Button.addEventListener(MouseEvent.CLICK,this.clickWarning3,false,0,true);
         this.m.kickButton.addEventListener(MouseEvent.CLICK,this.clickKick,false,0,true);
         addChild(this.m);
      }
      
      private function clickWarning1(param1:MouseEvent) : *
      {
         this.warnUser(1);
      }
      
      private function clickWarning2(param1:MouseEvent) : *
      {
         this.warnUser(2);
      }
      
      private function clickWarning3(param1:MouseEvent) : *
      {
         this.warnUser(3);
      }
      
      private function warnUser(param1:int) : *
      {
         Main.socket.write("warn`" + this.userName + "`" + param1);
         this.target.startFadeOut();
      }
      
      private function clickKick(param1:MouseEvent) : *
      {
         new ConfirmPopup(this.kickUser,"Are you sure you want to kick " + Data.escapeString(this.userName) + "? They will not be able to re-enter this server for 30 minutes.");
      }
      
      private function kickUser() : *
      {
         Main.socket.write("kick`" + this.userName);
         this.target.startFadeOut();
      }
      
      override public function remove() : *
      {
         this.m.warning1Button.removeEventListener(MouseEvent.CLICK,this.clickWarning1);
         this.m.warning2Button.removeEventListener(MouseEvent.CLICK,this.clickWarning2);
         this.m.warning3Button.removeEventListener(MouseEvent.CLICK,this.clickWarning3);
         this.m.kickButton.removeEventListener(MouseEvent.CLICK,this.clickKick);
         this.target = null;
         super.remove();
      }
   }
}
