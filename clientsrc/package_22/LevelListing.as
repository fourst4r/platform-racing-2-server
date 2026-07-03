package package_22
{
   import com.adobe.crypto.*;
   import com.jiggmin.data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   import fl.controls.Button;
   import page.Page;
   import ui.*;
   
   public class LevelListing extends Page
   {
      
      public static var levelListing:LevelListing;
       
      
      public var class_10:Sprite;
      
      protected var loadingGraphic:LoadingGraphic;
      
      protected var pageNavigation:PageNavigation;
      
      protected var var_280:uint;
      
      private var levelArray:Array;
      
      public var levels:Object;
      
      protected var pageNum:int = 1;
      
      protected var mode:String = "best";
      
      // primary and secondary loaders
      protected var superLoader:SuperLoader;
      protected var superLoader2:SuperLoader;
      
      // load state & parsed results
      protected var primaryLoaded:Boolean = false;
      protected var secondaryLoaded:Boolean = false;
      protected var primaryData:Array = null;
      protected var secondaryData:Array = null;

      // Which data sources are expected to be used. Subclasses can change these
      // before initiating loads to indicate only one source will be fetched.
      protected var usePrimary:Boolean = true;
      protected var useSecondary:Boolean = true;
      
      private var cm:CommandHandler;
      
      private var sourceToggle:LevelSourceToggle;
      private var noResultsPrompt:Sprite;
      private var noResultsAction:Button;
      
      private static const SOURCE_TOGGLE_MEMORY_KEY:String = "courseSourceUseSecondary";
      
      public function LevelListing()
      {
         this.class_10 = new Sprite();
         this.loadingGraphic = new LoadingGraphic();
         this.levelArray = new Array();
         this.levels = new Object();
         this.cm = CommandHandler.commandHandler;
         this.pageNavigation = new PageNavigation(this,"vertical",1,9,283);
         this.superLoader = new SuperLoader(true,SuperLoader.j);
         this.superLoader2 = new SuperLoader(true,SuperLoader.j);
         super();
         addChild(this.class_10);
         this.loadingGraphic.x = 164;
         this.loadingGraphic.y = 150;
         addChild(this.loadingGraphic);
         this.pageNavigation.x = 328;
         this.pageNavigation.y = 26;
         addChild(this.pageNavigation);
         var savedSource:* = Memory.memory[SOURCE_TOGGLE_MEMORY_KEY];
         var defaultToSecondary:Boolean = savedSource === 1 || savedSource === "1" || savedSource === true;
         this.sourceToggle = new LevelSourceToggle("Use PR2Hub source",defaultToSecondary);
         this.sourceToggle.x = this.pageNavigation.x;
         this.sourceToggle.y = this.pageNavigation.y - this.sourceToggle.height - 6;
         this.sourceToggle.addEventListener(Event.CHANGE,this.onSourceToggleChange,false,0,true);
         addChild(this.sourceToggle);
         this.noResultsPrompt = null;
         this.noResultsAction = null;
         // listen for both loaders
         this.superLoader.addEventListener(Event.COMPLETE,this.loadHandler);
         this.superLoader.addEventListener(SuperLoader.e,this.sourceLoadError);
         this.superLoader2.addEventListener(Event.COMPLETE,this.loadHandler);
         this.superLoader2.addEventListener(SuperLoader.e,this.sourceLoadError);
         Main.socket.write("set_right_room`none");
         LevelListing.levelListing = this;
         addEventListener("testLevelAccess",this.testLevelAccess,false,0,true);
         this.cm.defineCommand("addPageHighlight",this.addPageHighlight);
         this.cm.defineCommand("removePageHighlight",this.removePageHighlight);
      }
      
      override public function initialize() : *
      {
         var _loc1_:int = int(Memory.memory["coursePageNum" + this.mode]);
         if(_loc1_ != 0)
         {
            this.pageNavigation.setPageNum(_loc1_);
         }
      }
      
      protected function showCourses(param1:Array) : *
      {
         this.hideNoResultsPrompt();
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:LevelItem = null;
         if(class_33.getNumber("userRank") < 0)
         {
            this.var_280 = setTimeout(this.showCourses,250,param1);
         }
         else
         {
            if(this.pageNavigation.parent == this.class_10)
            {
               this.class_10.removeChild(this.pageNavigation);
            }
            _loc2_ = 0;
            _loc3_ = 0;
            if((_loc4_ = this.class_10.height) != 0)
            {
               _loc4_ += 20;
            }
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               _loc6_ = param1[_loc5_];
               if(_loc4_ + _loc3_ * 112 > 224)
               {
                  break;
               }
               (_loc7_ = new LevelItem(_loc6_.level_id,_loc6_.version,_loc6_.title,_loc6_.rating,_loc6_.play_count,_loc6_.min_level,_loc6_.note,_loc6_.user_name,_loc6_.user_group,_loc6_.pass,_loc6_.type,_loc6_.bad_hats,_loc6_.time,_loc6_.sourceIs8P)).x = 2 + _loc2_ * 109;
               _loc7_.y = _loc4_ + _loc3_ * 112;
               this.levelArray.push(_loc7_);
               this.levels["c" + _loc7_.courseID] = _loc7_;
               this.class_10.addChild(_loc7_);
               _loc2_++;
               if(_loc2_ >= 3)
               {
                  _loc3_++;
                  _loc2_ = 0;
               }
               _loc5_++;
            }
            Main.socket.write("set_right_room`" + (this.mode == "favorites" ? "search" : this.mode));
            this.loadingGraphic.visible = false;
         }
      }
      
      // called when either loader completes
      protected function loadHandler(e:Event) : *
      {
         if(!this.usePrimary && e.target === this.superLoader)
         {
            return;
         }
         if(!this.useSecondary && e.target === this.superLoader2)
         {
            return;
         }
         var raw:String = String(e.target.data);
         var parsed:Object = null;
         var extracted:String = null;
         var expected:String = null;
         if(raw != "")
         {
            try
            {
               parsed = JSON.parse(raw);
            }
            catch(err:Error)
            {
               parsed = null;
            }
            if(parsed != null && parsed.hash != null)
            {
               extracted = raw.substr(10, raw.length - 53);
               expected = String(MD5.hash(extracted + Env.LEVEL_LIST_SALT));
               if(parsed.hash == expected)
               {
                  if(e.target === this.superLoader)
                  {
                     this.primaryData = parsed.levels;
                     this.primaryLoaded = true;
                  }
                  else
                  {
                     this.secondaryData = parsed.levels;
                     this.secondaryLoaded = true;
                  }
               }
               else
               {
                  // invalid hash => treat as failure for that source
                  if(e.target === this.superLoader)
                  {
                     this.primaryData = null;
                     this.primaryLoaded = true;
                  }
                  else
                  {
                     this.secondaryData = null;
                     this.secondaryLoaded = true;
                  }
               }
            }
            else
            {
               if(e.target === this.superLoader)
               {
                  this.primaryData = null;
                  this.primaryLoaded = true;
               }
               else
               {
                  this.secondaryData = null;
                  this.secondaryLoaded = true;
               }
            }
         }
         else
         {
            if(e.target === this.superLoader)
            {
               this.primaryData = null;
               this.primaryLoaded = true;
            }
            else
            {
               this.secondaryData = null;
               this.secondaryLoaded = true;
            }
         }
         this.processSourceResultsIfReady();
      }
      
      // called when either loader errors
      private function sourceLoadError(e:Event) : *
      {
         if(!this.usePrimary && e.target === this.superLoader)
         {
            return;
         }
         if(!this.useSecondary && e.target === this.superLoader2)
         {
            return;
         }
         if(e.target === this.superLoader)
         {
            this.primaryData = null;
            this.primaryLoaded = true;
         }
         else
         {
            this.secondaryData = null;
            this.secondaryLoaded = true;
         }
         this.processSourceResultsIfReady();
      }
      
      // once all required sources have finished (success or fail), merge and show results
      protected function processSourceResultsIfReady() : *
      {
         var primaryReady:Boolean = !this.usePrimary || this.primaryLoaded;
         var secondaryReady:Boolean = !this.useSecondary || this.secondaryLoaded;
         if(!(primaryReady && secondaryReady))
         {
            return;
         }
         var allData:Array = [];
         var item:Object;
         if(this.usePrimary && this.primaryData != null)
         {
            for each (item in this.primaryData)
            {
               item.sourceIs8P = true;
               allData.push(item);
            }
         }
         if(this.useSecondary && this.secondaryData != null)
         {
            for each (item in this.secondaryData)
            {
               item.sourceIs8P = false;
               allData.push(item);
            }
         }
         if (mode == "search" || mode == "newest")
            allData.sortOn("time", Array.NUMERIC | Array.DESCENDING);
         if(allData.length > 0)
         {
            this.showCourses(allData);
         }
         else
         {
            this.showNoResultsPrompt();
         }
         this.loadingGraphic.visible = false;
         // reset flags for subsequent requests
         this.primaryLoaded = this.secondaryLoaded = false;
         this.primaryData = this.secondaryData = null;
      }
      
      // Allow subclasses to declare which sources they intend to use.
      protected function setDataSourcesUsed(primary:Boolean, secondary:Boolean) : *
      {
         this.usePrimary = primary;
         this.useSecondary = secondary;
         // If a source already completed, try to process now.
         this.processSourceResultsIfReady();
      }

      private function onSourceToggleChange(param1:Event) : void
      {
         Memory.memory[SOURCE_TOGGLE_MEMORY_KEY] = this.isUsingSecondarySource() ? 1 : 0;
         this.removeLevels();
         this.hideNoResultsPrompt();
         this.requestCourses();
      }

      protected function errorHandler(param1:Event) : *
      {
         this.loadingGraphic.visible = false;
      }
      
      protected function requestCourses() : *
      {
         this.hideNoResultsPrompt();
         var useSecondarySource:Boolean = this.isUsingSecondarySource();
         this.usePrimary = !useSecondarySource;
         this.useSecondary = useSecondarySource;
         this.primaryLoaded = !this.usePrimary;
         this.secondaryLoaded = !this.useSecondary;
         this.primaryData = null;
         this.secondaryData = null;
         var primaryURL:String = Main.levelsURL.substr(0,-7) + "/files/lists/" + this.mode + "/" + this.pageNum;
         var secondaryURL:String = Main.phLevelsURL.substr(0,-7) + "/files/lists/" + this.mode + "/" + this.pageNum;
         try
         {
            if(this.usePrimary)
            {
               this.superLoader.load(new URLRequest(primaryURL));
            }
            else
            {
               this.primaryLoaded = true;
            }
         }
         catch(err:Error)
         {
            this.primaryLoaded = true;
            this.primaryData = null;
         }
         try
         {
            if(this.useSecondary)
            {
               this.superLoader2.load(new URLRequest(secondaryURL));
            }
            else
            {
               this.secondaryLoaded = true;
            }
         }
         catch(err:Error)
         {
            this.secondaryLoaded = true;
            this.secondaryData = null;
         }
         this.processSourceResultsIfReady();
         this.loadingGraphic.visible = true;
      }

      protected function isUsingSecondarySource() : Boolean
      {
         return this.sourceToggle != null && this.sourceToggle.selected;
      }

      // Allow subclasses to adjust the visible toggle without triggering a reload.
      protected function setSourceToggleSelected(useSecondary:Boolean) : void
      {
         if(this.sourceToggle == null)
         {
            return;
         }
         this.sourceToggle.removeEventListener(Event.CHANGE,this.onSourceToggleChange);
         this.sourceToggle.selected = useSecondary;
         this.sourceToggle.addEventListener(Event.CHANGE,this.onSourceToggleChange,false,0,true);
      }
      
      public function getPageNum() : *
      {
         return this.pageNum;
      }
      
      public function setPageNum(param1:int) : *
      {
         this.pageNum = param1;
         Memory.memory["coursePageNum" + this.mode] = this.pageNum;
         this.removeLevels();
         this.requestCourses();
      }
      
      public function addPageHighlight(param1:Array) : *
      {
         if(this.mode !== "search" && this.mode !== "favorites")
         {
            this.pageNavigation.addPageHighlight(param1[0]);
         }
      }
      
      public function removePageHighlight(param1:Array) : *
      {
         if(this.mode !== "search" && this.mode !== "favorites")
         {
            this.pageNavigation.removePageHighlight(param1[0]);
         }
      }
      
      private function testLevelAccess(param1:Event) : *
      {
         var _loc2_:String = null;
         for(_loc2_ in this.levels)
         {
            this.levels[_loc2_].testAccess();
         }
      }

      private function showNoResultsPrompt() : void
      {
         this.hideNoResultsPrompt();
         this.noResultsPrompt = new Sprite();
         var msg:TextField = new TextField();
         msg.defaultTextFormat = new TextFormat("Arial",12,0,false);
         msg.autoSize = TextFieldAutoSize.LEFT;
         msg.selectable = false;
         msg.textColor = 0;
         msg.text = "No levels from " + this.currentSourceName() + ".";
         var action:Button = new Button();
         action.label = "Switch to " + this.otherSourceName();
         action.useHandCursor = true;
         action.addEventListener(MouseEvent.CLICK,this.onNoResultsSwitchClick,false,0,true);
         msg.x = 0;
         msg.y = 0;
         action.y = msg.height + 8;
         this.noResultsPrompt.addChild(msg);
         this.noResultsPrompt.addChild(action);
         var contentWidth:Number = Math.max(msg.width, action.width);
         msg.x = (contentWidth - msg.width) / 2;
         action.x = (contentWidth - action.width) / 2;
         this.noResultsAction = action;
         addChild(this.noResultsPrompt);
         this.centerNoResultsPrompt();
      }

      private function hideNoResultsPrompt() : void
      {
         if(this.noResultsPrompt != null)
         {
            if(this.noResultsAction != null)
            {
               this.noResultsAction.removeEventListener(MouseEvent.CLICK,this.onNoResultsSwitchClick);
               this.noResultsAction = null;
            }
            if(this.noResultsPrompt.parent != null)
            {
               this.noResultsPrompt.parent.removeChild(this.noResultsPrompt);
            }
            this.noResultsPrompt = null;
         }
      }

      private function centerNoResultsPrompt() : void
      {
         if(this.noResultsPrompt == null)
         {
            return;
         }
         var promptWidth:Number = this.noResultsPrompt.width;
         var promptHeight:Number = this.noResultsPrompt.height;
         var stageW:Number = Main.stage != null ? Main.stage.stageWidth : 550;
         var stageH:Number = Main.stage != null ? Main.stage.stageHeight : 400;
         this.noResultsPrompt.x = 165 - (promptWidth / 2);
         this.noResultsPrompt.y = 180 - (promptHeight / 2);
      }

      private function onNoResultsSwitchClick(param1:MouseEvent) : void
      {
         if(this.sourceToggle != null)
         {
            this.sourceToggle.selected = !this.sourceToggle.selected;
            this.centerNoResultsPrompt();
         }
         else
         {
            this.useSecondary = !this.useSecondary;
            this.usePrimary = !this.useSecondary;
            this.removeLevels();
            this.requestCourses();
         }
      }

      private function currentSourceName() : String
      {
         return this.isUsingSecondarySource() ? "PR2Hub" : "8P";
      }

      private function otherSourceName() : String
      {
         return this.isUsingSecondarySource() ? "8P" : "PR2Hub";
      }
      
      public function refreshHighlights() : *
      {
         Main.socket.write("refresh_highlights`");
      }
      
      protected function removeLevels() : *
      {
         var _loc1_:LevelItem = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.levelArray.length)
         {
            _loc1_ = this.levelArray[_loc2_];
            _loc1_.remove();
            _loc2_++;
         }
         this.levelArray = new Array();
         this.levels = new Object();
      }
      
      override public function remove() : *
      {
         removeEventListener("testLevelAccess",this.testLevelAccess);
         if(this.sourceToggle != null)
         {
            this.sourceToggle.removeEventListener(Event.CHANGE,this.onSourceToggleChange);
            if(this.sourceToggle.parent != null)
            {
               this.sourceToggle.parent.removeChild(this.sourceToggle);
            }
            this.sourceToggle.dispose();
            this.sourceToggle = null;
         }
         this.hideNoResultsPrompt();
         // remove both loaders/listeners if present
         if(this.superLoader != null)
         {
            try
            {
               this.superLoader.removeEventListener(Event.COMPLETE,this.loadHandler);
               this.superLoader.removeEventListener(SuperLoader.e,this.sourceLoadError);
            }
            catch(err:Error) {}
            this.superLoader.remove();
            this.superLoader = null;
         }
         if(this.superLoader2 != null)
         {
            try
            {
               this.superLoader2.removeEventListener(Event.COMPLETE,this.loadHandler);
               this.superLoader2.removeEventListener(SuperLoader.e,this.sourceLoadError);
            }
            catch(err:Error) {}
            this.superLoader2.remove();
            this.superLoader2 = null;
         }
         this.pageNavigation.remove();
         this.removeLevels();
         this.loadingGraphic = null;
         clearTimeout(this.var_280);
         super.remove();
      }
   }
}
