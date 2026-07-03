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
   
   public dynamic class LoginPopupGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var dropdown:ComboBox;
      
      public var forgotPass:SimpleButton;
      
      public var login_bt:Button;
      
      public var nameBox:TextInput;
      
      public var passBox:TextInput;
      
      public var reload_bt:SimpleButton;
      
      public var rememberMe_chk:CheckBox;
      
      public function LoginPopupGraphic()
      {
         super();
         this.__setProp_rememberMe_chk_LoginPopup_Layer10_0();
         this.__setProp_login_bt_LoginPopup_Layer6_0();
         this.__setProp_nameBox_LoginPopup_Layer5_0();
         this.__setProp_passBox_LoginPopup_Layer4_0();
         this.__setProp_dropdown_LoginPopup_Layer4_0();
         this.__setProp_cancel_bt_LoginPopup_Layer3_0();
      }
      
      internal function __setProp_rememberMe_chk_LoginPopup_Layer10_0() : *
      {
         try
         {
            this.rememberMe_chk["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.rememberMe_chk.enabled = true;
         this.rememberMe_chk.label = "Remember Me";
         this.rememberMe_chk.labelPlacement = "right";
         this.rememberMe_chk.selected = false;
         this.rememberMe_chk.visible = true;
         try
         {
            this.rememberMe_chk["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_login_bt_LoginPopup_Layer6_0() : *
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
      
      internal function __setProp_nameBox_LoginPopup_Layer5_0() : *
      {
         try
         {
            this.nameBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.nameBox.displayAsPassword = false;
         this.nameBox.editable = true;
         this.nameBox.enabled = true;
         this.nameBox.maxChars = 20;
         this.nameBox.restrict = "";
         this.nameBox.text = "";
         this.nameBox.visible = true;
         try
         {
            this.nameBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_passBox_LoginPopup_Layer4_0() : *
      {
         try
         {
            this.passBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.passBox.displayAsPassword = true;
         this.passBox.editable = true;
         this.passBox.enabled = true;
         this.passBox.maxChars = 0;
         this.passBox.restrict = "";
         this.passBox.text = "";
         this.passBox.visible = true;
         try
         {
            this.passBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_dropdown_LoginPopup_Layer4_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.dropdown["componentInspectorSetting"] = true;
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
         this.dropdown.dataProvider = _loc1_;
         this.dropdown.editable = false;
         this.dropdown.enabled = false;
         this.dropdown.prompt = "Loading...";
         this.dropdown.restrict = "";
         this.dropdown.rowCount = 5;
         this.dropdown.visible = true;
         try
         {
            this.dropdown["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_LoginPopup_Layer3_0() : *
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
   }
}
