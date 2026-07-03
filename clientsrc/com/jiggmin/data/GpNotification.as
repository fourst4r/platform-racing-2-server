package com.jiggmin.data
{
   import flash.display.DisplayObjectContainer;
   
   public class GpNotification
   {
      
      private static var holder:DisplayObjectContainer;
       
      
      public function GpNotification()
      {
         super();
      }
      
      public static function init(param1:DisplayObjectContainer) : *
      {
         holder = param1;
         CommandHandler.commandHandler.defineCommand("gpGain",gpGain);
      }
      
      public static function gpGain(param1:Array) : *
      {
         var _loc3_:GpNotificationGraphic = null;
         var _loc2_:int = int(param1[0]);
         _loc3_ = new GpNotificationGraphic();
         _loc3_.anim.textBox.text = "+" + _loc2_ + " GP";
         _loc3_.x = 25;
         _loc3_.y = 25;
         holder.addChild(_loc3_);
      }
   }
}
