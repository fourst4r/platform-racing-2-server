package package_4
{
   import flash.display.DisplayObject;
   import items.*;
   
   public class ItemMenu extends InfoPopup
   {
       
      
      private var m:ItemMenuGraphic;
      
      private var numItems:int;
      
      public function ItemMenu(param1:String, param2:DisplayObject)
      {
         this.m = new ItemMenuGraphic();
         this.numItems = Items.getAllCodes().length;
         this.parseItems(param1);
         var _loc3_:* = 1;
         while(_loc3_ <= this.numItems)
         {
            this.m["check" + _loc3_].enabled = false;
            _loc3_++;
         }
         addChild(this.m);
         super(param2);
      }
      
      private function parseItems(param1:String) : *
      {
         var _loc2_:Vector.<int> = null;
         var _loc3_:Array = null;
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         if(param1 == "")
         {
            _loc2_ = new Vector.<int>();
         }
         else if(param1 == "all" || param1 == null)
         {
            _loc2_ = Items.getAllCodes();
         }
         else
         {
            _loc2_ = new Vector.<int>();
            _loc3_ = param1.split("`");
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if((_loc5_ = String(_loc3_[_loc4_])).length > 1)
               {
                  _loc6_ = int(Items.getCodeFromName(_loc5_));
               }
               else
               {
                  _loc6_ = Number(_loc5_);
               }
               if(!isNaN(_loc6_) && _loc6_ >= 1 && _loc6_ <= Items.getAllCodes().length)
               {
                  this.m["check" + _loc6_].selected = true;
               }
               _loc4_++;
            }
         }
      }
      
      override public function remove() : *
      {
         super.remove();
      }
   }
}
