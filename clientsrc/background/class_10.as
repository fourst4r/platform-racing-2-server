package background
{
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.geom.*;
   import page.GamePage;
   import replay.ReplayManager;
   
   public class class_10 extends Background
   {
       
      
      private var bitmapData:BitmapData;
      
      private var bitmap:Bitmap;
      
      private var color:Number;
      
      private var displayCode:int;
      
      public function class_10(param1:GamePage)
      {
         this.bitmapData = new BitmapData(550,400,false,0);
         this.bitmap = new Bitmap(this.bitmapData);
         super(param1);
         scale = 0;
         cacheAsBitmap = true;
         mouseEnabled = false;
         mouseChildren = false;
         this.bitmap.x = -275;
         this.bitmap.y = -200;
         addChild(this.bitmap);
      }
      
      override public function setColor(param1:Number) : *
      {
         this.color = param1;
         this.bitmapData.fillRect(this.bitmapData.rect,param1);
         this.displayCode = -1;
         super.setColor(param1);
      }
      
      public function method_338(param1:int) : *
      {
         this.displayCode = param1;
         var _loc2_:DisplayObject = Objects.getFromCode(param1);
         if(param1 == Objects.BG5Code)
         {
            this.method_536(_loc2_);
         }
         this.bitmapData.draw(_loc2_);
         scale = param1 == Objects.BG4Code || param1 == Objects.BG5Code ? 0 : 1;
         method_59();
      }
      
      private function method_536(param1:DisplayObject) : *
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc6_:ColorTransform = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Circle = null;
         _loc2_ = MovieClip(param1);
         _loc3_ = 50;
         var _loc4_:int = int(550 / _loc3_);
         var _loc5_:int = int(400 / _loc3_);
         _loc6_ = new ColorTransform();
         while(_loc7_ < _loc4_)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc5_)
            {
               _loc6_.color = Math.random() * 16777215;
               _loc9_ = new Circle();
               _loc9_.width = _loc9_.height = 25;
               _loc9_.x = _loc7_ * _loc3_ + 7.5 + _loc9_.width / 2;
               _loc9_.y = _loc8_ * _loc3_ + 7.5 + _loc9_.height / 2;
               _loc9_.transform.colorTransform = _loc6_;
               _loc2_.addChild(_loc9_);
               _loc8_++;
            }
            _loc7_++;
         }
      }
      
      override public function getSaveString() : String
      {
         return this.displayCode.toString();
      }
      
      override public function setSaveString(param1:String, param2:Boolean = true) : *
      {
         if((!Settings.getValue(Settings.DRAW_ART,true) || ReplayManager.isActive) && !param2 || param1 == "-1" || param1 == "Square" || param1 == null || param1 == "")
         {
            return;
         }
         if(param1.indexOf("BG") != -1)
         {
            param1 = "20" + param1.substr(2);
         }
         this.method_338(int(param1));
      }
      
      override public function remove() : *
      {
         this.bitmapData.dispose();
         this.bitmap.bitmapData = null;
         removeChild(this.bitmap);
         this.bitmap = null;
         this.bitmapData = null;
         super.remove();
      }
   }
}
