package background
{
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.*;
   import levelEditor.*;
   import page.GamePage;
   import replay.ReplayManager;
   import flash.utils.getTimer;
   
   public class DrawableBackground extends Background
   {
       
      
      private var rasterTileSize:Number = 200;
      
      private var rasterTileLimit:int = 750;
      
      private var losslessQuality:Boolean = false;
      
      private var fromLE:Boolean;
      
      private var rasterCycles:Number = 1;
      
      private var bitmapArray:Array;
      
      public var brushCanvas:Sprite;
      
      public var rasterCanvas:Sprite;
      
      public var objCanvas:Sprite;
      
      private var brushSize:Number = 4;
      
      private var color:Number = 0;
      
      private var mode:String = "draw";
      
      private var brushX:Number;
      
      private var brushY:Number;
      
      public var drawing:Boolean = false;
      
      public var stoppedRasterizing:Boolean = false;
      
      public function DrawableBackground(gamePage:GamePage)
      {
         this.bitmapArray = new Array();
         this.brushCanvas = new Sprite();
         this.rasterCanvas = new Sprite();
         this.objCanvas = new Sprite();
         super(gamePage);
         this.fromLE = LevelEditor.editor != null;
         this.losslessQuality = Settings.getValue(Settings.ART_LOSSLESS_QUALITY,false);
         this.rasterCanvas.cacheAsBitmap = true;
         addChild(this.rasterCanvas);
         addChild(this.brushCanvas);
         addChild(this.objCanvas);
         this.brushCanvas.graphics.lineStyle(this.brushSize,this.color);
      }
      
      public function method_86() : *
      {
         this.rasterCanvas.cacheAsBitmap = false;
         this.setObjectCacheAsBitmap(false);
      }
      
      public function method_74() : *
      {
         this.rasterCanvas.cacheAsBitmap = true;
         this.setObjectCacheAsBitmap(true);
      }
      
      private function setObjectCacheAsBitmap(cacheAsBitmap:Boolean) : *
      {
         var child:DisplayObject = null;
         var index:int = 0;
         while(index < this.objCanvas.numChildren)
         {
            child = this.objCanvas.getChildAt(index);
            child.cacheAsBitmap = cacheAsBitmap;
            index++;
         }
      }
      
      override public function setSaveString(saveString:String, allowDraw:Boolean = true) : *
      {
         if((!Settings.getValue(Settings.DRAW_ART,true) || ReplayManager.isActive) && !allowDraw)
         {
            saveString = "";
         }
         super.setSaveString(saveString);
      }
      
      override public function setScale(newScale:Number) : *
      {
         scale = newScale;
         method_59();
      }
      
      public function rasterize() : *
      {
         this.rasterizeSprite(this.rasterCanvas,this.bitmapArray);
      }
      
      private function rasterizeSprite(targetCanvas:Sprite, tileArray:Array) : *
      {
         this.rasterizeSpriteTiles(targetCanvas,tileArray,this.brushCanvas);
         this.brushCanvas.graphics.clear();
         this.brushCanvas.graphics.lineStyle(this.brushSize,this.color);
      }
      
      private function rasterizeSpriteTiles(targetCanvas:Sprite, tileArray:Array, sourceSprite:Sprite) : *
      {
         var bounds:Rectangle = sourceSprite.getBounds(this);
         var tileSize:int = this.rasterTileSize * this.rasterCycles;
         var startX:Number = Math.floor(bounds.x / tileSize) * tileSize;
         var startY:Number = Math.floor(bounds.y / tileSize) * tileSize;
         var endX:Number = bounds.x + bounds.width;
         var endY:Number = bounds.y + bounds.height;
         var tileX:Number = startX;
         var tileY:Number = startY;
         while(tileX < endX)
         {
            tileY = startY;
            while(tileY < endY)
            {
               this.rasterizeTile(tileX,tileY,targetCanvas,tileArray,sourceSprite);
               tileY += tileSize;
            }
            tileX += tileSize;
         }
         if(!this.losslessQuality && !this.fromLE && this.rasterCycles < 5 && Main.var_184 >= this.rasterTileLimit)
         {
            ++this.rasterCycles;
            this.clear();
            this.draw();
         }
         else if(this.rasterCycles >= 5)
         {
            this.stoppedRasterizing = true;
         }
      }
      
      private function rasterizeTile(tileX:Number, tileY:Number, targetCanvas:Sprite, tileArray:Array, sourceSprite:Sprite) : *
      {
         var tileIndexX:Number = NaN;
         var tileIndexY:Number = NaN;
         var previousParent:DisplayObjectContainer = null;
         var tempContainer:Sprite = null;
         var tileData:BitmapData = null;
         var tileBitmap:Bitmap = null;
         tileIndexX = Math.floor(tileX / (this.rasterTileSize * this.rasterCycles));
         tileIndexY = Math.floor(tileY / (this.rasterTileSize * this.rasterCycles));
         var shouldCreate:Boolean = true;
         if(tileArray[tileIndexX] == null)
         {
            tileArray[tileIndexX] = new Array();
         }
         else if(tileArray[tileIndexX][tileIndexY] != null)
         {
            shouldCreate = false;
         }
         if(!shouldCreate || Main.var_184 <= this.rasterTileLimit || Boolean(this.losslessQuality) || Boolean(this.fromLE))
         {
            if(shouldCreate)
            {
               ++Main.var_184;
               tileData = new BitmapData(this.rasterTileSize + 1,this.rasterTileSize + 1,true,0);
               tileBitmap = new Bitmap(tileData);
               tileBitmap.scaleX = tileBitmap.scaleY = this.rasterCycles;
               tileArray[tileIndexX][tileIndexY] = tileBitmap;
               if(targetCanvas != this.rasterCanvas || method_32(tileIndexX,tileIndexY))
               {
                  targetCanvas.addChild(tileBitmap);
               }
               tileBitmap.x = tileX;
               tileBitmap.y = tileY;
            }
            previousParent = sourceSprite.parent;
            (tempContainer = new Sprite()).addChild(sourceSprite);
            sourceSprite.scaleX = sourceSprite.scaleY = 1 / this.rasterCycles;
            sourceSprite.x = -(tileX * (1 / this.rasterCycles));
            sourceSprite.y = -(tileY * (1 / this.rasterCycles));
            Bitmap(tileArray[tileIndexX][tileIndexY]).bitmapData.draw(tempContainer);
            sourceSprite.x = sourceSprite.y = 0;
            sourceSprite.scaleX = sourceSprite.scaleY = 1;
            if(previousParent != null)
            {
               previousParent.addChild(sourceSprite);
            }
         }
      }
      
      public function erase() : *
      {
         var tileBitmap:Bitmap = null;
         var eraseCanvas:Sprite = new Sprite();
         var eraseTiles:Array = new Array();
         this.rasterizeSprite(eraseCanvas,eraseTiles);
         var tileLayer:Sprite = new Sprite();
         this.extractTilesForMask(tileLayer,this.bitmapArray,eraseTiles);
         var compositeLayer:Sprite;
         (compositeLayer = new Sprite()).blendMode = BlendMode.LAYER;
         eraseCanvas.blendMode = BlendMode.ERASE;
         compositeLayer.addChild(tileLayer);
         compositeLayer.addChild(eraseCanvas);
         var index:int = 0;
         while(index < tileLayer.numChildren)
         {
            tileBitmap = Bitmap(tileLayer.getChildAt(index));
            this.rasterizeTile(tileBitmap.x,tileBitmap.y,this.rasterCanvas,this.bitmapArray,compositeLayer);
            index++;
         }
         this.disposeTilesInLayer(eraseCanvas);
         this.disposeTilesInLayer(tileLayer);
         addChildAt(this.rasterCanvas,0);
         addChildAt(this.brushCanvas,1);
      }
      
      private function extractTilesForMask(targetLayer:Sprite, mainTiles:Array, maskTiles:Array) : *
      {
         var rowIndex:int = 0;
         var colIndex:int = 0;
         while(rowIndex < maskTiles.length)
         {
            if(maskTiles[rowIndex] != null)
            {
               colIndex = 0;
               while(colIndex < maskTiles[rowIndex].length)
               {
                  if(maskTiles[rowIndex][colIndex] != null && mainTiles[rowIndex] != null && mainTiles[rowIndex][colIndex] != null)
                  {
                     targetLayer.addChild(mainTiles[rowIndex][colIndex]);
                     mainTiles[rowIndex][colIndex] = null;
                  }
                  colIndex++;
               }
            }
            rowIndex++;
         }
      }
      
      override public function draw(frameBudget:Number = 50) : *
      {
         var start:Number = 0;
         var steps:int = 0;
         var elapsed:Number = NaN;
         this.drawing = true;
         course.startDrawing(this);
         if(course.goodToDraw(this))
         {
            start = getTimer();
            this.brushCanvas.graphics.lineStyle(this.brushSize,this.color);
            steps = 0;
            while(var_39 < saveArray.length)
            {
               var entry:String = saveArray[var_39];
               var c:int = entry.charCodeAt(0);
               var data:String = entry.substr(1);

               var needsRasterize:Boolean = false;
               switch (c) {
               case 100: // 'd'
                  this.placeStroke(data);
                  needsRasterize = true;
                  break;
               case 99:  // 'c'
                  this.color = Number("0x" + data);
                  this.brushCanvas.graphics.lineStyle(this.brushSize, this.color);
                  break;
               case 116: // 't'
                  this.brushSize = Number(data);
                  this.brushCanvas.graphics.lineStyle(this.brushSize, this.color);
                  break;
               case 109: this.mode = data; break; // 'm'
               case 111: this.placeObject(data); break; // 'o'
               case 117: this.drawText(data); break; // 'u'
               }

               if(needsRasterize && this.mode == "erase")
               {
                  this.erase();
               }
               if(needsRasterize && this.mode == "draw")
               {
                  this.rasterize();
               }

               ++var_39;
               if ((steps & 31) == 0) { // every 32
                  elapsed = getTimer() - start;
                  if ((elapsed > 50 && steps > 20) || elapsed > 250) break;
               }
               steps++;
            }
         }
         if(var_39 >= saveArray.length)
         {
            this.drawing = false;
         }
         super.draw(frameBudget);
      }
      
      override public function setPos(xPos:Number, yPos:Number) : *
      {
         super.setPos(xPos,yPos);
         var rotatedPos:Point = Data.method_9(-course.posX,-course.posY,rotation);
         var tileX:int = Math.floor(rotatedPos.x * scale / (this.rasterTileSize * this.rasterCycles));
         var tileY:int = Math.floor(rotatedPos.y * scale / (this.rasterTileSize * this.rasterCycles));
         method_118(tileX,tileY,2,2,1,1,this.rasterCanvas,this.bitmapArray);
      }
      
      protected function placeObject(encoded:String) : *
      {
         var parts:Array = encoded.split(";");
         var scaleXFactor:Number = Number(parts[3]);
         var scaleYFactor:Number = Number(parts[4]);
         var displayObject:DisplayObject = Objects.getFromCode(Number(parts[0]));
         displayObject.scaleX = displayObject.scaleY = scale;
         displayObject.x = Number(parts[1]) * scale;
         displayObject.y = Number(parts[2]) * scale;
         if(!isNaN(scaleXFactor) && !isNaN(scaleYFactor))
         {
            displayObject.scaleX *= scaleXFactor;
            displayObject.scaleY *= scaleYFactor;
         }
         displayObject.cacheAsBitmap = true;
         this.objCanvas.addChild(displayObject);
      }
      
      protected function drawText(encoded:String) : *
      {
         var parts:Array = encoded.split(";");
         var text:String = String(parts[0]);
         var xPos:int = int(parts[1]);
         var yPos:int = int(parts[2]);
         var textColor:int = int(parts[3]);
         var scaleXFactor:Number = Number(parts[4]) / 100;
         var scaleYFactor:Number = Number(parts[5]) / 100;
         var textField:TextField;
         (textField = new TextObjectGraphic().textBox).selectable = false;
         textField.wordWrap = false;
         textField.autoSize = TextFieldAutoSize.LEFT;
         textField.multiline = true;
         textField.textColor = textColor;
         textField.text = TextObject.parseText(text);
         textField.scaleX = scaleXFactor * scale;
         textField.scaleY = scaleYFactor * scale;
         textField.height = 24;
         textField.x = xPos * scale;
         textField.y = yPos * scale;
         textField.cacheAsBitmap = true;
         this.objCanvas.addChild(textField);
      }
      
      private function placeStroke(encoded:String) : *
      {
         var parts:Array = encoded.split(";");
         this.initBrushMove(parts[0],parts[1]);
         var index:int = 2;
         while(index < parts.length)
         {
            this.drawLine(parts[index],parts[index + 1]);
            index += 2;
         }
      }
      
      public function recordColor(newColor:Number) : *
      {
         if(this.color != newColor)
         {
            this.color = newColor;
            this.brushCanvas.graphics.lineStyle(this.brushSize,this.color);
            recordAction("c" + this.color.toString(16));
         }
      }
      
      public function setBrushSize(newSize:Number) : *
      {
         if(this.brushSize != newSize)
         {
            this.brushSize = newSize;
            this.brushCanvas.graphics.lineStyle(newSize,this.color);
            recordAction("t" + newSize);
         }
      }
      
      public function setMode(newMode:String) : *
      {
         if(this.mode != newMode)
         {
            this.mode = newMode;
            recordAction("m" + newMode);
         }
      }
      
      public function moveTo(xPos:Number, yPos:Number) : *
      {
         recordAction("d" + xPos + ";" + yPos);
         if(!this.drawing)
         {
            this.initBrushMove(xPos,yPos);
         }
      }
      
      public function lineTo(xPos:Number, yPos:Number) : *
      {
         var deltaX:Number = xPos - this.brushX;
         var deltaY:Number = yPos - this.brushY;
         saveArray[saveArray.length - 1] = saveArray[saveArray.length - 1] + ";" + deltaX + ";" + deltaY;
         if(!this.drawing)
         {
            this.drawLine(deltaX,deltaY);
         }
      }
      
      private function initBrushMove(xPos:Number, yPos:Number) : *
      {
         this.brushCanvas.graphics.moveTo(xPos,yPos);
         this.brushCanvas.graphics.lineTo(xPos - 0.15,yPos);
         this.brushCanvas.graphics.moveTo(xPos,yPos);
         this.brushX = xPos;
         this.brushY = yPos;
      }
      
      private function drawLine(deltaX:Number, deltaY:Number) : *
      {
         this.brushX += deltaX;
         this.brushY += deltaY;
         this.brushCanvas.graphics.lineTo(this.brushX,this.brushY);
      }
      
      override public function undo() : *
      {
         var entry:String = null;
         var index:int = saveArray.length - 2;
         while(index >= 0)
         {
            entry = String(saveArray[index]);
            if(entry.charAt(0) == "d")
            {
               break;
            }
            redoArray.push(saveArray.pop());
            index--;
         }
         super.undo();
      }
      
      override public function redo() : *
      {
         var entry:String = null;
         var index:Number = redoArray.length - 2;
         while(index >= 0)
         {
            entry = String(redoArray[index]);
            if(entry.charAt(0) == "d")
            {
               break;
            }
            saveArray.push(redoArray.pop());
            index--;
         }
         super.redo();
      }
      
      override public function clear() : *
      {
         this.disposeTileArray(this.bitmapArray);
         this.bitmapArray = new Array();
         this.brushCanvas.graphics.clear();
         this.color = 0;
         this.brushSize = 4;
         this.mode = "draw";
         super.clear();
      }
      
      protected function disposeTilesInLayer(sprite:Sprite) : *
      {
         var tileBitmap:Bitmap = null;
         while(sprite.numChildren != 0)
         {
            tileBitmap = Bitmap(sprite.getChildAt(0));
            this.disposeTileBitmap(tileBitmap);
         }
      }
      
      private function disposeTileArray(tileArray:Array) : *
      {
         var row:Array = null;
         var entry:DisplayObject = null;
         var tileBitmap:Bitmap = null;
         for each(row in tileArray)
         {
            if(row != null)
            {
               for each(entry in row)
               {
                  tileBitmap = Bitmap(entry);
                  this.disposeTileBitmap(tileBitmap);
               }
            }
         }
      }
      
      private function disposeTileBitmap(tileBitmap:Bitmap) : *
      {
         if(tileBitmap != null)
         {
            --Main.var_184;
            tileBitmap.bitmapData.dispose();
            tileBitmap.bitmapData = null;
            if(tileBitmap.parent != null)
            {
               tileBitmap.parent.removeChild(tileBitmap);
            }
            tileBitmap = null;
         }
      }
      
      override public function remove() : *
      {
         this.clear();
         super.remove();
      }
   }
}
