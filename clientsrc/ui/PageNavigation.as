package ui
{
   import com.jiggmin.data.*;
   import flash.events.*;
   
   public class PageNavigation extends Removable
   {
       
      
      private var target:*;
      
      private var navButtonArray:Array;
      
      public var selected:int;
      
      private var count:int;
      
      private var w:Number;
      
      private var mode:String;
      
      public function PageNavigation(param1:*, param2:String = "full", param3:int = 1, param4:int = 9, param5:Number = 200)
      {
         this.navButtonArray = new Array();
         super();
         this.target = param1;
         this.mode = param2;
         this.selected = param3;
         this.count = param4;
         this.w = param5;
         this.draw();
      }
      
      private function draw() : *
      {
         var _loc2_:int = 0;
         this.clear();
         var _loc1_:* = true;
         if(this.mode != "vertical")
         {
            _loc1_ = this.selected > 1;
            this.makeNavButton("<- Last",this.selected - 1,_loc1_);
         }
         if(this.mode == "full" || this.mode == "vertical")
         {
            _loc2_ = 1;
            while(_loc2_ <= this.count)
            {
               _loc1_ = _loc2_ != this.selected;
               this.makeNavButton(_loc2_.toString(),_loc2_,_loc1_);
               _loc2_++;
            }
         }
         if(this.mode != "vertical")
         {
            _loc1_ = this.selected < this.count;
            this.makeNavButton("Next ->",this.selected + 1,_loc1_);
         }
         this.position(this.mode != "vertical" ? "horizontal" : "vertical");
      }
      
      private function position(param1:String) : *
      {
         var _loc3_:PageNumberGraphic = null;
         var _loc2_:int = 0;
         var _loc4_:* = param1 == "horizontal";
         var _loc5_:Number = 0;
         while(_loc2_ < this.navButtonArray.length)
         {
            _loc3_ = this.navButtonArray[_loc2_];
            if(_loc4_)
            {
               _loc3_.x = _loc5_;
               _loc5_ += _loc3_.width;
            }
            else
            {
               _loc3_.y = _loc5_;
               _loc5_ += _loc3_.height;
            }
            _loc2_++;
         }
         var _loc6_:Number = ((_loc4_ ? width : height) - this.w) / (this.navButtonArray.length - 1);
         _loc2_ = 1;
         while(_loc2_ < this.navButtonArray.length)
         {
            this.navButtonArray[_loc2_][_loc4_ ? "x" : "y"] -= _loc6_ * _loc2_;
            _loc2_++;
         }
      }
      
      private function clear() : *
      {
         var _loc2_:PageNumberGraphic = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.navButtonArray.length)
         {
            _loc2_ = this.navButtonArray[_loc1_];
            _loc2_.textBox.removeEventListener(TextEvent.LINK,this.clickPage);
            removeChild(_loc2_);
            _loc2_ = null;
            _loc1_++;
         }
         this.navButtonArray = new Array();
      }
      
      private function makeNavButton(param1:String, param2:int, param3:Boolean = true) : *
      {
         var _loc4_:PageNumberGraphic;
         (_loc4_ = new PageNumberGraphic()).textBox.autoSize = "left";
         if(param3)
         {
            _loc4_.textBox.htmlText = "<a href=\'event:" + param2 + "\'><font color=\'#325638\'><u>" + Data.escapeString(param1) + "</u></font></a>";
            _loc4_.textBox.addEventListener(TextEvent.LINK,this.clickPage,false,0,true);
         }
         else
         {
            _loc4_.textBox.text = param1;
         }
         addChild(_loc4_);
         this.navButtonArray.push(_loc4_);
      }
      
      private function clickPage(param1:TextEvent) : *
      {
         this.setPageNum(int(param1.text));
         Main.stage.focus = Main.stage;
      }
      
      public function setPageNum(param1:int) : *
      {
         this.selected = param1;
         this.draw();
         this.target.setPageNum(param1);
      }
      
      public function addPageHighlight(param1:int) : *
      {
         if(this.mode != "vertical" && this.mode != "full" || param1 > this.count || param1 < 1 || this.selected === param1)
         {
            return;
         }
         if(this.navButtonArray[param1 - 1] != null)
         {
            this.navButtonArray[param1 - 1].textBox.htmlText = "<a href=\'event:" + param1 + "\'><font color=\'#FFFFFF\'><u>" + param1 + "</u></font></a>";
         }
      }
      
      public function removePageHighlight(param1:int) : *
      {
         if(this.mode != "vertical" && this.mode != "full" || param1 > this.count || param1 < 1 || this.selected === param1)
         {
            return;
         }
         var _loc2_:* = this.selected === param1;
         if(this.navButtonArray[param1 - 1] != null)
         {
            if(_loc2_)
            {
               this.navButtonArray[param1 - 1].textBox.text = param1;
            }
            else
            {
               this.navButtonArray[param1 - 1].textBox.htmlText = "<a href=\'event:" + param1 + "\'><font color=\'#325638\'><u>" + param1 + "</u></font></a>";
            }
         }
      }
      
      override public function remove() : *
      {
         this.clear();
         this.target = null;
         super.remove();
      }
   }
}
