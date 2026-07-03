package
{
   import fl.controls.Button;
   import fl.controls.CheckBox;
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
   
   public dynamic class PlaceArtifactGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var daySel:ComboBox;
      
      public var hourBox:TextInput;
      
      public var meridSel:ComboBox;
      
      public var minBox:TextInput;
      
      public var monthSel:ComboBox;
      
      public var now_chk:CheckBox;
      
      public var place_bt:Button;
      
      public var yearSel:ComboBox;
      
      public function PlaceArtifactGraphic()
      {
         super();
         this.__setProp_place_bt_PlaceArtifact_buttons_0();
         this.__setProp_cancel_bt_PlaceArtifact_buttons_0();
         this.__setProp_monthSel_PlaceArtifact_selections_0();
         this.__setProp_daySel_PlaceArtifact_selections_0();
         this.__setProp_yearSel_PlaceArtifact_selections_0();
         this.__setProp_hourBox_PlaceArtifact_selections_0();
         this.__setProp_minBox_PlaceArtifact_selections_0();
         this.__setProp_meridSel_PlaceArtifact_selections_0();
         this.__setProp_now_chk_PlaceArtifact_selections_0();
      }
      
      internal function __setProp_place_bt_PlaceArtifact_buttons_0() : *
      {
         try
         {
            this.place_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.place_bt.emphasized = false;
         this.place_bt.enabled = true;
         this.place_bt.label = "Place";
         this.place_bt.labelPlacement = "right";
         this.place_bt.selected = false;
         this.place_bt.toggle = false;
         this.place_bt.visible = true;
         try
         {
            this.place_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_PlaceArtifact_buttons_0() : *
      {
         try
         {
            this.cancel_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.cancel_bt.emphasized = false;
         this.cancel_bt.enabled = true;
         this.cancel_bt.label = "Cancel";
         this.cancel_bt.labelPlacement = "right";
         this.cancel_bt.selected = false;
         this.cancel_bt.toggle = false;
         this.cancel_bt.visible = true;
         try
         {
            this.cancel_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_monthSel_PlaceArtifact_selections_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.monthSel["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         var _loc1_:DataProvider = new DataProvider();
         _loc3_ = [{
            "label":"Jan",
            "data":0
         },{
            "label":"Feb",
            "data":1
         },{
            "label":"Mar",
            "data":2
         },{
            "label":"Apr",
            "data":3
         },{
            "label":"May",
            "data":4
         },{
            "label":"Jun",
            "data":5
         },{
            "label":"Jul",
            "data":6
         },{
            "label":"Aug",
            "data":7
         },{
            "label":"Sep",
            "data":8
         },{
            "label":"Oct",
            "data":9
         },{
            "label":"Nov",
            "data":10
         },{
            "label":"Dec",
            "data":11
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
         this.monthSel.dataProvider = _loc1_;
         this.monthSel.editable = false;
         this.monthSel.enabled = true;
         this.monthSel.prompt = "Month";
         this.monthSel.restrict = "";
         this.monthSel.rowCount = 5;
         this.monthSel.visible = true;
         try
         {
            this.monthSel["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_daySel_PlaceArtifact_selections_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.daySel["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         var _loc1_:DataProvider = new DataProvider();
         _loc3_ = [];
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
         this.daySel.dataProvider = _loc1_;
         this.daySel.editable = false;
         this.daySel.enabled = true;
         this.daySel.prompt = "Day";
         this.daySel.restrict = "";
         this.daySel.rowCount = 5;
         this.daySel.visible = true;
         try
         {
            this.daySel["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_yearSel_PlaceArtifact_selections_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.yearSel["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         var _loc1_:DataProvider = new DataProvider();
         _loc3_ = [];
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
         this.yearSel.dataProvider = _loc1_;
         this.yearSel.editable = false;
         this.yearSel.enabled = true;
         this.yearSel.prompt = "Year";
         this.yearSel.restrict = "";
         this.yearSel.rowCount = 5;
         this.yearSel.visible = true;
         try
         {
            this.yearSel["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_hourBox_PlaceArtifact_selections_0() : *
      {
         try
         {
            this.hourBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.hourBox.displayAsPassword = false;
         this.hourBox.editable = true;
         this.hourBox.enabled = true;
         this.hourBox.maxChars = 2;
         this.hourBox.restrict = "0-9";
         this.hourBox.text = "";
         this.hourBox.visible = true;
         try
         {
            this.hourBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_minBox_PlaceArtifact_selections_0() : *
      {
         try
         {
            this.minBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.minBox.displayAsPassword = false;
         this.minBox.editable = true;
         this.minBox.enabled = true;
         this.minBox.maxChars = 2;
         this.minBox.restrict = "0-9";
         this.minBox.text = "";
         this.minBox.visible = true;
         try
         {
            this.minBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_meridSel_PlaceArtifact_selections_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.meridSel["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         var _loc1_:DataProvider = new DataProvider();
         _loc3_ = [{
            "label":"AM",
            "data":0
         },{
            "label":"PM",
            "data":1
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
         this.meridSel.dataProvider = _loc1_;
         this.meridSel.editable = false;
         this.meridSel.enabled = true;
         this.meridSel.prompt = "";
         this.meridSel.restrict = "";
         this.meridSel.rowCount = 5;
         this.meridSel.visible = true;
         try
         {
            this.meridSel["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_now_chk_PlaceArtifact_selections_0() : *
      {
         try
         {
            this.now_chk["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.now_chk.enabled = true;
         this.now_chk.label = "Place Now";
         this.now_chk.labelPlacement = "right";
         this.now_chk.selected = false;
         this.now_chk.visible = true;
         try
         {
            this.now_chk["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
