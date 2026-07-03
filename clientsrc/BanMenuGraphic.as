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
   
   public dynamic class BanMenuGraphic extends MovieClip
   {
       
      
      public var banButton:Button;
      
      public var duration:ComboBox;
      
      public var kickButton:Button;
      
      public var reason:TextInput;
      
      public var scope:ComboBox;
      
      public var type:ComboBox;
      
      public var viewPriorsButton:SimpleButton;
      
      public var warning1Button:Button;
      
      public var warning2Button:Button;
      
      public var warning3Button:Button;
      
      public function BanMenuGraphic()
      {
         super();
         this.__setProp_banButton_BanMenu_Layer13_0();
         this.__setProp_type_BanMenu_Layer9_0();
         this.__setProp_scope_BanMenu_Layer9_0();
         this.__setProp_duration_BanMenu_Layer9_0();
         this.__setProp_reason_BanMenu_Layer6_0();
         this.__setProp_warning1Button_BanMenu_Layer3_0();
         this.__setProp_warning2Button_BanMenu_Layer2_0();
         this.__setProp_warning3Button_BanMenu_Layer1_0();
         this.__setProp_kickButton_BanMenu_Layer1_0();
      }
      
      internal function __setProp_banButton_BanMenu_Layer13_0() : *
      {
         try
         {
            this.banButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.banButton.emphasized = false;
         this.banButton.enabled = true;
         this.banButton.label = "Ban User";
         this.banButton.labelPlacement = "right";
         this.banButton.selected = false;
         this.banButton.toggle = false;
         this.banButton.visible = true;
         try
         {
            this.banButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_type_BanMenu_Layer9_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.type["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         var _loc1_:DataProvider = new DataProvider();
         _loc3_ = [{
            "label":"Both",
            "data":"both"
         },{
            "label":"Account Only",
            "data":"account"
         },{
            "label":"IP Only",
            "data":"ip"
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
         this.type.dataProvider = _loc1_;
         this.type.editable = false;
         this.type.enabled = true;
         this.type.prompt = "";
         this.type.restrict = "";
         this.type.rowCount = 5;
         this.type.visible = true;
         try
         {
            this.type["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_scope_BanMenu_Layer9_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.scope["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         var _loc1_:DataProvider = new DataProvider();
         _loc3_ = [{
            "label":"Social",
            "data":"social"
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
         this.scope.dataProvider = _loc1_;
         this.scope.editable = false;
         this.scope.enabled = false;
         this.scope.prompt = "";
         this.scope.restrict = "";
         this.scope.rowCount = 5;
         this.scope.visible = true;
         try
         {
            this.scope["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_duration_BanMenu_Layer9_0() : *
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
            "label":"Choose...",
            "data":""
         },{
            "label":"One Hour",
            "data":3600
         },{
            "label":"One Day",
            "data":86400
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
      
      internal function __setProp_reason_BanMenu_Layer6_0() : *
      {
         try
         {
            this.reason["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.reason.displayAsPassword = false;
         this.reason.editable = true;
         this.reason.enabled = true;
         this.reason.maxChars = 100;
         this.reason.restrict = "^`";
         this.reason.text = "";
         this.reason.visible = true;
         try
         {
            this.reason["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_warning1Button_BanMenu_Layer3_0() : *
      {
         try
         {
            this.warning1Button["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.warning1Button.emphasized = false;
         this.warning1Button.enabled = true;
         this.warning1Button.label = "Warning 1";
         this.warning1Button.labelPlacement = "right";
         this.warning1Button.selected = false;
         this.warning1Button.toggle = false;
         this.warning1Button.visible = true;
         try
         {
            this.warning1Button["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_warning2Button_BanMenu_Layer2_0() : *
      {
         try
         {
            this.warning2Button["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.warning2Button.emphasized = false;
         this.warning2Button.enabled = true;
         this.warning2Button.label = "Warning 2";
         this.warning2Button.labelPlacement = "right";
         this.warning2Button.selected = false;
         this.warning2Button.toggle = false;
         this.warning2Button.visible = true;
         try
         {
            this.warning2Button["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_warning3Button_BanMenu_Layer1_0() : *
      {
         try
         {
            this.warning3Button["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.warning3Button.emphasized = false;
         this.warning3Button.enabled = true;
         this.warning3Button.label = "Warning 3";
         this.warning3Button.labelPlacement = "right";
         this.warning3Button.selected = false;
         this.warning3Button.toggle = false;
         this.warning3Button.visible = true;
         try
         {
            this.warning3Button["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_kickButton_BanMenu_Layer1_0() : *
      {
         try
         {
            this.kickButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.kickButton.emphasized = false;
         this.kickButton.enabled = true;
         this.kickButton.label = "30 Minute Kick";
         this.kickButton.labelPlacement = "right";
         this.kickButton.selected = false;
         this.kickButton.toggle = false;
         this.kickButton.visible = true;
         try
         {
            this.kickButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
