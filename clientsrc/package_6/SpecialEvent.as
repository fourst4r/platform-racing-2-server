package package_6
{
   import flash.display.Stage;
   import flash.events.*;
   import flash.ui.*;
   import page.*;
   
   public class SpecialEvent
   {
       
      
      private var stageRef:Stage;
      
      private var gameRef:Game;
      
      public function SpecialEvent(param1:Stage, param2:Game)
      {
         super();
         this.stageRef = param1;
         this.gameRef = param2;
         param1.addEventListener(MouseEvent.CLICK,this.clickHandler,false,0,true);
      }
      
      private function clickHandler(param1:MouseEvent) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(Main.group == 3 || Main.isSpecialUser || Main.isPrizer || Main.group == 2 && !Main.isTempMod && !Main.isTrialMod)
         {
            if(Keys.isPressed(Keyboard.G) && Keys.isPressed(Keyboard.C))
            {
               _loc2_ = int(Game(GamePage.course).getCourseID());
               _loc3_ = param1.stageX - GamePage.course.posX - GamePage.course.x;
               _loc4_ = param1.stageY - GamePage.course.posY - GamePage.course.y;
               _loc5_ = int(Course.course.blockBackground.rotation);
               new PlaceArtifact(_loc2_,_loc3_,_loc4_,_loc5_);
            }
            else if(Keys.isPressed(Keyboard.C) && Keys.isPressed(Keyboard.X) && this.gameRef.prize !== null)
            {
               Main.socket.write("cancel_prize`");
            }
         }
      }
      
      public function remove() : *
      {
         this.stageRef.removeEventListener(MouseEvent.CLICK,this.clickHandler);
         this.stageRef = null;
      }
   }
}
