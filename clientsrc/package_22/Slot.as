package package_22
{
   import flash.events.*;
   
   public class Slot extends Removable
   {
       
      
      private var target:LevelItem;
      
      public var courseMenu:CourseMenu;
      
      private var m:SlotGraphic;
      
      private var status:String = "empty";
      
      private var num:Number;
      
      public function Slot(param1:int, param2:LevelItem)
      {
         this.m = new SlotGraphic();
         super();
         this.num = param1;
         this.target = param2;
         addChild(this.m);
         this.m.bg.stop();
         addEventListener(MouseEvent.MOUSE_OVER,this.overHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.outHandler,false,0,true);
         addEventListener(MouseEvent.CLICK,this.clickHandler,false,0,true);
      }
      
      public function fillSlot(param1:String, param2:Number, param3:String) : *
      {
         this.clearSlot();
         this.m.rankBox.text = param2.toString();
         this.m.nameBox.text = param1;
         this.changeStatus("filled");
         if(param3 == "me")
         {
            this.courseMenu = new CourseMenu(this);
         }
      }
      
      public function confirmSlot() : *
      {
         this.changeStatus("confirmed");
      }
      
      public function clearSlot() : *
      {
         this.m.rankBox.text = "";
         this.m.nameBox.text = "";
         this.changeStatus("empty");
      }
      
      private function changeStatus(param1:String) : *
      {
         this.status = param1;
         this.m.bg.gotoAndStop(this.status + "Up");
      }
      
      private function overHandler(param1:MouseEvent) : *
      {
         this.m.bg.gotoAndStop(this.status + "Over");
      }
      
      private function outHandler(param1:MouseEvent) : *
      {
         this.m.bg.gotoAndStop(this.status + "Up");
      }
      
      private function clickHandler(param1:MouseEvent) : *
      {
         this.m.bg.gotoAndStop("pending");
         this.target.sendFillSlot(this.num);
      }
      
      public function sendConfirmSlot() : *
      {
         this.target.sendConfirmSlot();
      }
      
      public function sendClearSlot() : *
      {
         this.target.sendClearSlot();
         if(this.courseMenu != null)
         {
            this.courseMenu = null;
         }
      }
      
      override public function remove() : *
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.outHandler);
         removeEventListener(MouseEvent.CLICK,this.clickHandler);
         if(this.courseMenu != null)
         {
            this.courseMenu.remove();
         }
         this.courseMenu = null;
         this.target = null;
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
