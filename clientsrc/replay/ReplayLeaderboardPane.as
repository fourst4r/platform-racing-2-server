package replay
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.ContextMenuEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.FileReference;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.utils.Dictionary;
   import Main;
   import SuperLoader;
   import package_4.ConfirmPopup;
   import package_4.UploadingPopup;

   public class ReplayLeaderboardPane extends Sprite
   {
      private static const SLOT_COUNT:int = 5;

      private var skin:ReplayLeaderboardPaneGraphic;
      private var loadingGraphic:DisplayObject;
      private var loader:URLLoader;

      private var levelId:String;
      private var isPr2Hub:Boolean = false;

      private var soloSlots:Array;
      private var teamSlots:Array;
      private var viewFieldToSlot:Dictionary;
      private var showAllFieldToMode:Dictionary;
      private var contextItemToSlot:Dictionary;
      private var visibilityUploading:UploadingPopup;
      private var visibilitySlot:LeaderboardSlot;

      public function ReplayLeaderboardPane()
      {
         super();
         this.mouseEnabled = true;
         this.mouseChildren = true;
         this.initializeUI();
      }

      private function initializeUI() : void
      {
         this.skin = new ReplayLeaderboardPaneGraphic();
         addChild(this.skin);
         this.viewFieldToSlot = new Dictionary(true);
         this.showAllFieldToMode = new Dictionary(true);
         this.contextItemToSlot = new Dictionary(true);
         this.soloSlots = this.createSlots("solo");
         this.teamSlots = this.createSlots("team");
         this.initializeShowAllField("solo");
         this.initializeShowAllField("team");
         this.loadingGraphic = this.skin.loadingGraphic;
         this.setLoadingVisible(false);
      }

      private function initializeShowAllField(prefix:String) : void
      {
         var showAllField:TextField = this.skin[prefix + "ShowAll"] as TextField;
         if(showAllField == null)
         {
            throw new Error("ReplayLeaderboardPaneGraphic is missing expected show-all field for " + prefix + ".");
         }
         showAllField.selectable = false;
         showAllField.mouseEnabled = true;
         this.applyLinkFormat(showAllField);
         this.showAllFieldToMode[showAllField] = prefix;
         showAllField.addEventListener(MouseEvent.CLICK,this.onShowAllClick,false,0,true);
         showAllField.addEventListener(MouseEvent.MOUSE_OVER,this.onShowAllOver,false,0,true);
         showAllField.addEventListener(MouseEvent.MOUSE_OUT,this.onShowAllOut,false,0,true);
      }

      private function createSlots(prefix:String) : Array
      {
         var slots:Array = [];
         for(var i:int = 0; i < SLOT_COUNT; i++)
         {
            var timeField:TextField = this.skin[prefix + "Time" + i] as TextField;
            var playersField:TextField = this.skin[prefix + "Players" + i] as TextField;
            var viewField:TextField = this.skin[prefix + "View" + i] as TextField;
            if(timeField == null || playersField == null || viewField == null)
            {
               throw new Error("ReplayLeaderboardPaneGraphic is missing expected fields for " + prefix + " index " + i + ".");
            }
            viewField.selectable = false;
            viewField.mouseEnabled = true;
            var format:TextFormat = viewField.defaultTextFormat != null ? viewField.defaultTextFormat : viewField.getTextFormat();
            format.underline = true;
            viewField.defaultTextFormat = format;
            if(viewField.text.length > 0)
            {
               viewField.setTextFormat(format);
            }
            var slot:LeaderboardSlot = new LeaderboardSlot(timeField,playersField,viewField);
            this.viewFieldToSlot[viewField] = slot;
            viewField.addEventListener(MouseEvent.CLICK,this.onSlotViewClick,false,0,true);
            viewField.addEventListener(MouseEvent.MOUSE_OVER,this.onSlotViewOver,false,0,true);
            viewField.addEventListener(MouseEvent.MOUSE_OUT,this.onSlotViewOut,false,0,true);
            this.ensureContextMenu(slot);
            this.clearSlot(slot);
            slots.push(slot);
         }
         return slots;
      }

      public function loadLevel(id:String, pr2Hub:Boolean) : void
      {
         this.levelId = id;
         this.isPr2Hub = pr2Hub;
         this.setSlotsMessage(this.soloSlots,"Loading...");
         this.setSlotsMessage(this.teamSlots,"Loading...");
         this.disposeLoader();
         this.setLoadingVisible(true);
         if(this.levelId == null)
         {
            this.setSlotsMessage(this.soloSlots,"Unable to load leaderboard.");
            this.setSlotsMessage(this.teamSlots,"Unable to load leaderboard.");
            this.setLoadingVisible(false);
            return;
         }
         this.loader = new URLLoader();
         this.loader.dataFormat = URLLoaderDataFormat.TEXT;
         this.loader.addEventListener(Event.COMPLETE,this.handleComplete,false,0,true);
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.handleError,false,0,true);
         var request:URLRequest = ReplayLeaderboardData.buildRequest(this.levelId,this.isPr2Hub,ReplayLeaderboardData.FULL_COUNT,true);
         trace("Loading replay leaderboard from: " + request.url + "?" + request.data.toString());
         this.loader.load(request);
         this.updateLoadingVisibility();
      }

      private function handleComplete(e:Event) : void
      {
         var data:String = e != null && e.target is URLLoader && URLLoader(e.target).data != null ? String(URLLoader(e.target).data) : "";
         var response:Object = null;
         try
         {
            response = JSON.parse(data);
         }
         catch(error:Error)
         {
            this.handleError(new IOErrorEvent(IOErrorEvent.IO_ERROR,false,false,error.message));
            return;
         }
         var errorMessage:String = ReplayLeaderboardData.getErrorMessage(response,"Unable to load leaderboard.");
         if(errorMessage != null)
         {
            this.setSlotsMessage(this.soloSlots,errorMessage);
            this.setSlotsMessage(this.teamSlots,errorMessage);
            this.disposeLoader();
            this.setLoadingVisible(false);
            return;
         }
         var soloRows:Array = ReplayLeaderboardData.limitRows(ReplayLeaderboardData.getVisibleRows(ReplayLeaderboardData.getRowsForMode(response,"solo")),SLOT_COUNT);
         var teamRows:Array = ReplayLeaderboardData.limitRows(ReplayLeaderboardData.getVisibleRows(ReplayLeaderboardData.getRowsForMode(response,"team")),SLOT_COUNT);
         this.applyEntriesToSlots(soloRows,this.soloSlots);
         this.applyEntriesToSlots(teamRows,this.teamSlots);
         this.disposeLoader();
         this.setLoadingVisible(false);
      }

      private function handleError(e:IOErrorEvent) : void
      {
         this.disposeLoader();
         this.setSlotsMessage(this.soloSlots,"Unable to load leaderboard.");
         this.setSlotsMessage(this.teamSlots,"Unable to load leaderboard.");
         this.setLoadingVisible(false);
      }

      private function disposeLoader() : void
      {
         if(this.loader != null)
         {
            this.loader.removeEventListener(Event.COMPLETE,this.handleComplete);
            this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.handleError);
            try
            {
               this.loader.close();
            }
            catch(error:Error)
            {
            }
            this.loader = null;
         }
         this.updateLoadingVisibility();
      }

      private function applyEntriesToSlots(rows:Array, slots:Array) : void
      {
         this.clearSlots(slots);
         if(rows == null || rows.length == 0)
         {
            this.setSlotsMessage(slots,"No replays yet.");
            return;
         }
         var count:int = Math.min(rows.length,slots.length);
         for(var i:int = 0; i < slots.length; i++)
         {
            var slot:LeaderboardSlot = slots[i];
            if(i < count)
            {
               var row:Object = rows[i];
               var entry:ReplayLeaderboardEntry = ReplayLeaderboardData.buildEntry(row,i + 1,false);
               slot.entry = entry;
               slot.timeField.text = entry.displayTime;
               slot.playersField.text = entry.participants != null && entry.participants.length > 0 ? entry.participants.join(", ") : "Solo run";
               slot.refreshPlayersMarquee();
               slot.viewField.text = "watch";
               slot.viewField.visible = entry.canWatch;
               slot.viewField.mouseEnabled = entry.canWatch;
               this.applyLinkFormat(slot.viewField);
               this.applyContextMenuTargets(slot);
               this.updateContextMenuState(slot);
            }
            else
            {
               this.clearSlot(slot);
            }
         }
      }

      private function onSlotViewClick(event:MouseEvent) : void
      {
         var field:TextField = event.currentTarget as TextField;
         var slot:LeaderboardSlot = field != null ? this.viewFieldToSlot[field] as LeaderboardSlot : null;
         if(slot == null || slot.entry == null || slot.entry.replayId == null || slot.entry.replayId == "" || !slot.entry.canWatch)
         {
            return;
         }
         ReplayManager.playReplay(slot.entry.replayId,this.levelId,this.isPr2Hub);
      }

      private function onSlotViewOver(event:MouseEvent) : void
      {
         var field:TextField = event.currentTarget as TextField;
         var slot:LeaderboardSlot = field != null ? this.viewFieldToSlot[field] as LeaderboardSlot : null;
         if(slot != null && slot.entry != null && slot.entry.canWatch)
         {
            Mouse.cursor = MouseCursor.BUTTON;
         }
         else
         {
            Mouse.cursor = MouseCursor.AUTO;
         }
     }

     private function onSlotViewOut(event:MouseEvent) : void
     {
        Mouse.cursor = MouseCursor.AUTO;
      }

      private function onShowAllClick(event:MouseEvent) : void
      {
         var field:TextField = event.currentTarget as TextField;
         var mode:String = field != null ? this.showAllFieldToMode[field] as String : null;
         if(mode == null || this.levelId == null)
         {
            return;
         }
         new ReplaysPopup(this.levelId,this.isPr2Hub,mode);
      }

      private function onShowAllOver(event:MouseEvent) : void
      {
         Mouse.cursor = MouseCursor.BUTTON;
      }

      private function onShowAllOut(event:MouseEvent) : void
      {
         Mouse.cursor = MouseCursor.AUTO;
      }

      private function setSlotsMessage(slots:Array, message:String) : void
      {
         this.clearSlots(slots);
         if(slots.length > 0)
         {
            var slot:LeaderboardSlot = slots[0];
            slot.timeField.text = message;
         }
      }

      private function clearSlots(slots:Array) : void
      {
         for each(var slot:LeaderboardSlot in slots)
         {
            this.clearSlot(slot);
         }
      }

      private function clearSlot(slot:LeaderboardSlot) : void
      {
         if(slot == null)
         {
            return;
         }
         slot.entry = null;
         slot.timeField.text = "";
         slot.playersField.text = "";
         slot.viewField.text = "";
         slot.viewField.visible = false;
         slot.viewField.mouseEnabled = false;
         this.updateContextMenuState(slot);
         slot.refreshPlayersMarquee();
      }

      private function ensureContextMenu(slot:LeaderboardSlot) : void
      {
         var items:Array = null;
         if(slot == null || slot.viewField == null)
         {
            return;
         }
         if(slot.contextMenu == null)
         {
            slot.contextMenu = new ContextMenu();
            slot.contextMenu.hideBuiltInItems();
            slot.viewField.contextMenu = slot.contextMenu;
         }
         if(slot.downloadItem == null)
         {
            slot.downloadItem = new ContextMenuItem("Download this replay...");
            slot.downloadItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onDownloadMenuSelect,false,0,true);
            this.contextItemToSlot[slot.downloadItem] = slot;
         }
         if(this.canModerateReplay() && slot.toggleVisibilityItem == null)
         {
            slot.toggleVisibilityItem = new ContextMenuItem("Hide replay...");
            slot.toggleVisibilityItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onToggleVisibilityMenuSelect,false,0,true);
            this.contextItemToSlot[slot.toggleVisibilityItem] = slot;
         }
         items = [slot.downloadItem];
         if(this.canModerateReplay() && slot.toggleVisibilityItem != null)
         {
            items.push(slot.toggleVisibilityItem);
         }
         slot.contextMenu.customItems = items;
         this.applyContextMenuTargets(slot);
         this.updateContextMenuState(slot);
      }

      private function applyContextMenuTargets(slot:LeaderboardSlot) : void
      {
         var viewParent:InteractiveObject = null;
         if(slot == null || slot.viewField == null || slot.contextMenu == null)
         {
            return;
         }
         slot.viewField.contextMenu = slot.contextMenu;
         viewParent = slot.viewField.parent as InteractiveObject;
         if(viewParent != null)
         {
            viewParent.contextMenu = slot.contextMenu;
         }
      }

      private function updateContextMenuState(slot:LeaderboardSlot) : void
      {
         var hasReplay:Boolean = false;
         var isHidden:Boolean = false;
         if(slot == null || slot.downloadItem == null)
         {
            return;
         }
         hasReplay = slot.entry != null && slot.entry.replayId != null && slot.entry.replayId != "";
         isHidden = hasReplay && slot.entry.hidden;
         slot.downloadItem.enabled = hasReplay;
         if(slot.toggleVisibilityItem != null)
         {
            slot.toggleVisibilityItem.caption = isHidden ? "Un-hide this replay..." : "Hide replay...";
            slot.toggleVisibilityItem.enabled = hasReplay && this.visibilityUploading == null;
         }
      }

      private function onDownloadMenuSelect(event:ContextMenuEvent) : void
      {
         var item:ContextMenuItem = event.currentTarget as ContextMenuItem;
         var slot:LeaderboardSlot = item != null ? this.contextItemToSlot[item] as LeaderboardSlot : null;
         if(slot == null || slot.entry == null || slot.entry.replayId == null || slot.entry.replayId == "")
         {
            return;
         }
         var vars:URLVariables = new URLVariables();
         vars.id = slot.entry.replayId;
         if(Main.token != null && Main.token.length > 0)
         {
            vars.token = Main.token;
         }
         var request:URLRequest = new URLRequest(Main.baseURL + "/replays_get.php");
         request.method = URLRequestMethod.GET;
         request.data = vars;
         var fileName:String = slot.entry.replayId + ".pr2r";
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
         var item:ContextMenuItem = event.currentTarget as ContextMenuItem;
         var slot:LeaderboardSlot = item != null ? this.contextItemToSlot[item] as LeaderboardSlot : null;
         var self:ReplayLeaderboardPane = null;
         if(slot == null || slot.entry == null || slot.entry.replayId == null || slot.entry.replayId == "" || this.visibilityUploading != null)
         {
            return;
         }
         self = this;
         new ConfirmPopup(function():*
         {
            self.submitReplayVisibility(slot,!slot.entry.hidden);
         },slot.entry.hidden ? "Are you sure you want to un-hide this replay?" : "Are you sure you want to hide this replay?");
      }

      private function submitReplayVisibility(slot:LeaderboardSlot, hidden:Boolean) : void
      {
         var request:URLRequest = null;
         var vars:URLVariables = null;
         if(slot == null || slot.entry == null || slot.entry.replayId == null || slot.entry.replayId == "" || this.visibilityUploading != null)
         {
            return;
         }
         vars = new URLVariables();
         vars.replay_id = slot.entry.replayId;
         vars.hidden = hidden ? 1 : 0;
         if(Main.token != null && Main.token.length > 0)
         {
            vars.token = Main.token;
         }
         request = new URLRequest(Main.baseURL + "/api/replay_visibility.php");
         request.method = URLRequestMethod.POST;
         request.data = vars;
         this.visibilitySlot = slot;
         this.visibilityUploading = new UploadingPopup(request,"json",hidden ? "Hiding replay..." : "Unhiding replay...");
         this.visibilityUploading.addEventListener(SuperLoader.d,this.onReplayVisibilitySuccess,false,0,true);
         this.visibilityUploading.addEventListener(SuperLoader.e,this.onReplayVisibilityComplete,false,0,true);
         this.refreshContextMenuStates();
      }

      private function onReplayVisibilitySuccess(event:Event) : void
      {
         var replayData:Object = null;
         if(this.visibilityUploading != null && this.visibilityUploading.parsedData != null && this.visibilitySlot != null && this.visibilitySlot.entry != null)
         {
            replayData = this.visibilityUploading.parsedData["replay"];
            if(replayData != null)
            {
               this.visibilitySlot.entry.hidden = ReplayLeaderboardData.readBoolean(replayData["hidden"]);
               this.visibilitySlot.entry.hiddenAtMs = replayData["hidden_at_ms"] != null ? Number(replayData["hidden_at_ms"]) : 0;
               this.visibilitySlot.entry.hiddenByUserId = replayData["hidden_by_user_id"] != null ? int(replayData["hidden_by_user_id"]) : 0;
            }
         }
         this.clearVisibilityUpload();
         this.loadLevel(this.levelId,this.isPr2Hub);
      }

      private function onReplayVisibilityComplete(event:Event) : void
      {
         this.clearVisibilityUpload();
      }

      private function applyLinkFormat(field:TextField) : void
      {
         if(field == null)
         {
            return;
         }
         var format:TextFormat = field.defaultTextFormat != null ? field.defaultTextFormat : field.getTextFormat();
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

      private function setLoadingVisible(isVisible:Boolean) : void
      {
         if(this.loadingGraphic != null)
         {
            this.loadingGraphic.visible = isVisible;
         }
      }

      private function updateLoadingVisibility() : void
      {
         this.setLoadingVisible(this.loader != null);
      }

      private function canModerateReplay() : Boolean
      {
         return Main.group >= 2 || Main.isTempMod;
      }

      private function refreshContextMenuStates() : void
      {
         this.refreshSlotsContextMenuState(this.soloSlots);
         this.refreshSlotsContextMenuState(this.teamSlots);
      }

      private function refreshSlotsContextMenuState(slots:Array) : void
      {
         if(slots == null)
         {
            return;
         }
         for each(var slot:LeaderboardSlot in slots)
         {
            this.updateContextMenuState(slot);
         }
      }

      private function clearVisibilityUpload() : void
      {
         if(this.visibilityUploading != null)
         {
            this.visibilityUploading.removeEventListener(SuperLoader.d,this.onReplayVisibilitySuccess);
            this.visibilityUploading.removeEventListener(SuperLoader.e,this.onReplayVisibilityComplete);
            this.visibilityUploading = null;
         }
         this.visibilitySlot = null;
         this.refreshContextMenuStates();
      }

      public function dispose() : void
      {
         var showAllField:TextField = null;
         this.disposeLoader();
         this.clearVisibilityUpload();
         this.disposeSlots(this.soloSlots);
         this.disposeSlots(this.teamSlots);
         if(this.skin != null)
         {
            showAllField = this.skin["soloShowAll"] as TextField;
            if(showAllField != null)
            {
               showAllField.removeEventListener(MouseEvent.CLICK,this.onShowAllClick);
               showAllField.removeEventListener(MouseEvent.MOUSE_OVER,this.onShowAllOver);
               showAllField.removeEventListener(MouseEvent.MOUSE_OUT,this.onShowAllOut);
            }
            showAllField = this.skin["teamShowAll"] as TextField;
            if(showAllField != null)
            {
               showAllField.removeEventListener(MouseEvent.CLICK,this.onShowAllClick);
               showAllField.removeEventListener(MouseEvent.MOUSE_OVER,this.onShowAllOver);
               showAllField.removeEventListener(MouseEvent.MOUSE_OUT,this.onShowAllOut);
            }
         }
         Mouse.cursor = MouseCursor.AUTO;
         this.soloSlots = null;
         this.teamSlots = null;
         if(this.loadingGraphic != null && this.loadingGraphic.parent == this.skin)
         {
            this.skin.removeChild(this.loadingGraphic);
         }
         if(parent != null)
         {
            parent.removeChild(this);
         }
         this.viewFieldToSlot = null;
         this.showAllFieldToMode = null;
      }

      private function disposeSlots(slots:Array) : void
      {
         if(slots == null)
         {
            return;
         }
         for each(var slot:LeaderboardSlot in slots)
         {
            if(slot != null && slot.viewField != null)
            {
               slot.viewField.removeEventListener(MouseEvent.CLICK,this.onSlotViewClick);
               slot.viewField.removeEventListener(MouseEvent.MOUSE_OVER,this.onSlotViewOver);
               slot.viewField.removeEventListener(MouseEvent.MOUSE_OUT,this.onSlotViewOut);
               if(slot.downloadItem != null)
               {
                  slot.downloadItem.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onDownloadMenuSelect);
                  if(this.contextItemToSlot != null)
                  {
                     delete this.contextItemToSlot[slot.downloadItem];
                  }
               }
               if(slot.toggleVisibilityItem != null)
               {
                  slot.toggleVisibilityItem.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onToggleVisibilityMenuSelect);
                  if(this.contextItemToSlot != null)
                  {
                     delete this.contextItemToSlot[slot.toggleVisibilityItem];
                  }
               }
               if(this.viewFieldToSlot != null)
               {
                  delete this.viewFieldToSlot[slot.viewField];
               }
            }
            if(slot != null)
            {
               slot.dispose();
            }
         }
      }
   }
}

import flash.text.TextField;
import flash.ui.ContextMenu;
import flash.ui.ContextMenuItem;
import replay.ReplayLeaderboardEntry;
import replay.TextFieldMarquee;

class LeaderboardSlot
{
   public var timeField:TextField;
   public var playersField:TextField;
   public var viewField:TextField;
   public var entry:ReplayLeaderboardEntry;
   public var marquee:TextFieldMarquee;
   public var contextMenu:ContextMenu;
   public var downloadItem:ContextMenuItem;
   public var toggleVisibilityItem:ContextMenuItem;

   public function LeaderboardSlot(timeField:TextField, playersField:TextField, viewField:TextField)
   {
      this.timeField = timeField;
      this.playersField = playersField;
      this.viewField = viewField;
      this.entry = null;
      this.marquee = new TextFieldMarquee(this.playersField);
      this.contextMenu = null;
      this.downloadItem = null;
      this.toggleVisibilityItem = null;
   }

   public function refreshPlayersMarquee() : void
   {
      if(this.marquee != null)
      {
         this.marquee.refresh();
      }
   }

   public function dispose() : void
   {
      if(this.marquee != null)
      {
         this.marquee.dispose();
         this.marquee = null;
      }
      this.entry = null;
   }
}
