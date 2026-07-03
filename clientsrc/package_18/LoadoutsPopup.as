package package_18
{
   import com.jiggmin.data.*;
   import package_4.*;
   import package_8.Character;
   import ui.StatsSelect;
   import ui.class_229;
   
   public class LoadoutsPopup extends GetLevelsPopup
   {
       
      
      private var character:Character;
      
      private var statsSelect:StatsSelect;
      
      private var playerDisplay:PlayerDisplay;
      
      public function LoadoutsPopup(param1:Character, param2:StatsSelect, param3:PlayerDisplay)
      {
         super();
         this.character = param1;
         this.statsSelect = param2;
         this.playerDisplay = param3;
         this.var_454 = 68;
         m.titleBox.text = "-- Loadouts --";
         m.delete_bt.label = "Save";
         hideLoadingGraphic();
         this.populate();
      }
      
      private function populate() : *
      {
         var _loc2_:Preset = null;
         var _loc3_:PresetListing = null;
         var _loc1_:Vector.<Preset> = Presets.getPresets();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = new PresetListing(_loc2_,this.playerDisplay);
            this.method_455(_loc3_);
         }
      }
      
      override protected function loadListing(param1:class_229) : *
      {
         if(!Settings.isNameSet())
         {
            new MessagePopup("Error: You are not logged in.");
            startFadeOut();
            return;
         }
         var _loc2_:PresetListing = PresetListing(param1);
         var _loc3_:Preset = _loc2_.getPreset();
         Presets.apply(_loc3_,this.character,this.statsSelect,this.playerDisplay);
         startFadeOut();
      }
      
      override protected function deleteListing(param1:class_229) : *
      {
         var _loc2_:PresetListing = PresetListing(param1);
         var _loc3_:Object = _loc2_.getPreset();
         var _loc4_:Object = this.statsSelect.getStats();
         _loc3_.speed = _loc4_.speed;
         _loc3_.acceleration = _loc4_.acceleration;
         _loc3_.jumping = _loc4_.jumping;
         _loc3_.hat = this.character.hat1;
         _loc3_.head = this.character.head;
         _loc3_.body = this.character.body;
         _loc3_.feet = this.character.feet;
         _loc3_.hatColor = this.character.hat1Color;
         _loc3_.headColor = this.character.headColor;
         _loc3_.bodyColor = this.character.bodyColor;
         _loc3_.feetColor = this.character.feetColor;
         _loc3_.hatColor2 = !!this.playerDisplay.hasOwnProperty("hatSelect") ? this.playerDisplay.hatSelect.getColorCP2() : this.character.hat1Color2;
         _loc3_.headColor2 = !!this.playerDisplay.hasOwnProperty("headSelect") ? this.playerDisplay.headSelect.getColorCP2() : this.character.headColor2;
         _loc3_.bodyColor2 = !!this.playerDisplay.hasOwnProperty("bodySelect") ? this.playerDisplay.bodySelect.getColorCP2() : this.character.bodyColor2;
         _loc3_.feetColor2 = !!this.playerDisplay.hasOwnProperty("feetSelect") ? this.playerDisplay.feetSelect.getColorCP2() : this.character.feetColor2;
         Presets.savePresets();
         startFadeOut();
      }
      
      override public function remove() : *
      {
         this.character = null;
         this.statsSelect = null;
         this.playerDisplay = null;
         super.remove();
      }
   }
}
