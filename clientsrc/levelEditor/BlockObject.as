package levelEditor
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class BlockObject extends DrawObject
   {
       
      
      private var segSize:Number;
      
      private var optionsButton:BlockOptionsButton;
      
      private var lastX:Number;
      
      private var lastY:Number;
      
      public var segX:int;
      
      public var segY:int;
      
      public var posX:Number;
      
      public var posY:Number;
      
      public function BlockObject(param1:int, param2:Number, param3:Number, param4:String = "")
      {
         this.segSize = LevelEditor.segSize;
         super(param1,param2,param3);
         this.displayCode = param1;
         this.lastX = x = this.method_103(param2);
         this.lastY = y = this.method_103(param3);
         this.segX = Math.floor(x / this.segSize);
         this.segY = Math.floor(y / this.segSize);
         this.posX = x;
         this.posY = y;
         resizable = false;
         if(this.displayCode != Objects.BLOCK_MINION_EGG && param4 != "")
         {
            this.setOptionsString(param4);
         }
      }
      
      public function setSeg(param1:int, param2:int) : *
      {
         this.segX = param1;
         this.segY = param2;
         this.posX = x = this.segX * this.segSize;
         this.posY = y = this.segY * this.segSize;
      }
      
      public function getSeg() : Point
      {
         return new Point(this.segX,this.segY);
      }
      
      override protected function endDrag(param1:MouseEvent) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         _loc2_ = Number(this.method_103(x));
         _loc3_ = Number(this.method_103(y));
         x = this.lastX;
         y = this.lastY;
         var _loc4_:BlockObject = editor.blockBG.getBlockAt(_loc2_,_loc3_);
         var _loc5_:Boolean = true;
         if(_loc4_ != null && _loc4_ != this)
         {
            if(_loc4_.displayCode == Objects.BLOCK_START1 || _loc4_.displayCode == Objects.BLOCK_START2 || _loc4_.displayCode == Objects.BLOCK_START3 || _loc4_.displayCode == Objects.BLOCK_START4)
            {
               _loc5_ = false;
            }
            else
            {
               editor.cur.recordDelete(this);
               _loc4_.remove();
            }
         }
         if(_loc5_)
         {
            this.lastX = x = _loc2_;
            this.lastY = y = _loc3_;
         }
         editor.blockBG.moveBlock(new Point(this.segX,this.segY),new Point(Math.round(x / this.segSize),Math.round(y / this.segSize)));
         super.endDrag(param1);
      }
      
      public function onOptionsPress(param1:MouseEvent) : *
      {
         param1.stopImmediatePropagation();
         m.openOptions();
      }
      
      public function getOptionsString() : *
      {
         return m.options;
      }
      
      public function setOptionsString(param1:String) : *
      {
         m.applyOptions(param1);
      }
      
      override public function select() : *
      {
         super.select();
         LevelEditor.editor.selectedBlock = this;
         if(deleteable && Boolean(m.hasOptions))
         {
            this.showOptionsButton();
         }
         this.positionInternals();
      }
      
      override public function deselect() : *
      {
         super.deselect();
         if (LevelEditor.editor != null && LevelEditor.editor.selectedBlock == this)
         {
            LevelEditor.editor.selectedBlock = null;
         }
         this.hideOptionsButton();
      }
      
      private function showOptionsButton() : *
      {
         this.optionsButton = new BlockOptionsButton();
         this.optionsButton.addEventListener(MouseEvent.MOUSE_DOWN,this.onOptionsPress,false,0,true);
         addChild(this.optionsButton);
      }
      
      private function hideOptionsButton() : *
      {
         if(this.optionsButton != null)
         {
            this.optionsButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.onOptionsPress);
            removeChild(this.optionsButton);
            this.optionsButton = null;
         }
      }
      
      override protected function positionInternals() : *
      {
         super.positionInternals();
         if(this.optionsButton != null)
         {
            this.optionsButton.x = m.width;
            this.optionsButton.y = m.height;
            this.optionsButton.scaleX = buttonScaleX;
            this.optionsButton.scaleY = buttonScaleY;
         }
      }
      
      private function method_103(param1:Number) : Number
      {
         return Math.round(param1 / this.segSize) * this.segSize;
      }
      
      override public function remove() : *
      {
         if (LevelEditor.editor != null && LevelEditor.editor.selectedBlock == this)
         {
            LevelEditor.editor.selectedBlock = null;
         }
         this.hideOptionsButton();
         LevelEditor.editor.blockBG.removeBlock(this);
         --LevelEditor.editor.blockBG.blocksAttached;
         super.remove();
      }
   }
}
