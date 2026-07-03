package ui
{
   import flash.events.*;
   
   public class LoginPageMenuButton extends Removable
   {
       
      
      private var m:TextButtonGraphic;
      
      private var clickHandler:Function;
      
      private var str:String;
      
      public function LoginPageMenuButton(param1:String, param2:Function)
      {
         this.m = new TextButtonGraphic();
         super();
         this.str = param1;
         this.clickHandler = param2;
         this.m.textBox1.text = this.m.textBox2.text = this.str;
         this.m.textBox1.autoSize = this.m.textBox2.autoSize = "center";
         this.m.alpha = 0.75;
         this.m.addEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
         this.m.addEventListener(MouseEvent.MOUSE_OUT,this.outHandler);
         this.m.addEventListener(MouseEvent.CLICK,param2);
         addChild(this.m);
      }
      
      private function overHandler(param1:MouseEvent) : *
      {
         this.m.textBox1.text = this.m.textBox2.text = "- " + this.str + " -";
         this.m.alpha = 1;
      }
      
      private function outHandler(param1:MouseEvent) : *
      {
         if(this.m != null && this.str != null)
         {
            this.m.textBox1.text = this.m.textBox2.text = this.str;
            this.m.alpha = 0.75;
         }
      }
      
      override public function remove() : *
      {
         this.m.removeEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
         this.m.removeEventListener(MouseEvent.MOUSE_OUT,this.outHandler);
         this.m.removeEventListener(MouseEvent.CLICK,this.clickHandler);
         removeChild(this.m);
         this.m.textBox1.text = this.m.textBox2.text = "";
         this.m = null;
         this.clickHandler = null;
         super.remove();
      }
   }
}
