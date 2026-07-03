package
{
   import fl.controls.Button;
   import fl.controls.ComboBox;
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
   
   public dynamic class ServerSelectPopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var login_bt:Button;
      
      public var reload_bt:SimpleButton;
      
      public var serverSelect:ComboBox;
      
      public var userSelect:ComboBox;
      
      public var user_del_bt:SimpleButton;
      
      public function ServerSelectPopupGraphic()
      {
         super();
         this.__setProp_login_bt_LoggedInPopup_Layer3_0();
         this.__setProp_cancel_bt_LoggedInPopup_Layer2_0();
         this.__setProp_serverSelect_LoggedInPopup_Layer2_0();
         this.__setProp_userSelect_LoggedInPopup_Layer2_0();
      }
      
      internal function __setProp_login_bt_LoggedInPopup_Layer3_0() : *
      {
         try
         {
            this.login_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.login_bt.emphasized = false;
         this.login_bt.enabled = true;
         this.login_bt.label = "Log In";
         this.login_bt.labelPlacement = "right";
         this.login_bt.selected = false;
         this.login_bt.toggle = false;
         this.login_bt.visible = true;
         try
         {
            this.login_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_LoggedInPopup_Layer2_0() : *
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
      
      internal function __setProp_serverSelect_LoggedInPopup_Layer2_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.serverSelect["componentInspectorSetting"] = true;
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
         this.serverSelect.dataProvider = _loc1_;
         this.serverSelect.editable = false;
         this.serverSelect.enabled = false;
         this.serverSelect.prompt = "Loading...";
         this.serverSelect.restrict = "";
         this.serverSelect.rowCount = 5;
         this.serverSelect.visible = true;
         try
         {
            this.serverSelect["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_userSelect_LoggedInPopup_Layer2_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.userSelect["componentInspectorSetting"] = true;
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
         this.userSelect.dataProvider = _loc1_;
         this.userSelect.editable = false;
         this.userSelect.enabled = false;
         this.userSelect.prompt = "Guest";
         this.userSelect.restrict = "";
         this.userSelect.rowCount = 5;
         this.userSelect.visible = true;
         try
         {
            this.userSelect["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
