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
   
   public dynamic class FinishedPageGraphic extends MovieClip
   {
       
      
      public var bonus1:TextField;
      
      public var bonus2:TextField;
      
      public var bonus3:TextField;
      
      public var bonus4:TextField;
      
      public var bonus5:TextField;
      
      public var close_bt:Button;
      
      public var exp1:TextField;
      
      public var exp2:TextField;
      
      public var exp3:TextField;
      
      public var exp4:TextField;
      
      public var exp5:TextField;
      
      public var expTotal:TextField;
      
      public var return_bt:Button;
      
      public function FinishedPageGraphic()
      {
         super();
         this.__setProp_return_bt_Symbol943_Layer3_0();
         this.__setProp_close_bt_Symbol943_Layer1_0();
      }
      
      internal function __setProp_return_bt_Symbol943_Layer3_0() : *
      {
         try
         {
            this.return_bt["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.return_bt.emphasized = false;
         this.return_bt.enabled = true;
         this.return_bt.label = "Return to Lobby";
         this.return_bt.labelPlacement = "right";
         this.return_bt.selected = false;
         this.return_bt.toggle = false;
         this.return_bt.visible = true;
         try
         {
            this.return_bt["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_close_bt_Symbol943_Layer1_0() : *
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
   }
}
