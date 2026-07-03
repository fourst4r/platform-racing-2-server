package package_19
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.*;
   
   public class class_214 extends HoverDelayPopup
   {
       
      
      private var bg:MovieClip;
      
      private var m:DisplayObject;
      
      public function class_214(param1:DisplayObject, param2:String = "", param3:String = "")
      {
         this.bg = new SquareBG();
         super(param2,param3);
         this.m = param1;
         this.bg.width = this.bg.height = 28;
         this.bg.x = this.bg.y = 1;
         addChild(this.bg);
         addChild(param1);
      }
      
      override protected function overHandler(param1:MouseEvent) : *
      {
         this.m.transform.colorTransform = new ColorTransform(0.5,0.5,0.5,1,128,128,128,0);
         super.overHandler(param1);
      }
      
      override protected function outHandler(param1:MouseEvent) : *
      {
         this.m.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
         super.outHandler(param1);
      }
      
      override public function remove() : *
      {
         super.remove();
      }
   }
}
