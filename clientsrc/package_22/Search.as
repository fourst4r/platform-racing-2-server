package package_22
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.*;
   
   public class Search extends LevelListing
   {
       
      
      private var m:SearchGraphic;
      
      private var memory:Object;
      
      private var var_421:uint;
      
      private var firstRun:Boolean = true;
      
      public function Search(param1:String = "", param2:String = "user")
      {
         this.m = new SearchGraphic();
         this.memory = Memory.memory;
         super();
         mode = "search";
         this.m.x = 36;
         this.m.y = 8;
         this.m.mode_cb.addEventListener(Event.CLOSE,this.focusStage,false,0,true);
         this.m.order_cb.addEventListener(Event.CLOSE,this.focusStage,false,0,true);
         this.m.dir_cb.addEventListener(Event.CLOSE,this.focusStage,false,0,true);
         this.m.search_bt.addEventListener(MouseEvent.CLICK,this.doSearch,false,0,true);
         this.m.searchBox.addEventListener(KeyboardEvent.KEY_DOWN,this.doSearch);
         class_10.addChild(this.m);
         loadingGraphic.visible = false;
         if(this.memory.searchStr != null)
         {
            this.m.searchBox.text = this.memory.searchStr;
            this.m.mode_cb.selectedIndex = this.memory.searchModeIndex;
            this.m.order_cb.selectedIndex = this.memory.searchOrderIndex;
            this.m.dir_cb.selectedIndex = this.memory.searchDirIndex;
            if(this.memory.searchStr != "")
            {
               this.var_421 = setTimeout(this.requestCourses,10);
            }
         }
         if(param1 != "")
         {
            this.m.searchBox.text = param1;
            this.setSearchMode(param2);
            this.var_421 = setTimeout(this.requestCourses,10);
         }
      }
      
      private function setSearchMode(param1:String = "user") : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.m.mode_cb.dataProvider.length)
         {
            if(this.m.mode_cb.dataProvider.getItemAt(_loc3_).data == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         this.m.mode_cb.selectedIndex = _loc2_;
      }
      
      override protected function requestCourses() : *
      {
         if(Data.trimWhitespace(this.m.searchBox.text) == "")
         {
            return;
         }
         if(this.m.mode_cb.selectedItem.data == "id" && pageNum > 1)
         {
            if(this.firstRun)
            {
               pageNavigation.setPageNum(1);
            }
            return;
         }
         this.firstRun = false;
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.search_str = this.m.searchBox.text;
         if(this.m.mode_cb.selectedItem != null)
         {
            _loc1_.mode = this.m.mode_cb.selectedItem.data;
         }
         if(this.m.order_cb.selectedItem != null)
         {
            _loc1_.order = this.m.order_cb.selectedItem.data;
         }
         if(this.m.dir_cb.selectedItem != null)
         {
            _loc1_.dir = this.m.dir_cb.selectedItem.data;
         }
         _loc1_.page = pageNum;
         
         var searchStr:String = Data.trimWhitespace(this.m.searchBox.text);
         var idSearch:Boolean = this.m.mode_cb.selectedItem.data == "id";
         var useSecondary:Boolean = this.isUsingSecondarySource();
         // QOL: If searching by lvl id, automatically choose source based on prefix
         if(idSearch)
         {
            if(searchStr.indexOf("8p_") == 0)
            {
               useSecondary = false;
            }
            else
            {
               useSecondary = true;
            }
            this.setSourceToggleSelected(useSecondary);
         }
         this.usePrimary = !useSecondary;
         this.useSecondary = useSecondary;
         this.primaryLoaded = !this.usePrimary;
         this.secondaryLoaded = !this.useSecondary;
         this.primaryData = null;
         this.secondaryData = null;

         var req1:URLRequest = new URLRequest(Main.levelsURL.substr(0,-7) + "/search_levels.php");
         req1.method = URLRequestMethod.POST;
         req1.data = _loc1_;
         var req2:URLRequest = new URLRequest(Main.phLevelsURL.substr(0,-7) + "/search_levels.php");
         req2.method = URLRequestMethod.POST;
         req2.data = _loc1_;

         if(this.usePrimary)
         {
            try
            {
               superLoader.load(req1);
            }
            catch(err1:Error)
            {
               this.primaryLoaded = true;
               this.primaryData = null;
            }
         }

         if(this.useSecondary)
         {
            try
            {
               superLoader2.load(req2);
            }
            catch(err2:Error)
            {
               this.secondaryLoaded = true;
               this.secondaryData = null;
            }
         }
         
         this.processSourceResultsIfReady();
         loadingGraphic.visible = true;
      }
      
      override protected function loadHandler(param1:Event) : *
      {
         super.loadHandler(param1);
         if(param1.target.data == "")
         {
         }
      }
      
      private function doSearch(param1:Event) : *
      {
         if(param1 is KeyboardEvent)
         {
            if(param1.keyCode !== 13)
            {
               return;
            }
            Main.stage.focus = Main.stage;
         }
         if(this.m.searchBox.text != "")
         {
            pageNavigation.setPageNum(1);
         }
      }
      
      private function focusStage(param1:Event) : *
      {
         Main.stage.focus = Main.stage;
      }
      
      override public function remove() : *
      {
         this.memory.searchStr = this.m.searchBox.text;
         this.memory.searchModeIndex = this.m.mode_cb.selectedIndex;
         this.memory.searchOrderIndex = this.m.order_cb.selectedIndex;
         this.memory.searchDirIndex = this.m.dir_cb.selectedIndex;
         clearTimeout(this.var_421);
         this.m.mode_cb.removeEventListener(Event.CLOSE,this.focusStage);
         this.m.order_cb.removeEventListener(Event.CLOSE,this.focusStage);
         this.m.dir_cb.removeEventListener(Event.CLOSE,this.focusStage);
         this.m.search_bt.removeEventListener(MouseEvent.CLICK,this.doSearch);
         this.m.searchBox.removeEventListener(KeyboardEvent.KEY_DOWN,this.doSearch);
         super.remove();
      }
   }
}
