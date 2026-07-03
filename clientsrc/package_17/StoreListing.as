package package_17
{
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.text.*;
   import package_8.*;
   
   public class StoreListing extends Removable
   {
      
      public static const EVENT_QUANTITY_PURCHASE:String = "itemPurchaseFromQuantity";
      
      public static const EVENT_PURCHASE:String = "itemPurchase";
      
      public static const EVENT_INFO:String = "itemInfo";
       
      
      private var m:StoreListingGraphic;
      
      private var _listing:Object;
      
      private var loader:Loader;
      
      public function StoreListing(param1:Object, param2:EpicFlash = null)
      {
         this.m = new StoreListingGraphic();
         super();
         this._listing = param1;
         addChild(this.m);
         this.m.bg.visible = false;
         this.m.titleBox.text = this._listing.title;
         this.m.priceBox.autoSize = TextFieldAutoSize.LEFT;
         this.m.saleBox.autoSize = TextFieldAutoSize.LEFT;
         if(this._listing.price == 0)
         {
            this.m.priceBox.text = "free!";
            this.m.priceBG.width = this.m.priceBox.width + 7;
            this.m.removeChild(this.m.coin);
         }
         else
         {
            this.m.priceBox.text = this._listing.price.toString();
            this.m.coin.x = Math.round(this.m.priceBox.width + this.m.priceBox.x + 3);
            this.m.priceBG.width = Math.round(this.m.coin.x + this.m.coin.width);
         }
         if(this._listing.available && this._listing.price != 0 && Boolean(this._listing.sale.active) && (this._listing.sale.expires === 0 || this._listing.sale.expires > Data.getTimestamp()))
         {
            this.m.priceBox.text = Math.round(this._listing.price * (100 - this.listing.sale.value) / 100).toString();
            this.m.coin.x = Math.round(this.m.priceBox.width + this.m.priceBox.x + 3);
            this.m.saleBox.x = Math.round(this.m.coin.x + this.m.coin.width + 3);
            this.m.saleBox.text = this._listing.sale.value.toString() + "% off!";
            this.m.priceBG.width = Math.round(this.m.coin.x + this.m.coin.width) + this.m.saleBox.width;
            if(param2 != null)
            {
               param2.addItem(this.m.titleBox);
            }
         }
         else
         {
            this.m.removeChild(this.m.saleBox);
         }
         if(this._listing.slug === "epic_everything")
         {
            this.generateRandomCharacter(30);
            this.generateRandomCharacter(65);
            this.generateRandomCharacter(100);
         }
         this.m.descBox.htmlText = this._listing.description + " " + this.makeTextButtons(this._listing);
         this.m.descBox.addEventListener(TextEvent.LINK,this.clickTextLink,false,0,true);
         if(this._listing.available)
         {
            this.activate();
         }
         else
         {
            this.deactivate();
         }
         this.loader = new Loader();
         this.loader.load(new URLRequest(this._listing.img_url));
         this.m.picHolder.addChild(this.loader);
         this.m.bg.mouseEnabled = this.m.titleBox.mouseEnabled = this.m.coin.mouseEnabled = this.m.priceBG.mouseEnabled = this.m.picHolder.mouseEnabled = false;
      }
      
      private function generateRandomCharacter(param1:Number) : *
      {
         var _loc2_:int = int(Math.ceil(Math.random() * 12));
         var _loc3_:int = int(Math.ceil(Math.random() * 39));
         var _loc4_:int = int(Math.ceil(Math.random() * 39));
         var _loc5_:int = int(Math.ceil(Math.random() * 39));
         var _loc6_:int = int(Math.round(Math.random() * 16777215));
         var _loc7_:int = int(Math.round(Math.random() * 16777215));
         var _loc8_:int = int(Math.round(Math.random() * 16777215));
         var _loc9_:int = int(Math.round(Math.random() * 16777215));
         var _loc10_:int = int(Math.round(Math.random() * 16777215));
         var _loc11_:int = int(Math.round(Math.random() * 16777215));
         var _loc12_:int = int(Math.round(Math.random() * 16777215));
         var _loc13_:int = int(Math.round(Math.random() * 16777215));
         var _loc14_:Character = new Character(_loc2_,_loc3_,_loc4_,_loc5_);
         this.m.addChildAt(_loc14_,2);
         _loc14_.setHatColors(_loc6_,_loc7_);
         _loc14_.setHeadColors(_loc8_,_loc9_);
         _loc14_.setBodyColors(_loc10_,_loc11_);
         _loc14_.setFeetColors(_loc12_,_loc13_);
         _loc14_.scaleX = _loc14_.scaleY = 1;
         _loc14_.x = param1;
         _loc14_.y = 85;
      }
      
      public function activate() : *
      {
         this.m.cover.buttonMode = true;
         this.m.cover.useHandCursor = true;
         this.m.cover.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.m.cover.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.m.cover.addEventListener(MouseEvent.CLICK,this.clickHandler);
         alpha = 1;
      }
      
      public function deactivate() : *
      {
         this.m.cover.buttonMode = false;
         this.m.cover.useHandCursor = false;
         this.m.cover.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.m.cover.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.m.cover.removeEventListener(MouseEvent.CLICK,this.clickHandler);
         alpha = 0.33;
      }
      
      public function get listing() : Object
      {
         return this._listing;
      }
      
      private function makeTextButtons(param1:Object) : String
      {
         var _loc2_:* = "<u><font color=\"#4E4EFE\"><a href=\"event:itemPurchase\">" + (param1.price == 0 ? "use" : "buy") + "</a></font></u>";
         var _loc3_:String = "<u><font color=\"#4E4EFE\"><a href=\"event:itemInfo\">more info</a></font></u>";
         return (!!param1.available ? _loc2_ + " / " : "") + _loc3_;
      }
      
      private function clickTextLink(param1:TextEvent) : *
      {
         if(param1.text == "itemPurchase")
         {
            dispatchEvent(new Event(StoreListing.EVENT_PURCHASE));
         }
         if(param1.text == "itemInfo")
         {
            dispatchEvent(new Event(StoreListing.EVENT_INFO));
         }
      }
      
      private function clickHandler(param1:MouseEvent) : *
      {
         dispatchEvent(new Event(StoreListing.EVENT_PURCHASE));
      }
      
      public function get slug() : String
      {
         return this._listing.slug;
      }
      
      public function get available() : Boolean
      {
         return this._listing.available;
      }
      
      public function get title() : String
      {
         return this._listing.title;
      }
      
      public function get saleMultiplier() : Number
      {
         return this._listing.available && this._listing.price != 0 && Boolean(this._listing.sale.active) && (this._listing.sale.expires === 0 || this._listing.sale.expires > Data.getTimestamp()) ? (100 - this._listing.sale.value) / 100 : 1;
      }
      
      public function get currentPrice() : int
      {
         return int(this.m.priceBox.text);
      }
      
      private function onMouseOver(param1:MouseEvent) : *
      {
         this.m.bg.visible = true;
      }
      
      private function onMouseOut(param1:MouseEvent) : *
      {
         this.m.bg.visible = false;
      }
      
      override public function remove() : *
      {
         this.deactivate();
         this.m.descBox.removeEventListener(TextEvent.LINK,this.clickTextLink);
         removeChild(this.m);
         this.m = null;
         this._listing = null;
         super.remove();
      }
   }
}
