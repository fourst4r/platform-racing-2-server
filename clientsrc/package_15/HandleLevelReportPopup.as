package package_15
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.net.*;
   import package_4.*;
   
   public class HandleLevelReportPopup extends Popup
   {
       
      
      private var reportsPop:GetLevelReports;
      
      private var level:Object;
      
      private var htmlNM:HTMLNameMaker;
      
      private var uploading:UploadingPopup;
      
      private var banRet:Object;
      
      private var info:HoverPopup;
      
      private var m:HandleLevelReportPopupGraphic;
      
      public function HandleLevelReportPopup(param1:GetLevelReports, param2:Object)
      {
         this.htmlNM = new HTMLNameMaker();
         this.banRet = {};
         this.m = new HandleLevelReportPopupGraphic();
         super();
         this.reportsPop = param1;
         this.level = param2;
         this.htmlNM.listenForLink(this.m.titleBox);
         this.m.titleBox.htmlText = this.htmlNM.makeLevel(this.level.title,this.level.level_id) + " by " + this.htmlNM.makeName(this.level.creator,this.level.creator_group,"",true);
         this.m.otherReasonBox.visible = this.m.other_cancel_bt.visible = false;
         this.m.other_cancel_bt.addEventListener(MouseEvent.CLICK,this.checkIfSelectedOther,false,0,true);
         this.m.reason.addEventListener(Event.CHANGE,this.checkIfSelectedOther,false,0,true);
         this.m.info_bt.addEventListener(MouseEvent.MOUSE_OVER,this.addInfoHover,false,0,true);
         this.m.info_bt.addEventListener(MouseEvent.MOUSE_OUT,this.removeInfoHover,false,0,true);
         this.m.ban_bt.addEventListener(MouseEvent.CLICK,this.clickBan,false,0,true);
         this.m.cancel_bt.addEventListener(MouseEvent.CLICK,this.clickCancel,false,0,true);
         this.m.archive_bt.addEventListener(MouseEvent.CLICK,this.clickArchive,false,0,true);
         addChild(this.m);
      }
      
      private function addInfoHover(param1:MouseEvent) : *
      {
         var _loc2_:* = "-- " + Data.escapeString(this.level.title) + " --";
         var _loc3_:* = "Creator: " + Data.escapeString(this.level.creator) + "<br/>";
         _loc3_ += "Version: " + Data.formatNumber(this.level.version);
         if(Data.trimWhitespace(this.level.note) != "")
         {
            _loc3_ += "<br/>Note: <i>" + Data.escapeString(this.level.note,true) + "</i>";
         }
         _loc3_ += "<br/>-----<br/>";
         _loc3_ += "Reported: " + Data.getShortDateStr(this.level.report_time) + "<br/>";
         _loc3_ += "^ By: " + Data.escapeString(this.level.reporter) + "<br/>";
         _loc3_ += "Reason: <i>" + Data.escapeString(this.level.reason) + "</i>";
         this.info = new HoverPopup(_loc2_,_loc3_,this.m.info_bt);
         this.info.x += this.info.width + 23;
      }
      
      private function removeInfoHover(param1:MouseEvent = null) : *
      {
         if(this.info)
         {
            this.info.remove();
            this.info = null;
         }
      }
      
      private function reopenReportedLevelsPopup(param1:Event = null) : *
      {
         this.uploading.removeEventListener(SuperLoader.d,this.reopenReportedLevelsPopup);
         this.reportsPop.startFadeOut();
         new GetLevelReports();
         if(this.banRet.hasOwnProperty("message"))
         {
            new MessagePopup(this.banRet.message);
         }
         startFadeOut();
      }
      
      private function checkIfSelectedOther(param1:*) : *
      {
         if(param1 is MouseEvent)
         {
            param1 = false;
         }
         else if(param1 is Event)
         {
            if(this.m.reason.selectedIndex < this.m.reason.length - 1)
            {
               return;
            }
            param1 = true;
         }
         this.m.reason.selectedItem = this.m.reason.getItemAt(0);
         this.m.reason.visible = !param1;
         this.m.otherReasonBox.visible = this.m.other_cancel_bt.visible = param1;
      }
      
      private function clickBan(param1:MouseEvent) : *
      {
         var _loc2_:String = this.m.reason.selectedIndex == 0 || this.m.reason.selectedIndex == this.m.reason.length - 1 ? String(this.m.otherReasonBox.text) : String(this.m.reason.selectedItem.data);
         if(_loc2_ == "")
         {
            return new MessagePopup("Error: You must enter a reason for the ban.");
         }
         var _loc3_:int = int(this.m.duration.selectedItem.data);
         if(_loc3_ == 0)
         {
            return new MessagePopup("Error: You must specify a ban length.");
         }
         var _loc4_:String = String(Data.escapeString(this.level.creator));
         new ConfirmPopup(this.banUser,"Are you sure you want to socially ban " + _loc4_ + "? This will also unpublish the reported level.");
      }
      
      private function banUser() : *
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.level_id = this.level.level_id;
         _loc1_.banned_name = this.level.creator;
         _loc1_.duration = int(this.m.duration.selectedItem.data);
         _loc1_.reason = "Inappropriate Level -- " + (this.m.reason.selectedIndex == 0 || this.m.reason.selectedIndex == this.m.reason.length - 1 ? this.m.otherReasonBox.text : this.m.reason.selectedItem.data);
         _loc1_.scope = "social";
         _loc1_.record = "Level ID: " + this.level.level_id + "\nTitle: " + Data.escapeString(this.level.title) + "\nNote: " + Data.escapeString(this.level.note) + "\nVersion: " + this.level.version;
         var _loc2_:URLRequest = new URLRequest(Main.baseURL + "/ban_user.php");
         _loc2_.data = _loc1_;
         _loc2_.method = URLRequestMethod.POST;
         this.uploading = new UploadingPopup(_loc2_,"json","Unpublishing and banning...",false);
         this.uploading.addEventListener(SuperLoader.d,this.confirmArchive,false,0,true);
      }
      
      private function clickCancel(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      private function clickArchive(param1:MouseEvent) : *
      {
         new ConfirmPopup(this.confirmArchive,"Are you sure you want to archive this report?");
      }
      
      private function confirmArchive(param1:* = null) : *
      {
         if(this.uploading != null)
         {
            this.banRet = this.uploading.parsedData;
            this.uploading.removeEventListener(SuperLoader.d,this.confirmArchive);
            this.uploading = null;
         }
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.level_id = this.level.level_id;
         _loc2_.version = this.level.version;
         var _loc3_:URLRequest = new URLRequest(Main.baseURL + "/mod/archive_report.php");
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         this.uploading = new UploadingPopup(_loc3_,"json","Archiving report...");
         this.uploading.addEventListener(SuperLoader.d,this.reopenReportedLevelsPopup,false,0,true);
      }
      
      override public function remove() : *
      {
         if(this.uploading != null)
         {
            this.uploading.removeEventListener(SuperLoader.d,this.confirmArchive);
            this.uploading.removeEventListener(SuperLoader.d,this.reopenReportedLevelsPopup);
            this.uploading = null;
         }
         this.removeInfoHover();
         this.m.reason.removeEventListener(Event.CHANGE,this.checkIfSelectedOther);
         this.m.other_cancel_bt.removeEventListener(MouseEvent.CLICK,this.checkIfSelectedOther);
         this.m.ban_bt.removeEventListener(MouseEvent.CLICK,this.clickBan);
         this.m.cancel_bt.removeEventListener(MouseEvent.CLICK,this.clickCancel);
         this.m.archive_bt.removeEventListener(MouseEvent.CLICK,this.clickArchive);
         this.htmlNM.remove();
         super.remove();
      }
   }
}
