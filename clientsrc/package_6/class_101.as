package package_6
{
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   
   public class class_101 extends Sprite
   {
       
      
      private var bg:BlueSquareButton;
      
      private var img:Loader;
      
      private var id:int;
      
      public function class_101(param1:int)
      {
         this.bg = new BlueSquareButton();
         this.img = new Loader();
         super();
         this.id = param1;
         addChild(this.bg);
         addChild(this.img);
         this.getImg();
      }
      
      public function getId() : int
      {
         return this.id;
      }
      
      private function getImg() : *
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.img = this.id;
         var _loc2_:URLRequest = new URLRequest(Main.baseURL + "/cat/cat-img.php");
         _loc2_.data = _loc1_;
         this.img.contentLoaderInfo.addEventListener(Event.COMPLETE,this.method_566,false,0,true);
         this.img.load(_loc2_);
      }
      
      private function method_566(param1:* = null) : *
      {
         Data.method_314(this.img,200,200);
         this.img.x = Math.round((200 - this.img.width) / 2) + 5;
         this.img.y = Math.round((200 - this.img.height) / 2) + 5;
         this.img.mouseEnabled = this.img.mouseChildren = false;
      }
      
      public function remove() : *
      {
         this.img.removeEventListener(Event.COMPLETE,this.method_566);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}
