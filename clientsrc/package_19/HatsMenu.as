package package_19
{
   import fl.controls.CheckBox;
   import flash.events.*;
   import package_4.*;
   import page.*;
   
   public class HatsMenu extends class_264
   {
       
      
      private var m:HatsMenuGraphic;
      
      private var highestHatID:int;
      
      private var hover:HoverPopup = null;
      
      public function HatsMenu(param1:HatsMenuButton)
      {
         var _loc4_:CheckBox = null;
         this.m = new HatsMenuGraphic();
         this.highestHatID = Parts.getPartArray("HAT").length + 1;
         addChild(this.m);
         super(param1);
         var _loc2_:Vector.<int> = GamePage.course.badHats;
         var _loc3_:int = 2;
         while(_loc3_ <= this.highestHatID)
         {
            _loc4_ = this.m["hat" + _loc3_];
            if(_loc2_.indexOf(_loc3_) != -1)
            {
               _loc4_.selected = false;
            }
            _loc3_++;
         }
         if(GamePage.course.gameMode == "hat")
         {
            this.m.hat14.selected = false;
            this.m.hat14.addEventListener(MouseEvent.MOUSE_OVER,this.maybeAddHover,false,0,true);
            this.m.hat14.addEventListener(Event.CHANGE,this.maybeAddHover,false,0,true);
            this.m.hat14.addEventListener(MouseEvent.MOUSE_OUT,this.removeHover,false,0,true);
         }
         this.m.hat5.addEventListener(MouseEvent.MOUSE_OVER,this.maybeAddHover,false,0,true);
         this.m.hat5.addEventListener(Event.CHANGE,this.maybeAddHover,false,0,true);
         this.m.hat5.addEventListener(MouseEvent.MOUSE_OUT,this.removeHover,false,0,true);
      }
      
      private function maybeAddHover(param1:Event) : *
      {
         var _loc2_:CheckBox = param1.currentTarget;
         if(_loc2_ == this.m.hat5)
         {
            if(this.hover == null && GamePage.course.cowboyChance > 0 && !this.m.hat5.selected)
            {
               this.hover = new HoverPopup("Cowboy Mode","Disabling the cowboy hat here won\'t override your setting for chance of cowboy mode.",this.m.hat5);
            }
            else
            {
               this.removeHover();
            }
         }
         else if(_loc2_ == this.m.hat14 && GamePage.course.gameMode === "hat")
         {
            if(this.hover != null)
            {
               this.removeHover();
               if(param1.type == MouseEvent.MOUSE_OUT)
               {
                  return;
               }
            }
            this.hover = new HoverPopup("Artifact in Hat Attack","This setting won\'t have any effect since the artifact hat cannot be used in hat attack mode.",this.m.hat14);
         }
      }
      
      private function removeHover(param1:MouseEvent = null) : *
      {
         if(this.hover != null)
         {
            this.hover.remove();
            this.hover = null;
         }
      }
      
      override public function remove() : *
      {
         var _loc1_:int = 0;
         var _loc2_:CheckBox = null;
         if(GamePage.course != null)
         {
            GamePage.course.badHats = new Vector.<int>();
            _loc1_ = 2;
            while(_loc1_ <= this.highestHatID)
            {
               _loc2_ = this.m["hat" + _loc1_];
               if(!_loc2_.selected)
               {
                  GamePage.course.badHats.push(_loc1_);
               }
               _loc1_++;
            }
         }
         this.m.hat5.removeEventListener(MouseEvent.MOUSE_OVER,this.maybeAddHover);
         this.m.hat5.removeEventListener(Event.CHANGE,this.maybeAddHover);
         this.m.hat5.removeEventListener(MouseEvent.MOUSE_OUT,this.removeHover);
         this.m.hat14.removeEventListener(MouseEvent.MOUSE_OVER,this.maybeAddHover);
         this.m.hat14.removeEventListener(Event.CHANGE,this.maybeAddHover);
         this.m.hat14.removeEventListener(MouseEvent.MOUSE_OUT,this.removeHover);
         this.removeHover();
         super.remove();
      }
   }
}
