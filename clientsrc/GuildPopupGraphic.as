package
{
   import fl.controls.Button;
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
   
   public dynamic class GuildPopupGraphic extends MovieClip
   {
       
      
      public var close_bt:Button;
      
      public var delete_bt:SimpleButton;
      
      public var edit_bt:SimpleButton;
      
      public var gpTodayBox:TextField;
      
      public var gpTotalBox:TextField;
      
      public var guildProse:TextField;
      
      public var listCover:MovieClip;
      
      public var loadingGraphic:LoadingGraphic;
      
      public var membersCount:TextField;
      
      public var membersHolder:MovieClip;
      
      public var messageButton:Button;
      
      public var shadow:ShadowBG;
      
      public var titleBox:TextField;
      
      public var __setPropDict:Dictionary;
      
      public var __lastFrameProp:int = -1;
      
      public function GuildPopupGraphic()
      {
         this.__setPropDict = new Dictionary(true);
         super();
         this.__setProp_close_bt_Symbol1035_Buttons_0();
         addEventListener(Event.FRAME_CONSTRUCTED,this.__setProp_handler,false,0,true);
      }
      
      internal function __setProp_close_bt_Symbol1035_Buttons_0() : *
      {
         try
         {
            this.close_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.close_bt.emphasized = false;
         this.close_bt.enabled = true;
         this.close_bt.label = "Close";
         this.close_bt.labelPlacement = "right";
         this.close_bt.selected = false;
         this.close_bt.toggle = false;
         this.close_bt.visible = true;
         try
         {
            this.close_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_messageButton_Symbol1035_Buttons_10(param1:int) : *
      {
         if(this.messageButton != null && param1 >= 11 && param1 <= 16 && (this.__setPropDict[this.messageButton] == undefined || !(int(this.__setPropDict[this.messageButton]) >= 11 && int(this.__setPropDict[this.messageButton]) <= 16)))
         {
            this.__setPropDict[this.messageButton] = param1;
            try
            {
               this.messageButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.messageButton.emphasized = false;
            this.messageButton.enabled = true;
            this.messageButton.label = "PM Everyone";
            this.messageButton.labelPlacement = "right";
            this.messageButton.selected = false;
            this.messageButton.toggle = false;
            this.messageButton.visible = true;
            try
            {
               this.messageButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function __setProp_handler(param1:Object) : *
      {
         var _loc2_:int = currentFrame;
         if(this.__lastFrameProp == _loc2_)
         {
            return;
         }
         this.__lastFrameProp = _loc2_;
         this.__setProp_messageButton_Symbol1035_Buttons_10(_loc2_);
      }
   }
}
