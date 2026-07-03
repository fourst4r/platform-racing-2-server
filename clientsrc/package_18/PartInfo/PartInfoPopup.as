package package_18.PartInfo
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import package_4.*;
   import ui.*;
   
   public class PartInfoPopup extends Popup
   {
      
      public static var instance:PartInfoPopup;
       
      
      private var m:StorePopupGraphic;
      
      private var mode:String;
      
      private var ownedParts:Array;
      
      private var ownedEpics:Array;
      
      private var hasEE:Boolean = false;
      
      private var allParts:Array;
      
      private var var_513:int = 3;
      
      private var var_640:int = 137;
      
      private var var_632:int = 160;
      
      private var listings:Vector.<PartInfoListing>;
      
      private var scroll:CustomScrollBar;
      
      private var var_289:LoadingGraphic;
      
      public var epicFlash:EpicFlash;
      
      public function PartInfoPopup(param1:String, param2:Array, param3:Array)
      {
         this.m = new StorePopupGraphic();
         this.listings = new Vector.<PartInfoListing>();
         this.epicFlash = new EpicFlash();
         super();
         if(PartInfoPopup.instance != null)
         {
            PartInfoPopup.instance.startFadeOut();
         }
         PartInfoPopup.instance = this;
         this.mode = param1;
         this.ownedParts = param2;
         this.ownedEpics = param3;
         if(this.ownedEpics.indexOf("*") != -1)
         {
            this.hasEE = true;
         }
         this.m.titleBox.text = "-- " + Data.ucfirst(Parts.getPlural(this.mode)) + " --";
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.onClose,false,0,true);
         this.m.coinsLeftBg.visible = this.m.coinsLeftBox.visible = false;
         this.m.y += 20;
         addChild(this.m);
         this.scroll = new CustomScrollBar();
         this.scroll.x = 202;
         this.scroll.y = -115;
         this.scroll.height = 225;
         addChild(this.scroll);
         this.scroll.init(this.m.itemsHolder,225,225);
         this.allParts = Parts.getPartArray(this.mode);
         if(this.allParts == false)
         {
            new MessagePopup("Error: Invalid part mode specified.");
            this.remove();
         }
         this.populateParts();
      }
      
      private function populateParts() : *
      {
         var _loc1_:Object = null;
         for each(_loc1_ in this.allParts)
         {
            this.createListing(_loc1_);
         }
         if(this.epicFlash.isEmpty() === false)
         {
            this.epicFlash.start();
         }
      }
      
      private function createListing(param1:Object) : PartInfoListing
      {
         var _loc2_:PartInfoListing = null;
         param1.has = false;
         if(this.ownedParts.indexOf(param1.id.toString()) != -1)
         {
            param1.has = true;
         }
         param1.hasEpic = false;
         if(this.ownedEpics.indexOf(param1.id.toString()) != -1)
         {
            param1.hasEpic = true;
         }
         _loc2_ = new PartInfoListing(param1,this.hasEE);
         _loc2_.x = this.listings.length % this.var_513 * this.var_640;
         _loc2_.y = Math.floor(this.listings.length / this.var_513) * this.var_632;
         if(param1.hasEpic == true)
         {
            _loc2_.addEpicFlash(this.epicFlash);
         }
         this.m.itemsHolder.addChild(_loc2_);
         this.listings.push(_loc2_);
         return _loc2_;
      }
      
      private function onClose(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      private function clear() : *
      {
         var _loc1_:PartInfoListing = null;
         for each(_loc1_ in this.listings)
         {
            _loc1_.remove();
         }
      }
      
      override public function remove() : *
      {
         if(PartInfoPopup.instance === this)
         {
            PartInfoPopup.instance = null;
         }
         removeChild(this.m);
         this.m.close_bt.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.m = null;
         super.remove();
      }
   }
}
