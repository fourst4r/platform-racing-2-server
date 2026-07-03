package ui
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   import package_4.*;
   
   public class RatingSelect extends Removable
   {
       
      
      private var m:RatingSelectGraphic;
      
      private var star:HighlightStar;
      
      private var rating:Number = 3;
      
      private var starWidth:Number;
      
      private var courseID:String;
      
      public function RatingSelect(param1:String)
      {
         this.m = new RatingSelectGraphic();
         this.star = new HighlightStar();
         this.starWidth = this.m.width / 5;
         super();
         this.courseID = param1;
         scaleX = scaleY = 1.5;
         this.star.gotoAndStop("off");
         this.star.mouseChildren = false;
         this.star.mouseEnabled = false;
         addChild(this.m);
         addChild(this.star);
         addEventListener(MouseEvent.MOUSE_MOVE,this.moveHandler,false,0,true);
         addEventListener(MouseEvent.CLICK,this.clickHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.outHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_OVER,this.overHandler,false,0,true);
         this.method_175(this.rating);
      }
      
      private function moveHandler(param1:MouseEvent) : *
      {
         var _loc2_:Number = Number(this.method_274(param1.stageX));
         this.method_175(_loc2_);
      }
      
      private function clickHandler(param1:MouseEvent) : *
      {
         var e:MouseEvent = param1;
         this.rating = this.method_274(e.stageX);
         new ConfirmPopup(function():*
         {
            rateLevel();
         },"Are you sure you want to rate this level " + this.rating + "?");
      }
      
      private function rateLevel() : *
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.level_id = this.courseID;
         _loc1_.rating = this.rating;
         var _loc2_:URLRequest = new URLRequest(Main.baseURL + "/submit_rating.php");
         _loc2_.data = _loc1_;
         _loc2_.method = URLRequestMethod.POST;
         new UploadingPopup(_loc2_,"json","Submitting rating...");
      }
      
      private function outHandler(param1:MouseEvent) : *
      {
         this.method_175(this.rating);
         this.star.gotoAndStop("off");
      }
      
      private function overHandler(param1:MouseEvent) : *
      {
         this.star.gotoAndStop("on");
      }
      
      private function method_175(param1:Number) : *
      {
         this.m.bar.scaleX = param1 / 5;
         this.star.x = (param1 - 1) * this.starWidth;
      }
      
      private function method_274(param1:Number) : Number
      {
         var _loc2_:Point = new Point(0,0);
         _loc2_ = this.localToGlobal(_loc2_);
         var _loc3_:Number = param1 - _loc2_.x;
         return Data.numLimit(Math.ceil(_loc3_ / (this.m.width * scaleX) * 5),1,5);
      }
      
      override public function remove() : *
      {
         removeEventListener(MouseEvent.MOUSE_MOVE,this.moveHandler);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.clickHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.outHandler);
         removeEventListener(MouseEvent.MOUSE_OVER,this.overHandler);
         removeChild(this.m);
         removeChild(this.star);
         this.m = null;
         this.star = null;
         super.remove();
      }
   }
}
