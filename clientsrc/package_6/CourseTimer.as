package package_6
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class CourseTimer extends Removable
   {
       
      
      private var m:TimerGraphic;
      
      private var time:int = 120;
      
      private var startTime:Number;
      
      private var var_308:uint;
      
      private var target:Course;
      
      private var racing:Boolean = false;
      
      private var var_480:Boolean = true;
      
      public function CourseTimer(param1:Course)
      {
         this.m = new TimerGraphic();
         super();
         this.target = param1;
         this.m.holder.timeBox.text = "";
         addChild(this.m);
      }
      
      public function setTime(param1:Number) : *
      {
         clearInterval(this.var_308);
         this.time = param1;
         this.racing = param1 <= 0;
      }
      
      public function getMS() : Number
      {
         return this.time;
      }
      
      private function method_189() : Number
      {
         return (Main.socket.getMS() - this.startTime) / 1000;
      }
      
      private function method_362() : Number
      {
         var _loc1_:Number = Number(this.method_189());
         return Math.round(this.time - _loc1_);
      }
      
      private function method_467() : *
      {
         var _loc1_:Number = NaN;
         if(this.racing)
         {
            this.display(this.method_189());
         }
         else
         {
            _loc1_ = Math.round(this.method_362());
            this.display(_loc1_);
            if(_loc1_ <= 0)
            {
               this.target.outOfTimeHandler();
               this.pause();
            }
         }
      }
      
      private function display(param1:Number) : *
      {
         var _loc2_:Number = Math.round(param1);
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         this.m.holder.timeBox.text = Data.formatTime(_loc2_);
         if(!this.racing)
         {
            if(_loc2_ < 30)
            {
               this.m.holder.timeBox.textColor = 16711680;
            }
            else
            {
               this.m.holder.timeBox.textColor = 0;
            }
            if(_loc2_ < 10)
            {
               this.method_588();
            }
         }
      }
      
      public function addTime(param1:Number) : *
      {
         if(this.racing)
         {
            this.startTime -= param1 * 1000;
            this.display(this.method_189());
         }
         else
         {
            this.time += param1;
            this.display(this.method_362());
         }
         if(this.var_480)
         {
            this.method_425();
         }
      }
      
      public function init() : *
      {
         this.startTime = Main.socket.getMS();
         this.method_425();
      }
      
      public function pause() : *
      {
         this.var_480 = true;
         clearInterval(this.var_308);
      }
      
      public function method_425() : *
      {
         this.var_480 = false;
         clearInterval(this.var_308);
         this.var_308 = setInterval(this.method_467,1000);
         this.method_467();
      }
      
      private function method_588() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.go);
         addEventListener(Event.ENTER_FRAME,this.go);
         this.m.holder.scaleX = this.m.holder.scaleY = 3;
      }
      
      private function go(param1:Event) : *
      {
         this.m.holder.scaleX = this.m.holder.scaleY = this.m.holder.scaleX * 0.9;
         if(this.m.holder.scaleX <= 1)
         {
            this.m.holder.scaleX = this.m.holder.scaleY = 1;
            removeEventListener(Event.ENTER_FRAME,this.go);
         }
      }
      
      override public function remove() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.go);
         clearInterval(this.var_308);
         super.remove();
      }
   }
}
