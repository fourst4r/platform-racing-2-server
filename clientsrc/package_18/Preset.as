package package_18
{
   public class Preset
   {
       
      
      public var num:int = 1;
      
      public var speed:int = 50;
      
      public var acceleration:int = 50;
      
      public var jumping:int = 50;
      
      public var hat:int = 1;
      
      public var head:int = 1;
      
      public var body:int = 1;
      
      public var feet:int = 1;
      
      public var hatColor:int = 0;
      
      public var headColor:int = 0;
      
      public var bodyColor:int = 0;
      
      public var feetColor:int = 0;
      
      public var hatColor2:int = -1;
      
      public var headColor2:int = -1;
      
      public var bodyColor2:int = -1;
      
      public var feetColor2:int = -1;
      
      public function Preset(param1:Object)
      {
         super();
         this.applyPresetData(param1);
      }
      
      private function applyPresetData(param1:Object) : *
      {
         var _loc2_:String = null;
         if(param1 != null)
         {
            for(_loc2_ in param1)
            {
               if(this[_loc2_] != null)
               {
                  this[_loc2_] = param1[_loc2_];
               }
            }
         }
      }
      
      public function getPresetData() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.num = this.num;
         _loc1_.speed = this.speed;
         _loc1_.acceleration = this.acceleration;
         _loc1_.jumping = this.jumping;
         _loc1_.hat = this.hat;
         _loc1_.head = this.head;
         _loc1_.body = this.body;
         _loc1_.feet = this.feet;
         _loc1_.hatColor = this.hatColor;
         _loc1_.headColor = this.headColor;
         _loc1_.bodyColor = this.bodyColor;
         _loc1_.feetColor = this.feetColor;
         _loc1_.hatColor2 = this.hatColor2;
         _loc1_.headColor2 = this.headColor2;
         _loc1_.bodyColor2 = this.bodyColor2;
         _loc1_.feetColor2 = this.feetColor2;
         return _loc1_;
      }
      
      public function getOutfitFormat() : *
      {
         return {
            "hats":[this.hat,1,1,1],
            "head":this.head,
            "body":this.body,
            "feet":this.feet,
            "colors":{
               "hats":[[this.hatColor,this.hatColor2],null,null,null],
               "head":[this.headColor,this.headColor2],
               "body":[this.bodyColor,this.bodyColor2],
               "feet":[this.feetColor,this.feetColor2]
            },
            "stats":{
               "speed":this.speed,
               "accel":this.acceleration,
               "jumpn":this.jumping
            }
         };
      }
   }
}
