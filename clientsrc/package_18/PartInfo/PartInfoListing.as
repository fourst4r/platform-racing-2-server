package package_18.PartInfo
{
   import com.jiggmin.data.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import package_8.*;
   
   public class PartInfoListing extends Removable
   {
       
      
      private var m:PartInfoListingGraphic;
      
      private var listing:Object;
      
      private var hasEE:Boolean = false;
      
      private var target:MovieClip;
      
      public function PartInfoListing(param1:Object, param2:Boolean = false)
      {
         this.m = new PartInfoListingGraphic();
         super();
         this.listing = param1;
         this.hasEE = param2;
         this.activate();
         this.showPart();
         addChild(this.m);
         this.m.bg.visible = false;
         this.m.titleBox.text = this.listing.name + " " + Data.ucfirst(this.listing.type);
         this.m.descBox.htmlText = this.listing.desc;
         this.m.bg.mouseEnabled = this.m.titleBox.mouseEnabled = false;
      }
      
      private function showPart() : *
      {
         var _loc1_:String = null;
         _loc1_ = Parts.validateType(this.listing.type);
         this.m.ownedBox.y = 23.55;
         this.m.epicBox.y = 75.35;
         this.m.ownedBox.visible = false;
         this.m.epicBox.visible = false;
         this.m.hat.visible = false;
         this.m.head.visible = false;
         this.m.body.visible = false;
         this.m.foot.visible = false;
         this.m.head.hat1.visible = false;
         this.m.head.hat2.visible = false;
         this.m.head.hat3.visible = false;
         this.m.head.hat4.visible = false;
         if(_loc1_ == "HAT")
         {
            this.target = this.m.hat;
         }
         else if(_loc1_ == "HEAD")
         {
            this.target = this.m.head;
         }
         else if(_loc1_ == "BODY")
         {
            this.target = this.m.body;
         }
         else if(_loc1_ == "FEET")
         {
            this.target = this.m.foot;
            this.m.epicBox.y = 23.55;
         }
         if(this.listing.id == 35 && (this.listing.type == "BODY" || this.listing.type == "FEET"))
         {
            this.handleDjinn(this.listing.type,this.listing.has);
         }
         else if(this.listing.id == 29 && this.listing.type == "BODY")
         {
            this.target.y += 10;
            this.target.width /= 2;
            this.target.height /= 2;
         }
         else if(this.listing.id == 14 && this.listing.type == "HAT")
         {
            this.target.y += 10;
         }
         this.target.visible = true;
         this.target.alpha = 0.1;
         this.target.colorMC2.visible = _loc1_ == "HAT" && this.listing.id == 16;
         this.target.gotoAndStop(this.listing.id);
         this.target.colorMC.gotoAndStop(this.listing.id);
         this.target.colorMC2.gotoAndStop(this.listing.id);
         if(this.listing.has == true)
         {
            this.target.alpha = 1;
            this.m.ownedBox.visible = true;
            if(this.listing.hasEpic == true || this.hasEE == true)
            {
               this.m.epicBox.visible = true;
               if(this.hasEE == false || this.listing.hasEpic == true)
               {
                  this.m.epicBox.text = "Upgraded!";
               }
            }
         }
      }
      
      private function handleDjinn(param1:String, param2:Boolean) : *
      {
         var _loc3_:int = param1 == "BODY" ? 35 : 33;
         var _loc4_:int = param1 == "FEET" ? 35 : 33;
         var _loc5_:Character = new Character(1,31,_loc3_,_loc4_);
         this.m.addChildAt(_loc5_,2);
         _loc5_.setBodyColors(255,3329330);
         _loc5_.setFeetColors(255,3329330);
         _loc5_.scaleX = _loc5_.scaleY = 1;
         _loc5_.x = 65;
         _loc5_.y = 85;
         if(param2 == false)
         {
            _loc5_.djinnUpdateAlpha(0.1);
         }
      }
      
      public function addEpicFlash(param1:EpicFlash) : *
      {
         param1.addItem(this.m.epicBox);
      }
      
      public function activate() : *
      {
         this.m.cover.buttonMode = true;
         this.m.cover.useHandCursor = true;
         this.m.cover.addEventListener(MouseEvent.MOUSE_OVER,this.method_269);
         this.m.cover.addEventListener(MouseEvent.MOUSE_OUT,this.method_378);
         this.m.cover.addEventListener(MouseEvent.CLICK,this.clickHandler);
         alpha = 1;
      }
      
      private function clickHandler(param1:MouseEvent) : *
      {
         new PartPopup(this.listing,this.hasEE);
      }
      
      public function deactivate() : *
      {
         this.m.cover.buttonMode = false;
         this.m.cover.useHandCursor = false;
         this.m.cover.removeEventListener(MouseEvent.MOUSE_OVER,this.method_269);
         this.m.cover.removeEventListener(MouseEvent.MOUSE_OUT,this.method_378);
         this.m.cover.removeEventListener(MouseEvent.CLICK,this.clickHandler);
         alpha = 1;
      }
      
      public function method_653() : Object
      {
         return this.listing;
      }
      
      private function method_269(param1:MouseEvent) : *
      {
         this.m.bg.visible = true;
      }
      
      private function method_378(param1:MouseEvent) : *
      {
         this.m.bg.visible = false;
      }
      
      override public function remove() : *
      {
         this.deactivate();
         removeChild(this.m);
         this.m = null;
         this.listing = null;
         super.remove();
      }
   }
}
