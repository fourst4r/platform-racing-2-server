package package_4
{
   import flash.display.DisplayObject;
   
   public class HatsMenu extends InfoPopup
   {
       
      
      private var m:HatsMenuGraphic;
      
      private var highestHatID:int;
      
      public function HatsMenu(param1:String, param2:String, param3:DisplayObject)
      {
         this.m = new HatsMenuGraphic();
         this.highestHatID = Parts.getPartArray("HAT").length + 1;
         this.parseHats(param1,param2);
         var _loc4_:* = 2;
         while(_loc4_ <= this.highestHatID)
         {
            this.m["hat" + _loc4_].enabled = false;
            _loc4_++;
         }
         addChild(this.m);
         super(param3);
      }
      
      private function parseHats(param1:String, param2:String) : *
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param2 == "Hat Attack")
         {
            this.m.hat14.selected = false;
         }
         if(param1 == "" || param1 == null)
         {
            return;
         }
         _loc3_ = param1.split(",");
         for(_loc4_ in _loc3_)
         {
            _loc5_ = int(_loc3_[_loc4_]);
            if(!isNaN(_loc5_) && _loc5_ > 1 && _loc5_ <= this.highestHatID)
            {
               this.m["hat" + _loc5_].selected = false;
            }
         }
      }
      
      override public function remove() : *
      {
         super.remove();
      }
   }
}
