package package_9
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import package_8.Character;
   import sounds.*;
   
   public class Zap extends Effect
   {
       
      
      private var m:ZapGraphic;
      
      private var character:Character;
      
      public function Zap(param1:Character, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true)
      {
         this.m = new ZapGraphic();
         super();
         this.character = param1;
         if(!param2)
         {
            this.m.removeChild(this.m.lightning);
         }
         if(!param4)
         {
            this.m.removeChild(this.m.bg);
         }
         addChild(this.m);
         addEventListener(Event.ENTER_FRAME,this.go);
         this.pos();
         if(param3)
         {
            SoundEffects.playSound(new ZapSound(),1 * (Settings.soundLevel / 100));
         }
      }
      
      private function go(param1:Event) : *
      {
         this.pos();
         alpha -= 0.1;
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
