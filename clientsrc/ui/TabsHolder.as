package ui
{
   import flash.events.*;
   
   public class TabsHolder extends Removable
   {
      
      private static var memory:Object = new Object();
       
      
      public var tabArr:Array;
      
      private var selected:Number;
      
      private var holderId:String;
      
      public function TabsHolder(param1:Array, param2:String = "", param3:Number = 0, param4:Number = 100)
      {
         var _loc6_:LobbyTab = null;
         super();
         this.tabArr = param1;
         this.holderId = param2;
         var _loc5_:Number = Number(TabsHolder.getLastTab(this.holderId));
         this.selected = !isNaN(_loc5_) && _loc5_ < param1.length ? _loc5_ : param3;
         var _loc7_:int = 0;
         while(_loc7_ < param1.length)
         {
            (_loc6_ = param1[_loc7_]).setTabsHolder(this);
            addChild(_loc6_);
            _loc7_++;
         }
         this.populateTabs(param4);
         param1[this.selected].select();
         addEventListener(MouseEvent.MOUSE_OUT,this.resetTabPositions);
      }
      
      public static function setLastTab(param1:String, param2:Number) : *
      {
         TabsHolder.memory[param1] = param2;
      }
      
      public static function getLastTab(param1:String) : Number
      {
         return TabsHolder.memory[param1];
      }
      
      public function populateTabs(param1:Number) : *
      {
         var _loc2_:LobbyTab = null;
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         _loc3_ = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.tabArr.length)
         {
            _loc2_ = this.tabArr[_loc4_];
            _loc2_.x = _loc3_;
            _loc3_ += _loc2_.width;
            _loc4_++;
         }
         if(width > param1)
         {
            _loc5_ = (width - param1) / (this.tabArr.length - 1);
            _loc4_ = 1;
            while(_loc4_ < this.tabArr.length)
            {
               this.tabArr[_loc4_].x -= _loc5_ * _loc4_;
               _loc4_++;
            }
         }
      }
      
      private function resetTabPositions(param1:MouseEvent = null) : *
      {
         var _loc2_:Number = 0;
         while(_loc2_ < this.selected)
         {
            this.moveToFront(this.tabArr[_loc2_]);
            _loc2_++;
         }
         _loc2_ = this.tabArr.length - 1;
         while(_loc2_ > this.selected)
         {
            this.moveToFront(this.tabArr[_loc2_]);
            _loc2_--;
         }
         this.moveToFront(this.tabArr[this.selected]);
      }
      
      internal function select(param1:LobbyTab) : *
      {
         var _loc2_:LobbyTab = null;
         var _loc3_:Number = 0;
         while(_loc3_ < this.tabArr.length)
         {
            _loc2_ = this.tabArr[_loc3_];
            if(_loc2_ == param1)
            {
               this.selected = _loc3_;
            }
            else
            {
               _loc2_.activate();
            }
            _loc3_++;
         }
         this.resetTabPositions();
      }
      
      internal function moveToFront(param1:LobbyTab) : *
      {
         addChildAt(param1,numChildren - 1);
      }
      
      override public function remove() : *
      {
         removeEventListener(MouseEvent.MOUSE_OUT,this.resetTabPositions);
         var _loc1_:Number = 0;
         while(_loc1_ < this.tabArr.length)
         {
            this.tabArr[_loc1_].remove();
            _loc1_++;
         }
         if(this.holderId != "")
         {
            setLastTab(this.holderId,this.selected);
         }
         super.remove();
      }
   }
}
