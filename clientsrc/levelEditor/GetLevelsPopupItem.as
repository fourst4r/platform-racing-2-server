package levelEditor
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import package_4.*;
   import package_6.*;
   import ui.class_229;
   
   public class GetLevelsPopupItem extends class_229
   {
       
      
      public var level:Object;
      
      private var info:HoverPopup;
      
      private var m:GetLevelsPopupItemGraphic;
      
      public function GetLevelsPopupItem(param1:Object)
      {
         this.m = new GetLevelsPopupItemGraphic();
         super(this.m);
         this.level = param1;
         this.m.titleBox.text = this.level.title;
         this.m.statusBox.text = this.level.live == 1 ? "Published" : "Unpublished";
         this.m.mouseEnabled = false;
         this.m.mouseChildren = false;
         this.doubleClickEnabled = true;
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,false,0,true);
         addChild(this.m);
      }
      
      private function onMouseOver(param1:MouseEvent) : *
      {
         var _loc2_:* = "-- " + Data.escapeString(this.level.title) + " --";
         var _loc3_:* = "Game Mode: " + Modes.getFullName(this.level.type) + "<br/>";
         _loc3_ += "Version: " + Data.formatNumber(this.level.version) + "<br/>";
         _loc3_ += "Updated: " + Data.getShortDateStr(this.level.time) + "<br/>";
         _loc3_ += "Plays: " + Data.formatNumber(this.level.play_count) + "<br/>";
         _loc3_ += "Rating: " + this.level.rating;
         if(Data.trimWhitespace(this.level.note) != "")
         {
            _loc3_ += "<br/>-----<br/><i>" + Data.escapeString(this.level.note,true) + "</i>";
         }
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
