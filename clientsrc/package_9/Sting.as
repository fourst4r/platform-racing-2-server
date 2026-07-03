package package_9
{
   import flash.events.*;
   import package_8.Character;
   import sounds.*;
   
   public class Sting extends Effect
   {
       
      
      private var m:StingGraphic;
      
      private var character:Character;
      
      public function Sting(param1:Character, param2:String = "")
      {
         this.m = new StingGraphic();
         super();
         this.character = param1;
         if(param2 === "right")
         {
            this.m.removeChild(this.m.leftSting);
         }
         else if(param2 === "left")
         {
            this.m.removeChild(this.m.rightSting);
         }
         addChild(this.m);
         addEventListener(Event.ENTER_FRAME,this.go);
         this.pos();
         SoundEffects.playGameSound(new StingSound(),x,y,0.66);
      }
      
      private function go(param1:Event) : *
      {
         this.pos();
         alpha -= 0.05;
         if(alpha <= 0)
         {
            this.remove();
         }
      }
      
      private function pos() : *
      {
         x = this.character.x;
         y = this.character.y;
      }
      
      override public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.go);
         removeChild(this.m);
         this.m = null;
         this.character = null;
         super.remove();
      }
   }
}
