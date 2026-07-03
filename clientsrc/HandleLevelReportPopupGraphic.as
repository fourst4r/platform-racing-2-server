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
   
   public dynamic class HandleLevelReportPopupGraphic extends MovieClip
   {
       
      
      public var archive_bt:Button;
      
      public var ban_bt:Button;
      
      public var cancel_bt:Button;
      
      public var duration:ComboBox;
      
      public var info_bt:InfoButton;
      
      public var otherReasonBox:TextInput;
      
      public var other_cancel_bt:SimpleButton;
      
      public var reason:ComboBox;
      
      public var titleBox:TextField;
      
      public function HandleLevelReportPopupGraphic()
      {
         super();
         this.__setProp_cancel_bt_HandleLevelReportPopup_dynamic_0();
         this.__setProp_archive_bt_HandleLevelReportPopup_dynamic_0();
         this.__setProp_duration_HandleLevelReportPopup_dynamic_0();
         this.__setProp_ban_bt_HandleLevelReportPopup_dynamic_0();
         this.__setProp_reason_HandleLevelReportPopup_dynamic_2_0();
      }
      
      internal function __setProp_cancel_bt_HandleLevelReportPopup_dynamic_0() : *
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
      
      internal function __setProp_archive_bt_HandleLevelReportPopup_dynamic_0() : *
      {
         try
         {
            this.archive_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.archive_bt.emphasized = false;
         this.archive_bt.enabled = true;
         this.archive_bt.label = "Archive";
         this.archive_bt.labelPlacement = "right";
         this.archive_bt.selected = false;
         this.archive_bt.toggle = false;
         this.archive_bt.visible = true;
         try
         {
            this.archive_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_duration_HandleLevelReportPopup_dynamic_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.duration["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         var _loc1_:DataProvider = new DataProvider();
         _loc3_ = [{
            "label":"Duration...",
            "data":""
         },{
            "label":"One Hour",
            "data":3600
         },{
            "label":"One Day",
            "data":86400
         },{
            "label":"Three Days",
            "data":259200
         },{
            "label":"One Week",
            "data":604800
         },{
            "label":"Two Weeks",
            "data":1209600
         },{
            "label":"One Month",
            "data":2592000
         },{
            "label":"Six Months",
            "data":15768000
         },{
            "label":"One Year",
            "data":31536000
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
         this.duration.dataProvider = _loc1_;
         this.duration.editable = false;
         this.duration.enabled = true;
         this.duration.prompt = "";
         this.duration.restrict = "";
         this.duration.rowCount = 5;
         this.duration.visible = true;
         try
         {
            this.duration["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_ban_bt_HandleLevelReportPopup_dynamic_0() : *
      {
         try
         {
            this.ban_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.ban_bt.emphasized = false;
         this.ban_bt.enabled = true;
         this.ban_bt.label = "Ban";
         this.ban_bt.labelPlacement = "right";
         this.ban_bt.selected = false;
         this.ban_bt.toggle = false;
         this.ban_bt.visible = true;
         try
         {
            this.ban_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_reason_HandleLevelReportPopup_dynamic_2_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.reason["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         var _loc1_:DataProvider = new DataProvider();
         _loc3_ = [{
            "label":"Reason...",
            "data":""
         },{
            "label":"Vulgar Language",
            "data":"Vulgar Language"
         },{
            "label":"Harassment",
            "data":"Harassment"
         },{
            "label":"Sensitive Imagery",
            "data":"Sensitive Imagery"
         },{
            "label":"Scamming",
            "data":"Scamming"
         },{
            "label":"Copying (w/o attrib)",
            "data":"Copying (w/o attrib)"
         },{
            "label":"Republished Removed Level",
            "data":"Republished Removed Level"
         },{
            "label":"Other...",
            "data":""
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
         this.reason.dataProvider = _loc1_;
         this.reason.editable = false;
         this.reason.enabled = true;
         this.reason.prompt = "";
         this.reason.restrict = "";
         this.reason.rowCount = 5;
         this.reason.visible = true;
         try
         {
            this.reason["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
