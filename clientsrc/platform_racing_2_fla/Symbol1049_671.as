package platform_racing_2_fla
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
   
   public dynamic class Symbol1049_671 extends MovieClip
   {
       
      
      public var activeBox:TextField;
      
      public var followButton:Button;
      
      public var friendButton:Button;
      
      public var groupBox:TextField;
      
      public var guildBox:TextField;
      
      public var hatBox:TextField;
      
      public var hofIcon:MovieClip;
      
      public var ignoreButton:Button;
      
      public var inviteButton:SimpleButton;
      
      public var kickBg:ShadowBG;
      
      public var kickButton:SimpleButton;
      
      public var levelsButton:Button;
      
      public var messageButton:ReplyMessageButtonGraphic;
      
      public var rankBox:TextField;
      
      public var registerBox:TextField;
      
      public var statusBox:TextField;
      
      public var supplBg:ShadowBG;
      
      public var supplText:TextField;
      
      public var verifiedIcon:MovieClip;
      
      public function Symbol1049_671()
      {
         super();
         this.__setProp_followButton_Symbol1049_Layer14_0();
         this.__setProp_friendButton_Symbol1049_Layer13_0();
         this.__setProp_ignoreButton_Symbol1049_Layer12_0();
         this.__setProp_levelsButton_Symbol1049_Layer11_0();
      }
      
      internal function __setProp_followButton_Symbol1049_Layer14_0() : *
      {
         try
         {
            this.followButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.followButton.emphasized = false;
         this.followButton.enabled = true;
         this.followButton.label = "Follow";
         this.followButton.labelPlacement = "right";
         this.followButton.selected = false;
         this.followButton.toggle = false;
         this.followButton.visible = true;
         try
         {
            this.followButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_friendButton_Symbol1049_Layer13_0() : *
      {
         try
         {
            this.friendButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.friendButton.emphasized = false;
         this.friendButton.enabled = true;
         this.friendButton.label = "Add to Friends";
         this.friendButton.labelPlacement = "right";
         this.friendButton.selected = false;
         this.friendButton.toggle = false;
         this.friendButton.visible = true;
         try
         {
            this.friendButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_ignoreButton_Symbol1049_Layer12_0() : *
      {
         try
         {
            this.ignoreButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.ignoreButton.emphasized = false;
         this.ignoreButton.enabled = true;
         this.ignoreButton.label = "Ignore";
         this.ignoreButton.labelPlacement = "right";
         this.ignoreButton.selected = false;
         this.ignoreButton.toggle = false;
         this.ignoreButton.visible = true;
         try
         {
            this.ignoreButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_levelsButton_Symbol1049_Layer11_0() : *
      {
         try
         {
            this.levelsButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.levelsButton.emphasized = false;
         this.levelsButton.enabled = true;
         this.levelsButton.label = "View Levels";
         this.levelsButton.labelPlacement = "right";
         this.levelsButton.selected = false;
         this.levelsButton.toggle = false;
         this.levelsButton.visible = true;
         try
         {
            this.levelsButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
