package package_6
{
   import com.jiggmin.data.*;
   import fl.data.*;
   import flash.events.*;
   import flash.net.*;
   import package_4.*;
   
   public class PlaceArtifact extends Popup
   {
      
      public static var instance:PlaceArtifact;
       
      
      private var levelId:String;
      
      private var xPos:int;
      
      private var yPos:int;
      
      private var rot:int;
      
      private var setTime:int = 0;
      
      private var overrideSched:Boolean = false;
      
      private var uploading:UploadingPopup;
      
      private var m:PlaceArtifactGraphic;
      
      public function PlaceArtifact(param1:String, param2:int, param3:int, param4:int)
      {
         this.m = new PlaceArtifactGraphic();
         super();
         if(instance != null)
         {
            this.remove();
            return;
         }
         instance = this;
         this.levelId = param1;
         this.xPos = param2;
         this.yPos = param3;
         this.rot = param4;
         addChild(this.m);
         this.populateOptions(true);
         this.m.monthSel.addEventListener(Event.CHANGE,this.selChange,false,0,true);
         this.m.yearSel.addEventListener(Event.CHANGE,this.selChange,false,0,true);
         this.m.hourBox.addEventListener(FocusEvent.FOCUS_OUT,this.validateText,false,0,true);
         this.m.minBox.addEventListener(FocusEvent.FOCUS_OUT,this.validateText,false,0,true);
         this.m.now_chk.addEventListener(Event.CHANGE,this.checkNowBox,false,0,true);
         this.m.place_bt.addEventListener(MouseEvent.CLICK,this.clickPlace,false,0,true);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel,false,0,true);
      }
      
      private function populateOptions(param1:Boolean = false) : *
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Date = new Date();
         var _loc4_:int = _loc3_.fullYear;
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _loc5_ = _loc4_ + _loc2_;
               this.m.yearSel.dataProvider.addItem({
                  "label":_loc5_,
                  "data":_loc5_
               });
               _loc2_++;
            }
            this.showTime(_loc3_);
         }
         else
         {
            _loc6_ = int(this.m.daySel.selectedIndex);
            this.m.daySel.dataProvider = new DataProvider();
            _loc2_ = 1;
            while(_loc2_ <= 28)
            {
               this.m.daySel.dataProvider.addItem({
                  "label":_loc2_,
                  "data":_loc2_
               });
               _loc2_++;
            }
            _loc2_ = 29;
            while(_loc2_ <= 31)
            {
               if((_loc7_ = int(this.m.monthSel.selectedItem.data)) !== 1)
               {
                  this.m.daySel.dataProvider.addItem({
                     "label":_loc2_,
                     "data":_loc2_
                  });
                  if(_loc2_ === 30 && (_loc7_ === 3 || _loc7_ === 5 || _loc7_ === 8 || _loc7_ === 10))
                  {
                     break;
                  }
               }
               else if(_loc2_ === 29)
               {
                  if((_loc8_ = this.m.yearSel.selectedItem === null ? -1 : int(this.m.yearSel.selectedItem.data)) % 4 === 0 && _loc8_ % 100 !== 0 || _loc8_ % 400 === 0)
                  {
                     this.m.daySel.dataProvider.addItem({
                        "label":_loc2_,
                        "data":_loc2_
                     });
                  }
                  break;
               }
               _loc2_++;
            }
            this.m.daySel.selectedIndex = _loc6_;
         }
      }
      
      private function validateText(param1:* = null) : *
      {
         this.m.hourBox.text = Data.numLimit(int(this.m.hourBox.text),1,12);
         this.m.minBox.text = (int(this.m.minBox.text) < 10 ? "0" : "") + Data.numLimit(int(this.m.minBox.text),0,59);
      }
      
      private function selChange(param1:Event) : *
      {
         this.populateOptions();
      }
      
      private function checkNowBox(param1:Event) : *
      {
         this.m.monthSel.enabled = this.m.daySel.enabled = this.m.yearSel.enabled = this.m.hourBox.enabled = this.m.minBox.enabled = this.m.meridSel.enabled = !this.m.now_chk.selected;
      }
      
      private function showTime(param1:Date) : *
      {
         var _loc2_:int = param1.month;
         var _loc3_:int = param1.date;
         var _loc4_:int = param1.hours;
         var _loc5_:int = param1.minutes;
         var _loc6_:int = int(_loc4_ - 12 >= 0);
         this.m.monthSel.selectedIndex = _loc2_;
         this.m.yearSel.selectedIndex = 0;
         this.populateOptions();
         this.m.daySel.selectedIndex = _loc3_ - 1;
         this.m.hourBox.text = _loc4_ === 0 || _loc4_ > 12 ? String(Math.abs(_loc4_ - 12)) : String(_loc4_);
         this.m.minBox.text = (_loc5_ < 10 ? "0" : "") + _loc5_;
         this.m.meridSel.selectedIndex = _loc6_;
      }
      
      private function getDateFromInput() : *
      {
         this.validateText();
         var _loc1_:int = int(this.m.hourBox.text) + int(this.m.meridSel.selectedItem.data) * 12;
         _loc1_ = _loc1_ === 12 ? 0 : _loc1_;
         _loc1_ = _loc1_ === 24 ? 12 : int(Data.numLimit(_loc1_,0,23));
         return new Date(this.m.yearSel.selectedItem.data,this.m.monthSel.selectedItem.data,this.m.daySel.selectedItem.data,_loc1_,Data.numLimit(int(this.m.minBox.text),0,59));
      }
      
      private function clickPlace(param1:MouseEvent) : *
      {
         var _loc2_:Date = this.getDateFromInput();
         this.setTime = _loc2_.time / 1000 < Data.getTimestamp() || Boolean(this.m.now_chk.selected) ? 0 : int(_loc2_.time / 1000);
         var _loc3_:String = this.setTime > 0 ? "on " + Data.getDateTimeStr(this.setTime,["long","long"]) : "now";
         new ConfirmPopup(this.placeArtifact,"Are you sure you want to place the artifact " + _loc3_ + "?");
      }
      
      private function placeArtifact() : *
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.level_id = this.levelId;
         _loc1_.x = this.xPos;
         _loc1_.y = this.yPos;
         _loc1_.rot = this.rot;
         _loc1_.set_time = this.setTime < Data.getTimestamp() ? 0 : this.setTime;
         _loc1_.override_sched = int(this.overrideSched);
         var _loc2_:URLRequest = new URLRequest(Main.baseURL + "/place_artifact.php");
         _loc2_.data = _loc1_;
         _loc2_.method = URLRequestMethod.POST;
         this.uploading = new UploadingPopup(_loc2_,"json","Placing artifact...");
         this.uploading.addEventListener(SuperLoader.d,this.handleResponse,false,0,true);
      }
      
      private function handleResponse(param1:Event) : *
      {
         var e:Event = param1;
         var ret:Object = this.uploading.parsedData;
         if(!ret.success && ret.status === "scheduled")
         {
            new ConfirmPopup(function():*
            {
               overrideSched = true;
               placeArtifact();
            },"There is already a scheduled artifact placement. Is it OK to replace it with this one?");
            return;
         }
         startFadeOut();
      }
      
      private function clickCancel(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         if(instance === this)
         {
            instance = null;
         }
         if(this.uploading != null)
         {
            this.uploading.removeEventListener(SuperLoader.d,this.handleResponse);
            this.uploading.startFadeOut();
            this.uploading = null;
         }
         super.remove();
      }
   }
}
