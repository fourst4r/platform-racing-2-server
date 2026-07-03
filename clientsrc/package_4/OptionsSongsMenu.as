package package_4
{
   import com.jiggmin.data.*;
   import flash.display.DisplayObject;
   
   public class OptionsSongsMenu extends class_264
   {
      
      public static var instance:*;
       
      
      private var m:OptionsSongsMenuGraphic;
      
      public function OptionsSongsMenu(param1:DisplayObject)
      {
         var _loc3_:* = undefined;
         this.m = new OptionsSongsMenuGraphic();
         if(OptionsSongsMenu.instance != null)
         {
            OptionsSongsMenu.instance.remove();
         }
         OptionsSongsMenu.instance = this;
         y -= 45;
         addChild(this.m);
         super(param1);
         var _loc2_:Array = Settings.getValue(Settings.DISABLED_SONGS);
         for(_loc3_ in _loc2_)
         {
            this.m["song" + _loc2_[_loc3_]].selected = false;
         }
      }
      
      override public function remove() : *
      {
         if(OptionsSongsMenu.instance === this)
         {
            OptionsSongsMenu.instance = null;
         }
         var _loc1_:Array = [];
         var _loc2_:int = 1;
         while(_loc2_ <= 21)
         {
            if(!(_loc2_ == 9 || _loc2_ == 16))
            {
               if(this.m["song" + _loc2_].selected == false)
               {
                  _loc1_.push(_loc2_);
               }
            }
            _loc2_++;
         }
         Settings.setValue(Settings.DISABLED_SONGS,_loc1_);
         super.remove();
      }
   }
}
