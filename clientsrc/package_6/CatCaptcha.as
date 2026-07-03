package package_6
{
   import flash.events.*;
   import flash.net.*;
   import package_4.Popup;
   
   public class CatCaptcha extends Popup
   {
       
      
      private var m:CatCaptchaPopupGraphic;
      
      private var var_567:int = -215;
      
      private var var_608:int = -91;
      
      private var var_639:int = 220;
      
      private var var_629:int = 2;
      
      private var var_181:SuperLoader;
      
      private var var_191:SuperLoader;
      
      public function CatCaptcha()
      {
         this.m = new CatCaptchaPopupGraphic();
         this.var_181 = new SuperLoader(true,SuperLoader.j);
         this.var_191 = new SuperLoader(true,SuperLoader.j);
         super();
         addChild(this.m);
         this.var_181.addEventListener(SuperLoader.d,this.method_441,false,0,true);
         this.var_181.addEventListener(SuperLoader.e,this.method_99,false,0,true);
         this.var_191.addEventListener(SuperLoader.d,this.method_465,false,0,true);
         this.var_191.addEventListener(SuperLoader.e,this.method_99,false,0,true);
         this.method_694();
      }
      
      private function method_694() : *
      {
         this.var_181.load(new URLRequest(Main.baseURL + "/cat/cat-captcha.php"));
      }
      
      private function method_441(param1:Event) : *
      {
         this.method_561();
      }
      
      private function method_561() : *
      {
         var _loc2_:class_101 = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.var_629)
         {
            _loc2_ = new class_101(_loc1_);
            _loc2_.addEventListener(MouseEvent.CLICK,this.clickHandler,false,0,true);
            this.m.addChild(_loc2_);
            _loc2_.x = this.var_567 + this.var_639 * _loc1_;
            _loc2_.y = this.var_608;
            _loc1_++;
         }
      }
      
      private function clickHandler(param1:MouseEvent) : *
      {
         var _loc2_:class_101 = null;
         if(!fadeOutStarted && param1.currentTarget is class_101)
         {
            _loc2_ = class_101(param1.currentTarget);
            this.submit(_loc2_.getId());
         }
      }
      
      private function submit(param1:int) : *
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.answer = param1;
         var _loc3_:URLRequest = new URLRequest(Main.baseURL + "/cat/captcha-submit.php");
         _loc3_.data = _loc2_;
         this.var_191.load(_loc3_);
         startFadeOut();
      }
      
      private function method_465(param1:Event) : *
      {
         startFadeOut();
      }
      
      private function method_99(param1:Event) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.var_181.removeEventListener(SuperLoader.e,this.method_99);
         this.var_181.removeEventListener(SuperLoader.d,this.method_441);
         this.var_181.remove();
         this.var_181 = null;
         this.var_191.removeEventListener(SuperLoader.e,this.method_99);
         this.var_191.removeEventListener(SuperLoader.d,this.method_465);
         this.var_191.remove();
         this.var_191 = null;
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
