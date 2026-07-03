package
{
   import fl.controls.Button;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.utils.*;
   
   public dynamic class LobbyBottomButtonsGraphic extends MovieClip
   {
       
      
      public var __setPropDict:Dictionary;
      
      public var __lastFrameProp:int = -1;
      
      public var creditsButton:Button;
      
      public var levelEditorButton:Button;
      
      public var logoutButton:Button;
      
      public var moreGamesButton:MovieClip;
      
      public var optionsButton:Button;
      
      public var vaultButton:MovieClip;
      
      public var var_17:Dictionary;
      
      public var var_284:int = -1;
      
      public function LobbyBottomButtonsGraphic()
      {
         this.__setPropDict = new Dictionary(true);
         this.var_17 = new Dictionary(true);
         super();
         addEventListener(Event.FRAME_CONSTRUCTED,this.method_173,false,0,true);
         addEventListener(Event.FRAME_CONSTRUCTED,this.__setProp_handler,false,0,true);
      }
      
      internal function method_781(param1:int) : *
      {
         if(this.logoutButton != null && param1 >= 2 && param1 <= 31 && (this.var_17[this.logoutButton] == undefined || int(this.var_17[this.logoutButton]) < 2) && int(this.var_17[this.logoutButton]) <= 31)
         {
            this.var_17[this.logoutButton] = param1;
            try
            {
               this.logoutButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.logoutButton.emphasized = false;
            this.logoutButton.enabled = true;
            this.logoutButton.label = "Logout";
            this.logoutButton.labelPlacement = "right";
            this.logoutButton.selected = false;
            this.logoutButton.toggle = false;
            this.logoutButton.visible = true;
            try
            {
               this.logoutButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function method_762(param1:int) : *
      {
         if(this.levelEditorButton != null && param1 >= 2 && param1 <= 31 && (this.var_17[this.levelEditorButton] == undefined || int(this.var_17[this.levelEditorButton]) < 2) && int(this.var_17[this.levelEditorButton]) <= 31)
         {
            this.var_17[this.levelEditorButton] = param1;
            try
            {
               this.levelEditorButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.levelEditorButton.emphasized = false;
            this.levelEditorButton.enabled = true;
            this.levelEditorButton.label = "Level Editor";
            this.levelEditorButton.labelPlacement = "right";
            this.levelEditorButton.selected = false;
            this.levelEditorButton.toggle = false;
            this.levelEditorButton.visible = true;
            try
            {
               this.levelEditorButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function method_650(param1:int) : *
      {
         if(this.optionsButton != null && param1 >= 2 && param1 <= 31 && (this.var_17[this.optionsButton] == undefined || int(this.var_17[this.optionsButton]) < 2) && int(this.var_17[this.optionsButton]) <= 31)
         {
            this.var_17[this.optionsButton] = param1;
            try
            {
               this.optionsButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.optionsButton.emphasized = false;
            this.optionsButton.enabled = true;
            this.optionsButton.label = "Options";
            this.optionsButton.labelPlacement = "right";
            this.optionsButton.selected = false;
            this.optionsButton.toggle = false;
            this.optionsButton.visible = true;
            try
            {
               this.optionsButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function method_722(param1:int) : *
      {
         if(this.creditsButton != null && param1 >= 2 && param1 <= 31 && (this.var_17[this.creditsButton] == undefined || int(this.var_17[this.creditsButton]) < 2) && int(this.var_17[this.creditsButton]) <= 31)
         {
            this.var_17[this.creditsButton] = param1;
            try
            {
               this.creditsButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.creditsButton.emphasized = false;
            this.creditsButton.enabled = true;
            this.creditsButton.label = "Credits";
            this.creditsButton.labelPlacement = "right";
            this.creditsButton.selected = false;
            this.creditsButton.toggle = false;
            this.creditsButton.visible = true;
            try
            {
               this.creditsButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function method_173(param1:Object) : *
      {
         var _loc2_:int = currentFrame;
         if(this.var_284 == _loc2_)
         {
            return;
         }
         this.var_284 = _loc2_;
         this.logoutButton.label = "Logout";
         this.levelEditorButton.label = "Level Editor";
         this.optionsButton.label = "Options";
         this.creditsButton.label = "Credits";
         this.moreGamesButton.label = "";
         this.vaultButton.label = "";
      }
      
      internal function __setProp_logoutButton_LobbyBottom_Layer7_1(param1:int) : *
      {
         if(this.logoutButton != null && param1 >= 2 && param1 <= 31 && (this.__setPropDict[this.logoutButton] == undefined || !(int(this.__setPropDict[this.logoutButton]) >= 2 && int(this.__setPropDict[this.logoutButton]) <= 31)))
         {
            this.__setPropDict[this.logoutButton] = param1;
            try
            {
               this.logoutButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.logoutButton.emphasized = false;
            this.logoutButton.enabled = true;
            this.logoutButton.label = "Logout";
            this.logoutButton.labelPlacement = "right";
            this.logoutButton.selected = false;
            this.logoutButton.toggle = false;
            this.logoutButton.visible = true;
            try
            {
               this.logoutButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function __setProp_levelEditorButton_LobbyBottom_Layer6_1(param1:int) : *
      {
         if(this.levelEditorButton != null && param1 >= 2 && param1 <= 31 && (this.__setPropDict[this.levelEditorButton] == undefined || !(int(this.__setPropDict[this.levelEditorButton]) >= 2 && int(this.__setPropDict[this.levelEditorButton]) <= 31)))
         {
            this.__setPropDict[this.levelEditorButton] = param1;
            try
            {
               this.levelEditorButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.levelEditorButton.emphasized = false;
            this.levelEditorButton.enabled = true;
            this.levelEditorButton.label = "Level Editor";
            this.levelEditorButton.labelPlacement = "right";
            this.levelEditorButton.selected = false;
            this.levelEditorButton.toggle = false;
            this.levelEditorButton.visible = true;
            try
            {
               this.levelEditorButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function __setProp_optionsButton_LobbyBottom_Layer5_1(param1:int) : *
      {
         if(this.optionsButton != null && param1 >= 2 && param1 <= 31 && (this.__setPropDict[this.optionsButton] == undefined || !(int(this.__setPropDict[this.optionsButton]) >= 2 && int(this.__setPropDict[this.optionsButton]) <= 31)))
         {
            this.__setPropDict[this.optionsButton] = param1;
            try
            {
               this.optionsButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.optionsButton.emphasized = false;
            this.optionsButton.enabled = true;
            this.optionsButton.label = "Options";
            this.optionsButton.labelPlacement = "right";
            this.optionsButton.selected = false;
            this.optionsButton.toggle = false;
            this.optionsButton.visible = true;
            try
            {
               this.optionsButton["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      internal function __setProp_creditsButton_LobbyBottom_Layer3_1(param1:int) : *
      {
         if(this.creditsButton != null && param1 >= 2 && param1 <= 31 && (this.__setPropDict[this.creditsButton] == undefined || !(int(this.__setPropDict[this.creditsButton]) >= 2 && int(this.__setPropDict[this.creditsButton]) <= 31)))
         {
            this.__setPropDict[this.creditsButton] = param1;
            try
            {
               this.creditsButton["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.creditsButton.emphasized = false;
            this.creditsButton.enabled = true;
            this.creditsButton.label = "Credits";
            this.creditsButton.labelPlacement = "right";
            this.creditsButton.selected = false;
            this.creditsButton.toggle = false;
            this.creditsButton.visible = true;
            try
            {
               this.creditsButton["componentInspectorSetting"] = false;
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
         this.__setProp_logoutButton_LobbyBottom_Layer7_1(_loc2_);
         this.__setProp_levelEditorButton_LobbyBottom_Layer6_1(_loc2_);
         this.__setProp_optionsButton_LobbyBottom_Layer5_1(_loc2_);
         this.__setProp_creditsButton_LobbyBottom_Layer3_1(_loc2_);
      }
   }
}
