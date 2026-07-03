package package_22
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.utils.*;
   import package_4.class_264;
   
   public class CourseMenu extends class_264
   {
      
      public static var instance:CourseMenu = null;
       
      
      private var m:CourseMenuGraphic;
      
      private var slot:Slot;
      
      private var secondInterval:uint;
      
      private var waitTimeout:uint;
      
      private var confirmed:Boolean = false;
      
      private var timer:int;
      
      public function CourseMenu(param1:Slot)
      {
         this.m = new CourseMenuGraphic();
         if(CourseMenu.instance != null)
         {
            CourseMenu.instance.staticCloseMenu();
         }
         CourseMenu.instance = this;
         this.slot = param1;
         this.m.play_bt.validateNow();
         this.m.cancel_bt.validateNow();
         this.m.play_bt.addEventListener(MouseEvent.CLICK,this.clickPlay,false,0,true);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.closeMenu,false,0,true);
         addChild(this.m);
         CommandHandler.commandHandler.defineCommand("forceTime",this.forceTime);
         CommandHandler.commandHandler.defineCommand("closeCourseMenu",this.remoteRemove);
         this.waitTimeout = setTimeout(this.closeMenu,30000);
         super(this.slot);
      }
      
      public function forceTime(param1:Array) : *
      {
         var _loc2_:int = int(param1[0]);
         clearInterval(this.secondInterval);
         clearTimeout(this.waitTimeout);
         if(_loc2_ < 0)
         {
            this.m.textBox.text = "--";
            this.waitTimeout = setTimeout(this.closeMenu,30000);
         }
         else
         {
            this.timer = 15 - _loc2_ + 1;
            this.secondInterval = setInterval(this.decrementTimer,1000);
            this.decrementTimer();
         }
      }
      
      private function decrementTimer() : *
      {
         --this.timer;
         if(this.timer < 0)
         {
            this.timer = 0;
            clearInterval(this.secondInterval);
            Main.socket.write("force_start`");
         }
         this.m.textBox.text = this.timer.toString();
      }
      
      private function clickPlay(param1:MouseEvent) : *
      {
         this.confirmed = true;
         clearTimeout(this.waitTimeout);
         this.slot.sendConfirmSlot();
      }
      
      public function remoteRemove(param1:Array) : *
      {
         this.remove();
      }
      
      private function closeMenu(param1:* = null) : *
      {
         this.confirmed = false;
         this.remove();
         Main.stage.focus = Main.stage;
      }
      
      public function staticCloseMenu() : *
      {
         this.closeMenu(null);
      }
      
      override public function remove() : *
      {
         if(CourseMenu.instance === this)
         {
            CourseMenu.instance = null;
         }
         CommandHandler.commandHandler.defineCommand("forceTime",null);
         CommandHandler.commandHandler.defineCommand("closeCourseMenu",null);
         this.m.play_bt.removeEventListener(MouseEvent.CLICK,this.clickPlay);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.closeMenu);
         clearInterval(this.secondInterval);
         clearTimeout(this.waitTimeout);
         this.slot.sendClearSlot();
         this.slot = null;
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
