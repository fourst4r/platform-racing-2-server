package replay
{
   import com.jiggmin.data.Settings;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.FileReference;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import Main;
   import SuperLoader;
   import fl.controls.CheckBox;
   import package_4.ConfirmPopup;
   import package_4.Popup;
   import package_4.UploadingPopup;
   import ui.CustomScrollBar;

   public class ReplaysPopup extends Popup
   {
      private static const LIST_X:Number = -145;
      private static const LIST_Y:Number = -104;
      private static const LIST_WIDTH:Number = 286;
      private static const LIST_HEIGHT:Number = 208;
      private static const LIST_BOTTOM_PADDING:Number = 10;
      private static const SCROLLBAR_X_ADJUST:Number = 3;
      private static const ROW_HEIGHT:Number = 19;
      private static const HIDDEN_TOGGLE_X:Number = 56;
      private static const HIDDEN_TOGGLE_Y:Number = -135;

      public static var instance:ReplaysPopup;

      private var m:ReplaysPopupGraphic;
      private var loader:SuperLoader;
      private var scrollBar:CustomScrollBar;
      private var viewport:Sprite;
      private var holder:Sprite;
      private var rows:Array;
      private var replayRows:Array;
      private var emptyField:TextField;
      private var titleField:TextField;
      private var closeButton:InteractiveObject;
      private var hiddenToggle:CheckBox;
      private var levelId:String;
      private var isPr2Hub:Boolean;
      private var mode:String;
      private var listBounds:Rectangle;

      public function ReplaysPopup(levelId:String, isPr2Hub:Boolean, mode:String)
      {
         this.m = new ReplaysPopupGraphic();
         this.loader = new SuperLoader(true,SuperLoader.j);
         this.scrollBar = new CustomScrollBar();
         this.viewport = new Sprite();
         this.holder = new Sprite();
         this.rows = [];
         this.replayRows = [];
         this.listBounds = new Rectangle(LIST_X,LIST_Y,LIST_WIDTH,LIST_HEIGHT);
         super();
         if(ReplaysPopup.instance != null)
         {
            ReplaysPopup.instance.startFadeOut();
         }
         ReplaysPopup.instance = this;
         this.levelId = levelId;
         this.isPr2Hub = isPr2Hub;
         this.mode = mode == "team" ? "team" : "solo";
         addChild(this.m);
         this.hideTemplateRow();
         this.setupHeader();
         this.setupHiddenToggle();
         this.setupList();
         this.loader.addEventListener(SuperLoader.d,this.handleData,false,0,true);
         this.loader.addEventListener(SuperLoader.e,this.handleError,false,0,true);
         this.loadReplays();
      }

      private function setupHeader() : void
      {
         var closeControl:Object = null;
         this.titleField = this.m["titleText"] as TextField;
         if(this.titleField != null)
         {
            this.titleField.text = this.mode == "team" ? "All Team Replays" : "All Solo Replays";
         }
         closeControl = this.m["btnClose"];
         if(closeControl != null)
         {
            if("label" in closeControl)
            {
               closeControl["label"] = "Close";
            }
            else if(closeControl is TextField)
            {
               TextField(closeControl).text = "Close";
            }
            this.closeButton = closeControl as InteractiveObject;
            if(this.closeButton != null)
            {
               this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseClick,false,0,true);
            }
         }
      }

      private function hideTemplateRow() : void
      {
         var childIndex:int = 0;
         var child:DisplayObject = null;
         while(childIndex < this.m.numChildren)
         {
            child = this.m.getChildAt(childIndex);
            if(child is ReplayLeaderboardItemGraphic)
            {
               child.visible = false;
            }
            childIndex++;
         }
      }

      private function setupHiddenToggle() : void
      {
         this.hiddenToggle = this.m["chkHidden"] as CheckBox;
         if(this.hiddenToggle == null)
         {
            this.hiddenToggle = new CheckBox();
            this.hiddenToggle.name = "chkHidden";
            this.hiddenToggle.x = HIDDEN_TOGGLE_X;
            this.hiddenToggle.y = HIDDEN_TOGGLE_Y;
            this.m.addChild(this.hiddenToggle);
         }
         this.hiddenToggle.label = "Show hidden";
         this.hiddenToggle.labelPlacement = "right";
         this.hiddenToggle.enabled = true;
         this.hiddenToggle.visible = true;
         this.hiddenToggle.selected = Settings.getValue(Settings.SHOW_HIDDEN_REPLAYS,false);
         this.hiddenToggle.addEventListener(Event.CHANGE,this.onHiddenToggleChange,false,0,true);
      }

      private function setupList() : void
      {
         this.listBounds = this.measureListBounds();
         this.viewport.x = this.listBounds.x;
         this.viewport.y = this.listBounds.y;
         this.viewport.scrollRect = new Rectangle(0,0,this.listBounds.width,this.listBounds.height);
         this.viewport.addChild(this.holder);
         addChild(this.viewport);
         this.scrollBar.init(this.holder,this.listBounds.height,this.listBounds.height);
         this.positionScrollBar();
         addChild(this.scrollBar);
         this.scrollBar.visible = false;
         this.emptyField = new TextField();
         this.emptyField.defaultTextFormat = new TextFormat("Verdana",10,3355443);
         this.emptyField.width = this.listBounds.width - 14;
         this.emptyField.height = 20;
         this.emptyField.selectable = false;
         this.emptyField.mouseEnabled = false;
         this.emptyField.x = 2;
         this.emptyField.y = 2;
         this.holder.addChild(this.emptyField);
         this.setLoadingVisible(true);
      }

      private function loadReplays() : void
      {
         var request:URLRequest = ReplayLeaderboardData.buildRequest(this.levelId,this.isPr2Hub,ReplayLeaderboardData.FULL_COUNT,true);
         this.loader.load(request);
      }

      private function handleData(event:Event) : void
      {
         var response:Object = this.loader.parsedData;
         var errorMessage:String = ReplayLeaderboardData.getErrorMessage(response,"Unable to load replays.");
         if(errorMessage != null)
         {
            this.handleLoadFailure(errorMessage);
            return;
         }
         this.replayRows = ReplayLeaderboardData.getRowsForMode(response,this.mode);
         this.populateRows(this.replayRows);
      }

      private function handleError(event:Event) : void
      {
         this.handleLoadFailure("Unable to load replays.");
      }

      private function handleLoadFailure(message:String) : void
      {
         this.replayRows = [];
         this.clearRows();
         this.emptyField.text = message;
         this.emptyField.visible = true;
         this.setLoadingVisible(false);
         this.updateScrollBar();
      }

      private function populateRows(replayRows:Array) : void
      {
         var rowIndex:int = 0;
         var visibleRowIndex:int = 0;
         var rowData:Object = null;
         var row:ReplayPopupRow = null;
         this.clearRows();
         if(replayRows == null || replayRows.length == 0)
         {
            this.emptyField.text = "No replays yet.";
            this.emptyField.visible = true;
         }
         else
         {
            while(rowIndex < replayRows.length)
            {
               rowData = replayRows[rowIndex];
               if(this.shouldShowReplayRow(rowData))
               {
                  row = new ReplayPopupRow(this.levelId,this.isPr2Hub,this.loadReplays);
                  row.y = visibleRowIndex * ROW_HEIGHT;
                  row.setEntry(this.buildEntry(rowData,rowIndex + 1),visibleRowIndex % 2 == 1);
                  this.holder.addChild(row);
                  this.rows.push(row);
                  visibleRowIndex++;
               }
               rowIndex++;
            }
            this.emptyField.text = visibleRowIndex > 0 ? "" : "No visible replays.";
            this.emptyField.visible = visibleRowIndex == 0;
         }
         if(this.titleField != null)
         {
            this.titleField.text = (this.mode == "team" ? "All Team Replays" : "All Solo Replays") + " (" + visibleRowIndex + ")";
         }
         this.setLoadingVisible(false);
         this.updateScrollBar();
      }

      private function shouldShowReplayRow(replayRow:Object) : Boolean
      {
         if(replayRow == null)
         {
            return false;
         }
         if(this.isShowingHiddenReplays())
         {
            return true;
         }
         return !ReplayLeaderboardData.isReplayHidden(replayRow);
      }

      private function isShowingHiddenReplays() : Boolean
      {
         return this.hiddenToggle != null && this.hiddenToggle.visible && this.hiddenToggle.selected;
      }

      private function onHiddenToggleChange(event:Event) : void
      {
         Settings.setValue(Settings.SHOW_HIDDEN_REPLAYS,this.hiddenToggle.selected);
         this.populateRows(this.replayRows);
      }

      private function buildEntry(row:Object, rank:int) : ReplayLeaderboardEntry
      {
         return ReplayLeaderboardData.buildEntry(row,rank,true);
      }

      private function updateScrollBar() : void
      {
         this.scrollBar.position(0);
         this.scrollBar.visible = this.holder.height > this.listBounds.height;
      }

      private function positionScrollBar() : void
      {
         this.scrollBar.x = this.listBounds.right - this.scrollBar.width / 2 + SCROLLBAR_X_ADJUST;
         this.scrollBar.y = this.listBounds.y;
      }

      private function measureListBounds() : Rectangle
      {
         var templateRow:DisplayObject = this.findTemplateRow();
         var listX:Number = LIST_X;
         var listY:Number = LIST_Y;
         var listWidth:Number = LIST_WIDTH;
         var listHeight:Number = LIST_HEIGHT;
         var bottom:Number = NaN;
         if(templateRow != null)
         {
            listX = Math.round(templateRow.x);
            listY = Math.round(templateRow.y);
            listWidth = Math.round(templateRow.width);
         }
         if(this.closeButton != null)
         {
            bottom = this.closeButton.y - LIST_BOTTOM_PADDING;
            if(bottom > listY + ROW_HEIGHT)
            {
               listHeight = Math.round(bottom - listY);
            }
         }
         return new Rectangle(listX,listY,listWidth,listHeight);
      }

      private function findTemplateRow() : DisplayObject
      {
         var childIndex:int = 0;
         var child:DisplayObject = null;
         while(childIndex < this.m.numChildren)
         {
            child = this.m.getChildAt(childIndex);
            if(child is ReplayLeaderboardItemGraphic)
            {
               return child;
            }
            childIndex++;
         }
         return null;
      }

      private function clearRows() : void
      {
         var row:ReplayPopupRow = null;
         for each(row in this.rows)
         {
            row.dispose();
            if(row.parent == this.holder)
            {
               this.holder.removeChild(row);
            }
         }
         this.rows = [];
         this.holder.y = 0;
      }

      private function setLoadingVisible(isVisible:Boolean) : void
      {
         if(this.m != null && this.m.loading != null)
         {
            this.m.loading.visible = isVisible;
         }
      }

      private function onCloseClick(event:MouseEvent) : void
      {
         startFadeOut();
      }

      override public function remove() : *
      {
         if(ReplaysPopup.instance === this)
         {
            ReplaysPopup.instance = null;
         }
         Mouse.cursor = MouseCursor.AUTO;
         if(this.closeButton != null)
         {
            this.closeButton.removeEventListener(MouseEvent.CLICK,this.onCloseClick);
         }
         if(this.hiddenToggle != null)
         {
            this.hiddenToggle.removeEventListener(Event.CHANGE,this.onHiddenToggleChange);
         }
         this.clearRows();
         if(this.loader != null)
         {
            this.loader.removeEventListener(SuperLoader.d,this.handleData);
            this.loader.removeEventListener(SuperLoader.e,this.handleError);
            this.loader.remove();
            this.loader = null;
         }
         if(this.scrollBar != null)
         {
            this.scrollBar.remove();
            this.scrollBar = null;
         }
         super.remove();
      }

      private function canModerateReplay() : Boolean
      {
         return Main.group >= 2 || Main.isTempMod;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.ContextMenuEvent;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.FileReference;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.ui.ContextMenu;
import flash.ui.ContextMenuItem;
import flash.ui.Mouse;
import flash.ui.MouseCursor;
import Main;
import SuperLoader;
import package_4.ConfirmPopup;
import package_4.UploadingPopup;
import replay.ReplayLeaderboardEntry;
import replay.ReplayLeaderboardData;
import replay.ReplayManager;
import replay.ReplaysPopup;
import replay.TextFieldMarquee;

class ReplayPopupRow extends Sprite
{
   private static const STRIPE_X:Number = 0;
   private static const STRIPE_Y:Number = 0;
   private static const STRIPE_WIDTH:Number = 286;
   private static const STRIPE_HEIGHT:Number = 18;

   private var skin:ReplayLeaderboardItemGraphic;
   private var entry:ReplayLeaderboardEntry;
   private var levelId:String;
   private var isPr2Hub:Boolean;
   private var reloadHandler:Function;
   private var marquee:TextFieldMarquee;
   private var stripeBG:Sprite;
   private var customContextMenu:ContextMenu;
   private var downloadItem:ContextMenuItem;
   private var toggleVisibilityItem:ContextMenuItem;
   private var visibilityUploading:UploadingPopup;

   public function ReplayPopupRow(levelId:String, isPr2Hub:Boolean, reloadHandler:Function = null)
   {
      super();
      this.levelId = levelId;
      this.isPr2Hub = isPr2Hub;
      this.reloadHandler = reloadHandler;
      this.skin = new ReplayLeaderboardItemGraphic();
      addChild(this.skin);
      this.skin.gotoAndStop("up");
      this.setupStripeBackground();
      this.skin.viewField.selectable = false;
      this.skin.viewField.mouseEnabled = true;
      this.applyLinkFormat(this.skin.viewField);
      this.skin.viewField.addEventListener(MouseEvent.CLICK,this.onViewClick,false,0,true);
      this.skin.viewField.addEventListener(MouseEvent.MOUSE_OVER,this.onViewOver,false,0,true);
      this.skin.viewField.addEventListener(MouseEvent.MOUSE_OUT,this.onViewOut,false,0,true);
      this.marquee = new TextFieldMarquee(this.skin.playersField);
      this.ensureContextMenu();
   }

   public function setEntry(entry:ReplayLeaderboardEntry, showStripe:Boolean = false) : void
   {
      this.entry = entry;
      this.skin.gotoAndStop("up");
      this.skin.timeField.text = entry.displayTime;
      this.skin.playersField.text = entry.participants != null && entry.participants.length > 0 ? entry.participants.join(", ") : "Solo run";
      if(entry.hidden)
      {
         this.skin.playersField.appendText(" [hidden]");
      }
      this.skin.viewField.text = "watch";
      this.skin.viewField.visible = entry.canWatch;
      this.skin.viewField.mouseEnabled = entry.canWatch;
      if(this.stripeBG != null)
      {
         this.stripeBG.visible = showStripe;
      }
      this.applyLinkFormat(this.skin.viewField);
      this.ensureContextMenu();
      this.updateContextMenuState();
      this.marquee.refresh();
   }

   private function setupStripeBackground() : void
   {
      this.stripeBG = new Sprite();
      this.stripeBG.mouseEnabled = false;
      this.stripeBG.visible = false;
      this.stripeBG.graphics.beginFill(14540253,1);
      this.stripeBG.graphics.drawRect(STRIPE_X,STRIPE_Y,STRIPE_WIDTH,STRIPE_HEIGHT);
      this.stripeBG.graphics.endFill();
      addChildAt(this.stripeBG,0);
   }

   private function applyLinkFormat(field:TextField) : void
   {
      var format:TextFormat = null;
      if(field == null)
      {
         return;
      }
      format = field.defaultTextFormat != null ? field.defaultTextFormat : field.getTextFormat();
      if(format != null)
      {
         format.underline = true;
         field.defaultTextFormat = format;
         if(field.text.length > 0)
         {
            field.setTextFormat(format);
         }
      }
   }

   private function ensureContextMenu() : void
   {
      var items:Array = null;
      if(this.skin == null || this.skin.viewField == null)
      {
         return;
      }
      if(this.customContextMenu == null)
      {
         this.customContextMenu = new ContextMenu();
         this.customContextMenu.hideBuiltInItems();
      }
      if(this.downloadItem == null)
      {
         this.downloadItem = new ContextMenuItem("Download this replay...");
         this.downloadItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onDownloadMenuSelect,false,0,true);
      }
      items = [this.downloadItem];
      if(this.canModerateReplay())
      {
         if(this.toggleVisibilityItem == null)
         {
            this.toggleVisibilityItem = new ContextMenuItem("Hide replay...");
            this.toggleVisibilityItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onToggleVisibilityMenuSelect,false,0,true);
         }
         items.push(this.toggleVisibilityItem);
      }
      this.customContextMenu.customItems = items;
      this.applyContextMenuTargets();
   }

   private function applyContextMenuTargets() : void
   {
      var viewParent:InteractiveObject = null;
      if(this.customContextMenu == null || this.skin == null || this.skin.viewField == null)
      {
         return;
      }
      this.contextMenu = this.customContextMenu;
      this.skin.contextMenu = this.customContextMenu;
      this.skin.viewField.contextMenu = this.customContextMenu;
      viewParent = this.skin.viewField.parent as InteractiveObject;
      if(viewParent != null)
      {
         viewParent.contextMenu = this.customContextMenu;
      }
   }

   private function updateContextMenuState() : void
   {
      var hasReplay:Boolean = false;
      var isHidden:Boolean = false;
      if(this.downloadItem == null)
      {
         return;
      }
      hasReplay = this.entry != null && this.entry.replayId != null && this.entry.replayId != "";
      isHidden = hasReplay && this.entry.hidden;
      this.downloadItem.enabled = hasReplay;
      if(this.toggleVisibilityItem != null)
      {
         this.toggleVisibilityItem.caption = isHidden ? "Un-hide this replay..." : "Hide replay...";
         this.toggleVisibilityItem.enabled = hasReplay && this.visibilityUploading == null;
      }
   }

   private function onViewClick(event:MouseEvent) : void
   {
      if(this.entry == null || this.entry.replayId == null || this.entry.replayId == "" || !this.entry.canWatch)
      {
         return;
      }
      if(ReplaysPopup.instance != null)
      {
         ReplaysPopup.instance.startFadeOut();
      }
      ReplayManager.playReplay(this.entry.replayId,this.levelId,this.isPr2Hub);
   }

   private function onDownloadMenuSelect(event:ContextMenuEvent) : void
   {
      var request:URLRequest = null;
      var vars:URLVariables = null;
      var fileName:String = null;
      if(this.entry == null || this.entry.replayId == null || this.entry.replayId == "")
      {
         return;
      }
      vars = new URLVariables();
      vars.id = this.entry.replayId;
      if(Main.token != null && Main.token.length > 0)
      {
         vars.token = Main.token;
      }
      request = new URLRequest(Main.baseURL + "/replays_get.php");
      request.method = URLRequestMethod.GET;
      request.data = vars;
      fileName = this.entry.replayId + ".pr2r";
      try
      {
         new FileReference().download(request,fileName);
      }
      catch(error:Error)
      {
      }
   }

   private function onToggleVisibilityMenuSelect(event:ContextMenuEvent) : void
   {
      var self:ReplayPopupRow = null;
      if(this.entry == null || this.entry.replayId == null || this.entry.replayId == "" || this.visibilityUploading != null)
      {
         return;
      }
      self = this;
      new ConfirmPopup(function():*
      {
         self.submitReplayVisibility(!self.entry.hidden);
      },this.entry.hidden ? "Are you sure you want to un-hide this replay?" : "Are you sure you want to hide this replay?");
   }

   private function submitReplayVisibility(hidden:Boolean) : void
   {
      var request:URLRequest = null;
      var vars:URLVariables = null;
      if(this.entry == null || this.entry.replayId == null || this.entry.replayId == "" || this.visibilityUploading != null)
      {
         return;
      }
      vars = new URLVariables();
      vars.replay_id = this.entry.replayId;
      vars.hidden = hidden ? 1 : 0;
      if(Main.token != null && Main.token.length > 0)
      {
         vars.token = Main.token;
      }
      request = new URLRequest(Main.baseURL + "/api/replay_visibility.php");
      request.method = URLRequestMethod.POST;
      request.data = vars;
      this.visibilityUploading = new UploadingPopup(request,"json",hidden ? "Hiding replay..." : "Unhiding replay...");
      this.visibilityUploading.addEventListener(SuperLoader.d,this.onReplayVisibilitySuccess,false,0,true);
      this.visibilityUploading.addEventListener(SuperLoader.e,this.onReplayVisibilityComplete,false,0,true);
      this.updateContextMenuState();
   }

   private function onReplayVisibilitySuccess(event:Event) : void
   {
      var replayData:Object = null;
      if(this.visibilityUploading != null && this.visibilityUploading.parsedData != null && this.entry != null)
      {
         replayData = this.visibilityUploading.parsedData["replay"];
         if(replayData != null)
         {
            this.entry.hidden = ReplayLeaderboardData.readBoolean(replayData["hidden"]);
            this.entry.hiddenAtMs = replayData["hidden_at_ms"] != null ? Number(replayData["hidden_at_ms"]) : 0;
            this.entry.hiddenByUserId = replayData["hidden_by_user_id"] != null ? int(replayData["hidden_by_user_id"]) : 0;
         }
      }
      this.clearVisibilityUpload();
      if(this.reloadHandler != null)
      {
         this.reloadHandler();
      }
   }

   private function onReplayVisibilityComplete(event:Event) : void
   {
      this.clearVisibilityUpload();
   }

   private function clearVisibilityUpload() : void
   {
      if(this.visibilityUploading != null)
      {
         this.visibilityUploading.removeEventListener(SuperLoader.d,this.onReplayVisibilitySuccess);
         this.visibilityUploading.removeEventListener(SuperLoader.e,this.onReplayVisibilityComplete);
         this.visibilityUploading = null;
      }
      this.updateContextMenuState();
   }

   private function onViewOver(event:MouseEvent) : void
   {
      if(this.entry != null && this.entry.canWatch)
      {
         Mouse.cursor = MouseCursor.BUTTON;
      }
   }

   private function onViewOut(event:MouseEvent) : void
   {
      Mouse.cursor = MouseCursor.AUTO;
   }

   private function canModerateReplay() : Boolean
   {
      return Main.group >= 2 || Main.isTempMod;
   }

   public function dispose() : void
   {
      Mouse.cursor = MouseCursor.AUTO;
      this.skin.viewField.removeEventListener(MouseEvent.CLICK,this.onViewClick);
      this.skin.viewField.removeEventListener(MouseEvent.MOUSE_OVER,this.onViewOver);
      this.skin.viewField.removeEventListener(MouseEvent.MOUSE_OUT,this.onViewOut);
      if(this.downloadItem != null)
      {
         this.downloadItem.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onDownloadMenuSelect);
      }
      if(this.toggleVisibilityItem != null)
      {
         this.toggleVisibilityItem.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onToggleVisibilityMenuSelect);
      }
      this.clearVisibilityUpload();
      if(this.marquee != null)
      {
         this.marquee.dispose();
         this.marquee = null;
      }
      this.entry = null;
   }
}
