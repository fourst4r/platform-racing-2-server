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
   
   public dynamic class LevelEditorMenuGraphic extends MovieClip
   {
       
      
      public var bgButton:Button;
      
      public var blocksButton:Button;
      
      public var exitButton:Button;
      
      public var layer00Button:Button;
      
      public var layer0Button:Button;
      
      public var layer1Button:Button;
      
      public var layer2Button:Button;
      
      public var layer3Button:Button;
      
      public var loadButton:Button;
      
      public var newButton:Button;
      
      public var redoButton:Button;
      
      public var saveButton:Button;
      
      public var selectedGlow:MovieClip;
      
      public var settingsButton:Button;
      
      public var testButton:Button;
      
      public var undoButton:Button;
      
      public var zoomSelect:ComboBox;
      
      public function LevelEditorMenuGraphic()
      {
         super();
         this.__setProp_saveButton_LevelEditorMenu_Layer16_0();
         this.__setProp_testButton_LevelEditorMenu_Layer15_0();
         this.__setProp_undoButton_LevelEditorMenu_Layer14_0();
         this.__setProp_redoButton_LevelEditorMenu_Layer13_0();
         this.__setProp_zoomSelect_LevelEditorMenu_Layer12_0();
         this.__setProp_newButton_LevelEditorMenu_Layer11_0();
         this.__setProp_loadButton_LevelEditorMenu_Layer10_0();
         this.__setProp_exitButton_LevelEditorMenu_Layer9_0();
         this.__setProp_blocksButton_LevelEditorMenu_Layer8_0();
         this.__setProp_layer1Button_LevelEditorMenu_Layer7_0();
         this.__setProp_layer2Button_LevelEditorMenu_Layer6_0();
         this.__setProp_layer3Button_LevelEditorMenu_Layer5_0();
         this.__setProp_settingsButton_LevelEditorMenu_Layer4_0();
         this.__setProp_bgButton_LevelEditorMenu_Layer3_0();
         this.__setProp_layer0Button_LevelEditorMenu_Layer2_0();
         this.__setProp_layer00Button_LevelEditorMenu_Layer1_0();
      }
      
      internal function __setProp_saveButton_LevelEditorMenu_Layer16_0() : *
      {
         try
         {
            this.saveButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.saveButton.emphasized = false;
         this.saveButton.enabled = true;
         this.saveButton.label = "Save";
         this.saveButton.labelPlacement = "right";
         this.saveButton.selected = false;
         this.saveButton.toggle = false;
         this.saveButton.visible = true;
         try
         {
            this.saveButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_testButton_LevelEditorMenu_Layer15_0() : *
      {
         try
         {
            this.testButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.testButton.emphasized = false;
         this.testButton.enabled = true;
         this.testButton.label = "Test";
         this.testButton.labelPlacement = "right";
         this.testButton.selected = false;
         this.testButton.toggle = false;
         this.testButton.visible = true;
         try
         {
            this.testButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_undoButton_LevelEditorMenu_Layer14_0() : *
      {
         try
         {
            this.undoButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.undoButton.emphasized = false;
         this.undoButton.enabled = true;
         this.undoButton.label = "Undo";
         this.undoButton.labelPlacement = "right";
         this.undoButton.selected = false;
         this.undoButton.toggle = false;
         this.undoButton.visible = true;
         try
         {
            this.undoButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_redoButton_LevelEditorMenu_Layer13_0() : *
      {
         try
         {
            this.redoButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.redoButton.emphasized = false;
         this.redoButton.enabled = true;
         this.redoButton.label = "Redo";
         this.redoButton.labelPlacement = "right";
         this.redoButton.selected = false;
         this.redoButton.toggle = false;
         this.redoButton.visible = true;
         try
         {
            this.redoButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_zoomSelect_LevelEditorMenu_Layer12_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.zoomSelect["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         var _loc1_:DataProvider = new DataProvider();
         _loc3_ = [{
            "label":"25%",
            "data":25
         },{
            "label":"50%",
            "data":50
         },{
            "label":"75%",
            "data":75
         },{
            "label":"100%",
            "data":100
         },{
            "label":"150%",
            "data":150
         },{
            "label":"250%",
            "data":250
         },{
            "label":"500%",
            "data":500
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
         this.zoomSelect.dataProvider = _loc1_;
         this.zoomSelect.editable = false;
         this.zoomSelect.enabled = true;
         this.zoomSelect.prompt = "";
         this.zoomSelect.restrict = "";
         this.zoomSelect.rowCount = 7;
         this.zoomSelect.visible = true;
         try
         {
            this.zoomSelect["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_newButton_LevelEditorMenu_Layer11_0() : *
      {
         try
         {
            this.newButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.newButton.emphasized = false;
         this.newButton.enabled = true;
         this.newButton.label = "New";
         this.newButton.labelPlacement = "right";
         this.newButton.selected = false;
         this.newButton.toggle = false;
         this.newButton.visible = true;
         try
         {
            this.newButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_loadButton_LevelEditorMenu_Layer10_0() : *
      {
         try
         {
            this.loadButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.loadButton.emphasized = false;
         this.loadButton.enabled = true;
         this.loadButton.label = "Load";
         this.loadButton.labelPlacement = "right";
         this.loadButton.selected = false;
         this.loadButton.toggle = false;
         this.loadButton.visible = true;
         try
         {
            this.loadButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_exitButton_LevelEditorMenu_Layer9_0() : *
      {
         try
         {
            this.exitButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.exitButton.emphasized = false;
         this.exitButton.enabled = true;
         this.exitButton.label = "Exit";
         this.exitButton.labelPlacement = "right";
         this.exitButton.selected = false;
         this.exitButton.toggle = false;
         this.exitButton.visible = true;
         try
         {
            this.exitButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_blocksButton_LevelEditorMenu_Layer8_0() : *
      {
         try
         {
            this.blocksButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.blocksButton.emphasized = false;
         this.blocksButton.enabled = true;
         this.blocksButton.label = "Blocks";
         this.blocksButton.labelPlacement = "right";
         this.blocksButton.selected = false;
         this.blocksButton.toggle = false;
         this.blocksButton.visible = true;
         try
         {
            this.blocksButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_layer1Button_LevelEditorMenu_Layer7_0() : *
      {
         try
         {
            this.layer1Button["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.layer1Button.emphasized = false;
         this.layer1Button.enabled = true;
         this.layer1Button.label = "Art 1";
         this.layer1Button.labelPlacement = "right";
         this.layer1Button.selected = false;
         this.layer1Button.toggle = false;
         this.layer1Button.visible = true;
         try
         {
            this.layer1Button["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_layer2Button_LevelEditorMenu_Layer6_0() : *
      {
         try
         {
            this.layer2Button["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.layer2Button.emphasized = false;
         this.layer2Button.enabled = true;
         this.layer2Button.label = "Art 2";
         this.layer2Button.labelPlacement = "right";
         this.layer2Button.selected = false;
         this.layer2Button.toggle = false;
         this.layer2Button.visible = true;
         try
         {
            this.layer2Button["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_layer3Button_LevelEditorMenu_Layer5_0() : *
      {
         try
         {
            this.layer3Button["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.layer3Button.emphasized = false;
         this.layer3Button.enabled = true;
         this.layer3Button.label = "Art 3";
         this.layer3Button.labelPlacement = "right";
         this.layer3Button.selected = false;
         this.layer3Button.toggle = false;
         this.layer3Button.visible = true;
         try
         {
            this.layer3Button["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_settingsButton_LevelEditorMenu_Layer4_0() : *
      {
         try
         {
            this.settingsButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.settingsButton.emphasized = false;
         this.settingsButton.enabled = true;
         this.settingsButton.label = "Settings";
         this.settingsButton.labelPlacement = "right";
         this.settingsButton.selected = false;
         this.settingsButton.toggle = false;
         this.settingsButton.visible = true;
         try
         {
            this.settingsButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_bgButton_LevelEditorMenu_Layer3_0() : *
      {
         try
         {
            this.bgButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.bgButton.emphasized = false;
         this.bgButton.enabled = true;
         this.bgButton.label = "BG";
         this.bgButton.labelPlacement = "right";
         this.bgButton.selected = false;
         this.bgButton.toggle = false;
         this.bgButton.visible = true;
         try
         {
            this.bgButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_layer0Button_LevelEditorMenu_Layer2_0() : *
      {
         try
         {
            this.layer0Button["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.layer0Button.emphasized = false;
         this.layer0Button.enabled = true;
         this.layer0Button.label = "Art 0";
         this.layer0Button.labelPlacement = "right";
         this.layer0Button.selected = false;
         this.layer0Button.toggle = false;
         this.layer0Button.visible = true;
         try
         {
            this.layer0Button["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_layer00Button_LevelEditorMenu_Layer1_0() : *
      {
         try
         {
            this.layer00Button["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.layer00Button.emphasized = false;
         this.layer00Button.enabled = true;
         this.layer00Button.label = "Art 00";
         this.layer00Button.labelPlacement = "right";
         this.layer00Button.selected = false;
         this.layer00Button.toggle = false;
         this.layer00Button.visible = true;
         try
         {
            this.layer00Button["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
