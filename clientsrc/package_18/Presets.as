package package_18
{
   import com.jiggmin.data.*;
   import package_8.Character;
   import ui.StatsSelect;
   
   public class Presets
   {
      
      public static const NUM_PRESETS:int = 10;
      
      private static var presets:Vector.<Preset>;
       
      
      public function Presets()
      {
         super();
      }
      
      public static function load() : *
      {
         var _loc3_:Object = null;
         var _loc4_:Preset = null;
         presets = new Vector.<Preset>();
         var _loc1_:Array = [{"num":1},{"num":2},{"num":3},{"num":4},{"num":5},{"num":6},{"num":7},{"num":8},{"num":9},{"num":10}];
         var _loc2_:Array = Settings.getValue(Settings.PRESETS,_loc1_) as Array;
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = new Preset(_loc3_);
            presets[_loc4_.num - 1] = _loc4_;
         }
      }
      
      public static function savePresets() : *
      {
         var _loc2_:Preset = null;
         var _loc3_:Object = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in presets)
         {
            _loc3_ = _loc2_.getPresetData();
            _loc1_[_loc3_.num - 1] = _loc3_;
         }
         Settings.setValue(Settings.PRESETS,_loc1_);
      }
      
      public static function getPresets() : Vector.<Preset>
      {
         var _loc1_:Preset = null;
         if(presets.length < Presets.NUM_PRESETS)
         {
            while(presets.length < Presets.NUM_PRESETS)
            {
               _loc1_ = new Preset({"num":presets.length + 1});
               presets.push(_loc1_);
            }
         }
         return presets;
      }
      
      public static function getPreset(param1:int) : Preset
      {
         return presets[param1 - 1];
      }
      
      public static function apply(param1:Preset, param2:Character, param3:StatsSelect, param4:PlayerDisplay) : *
      {
         var _loc5_:int = param1.hatColor2;
         var _loc6_:int = param1.headColor2;
         var _loc7_:int = param1.bodyColor2;
         var _loc8_:int = param1.feetColor2;
         if(param3 != null)
         {
            param3.setStats({
               "speed":1,
               "acceleration":1,
               "jumping":1
            });
            param3.setStats(param1);
         }
         if(param4 != null)
         {
            param4.hatSelect.setValue(param1.hat);
            param4.headSelect.setValue(param1.head);
            param4.bodySelect.setValue(param1.body);
            param4.feetSelect.setValue(param1.feet);
            param4.hatSelect.setColors(param1.hatColor,param1.hatColor2);
            param4.headSelect.setColors(param1.headColor,param1.headColor2);
            param4.bodySelect.setColors(param1.bodyColor,param1.bodyColor2);
            param4.feetSelect.setColors(param1.feetColor,param1.feetColor2);
            _loc5_ = param4.hatSelect.getColor2();
            _loc6_ = param4.headSelect.getColor2();
            _loc7_ = param4.bodySelect.getColor2();
            _loc8_ = param4.feetSelect.getColor2();
         }
         if(param2 != null)
         {
            param2.setHatId(param1.hat);
            param2.setHeadId(param1.head);
            param2.setBodyId(param1.body);
            param2.setFeetId(param1.feet);
            param2.setColors(param1.hatColor,_loc5_,param1.headColor,_loc6_,param1.bodyColor,_loc7_,param1.feetColor,_loc8_);
         }
      }
   }
}
