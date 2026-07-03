package package_14
{
   import flash.display.*;
   import package_19.*;
   import ui.*;
   
   public class SideBar extends Sprite
   {
       
      
      private var scrollBar:CustomScrollBar;
      
      private var scroll:Sprite;
      
      private var var_126:Sprite;
      
      private var posX:Number = 0;
      
      private var posY:Number = 0;
      
      private var var_388:Number = 10;
      
      public function SideBar()
      {
         this.scrollBar = new CustomScrollBar();
         this.scroll = new Sprite();
         this.var_126 = new Sprite();
         super();
         addChild(this.scrollBar);
         addChild(this.scroll);
         addChild(this.var_126);
         this.scroll.y = 4;
         this.scrollBar.x = 35;
         this.scrollBar.y = 2;
         this.scrollBar.init(this.scroll,348,346);
         x = 222;
         y = -195;
         this.method_711();
      }
      
      private function method_711() : *
      {
         var _loc1_:Number = 0;
         var _loc2_:Number = 2;
         var _loc3_:Number = 30;
         var _loc4_:Number = 348;
         var _loc5_:Number = _loc1_ + _loc3_;
         var _loc6_:Number = _loc2_ + _loc4_;
         this.var_126.graphics.beginFill(0);
         this.var_126.graphics.moveTo(_loc1_,_loc2_);
         this.var_126.graphics.lineTo(_loc1_,_loc6_);
         this.var_126.graphics.lineTo(_loc5_,_loc6_);
         this.var_126.graphics.lineTo(_loc5_,_loc2_);
         this.var_126.graphics.lineTo(_loc1_,_loc2_);
         this.var_126.graphics.endFill();
         this.scroll.mask = this.var_126;
      }
      
      protected function addItem(param1:DisplayObject, param2:String = "", param3:String = "") : *
      {
         var _loc4_:class_214 = null;
         _loc4_ = new class_214(param1,param2,param3);
         this.scroll.addChild(_loc4_);
         _loc4_.x = this.posX;
         _loc4_.y = this.posY;
         this.posY += _loc4_.height + this.var_388;
      }
      
      public function init() : *
      {
      }
      
      public function exit() : *
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      public function remove() : *
      {
         while(this.scroll.numChildren > 0)
         {
            class_214(this.scroll.getChildAt(0)).remove();
         }
         this.scrollBar.remove();
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}
