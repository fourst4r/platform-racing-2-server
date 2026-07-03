package package_6
{
   import flash.events.*;
   import package_4.*;
   import page.Page;
   
   public class QuitButton extends Page
   {
       
      
      private var m:QuitButtonGraphic;
      
      private var game:Game;
      
      public function QuitButton(param1:Game)
      {
         this.m = new QuitButtonGraphic();
         super();
         this.game = param1;
         addChild(this.m);
         this.m.quit_bt.addEventListener(KeyboardEvent.KEY_UP,this.invokeQuit);
         this.m.quit_bt.addEventListener(MouseEvent.MOUSE_UP,this.invokeQuit);
      }
      
      private function invokeQuit(param1:*) : *
      {
         if(param1 is KeyboardEvent)
         {
            if(param1.keyCode === 32)
            {
               if(this.game.isDonePlaying() === false)
               {
                  new ConfirmPopup(this.game.quitGame,"Do you really want to quit the game?");
               }
               else
               {
                  this.game.quitGame();
               }
            }
         }
         else
         {
            this.game.quitGame();
         }
      }
      
      public function startGlow() : *
      {
         this.m.glow.gotoAndPlay("on");
      }
      
      public function stopGlow() : *
      {
         this.m.glow.gotoAndStop("off");
      }
      
      override public function remove() : *
      {
         this.game = null;
         this.m.quit_bt.removeEventListener(MouseEvent.MOUSE_UP,this.invokeQuit);
         this.m.quit_bt.removeEventListener(KeyboardEvent.KEY_UP,this.invokeQuit);
         super.remove();
      }
   }
}
