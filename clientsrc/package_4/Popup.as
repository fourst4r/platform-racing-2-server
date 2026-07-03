package package_4
{
   import flash.events.*;
   import flash.geom.*;
   
   public class Popup extends Removable
   {
      
      private static var OPEN_POPUPS:Array = new Array();
      
      public static var LOADED:* = "loaded";
      
      public static var REMOVED:* = "removed";
       
      
      public var fadeOutStarted:Boolean = false;
      
      public function Popup(param1:Boolean = true)
      {
         var _loc2_:ColorTransform = null;
         var _loc3_:Square = null;
         super();
         if(param1)
         {
            _loc2_ = new ColorTransform();
            _loc3_ = new Square();
            _loc2_.color = 0;
            _loc3_.width = 550;
            _loc3_.height = 400;
            _loc3_.transform.colorTransform = _loc2_;
            _loc3_.alpha = 0.55;
            addChild(_loc3_);
         }
         x = 550 / 2;
         y = 400 / 2;
         alpha = 0;
         Main.stage.addChild(this);
         addEventListener(Event.ENTER_FRAME,this.fadeIn,false,0,true);
         OPEN_POPUPS.push(this);
      }
      
      public static function getOpen() : *
      {
         return OPEN_POPUPS;
      }
      
      private function fadeIn(param1:Event) : *
      {
         alpha += 0.15;
         if(alpha >= 1)
         {
            alpha = 1;
            removeEventListener(Event.ENTER_FRAME,this.fadeIn);
            dispatchEvent(new Event(LOADED));
         }
      }
      
      private function fadeOut(param1:Event) : *
      {
         alpha -= 0.15;
         if(alpha <= 0)
         {
            this.remove();
            dispatchEvent(new Event(REMOVED));
         }
      }
      
      public function startFadeOut() : *
      {
         this.fadeOutStarted = true;
         removeEventListener(Event.ENTER_FRAME,this.fadeIn);
         addEventListener(Event.ENTER_FRAME,this.fadeOut,false,0,true);
      }
      
      override public function remove() : *
      {
         OPEN_POPUPS.splice(OPEN_POPUPS.indexOf(this),1);
         removeEventListener(Event.ENTER_FRAME,this.fadeIn);
         removeEventListener(Event.ENTER_FRAME,this.fadeOut);
         if(stage != null)
         {
            stage.focus = stage;
         }
         super.remove();
      }
   }
}
