package
{
   import PR2_Graphics_1_Apr_2014_fla.buttonGlowAnim_182;
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
   
   public dynamic class QuitButtonGraphic extends MovieClip
   {
       
      
      public var glow:buttonGlowAnim_182;
      
      public var quit_bt:Button;
      
      public function QuitButtonGraphic()
      {
         super();
         this.__setProp_quit_bt_QuitButton_Layer1_0();
      }
      
      internal function __setProp_quit_bt_QuitButton_Layer1_0() : *
      {
         try
         {
            this.quit_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.quit_bt.emphasized = false;
         this.quit_bt.enabled = true;
         this.quit_bt.label = "Quit";
         this.quit_bt.labelPlacement = "right";
         this.quit_bt.selected = false;
         this.quit_bt.toggle = false;
         this.quit_bt.visible = true;
         try
         {
            this.quit_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
