package package_20
{
   import background.DrawableBackground;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import levelEditor.*;
   import ui.CustomCursor;
   
   public class Brush extends CustomCursor
   {
       
      
      private var circle:Circle;
      
      private var drawableBG:DrawableBackground;
      
      private var mousePos:Point;
      
      private var rdInt:uint;
      
      protected var size:Number = 4;
      
      protected var color:Number = 0;
      
      protected var mode:String = "draw";
      
      protected var zoomMultiplier:Number = 1;
      
      protected var drawing:Boolean = false;
      
      private var lastX:Number = -1;
      
      private var lastY:Number = -1;
      
      private var drawStartX:int;
      
      private var drawStartY:int;
      
      public function Brush()
      {
         this.circle = new Circle();
         this.mousePos = new Point();
         super();
         var_411 = false;
         addChild(this.circle);
         this.setSize(this.size);
      }
      
      override public function init() : *
      {
         super.init();
         addEventListener(Event.ENTER_FRAME,this.go);
         clearInterval(this.rdInt);
         this.rdInt = setInterval(this.restartDrawing,10000);
      }
      
      override public function pause() : *
      {
         super.pause();
         removeEventListener(Event.ENTER_FRAME,this.go);
         clearInterval(this.rdInt);
      }
      
      private function go(param1:Event) : *
      {
         var _loc2_:Point = null;
         if(this.drawing == true)
         {
            if(!this.drawableBG.drawing)
            {
               _loc2_ = this.roundPoint(this.mousePos);
               if(_loc2_.x != this.lastX || _loc2_.y != this.lastY)
               {
                  this.drawableBG.lineTo(_loc2_.x,_loc2_.y);
                  this.lastX = _loc2_.x;
                  this.lastY = _loc2_.y;
               }
               if(Math.abs(this.drawStartX - _loc2_.x) > 400 || Math.abs(this.drawStartY - _loc2_.y) > 400)
               {
                  this.restartDrawing();
               }
            }
            else
            {
               this.stopDrawing();
            }
         }
      }
      
      private function restartDrawing() : *
      {
         if(this.drawing == true)
         {
            this.stopDrawing();
            this.startDrawing();
         }
      }
      
      public function setSize(param1:Number = 4) : *
      {
         this.size = param1;
         this.circle.width = this.circle.height = this.size * this.zoomMultiplier;
      }
      
      public function setColor(param1:Number = 0) : *
      {
         this.color = param1;
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.color = param1;
         this.circle.transform.colorTransform = _loc2_;
      }
      
      public function setZoom(param1:Number) : *
      {
         this.zoomMultiplier = param1;
         this.setSize(this.size);
      }
      
      override protected function mouseDownHandler(param1:MouseEvent) : *
      {
         var _loc2_:String = null;
         super.mouseDownHandler(param1);
         if(param1.target.parent != null)
         {
            _loc2_ = String(param1.target.parent.toString());
            if(_loc2_ == "[object DrawableBackground]" || _loc2_ == "[object LevelEditor]" || param1.target.toString() == "[object BlockGridLines]")
            {
               if(!LevelEditor.editor.menu.hitTestPoint(param1.stageX,param1.stageY,true))
               {
                  this.mousePos = new Point(param1.stageX,param1.stageY);
                  this.startDrawing();
               }
            }
         }
      }
      
      override protected function mouseUpHandler(param1:MouseEvent) : *
      {
         super.mouseUpHandler(param1);
         if(this.drawing)
         {
            this.stopDrawing();
         }
      }
      
      override protected function mouseMoveHandler(param1:MouseEvent) : *
      {
         super.mouseMoveHandler(param1);
         this.mousePos.x = param1.stageX;
         this.mousePos.y = param1.stageY;
         visible = !LevelEditor.editor.menu.hitTestPoint(param1.stageX,param1.stageY,true);
      }
      
      protected function startDrawing() : *
      {
         this.drawing = true;
         this.drawableBG = LevelEditor.editor.var_220;
         this.drawableBG.recordColor(this.color);
         this.drawableBG.setBrushSize(this.size);
         this.drawableBG.setMode(this.mode);
         var _loc1_:Point = this.roundPoint(this.mousePos);
         this.drawableBG.moveTo(_loc1_.x,_loc1_.y);
         this.drawStartX = _loc1_.x;
         this.drawStartY = _loc1_.y;
      }
      
      protected function stopDrawing() : *
      {
         this.drawing = false;
         LevelEditor.editor.var_220.rasterize();
      }
      
      private function roundPoint(param1:Point) : Point
      {
         param1 = this.drawableBG.globalToLocal(param1);
         param1.x = Math.round(param1.x);
         param1.y = Math.round(param1.y);
         return param1;
      }
      
      override public function remove() : *
      {
         this.circle = null;
         this.drawableBG = null;
         this.mousePos = null;
         super.remove();
      }
   }
}
