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
   
   public dynamic class CourseMenuGraphic extends MovieClip
   {
       
      
      public var cancel_bt:Button;
      
      public var play_bt:Button;
      
      public var textBox:TextField;
      
      public function CourseMenuGraphic()
      {
         super();
         this.__setProp_play_bt_Symbol1371_Layer2_0();
         this.__setProp_cancel_bt_Symbol1371_Layer1_0();
      }
      
      internal function __setProp_play_bt_Symbol1371_Layer2_0() : *
      {
         try
         {
            this.play_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.play_bt.emphasized = false;
         this.play_bt.enabled = true;
         this.play_bt.label = "Play";
         this.play_bt.labelPlacement = "right";
         this.play_bt.selected = false;
         this.play_bt.toggle = false;
         this.play_bt.visible = true;
         try
         {
            this.play_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cancel_bt_Symbol1371_Layer1_0() : *
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
