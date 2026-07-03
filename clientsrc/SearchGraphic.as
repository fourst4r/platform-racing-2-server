package
{
   import fl.controls.Button;
   import fl.controls.ComboBox;
   import fl.controls.TextInput;
   import fl.data.DataProvider;
   import fl.data.SimpleCollectionItem;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public dynamic class SearchGraphic extends MovieClip
   {
       
      
      public var dir_cb:ComboBox;
      
      public var mode_cb:ComboBox;
      
      public var order_cb:ComboBox;
      
      public var searchBox:TextInput;
      
      public var search_bt:Button;
      
      public function SearchGraphic()
      {
         super();
         this.__setProp_mode_cb_SearchOptions_Layer7_0();
         this.__setProp_order_cb_SearchOptions_Layer4_0();
         this.__setProp_searchBox_SearchOptions_Layer3_0();
         this.__setProp_search_bt_SearchOptions_Layer2_0();
         this.__setProp_dir_cb_SearchOptions_Layer1_0();
      }
      
      internal function __setProp_mode_cb_SearchOptions_Layer7_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.mode_cb["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         var _loc1_:DataProvider = new DataProvider();
         _loc3_ = [{
            "label":"User Name",
            "data":"user"
         },{
            "label":"Level Title",
            "data":"title"
         },{
            "label":"Level ID",
            "data":"id"
         }];
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc2_ = new SimpleCollectionItem();
            _loc4_ = _loc3_[_loc5_];
            for(_loc6_ in _loc4_)
            {
               _loc2_[_loc6_] = _loc4_[_loc6_];
            }
            _loc1_.addItem(_loc2_);
            _loc5_++;
         }
         this.mode_cb.dataProvider = _loc1_;
         this.mode_cb.editable = false;
         this.mode_cb.enabled = true;
         this.mode_cb.prompt = "";
         this.mode_cb.restrict = "";
         this.mode_cb.rowCount = 5;
         this.mode_cb.visible = true;
         try
         {
            this.mode_cb["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_order_cb_SearchOptions_Layer4_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.order_cb["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         var _loc1_:DataProvider = new DataProvider();
         _loc3_ = [{
            "label":"Date",
            "data":"date"
         },{
            "label":"Alphabetical",
            "data":"alphabetical"
         },{
            "label":"Rating",
            "data":"rating"
         },{
            "label":"Popularity",
            "data":"popularity"
         }];
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc2_ = new SimpleCollectionItem();
            _loc4_ = _loc3_[_loc5_];
            for(_loc6_ in _loc4_)
            {
               _loc2_[_loc6_] = _loc4_[_loc6_];
            }
            _loc1_.addItem(_loc2_);
            _loc5_++;
         }
         this.order_cb.dataProvider = _loc1_;
         this.order_cb.editable = false;
         this.order_cb.enabled = true;
         this.order_cb.prompt = "";
         this.order_cb.restrict = "";
         this.order_cb.rowCount = 5;
         this.order_cb.visible = true;
         try
         {
            this.order_cb["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_searchBox_SearchOptions_Layer3_0() : *
      {
         try
         {
            this.searchBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.searchBox.displayAsPassword = false;
         this.searchBox.editable = true;
         this.searchBox.enabled = true;
         this.searchBox.maxChars = 50;
         this.searchBox.restrict = "";
         this.searchBox.text = "";
         this.searchBox.visible = true;
         try
         {
            this.searchBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_search_bt_SearchOptions_Layer2_0() : *
      {
         try
         {
            this.search_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.search_bt.emphasized = false;
         this.search_bt.enabled = true;
         this.search_bt.label = "Search";
         this.search_bt.labelPlacement = "right";
         this.search_bt.selected = false;
         this.search_bt.toggle = false;
         this.search_bt.visible = true;
         try
         {
            this.search_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_dir_cb_SearchOptions_Layer1_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.dir_cb["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         var _loc1_:DataProvider = new DataProvider();
         _loc3_ = [{
            "label":"Descending",
            "data":"desc"
         },{
            "label":"Ascending",
            "data":"asc"
         }];
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc2_ = new SimpleCollectionItem();
            _loc4_ = _loc3_[_loc5_];
            for(_loc6_ in _loc4_)
            {
               _loc2_[_loc6_] = _loc4_[_loc6_];
            }
            _loc1_.addItem(_loc2_);
            _loc5_++;
         }
         this.dir_cb.dataProvider = _loc1_;
         this.dir_cb.editable = false;
         this.dir_cb.enabled = true;
         this.dir_cb.prompt = "";
         this.dir_cb.restrict = "";
         this.dir_cb.rowCount = 5;
         this.dir_cb.visible = true;
         try
         {
            this.dir_cb["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
