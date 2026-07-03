package package_22
{
   import com.jiggmin.data.*;
   import flash.display.DisplayObject;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.*;
   import package_18.*;
   import package_4.*;
   
   public class LevelItem extends Removable
   {
       
      
      private var m:LevelItemGraphic;
      
      private var cm:CommandHandler;
      
      private var htmlNameMaker:HTMLNameMaker;
      
      private var infoPopup:HoverPopup;
      
      private var favBtPopup:HoverPopup;
      
      private var favBtTimer:uint;
      
      private var slotArray:Array;
      
      private var coverActive:* = true;
      
      public var courseID:String;
      
      public var version:int;
      
      private var title:String;
      
      private var rating:Number;
      
      private var playCount:Number;
      
      private var myRank:Number;
      
      private var minRank:Number;
      
      private var note:String;
      
      private var userName:String;
      
      private var group:String;
      
      private var pass:Boolean;
      
      private var passOK:Boolean = false;
      
      private var type:String;
      
      private var badHats:Vector.<int>;
      
      private var lastUpdated:int;
      
      private var maxSlots:Number = 8;
      
      private var superLoader:SuperLoader;
      
      private var uploading:UploadingPopup;
      
      public function LevelItem(param1:String, param2:int, param3:String, param4:Number, param5:int, param6:int, param7:String, param8:String, param9:String, param10:Boolean, param11:String, param12:String, param13:int, sourceIs8P:Boolean)
      {
         var _loc16_:int = 0;
         this.m = new LevelItemGraphic();
         this.cm = CommandHandler.commandHandler;
         this.htmlNameMaker = new HTMLNameMaker();
         this.slotArray = new Array();
         this.badHats = new Vector.<int>();
         super();
         this.courseID = param1;
         this.version = param2;
         this.title = param3;
         this.rating = param4;
         this.playCount = param5;
         this.myRank = class_33.getNumber("userRank");
         this.minRank = param6;
         this.note = param7;
         this.userName = param8;
         this.group = param9;
         this.pass = param10;
         this.passOK = !this.pass;
         this.type = param11;
         this.lastUpdated = param13;
         this.myRank = Boolean(isNaN(this.myRank)) || this.myRank < 0 ? 0 : Number(this.myRank);
         this.minRank = Data.numLimit(this.minRank,0,99);
         var _loc14_:String = String(this.htmlNameMaker.makeName(this.userName,this.group, "", sourceIs8P));
         this.m.titleBox.text = this.title;
         this.m.authorBox.htmlText = "by " + _loc14_;
         this.m.ratingStars.bar.scaleX = this.rating / 5;
         this.m.infoButton.addEventListener(MouseEvent.MOUSE_OVER,this.overInfoHandler,false,0,true);
         this.m.infoButton.addEventListener(MouseEvent.MOUSE_OUT,this.outInfoHandler,false,0,true);
         this.m.infoButton.addEventListener(MouseEvent.CLICK,this.clickInfoHandler,false,0,true);
         if(Main.group >= 1)
         {
            if(Main.favoriteLevels.indexOf(this.courseID) > -1)
            {
               this.m.minusButton.addEventListener(MouseEvent.MOUSE_OVER,this.overFavBt,false,0,true);
               this.m.minusButton.addEventListener(MouseEvent.MOUSE_OUT,this.outFavBt,false,0,true);
               this.m.minusButton.addEventListener(MouseEvent.CLICK,this.clickMinus,false,0,true);
               this.m.removeChild(this.m.plusButton);
            }
            else
            {
               this.m.plusButton.addEventListener(MouseEvent.MOUSE_OVER,this.overFavBt,false,0,true);
               this.m.plusButton.addEventListener(MouseEvent.MOUSE_OUT,this.outFavBt,false,0,true);
               this.m.plusButton.addEventListener(MouseEvent.CLICK,this.clickPlus,false,0,true);
               this.m.removeChild(this.m.minusButton);
            }
         }
         else
         {
            this.m.removeChild(this.m.plusButton);
            this.m.removeChild(this.m.minusButton);
         }
         if(param11 == "r")
         {
            this.m.bg.gotoAndStop(1);
         }
         else if(param11 == "d")
         {
            this.m.bg.gotoAndStop(2);
         }
         else if(param11 == "e")
         {
            this.m.bg.gotoAndStop(3);
         }
         else if(param11 == "o")
         {
            this.m.bg.gotoAndStop(4);
         }
         else if(param11 == "h")
         {
            this.m.bg.gotoAndStop(5);
         }
         var _loc15_:Array = param12.split(",");
         for(_loc16_ in _loc15_)
         {
            if(_loc15_[_loc16_] > 1)
            {
               this.badHats.push(_loc15_[_loc16_]);
            }
         }
         this.htmlNameMaker.listenForLink(this.m.authorBox);
         addChild(this.m);
         this.addSlots();
         this.testAccess();
         this.cm.defineCommand("fillSlot" + this.courseID + "_" + this.version,this.fillSlot);
         this.cm.defineCommand("confirmSlot" + this.courseID + "_" + this.version,this.confirmSlot);
         this.cm.defineCommand("clearSlot" + this.courseID + "_" + this.version,this.clearSlot);
      }
      
      public function testAccess() : *
      {
         var _loc1_:* = Main.loggedInAs.toLowerCase() == this.userName.toLowerCase();
         if(Boolean(this.pass) && !this.passOK && Main.group < 2 && !_loc1_)
         {
            if(this.m.accessCover.textBox.text !== "Pass Needed")
            {
               this.m.accessCover.textBox.text = "Pass Needed";
               if(!this.m.accessCover.contains(this.m.accessCover.passButton))
               {
                  this.m.accessCover.addChild(this.m.accessCover.passButton);
               }
               if(!this.m.accessCover.contains(this.m.accessCover.passBox))
               {
                  this.m.accessCover.addChild(this.m.accessCover.passBox);
               }
               this.m.accessCover.passButton.addEventListener(MouseEvent.CLICK,this.clickPassEnter,false,0,true);
            }
            return;
         }
         if(!this.pass || Boolean(this.pass) && Boolean(this.passOK) || Main.group >= 2 || _loc1_)
         {
            if(this.m.accessCover.contains(this.m.accessCover.passButton))
            {
               this.m.accessCover.passButton.removeEventListener(MouseEvent.CLICK,this.clickPassEnter);
               this.m.accessCover.removeChild(this.m.accessCover.passButton);
            }
            if(this.m.accessCover.contains(this.m.accessCover.passBox))
            {
               this.m.accessCover.removeChild(this.m.accessCover.passBox);
            }
         }
         this.myRank = class_33.getNumber("userRank");
         this.myRank = Boolean(isNaN(this.myRank)) || this.myRank < 0 ? 0 : Number(this.myRank);
         if(Main.group < 2 && !_loc1_)
         {
            if(this.myRank < this.minRank)
            {
               this.m.accessCover.textBox.text = "Rank " + this.minRank + " Needed";
               this.toggleCover(true);
               return;
            }
            this.toggleCover(false);
         }
         // if(this.badHats.length > 0 && this.badHats.indexOf(AccountInfo.currentHat) != -1)
         // {
         //    this.m.accessCover.textBox.text = "Hat Not Allowed";
         //    this.toggleCover(true);
         //    return;
         // }
         this.toggleCover(false);
      }
      
      private function toggleCover(param1:Boolean) : *
      {
         if(param1 && !this.m.contains(this.m.accessCover))
         {
            this.m.addChild(this.m.accessCover);
            if(CourseMenu.instance != null)
            {
               CourseMenu.instance.staticCloseMenu();
            }
         }
         else if(!param1 && Boolean(this.m.contains(this.m.accessCover)))
         {
            this.m.removeChild(this.m.accessCover);
         }
         this.coverActive = param1;
      }
      
      private function clickPassEnter(param1:MouseEvent) : *
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:URLVariables = null;
         var _loc5_:URLRequest = null;
         if(this.superLoader == null)
         {
            _loc2_ = String(this.m.accessCover.passBox.text);
            _loc3_ = String(Data.hash(_loc2_ + Env.LEVEL_PASS_SALT));
            this.m.accessCover.passButton.enabled = this.m.accessCover.passBox.enabled = false;
            this.m.accessCover.passBox.text = "checking...";
            this.superLoader = new SuperLoader(true,SuperLoader.j);
            this.superLoader.addEventListener(SuperLoader.d,this.validatePassResponse,false,0,true);
            this.superLoader.addEventListener(SuperLoader.e,this.passResponseError,false,0,true);
            (_loc4_ = new URLVariables()).course_id = this.courseID;
            _loc4_.hash = _loc3_;
            (_loc5_ = new URLRequest(Main.baseURL + "/level_pass_check.php")).method = URLRequestMethod.POST;
            _loc5_.data = _loc4_;
            this.superLoader.load(_loc5_);
         }
      }
      
      private function validatePassResponse(param1:Event) : *
      {
         var _loc3_:Encryptor = null;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc2_:Object = this.superLoader.parsedData;
         if(_loc2_.success == true)
         {
            _loc3_ = new Encryptor();
            _loc3_.setKey(Env.LEVEL_PASS_KEY);
            _loc3_.setIV(Env.LEVEL_PASS_IV);
            if((_loc4_ = _loc3_.decrypt(_loc2_.result)).substr(1).indexOf("{") != -1)
            {
               _loc4_ = _loc4_.substring(0,_loc4_.indexOf("}") + 1);
            }
            _loc4_ = String(Data.trimWhitespace(_loc4_));
            if((_loc5_ = JSON.parse(_loc4_)).level_id == this.courseID && _loc5_.access == 1)
            {
               this.passOK = true;
               this.testAccess();
            }
            else
            {
               this.m.accessCover.passBox.text = "nope!";
               this.m.accessCover.passButton.enabled = this.m.accessCover.passBox.enabled = true;
            }
         }
         this.superLoader.removeEventListener(SuperLoader.d,this.validatePassResponse);
         this.superLoader.removeEventListener(SuperLoader.e,this.passResponseError);
         this.superLoader.remove();
         this.superLoader = null;
      }
      
      private function passResponseError(param1:Event) : *
      {
         this.m.accessCover.passBox.text = "";
         this.m.accessCover.passButton.enabled = this.m.accessCover.passBox.enabled = true;
         this.superLoader.removeEventListener(SuperLoader.d,this.validatePassResponse);
         this.superLoader.removeEventListener(SuperLoader.e,this.passResponseError);
         this.superLoader.remove();
         this.superLoader = null;
      }
      
      private function addSlots() : *
      {
         var _loc3_:Slot = null;
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         var columns:int = 2;
         var rows:int = 4;
         var slotSpacingY:Number = 16;
         var slotSpacingX:Number = 50; // adjust as needed for your graphics

         while(_loc2_ < this.maxSlots)
         {
            _loc3_ = new Slot(_loc2_, this);
            // Calculate column and row
            var col:int = _loc2_ % columns;
            var row:int = int(_loc2_ / columns);
            _loc3_.x = col * slotSpacingX;
            _loc3_.y = row * slotSpacingY;
            this.slotArray.push(_loc3_);
            this.m.slotsHolder.addChild(_loc3_);
            _loc2_++;
         }
      }
      
      private function removeSlots() : *
      {
         var _loc1_:Slot = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.maxSlots)
         {
            _loc1_ = this.slotArray[_loc2_];
            _loc1_.remove();
            _loc2_++;
         }
      }
      
      private function clickPlus(param1:MouseEvent) : *
      {
         if(this.uploading == null)
         {
            this.handleFavorite("add");
         }
      }
      
      private function clickMinus(param1:MouseEvent) : *
      {
         if(this.uploading == null)
         {
            this.handleFavorite("remove");
         }
      }
      
      private function handleFavorite(param1:String) : *
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.mode = param1;
         _loc2_.level_id = this.courseID;
         var _loc3_:URLRequest = new URLRequest(Main.baseURL + "/favorite_levels_modify.php");
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         this.uploading = new UploadingPopup(_loc3_,SuperLoader.j,(param1 == "add" ? "Adding to" : "Removing from") + " favorites...");
         this.uploading.addEventListener(SuperLoader.d,this.onFavoriteResult,false,0,true);
      }
      
      private function onFavoriteResult(param1:Event) : *
      {
         var _loc2_:Object = this.uploading.parsedData;
         if(_loc2_.mode === "add")
         {
            Main.favoriteLevels.push(this.courseID);
            this.m.plusButton.removeEventListener(MouseEvent.MOUSE_OVER,this.overFavBt);
            this.m.plusButton.removeEventListener(MouseEvent.MOUSE_OUT,this.outFavBt);
            this.m.plusButton.removeEventListener(MouseEvent.CLICK,this.clickPlus);
            this.m.removeChild(this.m.plusButton);
            this.m.addChild(this.m.minusButton);
            this.m.minusButton.addEventListener(MouseEvent.MOUSE_OVER,this.overFavBt,false,0,true);
            this.m.minusButton.addEventListener(MouseEvent.MOUSE_OUT,this.outFavBt,false,0,true);
            this.m.minusButton.addEventListener(MouseEvent.CLICK,this.clickMinus,false,0,true);
         }
         else if(_loc2_.mode === "remove")
         {
            Main.favoriteLevels.splice(Main.favoriteLevels.indexOf(this.courseID),1);
            this.m.minusButton.removeEventListener(MouseEvent.MOUSE_OVER,this.overFavBt);
            this.m.minusButton.removeEventListener(MouseEvent.MOUSE_OUT,this.outFavBt);
            this.m.minusButton.removeEventListener(MouseEvent.CLICK,this.clickMinus);
            this.m.removeChild(this.m.minusButton);
            this.m.addChild(this.m.plusButton);
            this.m.plusButton.addEventListener(MouseEvent.MOUSE_OVER,this.overFavBt,false,0,true);
            this.m.plusButton.addEventListener(MouseEvent.MOUSE_OUT,this.outFavBt,false,0,true);
            this.m.plusButton.addEventListener(MouseEvent.CLICK,this.clickPlus,false,0,true);
         }
         if(this.uploading != null)
         {
            this.uploading.removeEventListener(SuperLoader.d,this.onFavoriteResult);
            this.uploading.startFadeOut();
            this.uploading = null;
         }
      }
      
      private function overFavBt(param1:MouseEvent) : *
      {
         this.favBtTimer = setTimeout(this.showFavHover,500);
      }
      
      private function showFavHover() : *
      {
         clearTimeout(this.favBtTimer);
         var _loc1_:DisplayObject = !!this.m.contains(this.m.plusButton) ? this.m.plusButton : this.m.minusButton;
         var _loc2_:String = !!this.m.contains(this.m.plusButton) ? "add" : "remove";
         var _loc3_:String = _loc2_ === "add" ? "Add to Favorites" : "Remove from Favorites";
         var _loc4_:String = _loc2_ === "add" ? "Add this level to your favorites list." : "Remove this level from your favorites list.";
         this.favBtPopup = new HoverPopup(_loc3_,_loc4_,_loc1_);
      }
      
      private function outFavBt(param1:MouseEvent) : *
      {
         clearTimeout(this.favBtTimer);
         if(this.favBtPopup != null)
         {
            this.favBtPopup.remove();
            this.favBtPopup = null;
         }
      }
      
      public function sendFillSlot(param1:int) : *
      {
         var _loc2_:int = int(LevelListing.levelListing.getPageNum());
         Main.socket.write("fill_slot`" + this.courseID + "_" + this.version + "`" + param1 + "`" + _loc2_);
      }
      
      public function sendClearSlot() : *
      {
         Main.socket.write("clear_slot`");
      }
      
      public function sendConfirmSlot() : *
      {
         Main.socket.write("confirm_slot`");
      }
      
      private function fillSlot(param1:Array) : *
      {
         var _loc2_:Slot = null;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         if(this.slotArray != null)
         {
            _loc3_ = Number(param1[0]);
            _loc2_ = this.slotArray[_loc3_];
         }
         if(_loc2_ != null)
         {
            _loc4_ = String(param1[1]);
            _loc5_ = Number(param1[2]);
            _loc6_ = String(param1[3]);
            _loc2_.fillSlot(_loc4_,_loc5_,_loc6_);
         }
         if(_loc6_ == "me")
         {
            Main.filledSlotCourseID = this.courseID;
            Main.filledSlotCourseVersion = this.version;
         }
      }
      
      private function confirmSlot(param1:Array) : *
      {
         var _loc2_:Slot = null;
         var _loc3_:Number = Number(param1[0]);
         if(this.slotArray != null)
         {
            _loc2_ = this.slotArray[_loc3_];
            _loc2_.confirmSlot();
         }
      }
      
      private function clearSlot(param1:Array) : *
      {
         var _loc2_:Slot = null;
         var _loc3_:Number = Number(param1[0]);
         if(this.slotArray != null)
         {
            _loc2_ = this.slotArray[_loc3_];
            _loc2_.clearSlot();
         }
      }
      
      private function overInfoHandler(param1:MouseEvent) : *
      {
         var _loc2_:* = "-- " + Data.escapeString(this.title) + " --";
         var _loc3_:* = "By: " + Data.escapeString(this.userName) + "<br/>";
         var _loc4_:* = "Version: " + Data.formatNumber(this.version) + "<br/>";
         var _loc5_:* = "Updated: " + Data.getShortDateStr(this.lastUpdated) + "<br/>";
         var _loc6_:* = "Min Rank: " + this.minRank + "<br/>";
         var _loc7_:* = "Plays: " + Data.formatNumber(this.playCount) + "<br/>";
         var _loc8_:String = "Rating: " + this.rating;
         var _loc9_:* = "";
         if(Data.escapeString(this.note) != "")
         {
            _loc9_ = "<br/>-----<br/><i>" + Data.escapeString(this.note,true) + "</i>";
         }
         var _loc10_:String = "<br/>-----<br/>(click the \"?\" for more info)";
         var _loc11_:String = _loc3_ + _loc4_ + _loc5_ + _loc6_ + _loc7_ + _loc8_ + _loc9_ + _loc10_;
         this.infoPopup = new HoverPopup(_loc2_,_loc11_,this.m.infoButton);
      }
      
      private function outInfoHandler(param1:MouseEvent) : *
      {
         this.infoPopup.remove();
         this.infoPopup = null;
      }
      
      private function clickInfoHandler(param1:MouseEvent) : *
      {
         new LevelInfoPopup(this.courseID);
      }
      
      override public function remove() : *
      {
         this.m.infoButton.removeEventListener(MouseEvent.MOUSE_OVER,this.overInfoHandler);
         this.m.infoButton.removeEventListener(MouseEvent.MOUSE_OUT,this.outInfoHandler);
         this.m.infoButton.removeEventListener(MouseEvent.CLICK,this.clickInfoHandler);
         this.m.plusButton.removeEventListener(MouseEvent.MOUSE_OVER,this.overFavBt);
         this.m.plusButton.removeEventListener(MouseEvent.MOUSE_OUT,this.outFavBt);
         this.m.plusButton.removeEventListener(MouseEvent.CLICK,this.clickPlus);
         this.m.minusButton.removeEventListener(MouseEvent.MOUSE_OVER,this.overFavBt);
         this.m.minusButton.removeEventListener(MouseEvent.MOUSE_OUT,this.outFavBt);
         this.m.minusButton.removeEventListener(MouseEvent.CLICK,this.clickMinus);
         this.removeSlots();
         this.slotArray = null;
         if(this.infoPopup != null)
         {
            this.infoPopup.remove();
            this.infoPopup = null;
         }
         clearTimeout(this.favBtTimer);
         if(this.favBtPopup != null)
         {
            this.favBtPopup.remove();
            this.favBtPopup = null;
         }
         if(this.superLoader != null)
         {
            this.superLoader.removeEventListener(Event.COMPLETE,this.validatePassResponse);
            this.superLoader.remove();
            this.superLoader = null;
         }
         if(this.uploading != null)
         {
            this.uploading.removeEventListener(SuperLoader.d,this.onFavoriteResult);
            this.uploading.remove();
            this.uploading = null;
         }
         this.htmlNameMaker.remove();
         this.htmlNameMaker = null;
         this.cm.defineCommand("fillSlot" + this.courseID,null);
         this.cm.defineCommand("confirmSlot" + this.courseID,null);
         this.cm.defineCommand("clearSlot" + this.courseID,null);
         this.cm = null;
         super.remove();
      }
   }
}
