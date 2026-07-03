package ui
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.*;
   import flash.geom.*;
   
   public class CustomScrollBar extends MovieClip
   {
       
      
      private var m:CustomScrollBarGraphic;
      
      private var target:DisplayObject;
      
      private var stageRef:Stage;
      
      private var var_312:Number;
      
      private var var_353:Number;
      
      private var var_337:Number;
      
      private var var_610:Number;
      
      private var pos:Number = 0;
      
      private var var_586:Number = 5;
      
      private var var_595:Number;
      
      public function CustomScrollBar()
      {
         this.stageRef = Main.stage;
         super();
         this.m = new CustomScrollBarGraphic();
         addChild(this.m);
         this.m.thumb.addEventListener(MouseEvent.MOUSE_DOWN,this.method_457,false,0,true);
         this.m.upArrow.addEventListener(MouseEvent.MOUSE_DOWN,this.method_381,false,0,true);
         this.m.downArrow.addEventListener(MouseEvent.MOUSE_DOWN,this.method_255,false,0,true);
      }
      
      public function init(param1:DisplayObject, param2:Number, param3:Number) : *
      {
         this.m.track.height = param2 - 15;
         this.m.downArrow.y = param2 - this.m.downArrow.height;
         this.var_353 = this.m.downArrow.y - this.m.thumb.height / 2;
         this.var_312 = this.m.upArrow.height + this.m.thumb.height / 2;
         this.var_337 = param1.y;
         this.target = param1;
         this.var_610 = param3;
         scaleX = scaleY = 1;
      }
      
      private function method_457(param1:MouseEvent) : *
      {
         this.stageRef.addEventListener(MouseEvent.MOUSE_UP,this.method_199,false,0,true);
         this.stageRef.addEventListener(MouseEvent.MOUSE_MOVE,this.method_183,false,0,true);
      }
      
      private function method_381(param1:MouseEvent) : *
      {
         this.method_319(-this.var_586);
      }
      
      private function method_255(param1:MouseEvent) : *
      {
         this.method_319(this.var_586);
      }
      
      private function method_319(param1:Number) : *
      {
         removeEventListener(Event.ENTER_FRAME,this.scroll);
         addEventListener(Event.ENTER_FRAME,this.scroll,false,0,true);
         this.stageRef.addEventListener(MouseEvent.MOUSE_UP,this.method_347,false,0,true);
         this.var_595 = param1;
      }
      
      private function method_347(param1:MouseEvent) : *
      {
         removeEventListener(Event.ENTER_FRAME,this.scroll);
      }
      
      private function scroll(param1:Event) : *
      {
         this.position(this.pos + this.var_595);
      }
      
      private function method_199(param1:MouseEvent) : *
      {
         this.stageRef.removeEventListener(MouseEvent.MOUSE_UP,this.method_199);
         this.stageRef.removeEventListener(MouseEvent.MOUSE_MOVE,this.method_183);
      }
      
      private function method_183(param1:MouseEvent) : *
      {
         var _loc2_:Number = param1.stageY;
         var _loc3_:Point = new Point(0,_loc2_);
         _loc3_ = globalToLocal(_loc3_);
         _loc2_ = _loc3_.y;
         this.position(_loc2_);
      }
      
      public function position(param1:Number) : *
      {
         if(param1 > this.var_353)
         {
            param1 = Number(this.var_353);
         }
         if(param1 < this.var_312)
         {
            param1 = Number(this.var_312);
         }
         this.m.thumb.y = this.pos = param1;
         var _loc2_:Number = (this.m.thumb.y - this.var_312) / (this.var_353 - this.var_312);
         var _loc3_:Number = this.target.height - this.var_610;
         this.target.y = this.var_337 - _loc2_ * _loc3_;
         if(this.target.y > this.var_337)
         {
            this.target.y = this.var_337;
         }
         this.target.y = Math.round(this.target.y);
      }
      
      public function remove() : *
      {
         this.m.thumb.removeEventListener(MouseEvent.MOUSE_DOWN,this.method_457);
         this.m.upArrow.removeEventListener(MouseEvent.MOUSE_DOWN,this.method_381);
         this.m.downArrow.removeEventListener(MouseEvent.MOUSE_DOWN,this.method_255);
         removeEventListener(Event.ENTER_FRAME,this.scroll);
         this.stageRef.removeEventListener(MouseEvent.MOUSE_UP,this.method_347);
         this.stageRef.removeEventListener(MouseEvent.MOUSE_UP,this.method_199);
         this.stageRef.removeEventListener(MouseEvent.MOUSE_MOVE,this.method_183);
         this.target = null;
         this.stageRef = null;
         this.m = null;
      }
   }
}
