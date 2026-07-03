package com.jiggmin.data
{
   import flash.display.DisplayObjectContainer;
   
   public class UnreadNotif
   {
      
      private static var lastReadTime:Number = 0;
      
      private static var unreadMessages:Array = new Array();
      
      private static var m:UnreadNotifGraphic = new UnreadNotifGraphic();
      
      private static var pmTab:DisplayObjectContainer;
       
      
      public function UnreadNotif()
      {
         super();
      }
      
      public static function setLastRead(param1:Number) : *
      {
         lastReadTime = param1;
      }
      
      public static function notifyUser(param1:Number) : *
      {
         if(param1 > lastReadTime)
         {
            unreadMessages.push(param1);
         }
         addNotif();
      }
      
      public static function updateLastRead() : *
      {
         var _loc1_:Number = NaN;
         for each(_loc1_ in unreadMessages)
         {
            if(_loc1_ > lastReadTime)
            {
               lastReadTime = _loc1_;
            }
         }
         unreadMessages = new Array();
         removeNotif();
      }
      
      public static function addNotifContainer(param1:DisplayObjectContainer) : *
      {
         UnreadNotif.pmTab = param1;
         if(numUnread > 0)
         {
            addNotif();
         }
      }
      
      private static function addNotif() : *
      {
         if(pmTab != null)
         {
            m.x = 26;
            m.y = 0;
            pmTab.addChild(m);
         }
      }
      
      private static function removeNotif() : *
      {
         if(m.parent != null)
         {
            m.parent.removeChild(m);
         }
      }
      
      public static function get numUnread() : int
      {
         return unreadMessages.length;
      }
      
      public static function reset() : *
      {
         lastReadTime = 0;
         unreadMessages = [];
         removeNotif();
         pmTab = null;
      }
   }
}
