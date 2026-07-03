package
{
   import flash.display.MovieClip;
   import flash.events.*;
   import package_4.*;
   import package_6.*;
   import package_8.*;
   
   public dynamic class MiniMapDot extends MovieClip
   {
       
      
      private const remote0Color:uint = 1095390;
      
      private const remote1Color:uint = 16711680;
      
      private const remote2Color:uint = 65280;
      
      private const remote3Color:uint = 10066329;
      
      private const remote4Color:uint = 16753920;
      
      private const remote5Color:uint = 16711935;
      
      private const remote6Color:uint = 65535;
      
      private const remote7Color:uint = 16711920;
      
      private const localColor:uint = 16776960;
      
      private var tempID:int = -1;
      
      private var infoHover:HoverPopup;
      
      public function MiniMapDot()
      {
         super();
         stop();
         this.addEventListener(MouseEvent.MOUSE_OVER,this.infoMouseEvent,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.infoMouseEvent,false,0,true);
      }
      
      public function setTempID(param1:int, param2:Boolean = false) : *
      {
         if(this.tempID == -1 && param1 >= 0 && param1 <= 7)
         {
            this.tempID = param1;
            gotoAndStop(param2 ? "local" : "remote" + this.tempID.toString());
         }
      }
      
      public function infoMouseEvent(param1:MouseEvent = null) : *
      {
         var _loc2_:Character = null;
         if((Course.course == null || !(Course.course is Game)) && param1 != null)
         {
            return;
         }
         if(this.infoHover != null)
         {
            this.infoHover.remove();
            this.infoHover = null;
         }
         if(param1 == null || param1.type == MouseEvent.MOUSE_OUT)
         {
            return;
         }
         if(param1.type == MouseEvent.MOUSE_OVER)
         {
            _loc2_ = Course.course.playerArray[this.tempID];
            if(_loc2_ != null)
            {
               this.infoHover = new HoverPopup("Player " + (this.tempID + 1),_loc2_ is LocalCharacter ? Main.loggedInAs : _loc2_.getName(),this);
            }
         }
      }
      
      public function getColor(param1:int) : *
      {
         if(param1 >= 0 && param1 <= 7)
         {
            return this["remote" + param1 + "Color"];
         }
         return this.localColor;
      }
      
      public function remove() : *
      {
         this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
      }
   }
}
