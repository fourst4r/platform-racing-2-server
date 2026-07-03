package
{
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
   
   public dynamic class ModeMenuGraphic extends MovieClip
   {
       
      
      public var modeSelect:ComboBox;
      
      public var var_283:TextField;
      
      public function ModeMenuGraphic()
      {
         super();
         this.__setProp_modeSelect_ModeMenu_Layer1_0();
      }
      
      internal function __setProp_modeSelect_ModeMenu_Layer1_0() : *
      {
         var _loc2_:SimpleCollectionItem = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         try
         {
            this.modeSelect["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         var _loc1_:DataProvider = new DataProvider();
         _loc3_ = [{
            "label":"Race",
            "data":"race"
         },{
            "label":"Objective",
            "data":"objective"
         },{
            "label":"Deathmatch",
            "data":"deathmatch"
         },{
            "label":"Alien Eggs",
            "data":"egg"
         },{
            "label":"Hat Attack",
            "data":"hat"
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
         this.modeSelect.dataProvider = _loc1_;
         this.modeSelect.editable = false;
         this.modeSelect.enabled = true;
         this.modeSelect.prompt = "";
         this.modeSelect.restrict = "";
         this.modeSelect.rowCount = 5;
         this.modeSelect.visible = true;
         try
         {
            this.modeSelect["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
