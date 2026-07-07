package package_6
{
   import com.jiggmin.data.*;
   import flash.display.Sprite;
   import flash.events.*;
   import package_8.Character;
   import package_8.LocalCharacter;
   
   public class SpectatePicker extends Sprite
   {
       
      
      private var game:Course;
      
      private var m:SpectatePickerGraphic;
      
      private var htmlNameMaker:HTMLNameMaker;
      
      private var pickedID:int = -1;
      
      public function SpectatePicker()
      {
         this.game = Course.course;
         this.htmlNameMaker = new HTMLNameMaker();
         super();
         tabEnabled = false;
         tabChildren = false;
         focusRect = false;
         this.m = new SpectatePickerGraphic();
         this.m.tabEnabled = false;
         this.m.tabChildren = false;
         this.m.focusRect = false;
         this.m.arrowLeft.tabEnabled = false;
         this.m.arrowLeft.focusRect = false;
         this.m.arrowRight.tabEnabled = false;
         this.m.arrowRight.focusRect = false;
         this.m.arrowLeft.addEventListener(MouseEvent.CLICK,this.clickLeft,false,0,true);
         this.m.arrowRight.addEventListener(MouseEvent.CLICK,this.clickRight,false,0,true);
         addChild(this.m);
         this.htmlNameMaker.listenForLink(this.m.playerName.top.box);
         this.stopSpectating();
      }
      
      // find a non-local (not LocalCharacter), non-null player starting from startIndex and moving by dir (±1).
      // Returns -1 if none found.
      private function findValidAround(startIndex:int, dir:int) : int
      {
         var len:int = this.game.playerArray.length;
         if(len == 0) return -1;
         var idx:int = startIndex;
         var tries:int = 0;
         while(tries < len)
         {
            idx += dir;
            if(idx < 0) idx = len - 1;
            else if(idx >= len) idx = 0;
            var c:Character = this.game.playerArray[idx];
            if(c != null && !(c is LocalCharacter))
            {
               return idx;
            }
            tries++;
         }
         return -1;
      }
      
      private function clickLeft(param1:MouseEvent) : *
      {
         var start:int = this.pickedID;
         if(start == -1) start = 0;
         var target:int = this.findValidAround(start, -1);
         this.setPlayer(target);
      }
      
      private function clickRight(param1:MouseEvent) : *
      {
         var start:int = this.pickedID;
         if(start == -1) start = -1;
         var target:int = this.findValidAround(start, 1);
         this.setPlayer(target);
      }
      
      private function setPlayer(param1:int = -1) : *
      {
         var _loc2_:Character = null;
         if(param1 == this.pickedID)
         {
            return;
         }
         if(param1 == -1 || this.game.playerArray[param1] == null)
         {
            this.stopSpectating();
            return;
         }
         // If the target is the local player, treat it as nonexistent: find the next valid one
         var candidate:Character = this.game.playerArray[param1];
         if(candidate is LocalCharacter)
         {
            var next:int = this.findValidAround(param1, 1);
            if(next == -1)
            {
               this.stopSpectating();
               return;
            }
            param1 = next;
         }
         this.pickedID = param1;
         _loc2_ = this.game.playerArray[this.pickedID];
         this.m.spectatingText.visible = true;
         this.m.playerName.top.box.htmlText = this.m.playerName.bg.box.htmlText = "&nbsp;" + this.htmlNameMaker.makeName(_loc2_.getName(),_loc2_.getGroup(),"",true) + "&nbsp;";
         this.game.changeSpectate(this.pickedID);
      }
      
      public function stopSpectating() : *
      {
         this.pickedID = -1;
         this.m.playerName.top.box.htmlText = this.m.playerName.bg.box.htmlText = "Free Scroll";
         this.m.spectatingText.visible = false;
      }
      
      public function toggleVisibility(param1:Boolean) : *
      {
         this.m.visible = param1;
         if(this.m.visible)
         {
            this.stopSpectating();
         }
      }
      
      public function remove() : *
      {
         this.m.arrowLeft.removeEventListener(MouseEvent.CLICK,this.clickLeft);
         this.m.arrowRight.removeEventListener(MouseEvent.CLICK,this.clickRight);
         this.m = null;
      }
   }
}
