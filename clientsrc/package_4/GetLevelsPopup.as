package package_4
{
   import flash.events.*;
   import ui.*;
   
   public class GetLevelsPopup extends Popup
   {
       
      
      protected var m:GetLevelsPopupGraphic;
      
      protected var var_454:int = 25;
      
      protected var listings:Vector.<class_229>;
      
      private var scroll:CustomScrollBar;
      
      private var selected:class_229;
      
      public function GetLevelsPopup()
      {
         this.m = new GetLevelsPopupGraphic();
         this.listings = new Vector.<class_229>();
         super();
         addChild(this.m);
         this.scroll = new CustomScrollBar();
         this.scroll.width = 16;
         this.scroll.height = 160;
         this.scroll.x = 119;
         this.scroll.y = -86;
         this.scroll.init(this.m.levelsHolder,160,158);
         this.m.addChild(this.scroll);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel);
         this.m.load_bt.addEventListener(MouseEvent.CLICK,this.clickLoad);
         this.m.delete_bt.addEventListener(MouseEvent.CLICK,this.clickDelete);
         this.m.levelsHolder.addEventListener(MouseEvent.CLICK,this.method_401,false,0,true);
         this.m.levelsHolder.addEventListener(MouseEvent.DOUBLE_CLICK,this.method_222,false,0,true);
         this.method_394();
      }
      
      public function getSelected() : class_229
      {
         return this.selected;
      }
      
      protected function hideLoadingGraphic() : *
      {
         this.m.removeChild(this.m.loadingGraphic);
      }
      
      protected function method_455(param1:class_229) : *
      {
         param1.y = this.listings.length * this.var_454;
         this.m.levelsHolder.addChild(param1);
         this.listings.push(param1);
      }
      
      protected function method_539() : *
      {
         var _loc1_:class_229 = null;
         for each(_loc1_ in this.listings)
         {
            _loc1_.method_368(false);
         }
      }
      
      protected function method_825() : *
      {
         var _loc1_:class_229 = null;
         for each(_loc1_ in this.listings)
         {
            _loc1_.remove();
         }
         this.listings = new Vector.<class_229>();
      }
      
      protected function method_491(param1:class_229) : *
      {
         this.selected = param1;
         this.method_539();
         if(this.selected != null)
         {
            this.selected.method_368(true);
            this.m.load_bt.enabled = this.m.delete_bt.enabled = true;
         }
         else
         {
            this.m.load_bt.enabled = this.m.delete_bt.enabled = false;
         }
         this.method_394();
      }
      
      protected function loadListing(param1:class_229) : *
      {
      }
      
      protected function deleteListing(param1:class_229) : *
      {
      }
      
      private function clickCancel(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      private function clickLoad(param1:MouseEvent) : *
      {
         if(this.selected != null)
         {
            this.loadListing(this.selected);
         }
      }
      
      private function clickDelete(param1:MouseEvent) : *
      {
         if(this.selected != null)
         {
            this.deleteListing(this.selected);
         }
      }
      
      private function method_401(param1:MouseEvent) : *
      {
         var _loc2_:class_229 = null;
         if(param1.target is class_229)
         {
            _loc2_ = class_229(param1.target);
            this.method_491(_loc2_);
         }
      }
      
      private function method_222(param1:MouseEvent) : *
      {
         var _loc2_:class_229 = null;
         if(param1.target is class_229)
         {
            _loc2_ = class_229(param1.target);
            this.loadListing(_loc2_);
         }
      }
      
      private function method_394() : *
      {
         this.m.load_bt.enabled = this.m.delete_bt.enabled = this.selected != null;
      }
      
      override public function remove() : *
      {
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         this.m.load_bt.removeEventListener(MouseEvent.CLICK,this.clickLoad);
         this.m.delete_bt.removeEventListener(MouseEvent.CLICK,this.clickDelete);
         this.m.levelsHolder.removeEventListener(MouseEvent.CLICK,this.method_401);
         this.m.levelsHolder.removeEventListener(MouseEvent.DOUBLE_CLICK,this.method_222);
         this.method_825();
         this.scroll.remove();
         this.scroll = null;
         removeChild(this.m);
         this.m = null;
         this.selected = null;
         super.remove();
      }
   }
}
