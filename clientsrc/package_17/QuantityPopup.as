package package_17
{
   import flash.events.*;
   import package_4.Popup;
   
   public class QuantityPopup extends Popup
   {
      
      public static var instance:QuantityPopup = null;
       
      
      public var numSelected:int = 1;
      
      public var totalCost:int = 0;
      
      private var item:StoreListing;
      
      private var slug:String;
      
      private var singlePrice:int;
      
      private var maxQuantity:int;
      
      private var m:QuantityPopupGraphic;
      
      public function QuantityPopup(param1:StoreListing)
      {
         this.m = new QuantityPopupGraphic();
         super();
         if(QuantityPopup.instance != null)
         {
            QuantityPopup.instance.remove();
         }
         QuantityPopup.instance = this;
         this.item = param1;
         this.slug = this.item.slug;
         this.singlePrice = this.totalCost = this.item.currentPrice;
         this.maxQuantity = this.m.quantitySlider.maximum = this.slug === "rank_rental" ? this.item.listing.max_quantity - this.item.listing.rented_tokens : Number(this.item.listing.max_quantity);
         this.m.maxBox.text = this.maxQuantity.toString();
         this.m.numSelectedBox.text = "Selected: 1";
         this.m.costBox.htmlText = "<font color=\"#006600\">Cost: " + this.singlePrice + " Coins</font>";
         this.m.buy_bt.addEventListener(MouseEvent.CLICK,this.onClickBuy,false,0,true);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.onClickCancel,false,0,true);
         this.m.quantitySlider.addEventListener(Event.CHANGE,this.onSliderChange,false,0,true);
         addChild(this.m);
      }
      
      private function onSliderChange(param1:Event) : *
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = int(this.numSelected = this.m.quantitySlider.value);
         this.m.numSelectedBox.text = "Selected: " + _loc2_;
         if(this.slug === "rank_rental")
         {
            _loc5_ = 50 * _loc2_;
            _loc6_ = int(this.item.listing.rented_tokens);
            while(_loc6_ < _loc2_ + this.item.listing.rented_tokens)
            {
               _loc5_ += 20 * _loc6_;
               _loc6_++;
            }
         }
         this.totalCost = this.slug === "rank_rental" ? int(_loc5_ * this.item.saleMultiplier) : int(this.singlePrice * _loc2_);
         var _loc3_:* = this.totalCost <= StorePopup.userCoins;
         var _loc4_:String = _loc3_ ? "006600" : "BB0000";
         this.m.costBox.htmlText = "<font color=\"#" + _loc4_ + "\">Cost: " + this.totalCost + " Coins</font>";
         this.m.buy_bt.enabled = _loc3_;
      }
      
      private function onClickBuy(param1:MouseEvent) : *
      {
         if(this.m.buy_bt.enabled)
         {
            this.item.dispatchEvent(new Event(StoreListing.EVENT_QUANTITY_PURCHASE));
         }
      }
      
      private function onClickCancel(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         if(QuantityPopup.instance === this)
         {
            QuantityPopup.instance = null;
         }
         this.m.buy_bt.removeEventListener(MouseEvent.CLICK,this.onClickBuy);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.onClickCancel);
         this.m.quantitySlider.removeEventListener(Event.CHANGE,this.onSliderChange);
         super.remove();
      }
   }
}
