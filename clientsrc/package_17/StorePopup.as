package package_17
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.net.*;
   import package_4.*;
   import ui.*;
   
   public class StorePopup extends Popup
   {
      
      public static var userCoins:int = 0;
       
      
      private var m:StorePopupGraphic;
      
      private var var_513:int = 3;
      
      private var var_640:int = 137;
      
      private var var_632:int = 160;
      
      private var listings:Vector.<StoreListing>;
      
      private var scroll:CustomScrollBar;
      
      private var loading:LoadingGraphic;
      
      private var superLoader:SuperLoader;
      
      private var saleFlash:EpicFlash;
      
      private var uploading:UploadingPopup;
      
      public function StorePopup()
      {
         this.m = new StorePopupGraphic();
         this.listings = new Vector.<StoreListing>();
         this.saleFlash = new EpicFlash();
         super();
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.closePopup,false,0,true);
         addChild(this.m);
         this.m.coinsLeftBox.visible = false;
         this.scroll = new CustomScrollBar();
         this.scroll.x = 202;
         this.scroll.y = -115;
         this.scroll.height = 225;
         addChild(this.scroll);
         this.scroll.init(this.m.itemsHolder,225,225);
         this.loading = new LoadingGraphic();
         addChild(this.loading);
         this.superLoader = new SuperLoader(true,SuperLoader.j);
         this.superLoader.addEventListener(SuperLoader.d,this.populateList);
         this.superLoader.addEventListener(SuperLoader.e,this.closePopup);
         this.superLoader.load(new URLRequest(Main.baseURL + "/vault/vault.php"));
      }
      
      private function populateList(param1:Event) : *
      {
         var _loc4_:Object = null;
         removeChild(this.loading);
         this.m.coinsLeftBox.addEventListener(TextEvent.LINK,this.clickNeedMore,false,0,true);
         var _loc2_:Object = this.superLoader.parsedData;
         var _loc3_:String = _loc2_.info.user.coins === 0 ? "BB0000" : "006600";
         StorePopup.userCoins = _loc2_.info.user.coins;
         this.m.coinsLeftBox.htmlText = "<b><font color=\"#" + _loc3_ + "\">You have " + Data.formatNumber(StorePopup.userCoins) + " Coins remaining.</font> " + Data.urlify("event:clickNeedMore","Need more?") + "</b>";
         this.m.coinsLeftBox.visible = true;
         if(this.superLoader.parsedData.info.hasOwnProperty("title"))
         {
            this.m.titleBox.text = "-- " + this.superLoader.parsedData.info.title.title + " --";
            if(this.superLoader.parsedData.info.title.flashing)
            {
               this.saleFlash.addItem(this.m.titleBox);
            }
         }
         for each(_loc4_ in this.superLoader.parsedData.listings)
         {
            this.addListing(_loc4_);
         }
         if(!this.saleFlash.isEmpty())
         {
            this.saleFlash.start();
         }
      }
      
      private function addListing(param1:Object) : StoreListing
      {
         var _loc2_:StoreListing = new StoreListing(param1,this.saleFlash);
         if(_loc2_.available)
         {
            _loc2_.addEventListener(StoreListing.EVENT_PURCHASE,this.clickItem,false,0,true);
            _loc2_.addEventListener(StoreListing.EVENT_QUANTITY_PURCHASE,this.quantityClick,false,0,true);
         }
         _loc2_.addEventListener(StoreListing.EVENT_INFO,this.showFAQ,false,0,true);
         _loc2_.x = this.listings.length % this.var_513 * this.var_640;
         _loc2_.y = Math.floor(this.listings.length / this.var_513) * this.var_632;
         this.m.itemsHolder.addChild(_loc2_);
         this.listings.push(_loc2_);
         return _loc2_;
      }
      
      private function quantityClick(param1:Event) : *
      {
         this.clickItem(param1,true);
      }
      
      private function clickNeedMore(param1:TextEvent) : *
      {
         var e:TextEvent = param1;
         new ConfirmPopup(function():*
         {
            sendToBuyCoinsPage();
         },"You will be routed to pr2hub.com in order to complete this transaction.");
      }
      
      private function clickItem(param1:Event, param2:Boolean = false) : *
      {
         var item:StoreListing = null;
         var e:Event = param1;
         var fromQuantity:Boolean = param2;
         var gameUA:String = String(Data.urlify(Main.baseURL + "/terms_of_use.php","PR2 Terms of Use"));
         if(Main.socket.connected)
         {
            item = StoreListing(e.target);
            if(item.slug == "stats_boost")
            {
               this.useSuperBooster();
               this.closePopup();
               return;
            }
            if(StorePopup.userCoins < item.currentPrice)
            {
               new MessagePopup("Error: You don\'t have enough coins to purchase this item.");
               return;
            }
            if(item.listing.max_quantity > 1)
            {
               if(fromQuantity)
               {
                  new ConfirmPopup(function():*
                  {
                     purchaseItem(item.slug,QuantityPopup.instance.numSelected);
                  },"Are you sure you\'d like to purchase <b>" + QuantityPopup.instance.numSelected + "</b> of this lovely <b>" + item.title + "</b>? Your account will be debited <b>" + QuantityPopup.instance.totalCost + " coins</b>.\n\nPlease see the " + gameUA + " for more information.");
               }
               else
               {
                  new QuantityPopup(item);
               }
            }
            else
            {
               new ConfirmPopup(function():*
               {
                  purchaseItem(item.slug,1);
               },"Are you sure you\'d like to purchase this lovely <b>" + item.title + "</b>? Your account will be debited <b>" + item.currentPrice + " coins</b>.\n\nPlease see the " + gameUA + " for more information.");
            }
         }
         else
         {
            new MessagePopup("Error: You must be logged in to use the Vault of Magics.");
            this.closePopup();
         }
      }
      
      private function sendToBuyCoinsPage() : *
      {
         var _loc1_:Object = new Object();
         _loc1_.token = Main.token;
         _loc1_.time = Data.getTimestamp();
         _loc1_.rand = int(Math.random() * 10000000);
         var _loc2_:Encryptor = new Encryptor();
         _loc2_.setKey(Env.URL_PASS_KEY);
         _loc2_.setIV(Env.URL_PASS_IV);
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.data = _loc2_.encrypt(JSON.stringify(_loc1_));
         var _loc4_:URLRequest;
         (_loc4_ = new URLRequest(Main.baseURL + "/vault/buy_coins.php")).data = _loc3_;
         _loc4_.method = URLRequestMethod.POST;
         navigateToURL(_loc4_,"_blank");
         this.closePopup();
      }
      
      private function showFAQ(param1:Event) : *
      {
         var _loc2_:StoreListing = StoreListing(param1.target);
         var _loc3_:Object = _loc2_.listing;
         new MessagePopup("<b>--- " + _loc3_.title + " FAQ ---</b> \n\n" + _loc3_.faq);
      }
      
      private function useSuperBooster() : *
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.server_id = Main.server.server_id;
         var _loc2_:URLRequest = new URLRequest(Main.baseURL + "/vault/use_super_booster.php");
         _loc2_.method = URLRequestMethod.POST;
         _loc2_.data = _loc1_;
         var _loc3_:UploadingPopup = new UploadingPopup(_loc2_,SuperLoader.j,"Powering up...");
         _loc3_.addEventListener(SuperLoader.d,this.onPurchaseComplete,false,0,true);
      }
      
      private function purchaseItem(param1:String, param2:int) : *
      {
         if(QuantityPopup.instance !== null)
         {
            QuantityPopup.instance.startFadeOut();
         }
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.slug = param1;
         _loc3_.quantity = param2;
         var _loc4_:URLRequest;
         (_loc4_ = new URLRequest(Main.baseURL + "/vault/purchase_item.php")).method = URLRequestMethod.POST;
         _loc4_.data = _loc3_;
         var _loc5_:UploadingPopup;
         (_loc5_ = new UploadingPopup(_loc4_,SuperLoader.j,"Purchasing item...")).addEventListener(SuperLoader.d,this.onPurchaseComplete,false,0,true);
      }
      
      private function onPurchaseComplete(param1:Event) : *
      {
         if(param1.target.parsedData.success)
         {
            this.closePopup();
         }
      }
      
      private function closePopup(param1:Event = null) : *
      {
         startFadeOut();
      }
      
      private function clear() : *
      {
         var _loc1_:StoreListing = null;
         for each(_loc1_ in this.listings)
         {
            _loc1_.addEventListener(StoreListing.EVENT_QUANTITY_PURCHASE,this.quantityClick);
            _loc1_.removeEventListener(StoreListing.EVENT_PURCHASE,this.clickItem);
            _loc1_.removeEventListener(StoreListing.EVENT_INFO,this.showFAQ);
            _loc1_.remove();
         }
      }
      
      override public function remove() : *
      {
         StorePopup.userCoins = 0;
         this.m.coinsLeftBox.removeEventListener(TextEvent.LINK,this.clickNeedMore);
         this.saleFlash.remove();
         this.saleFlash = null;
         this.superLoader.removeEventListener(SuperLoader.d,this.populateList);
         this.superLoader.remove();
         this.superLoader = null;
         removeChild(this.m);
         this.m.close_bt.removeEventListener(MouseEvent.CLICK,this.closePopup);
         this.m = null;
         super.remove();
      }
   }
}
