package
{
   import flash.display.MovieClip;
   import package_8.*;
   
   public dynamic class OutfitPopupGraphic extends MovieClip
   {
       
      
      public var c:Character;
      
      public var main:ConfirmPopupGraphic;
      
      public function OutfitPopupGraphic(param1:Object)
      {
         var outfit:Object = param1;
         super();
         outfit.hatIds = outfit.hatIds == null || !(outfit.hatIds is Array) || outfit.hatIds.length != 4 ? [1,1,1,1] : outfit.hatIds;
      }
      
      private function frame1(param1:Array, param2:int, param3:int, param4:int, param5:Object, param6:Object) : *
      {
         this.c = new Character(param1[0],param2,param3,param4);
         addChild(this.c);
         this.c.x = 172;
         this.c.y = 7.5;
         var _loc7_:Number = this.c.height / this.c.width;
         this.c.width += 50;
         this.c.height += 50 * _loc7_;
         if(param6 == null)
         {
            this.speedBox.visible = this.accelBox.visible = this.jumpnBox.visible = this.statsBg.visible = false;
            this.c.y += 32.8;
            this.characterBg.y += 32.8;
         }
         else
         {
            this.speedBox.appendText(param6.speed);
            this.accelBox.appendText(param6.accel);
            this.jumpnBox.appendText(param6.jumpn);
         }
         if(param5 != null)
         {
            if(param5.head != null)
            {
               this.c.setHeadColors(param5.head[0],param5.head[1]);
            }
            if(param5.body != null)
            {
               this.c.setBodyColors(param5.body[0],param5.body[1]);
            }
            if(param5.feet != null)
            {
               this.c.setFeetColors(param5.feet[0],param5.feet[1]);
            }
            if(param5.hats != null)
            {
               if(param1[0] > 1 && param5.hats[0] != null)
               {
                  this.c.setHatColors(param5.hats[0][0],param5.hats[0][1],1);
               }
            }
         }
      }
   }
}
