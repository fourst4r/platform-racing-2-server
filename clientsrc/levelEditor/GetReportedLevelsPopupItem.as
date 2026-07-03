package levelEditor
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import package_4.*;
   import ui.class_229;
   
   public class GetReportedLevelsPopupItem extends class_229
   {
       
      
      public var level:Object;
      
      private var info:HoverPopup;
      
      private var m:GetReportedLevelsPopupItemGraphic;
      
      public function GetReportedLevelsPopupItem(param1:Object)
      {
         this.m = new GetReportedLevelsPopupItemGraphic();
         super(this.m);
         this.level = param1;
         this.m.titleBox.text = this.level.title;
         this.m.timeBox.text = Data.getShortDateStr(param1.report_time);
         this.doubleClickEnabled = true;
         this.m.mouseEnabled = false;
         this.m.mouseChildren = false;
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,false,0,true);
         addChild(this.m);
      }
      
      private function onMouseOver(param1:MouseEvent) : *
      {
         var _loc2_:* = "-- " + Data.escapeString(this.level.title) + " --";
         var _loc3_:* = "Creator: " + Data.escapeString(this.level.creator) + "<br/>";
         _loc3_ += "Version: " + Data.formatNumber(this.level.version);
         if(Data.trimWhitespace(this.level.note) != "")
         {
            _loc3_ += "<br/>Note: <i>" + Data.escapeString(this.level.note,true) + "</i>";
         }
         _loc3_ += "<br/>-----<br/>";
         _loc3_ += "Reported: " + this.m.timeBox.text + "<br/>";
         _loc3_ += "^ By: " + Data.escapeString(this.level.reporter) + "<br/>";
         _loc3_ += "Reason: <i>" + Data.escapeString(this.level.reason) + "</i>";
         this.info = new HoverPopup(_loc2_,_loc3_,this.m);
         this.info.width -= 3;
         this.info.x = 550 - this.info.width;
      }
      
      private function onMouseOut(param1:MouseEvent = null) : *
      {
         if(this.info != null)
         {
            this.info.remove();
            this.info = null;
         }
      }
      
      override public function remove() : *
      {
         this.onMouseOut();
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         super.remove();
      }
   }
}
