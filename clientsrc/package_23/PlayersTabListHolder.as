package package_23
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import page.Page;
   import ui.*;
   
   public class PlayersTabListHolder extends Page
   {
       
      
      private var holder:DisplayObjectContainer;
      
      private var scrollBar:CustomScrollBar;
      
      private var loadingGraphic:LoadingGraphic;
      
      private var listings:Array;
      
      private var listingHeight:Number = 16;
      
      private var sortKeys:Array;
      
      private var sortOrder:String = "desc";
      
      public function PlayersTabListHolder(param1:DisplayObjectContainer)
      {
         this.scrollBar = new CustomScrollBar();
         this.loadingGraphic = new LoadingGraphic();
         this.listings = new Array();
         this.sortKeys = new Array();
         super();
         this.holder = param1;
         this.scrollBar.x = 175;
         this.scrollBar.y = 20;
         this.scrollBar.init(this.holder,330,325);
         addChild(this.scrollBar);
         this.loadingGraphic.x = 85;
         this.loadingGraphic.y = 140;
         addChild(this.loadingGraphic);
      }
      
      public function hideLoadingGraphic(param1:* = null) : *
      {
         this.loadingGraphic.visible = false;
      }
      
      public function method_179(param1:DisplayObject) : *
      {
         this.listings.push(param1);
         param1.y = this.holder.numChildren * this.listingHeight;
         this.holder.addChild(param1);
      }
      
      public function clear() : *
      {
         var _loc1_:Removable = null;
         for each(_loc1_ in this.listings)
         {
            _loc1_.remove();
         }
         this.listings = new Array();
      }
      
      public function sortOn(param1:*, param2:* = 0) : *
      {
         this.listings.sortOn(param1,param2);
         this.populate();
      }
      
      public function numSort(param1:Array, param2:String = "desc") : *
      {
         this.sortKeys = param1;
         this.sortOrder = param2;
         this.listings.sort(this.doNumSort);
         this.populate();
      }
      
      private function doNumSort(param1:Removable, param2:Removable) : *
      {
         var _loc3_:String = String(this.sortKeys[0]);
         var _loc4_:String = String(this.sortKeys[1]);
         var _loc5_:String = "userName" in param1 ? "userName" : "guildName";
         if(this.sortOrder == "desc")
         {
            if(param1[_loc3_] !== param2[_loc3_])
            {
               if(param1[_loc3_] > param2[_loc3_])
               {
                  return -1;
               }
               if(param1[_loc3_] < param2[_loc3_])
               {
                  return 1;
               }
            }
            else
            {
               if(param1[_loc4_] === param2[_loc4_])
               {
                  return param1[_loc5_].toLowerCase().localeCompare(param2[_loc5_].toLowerCase());
               }
               if(param1[_loc4_] > param2[_loc4_])
               {
                  return -1;
               }
               if(param1[_loc4_] < param2[_loc4_])
               {
                  return 1;
               }
            }
         }
         else if(this.sortOrder == "asc")
         {
            if(param1[_loc3_] !== param2[_loc3_])
            {
               if(param1[_loc3_] > param2[_loc3_])
               {
                  return 1;
               }
               if(param1[_loc3_] < param2[_loc3_])
               {
                  return -1;
               }
            }
            else
            {
               if(param1[_loc4_] === param2[_loc4_])
               {
                  return param2[_loc5_].toLowerCase().localeCompare(param1[_loc5_].toLowerCase());
               }
               if(param1[_loc4_] > param2[_loc4_])
               {
                  return 1;
               }
               if(param1[_loc4_] < param2[_loc4_])
               {
                  return -1;
               }
            }
         }
      }
      
      private function populate() : *
      {
         var _loc2_:Removable = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.listings.length)
         {
            _loc2_ = this.listings[_loc1_];
            _loc2_.y = _loc1_ * this.listingHeight;
            _loc1_++;
         }
      }
      
      override public function remove() : *
      {
         this.clear();
         super.remove();
      }
   }
}
