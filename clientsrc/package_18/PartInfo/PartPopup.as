package package_18.PartInfo
{
   import com.jiggmin.data.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import package_18.*;
   import package_4.Popup;
   import package_8.*;
   
   public class PartPopup extends Popup
   {
      
      public static var instance:PartPopup;
       
      
      private var m:PartPopupGraphic;
      
      private var listing:Object;
      
      private var hasEE:Boolean = false;
      
      private var target:MovieClip;
      
      private var epicFlash:EpicFlash;
      
      private var nameMaker:HTMLNameMaker;
      
      public function PartPopup(param1:Object, param2:Boolean = false)
      {
         this.m = new PartPopupGraphic();
         this.epicFlash = new EpicFlash();
         this.nameMaker = new HTMLNameMaker();
         super();
         if(PartPopup.instance != null)
         {
            PartPopup.instance.startFadeOut();
         }
         PartPopup.instance = this;
         this.listing = param1;
         this.hasEE = param2;
         this.m.titleBox.text = "-- " + this.listing.name + " " + Data.ucfirst(this.listing.type) + " --";
         this.m.descBox.htmlText = this.listing.desc;
         this.m.obtainBox.htmlText = "How to obtain: " + this.listing.obtain;
         this.dynamicObtain();
         this.showPart();
         addChild(this.m);
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose);
      }
      
      private function dynamicObtain() : *
      {
         var _loc1_:String = String(this.listing.name);
         var _loc2_:* = this.listing.type.toLowerCase() === "hat";
         var _loc3_:String = String(this.listing.obtain);
         if(_loc2_)
         {
            if(_loc1_ == "Propeller")
            {
               _loc3_ = _loc3_.replace("Hat Factory",this.nameMaker.makeLevel("Hat Factory",84156));
               _loc3_ = _loc3_.replace("Jiggmin",this.nameMaker.makeName("Jiggmin",3));
               _loc3_ = _loc3_.replace("Volcanic Inferno",this.nameMaker.makeLevel("Volcanic Inferno",4866546));
               _loc3_ = _loc3_.replace("Pounce",this.nameMaker.makeName("Pounce",1));
            }
            else if(_loc1_ == "Top")
            {
               _loc3_ = _loc3_.replace("The Golden Compass",this.nameMaker.makeLevel("The Golden Compass",3236908));
               _loc3_ = _loc3_.replace("-Shadowfax-",this.nameMaker.makeName("-Shadowfax-",1));
            }
            else if(_loc1_ == "Moon")
            {
               _loc3_ = _loc3_.replace("Redemption",this.nameMaker.makeLevel("Redemption",5793214));
               _loc3_ = _loc3_.replace("cooldude90",this.nameMaker.makeName("cooldude90",1));
            }
            else if(_loc1_ == "Thief")
            {
               _loc3_ = _loc3_.replace("Apocalypse",this.nameMaker.makeLevel("Apocalypse",5877893));
               _loc3_ = _loc3_.replace("Divinity",this.nameMaker.makeName("Divinity",1));
            }
            else if(_loc1_ == "Jigg")
            {
               _loc3_ = _loc3_.replace("Buto (EXACT)",this.nameMaker.makeLevel("Buto (EXACT)",1738847));
               _loc3_ = _loc3_.replace("ZePHiR",this.nameMaker.makeName("ZePHiR",1));
            }
            else if(_loc1_ == "Jellyfish")
            {
               _loc3_ = _loc3_.replace("Deeper",this.nameMaker.makeLevel("Deeper",6493337));
               _loc3_ = _loc3_.replace("Sothal",this.nameMaker.makeName("Sothal",1));
            }
            else if(_loc1_ == "Cheese")
            {
               _loc3_ = _loc3_.replace("Moon is made w/ cheese",this.nameMaker.makeLevel("Moon is made w/ cheese",6207945));
               _loc3_ = _loc3_.replace("ktosss450",this.nameMaker.makeName("ktosss450",1));
            }
         }
         else if(_loc1_ == "Slender")
         {
            _loc3_ = _loc3_.replace("-Deliverance-",this.nameMaker.makeLevel("-Deliverance-",1896157));
            _loc3_ = _loc3_.replace("changelings",this.nameMaker.makeName("changelings",1));
         }
         else if(_loc1_ == "Sea")
         {
            _loc3_ = _loc3_.replace("~Under the sea~",this.nameMaker.makeLevel("~Under the sea~",2255404));
            _loc3_ = _loc3_.replace("Rammjet",this.nameMaker.makeName("Rammjet",1));
         }
         else if(_loc1_ == "Blobfish")
         {
            _loc3_ = _loc3_.replace("Underwater World",this.nameMaker.makeLevel("Underwater World",5985129));
            _loc3_ = _loc3_.replace("Odin0030",this.nameMaker.makeName("Odin0030",1));
         }
         else if(_loc1_ == "Gladiator")
         {
            _loc3_ = _loc3_.replace("Romªn Empire",this.nameMaker.makeLevel("Romªn Empire",3385938));
            _loc3_ = _loc3_.replace("Overbeing",this.nameMaker.makeName("Overbeing",1));
         }
         this.m.obtainBox.htmlText = "How to obtain: " + _loc3_;
         this.nameMaker.listenForLink(this.m.obtainBox);
      }
      
      private function showPart() : *
      {
         var _loc1_:String = Parts.validateType(this.listing.type);
         this.m.ownedBox.text = "You don\'t own this part.";
         this.m.epicBox.text = "You don\'t own this epic upgrade.";
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
         }
         if(this.listing.id == 35 && (this.listing.type == "BODY" || this.listing.type == "FEET"))
         {
            this.handleDjinn(this.listing.type,this.listing.has);
         }
         if(this.listing.id == 29 && this.listing.type == "BODY")
         {
            this.target.y += 10;
            this.target.width /= 1.8;
            this.target.height /= 1.8;
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
            this.m.ownedBox.text = "You own this part!";
            this.m.ownedBox.textColor = 26112;
            if(this.listing.hasEpic == true || this.hasEE == true)
            {
               this.target.colorMC2.visible = true;
               this.epicFlash.addItem(this.target.colorMC2);
            }
            this.m.equip_bt.enabled = true;
            this.m.equip_bt.addEventListener(MouseEvent.CLICK,this.equipPart,false,0,true);
         }
         if(this.listing.hasEpic == true)
         {
            this.m.epicBox.text = "You own this epic upgrade!";
            this.epicFlash.addItem(this.m.epicBox);
         }
         else if(this.hasEE == true)
         {
            this.m.epicBox.text = "Epic Upgrade included with EE purchase!";
            this.m.epicBox.textColor = 26112;
         }
         if(this.epicFlash.isEmpty() == false)
         {
            this.epicFlash.start();
         }
      }
      
      private function handleDjinn(param1:String, param2:Boolean) : *
      {
         var _loc5_:Character = null;
         var _loc3_:int = param1 == "BODY" ? 35 : 33;
         var _loc4_:int = param1 == "FEET" ? 35 : 33;
         _loc5_ = new Character(1,31,_loc3_,_loc4_);
         this.m.addChildAt(_loc5_,2);
         _loc5_.setBodyColors(255,3329330);
         _loc5_.setFeetColors(255,3329330);
         _loc5_.scaleX = _loc5_.scaleY = 1;
         _loc5_.x = -130;
         _loc5_.y = 10;
         if(param2 == false)
         {
            _loc5_.djinnUpdateAlpha(0.1);
         }
      }
      
      private function equipPart(param1:MouseEvent) : *
      {
         AccountInfo.partToSet = [this.listing.type.toLowerCase(),int(this.listing.id)];
         Main.instance.dispatchEvent(new Event(AccountInfo.SET_MANUAL_PART));
         startFadeOut();
         PartInfoPopup.instance.startFadeOut();
      }
      
      private function clickClose(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         if(PartPopup.instance === this)
         {
            PartPopup.instance = null;
         }
         removeChild(this.m);
         this.m.close_bt.removeEventListener(MouseEvent.CLICK,this.clickClose);
         this.m.equip_bt.removeEventListener(MouseEvent.CLICK,this.equipPart);
         this.m = null;
         this.nameMaker.remove();
         super.remove();
      }
   }
}
