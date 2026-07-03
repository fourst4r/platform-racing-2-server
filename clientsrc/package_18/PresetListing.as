package package_18
{
   import package_8.*;
   import ui.class_229;
   
   public class PresetListing extends class_229
   {
       
      
      private var preset:Preset;
      
      private var character:Character;
      
      private var playerDisplay:PlayerDisplay;
      
      private var m:PresetListingGraphic;
      
      public function PresetListing(param1:Preset, param2:PlayerDisplay)
      {
         this.preset = param1;
         this.playerDisplay = param2;
         this.mouseChildren = false;
         this.doubleClickEnabled = true;
         this.m = new PresetListingGraphic();
         addChild(this.m);
         super(this.m);
         this.character = new Character(this.preset.hat,this.preset.head,this.preset.body,this.preset.feet);
         this.m.addChild(this.character);
         var _loc3_:int = !!this.playerDisplay.hatSelect.isPartEpic(this.preset.hat) ? int(this.preset.hatColor2) : -1;
         var _loc4_:int = !!this.playerDisplay.headSelect.isPartEpic(this.preset.head) ? int(this.preset.headColor2) : -1;
         var _loc5_:int = !!this.playerDisplay.bodySelect.isPartEpic(this.preset.body) ? int(this.preset.bodyColor2) : -1;
         var _loc6_:int = !!this.playerDisplay.feetSelect.isPartEpic(this.preset.feet) ? int(this.preset.feetColor2) : -1;
         this.character.setColors(this.preset.hatColor,_loc3_,this.preset.headColor,_loc4_,this.preset.bodyColor,_loc5_,this.preset.feetColor,_loc6_);
         this.character.scaleX = this.character.scaleY = 0.13 * (1 / 0.15);
         this.character.x = 58;
         this.character.y = 61;
         this.m.loadoutSpeed.text = "Speed: " + this.preset.speed;
         this.m.loadoutAccel.text = "Acceleration: " + this.preset.acceleration;
         this.m.loadoutJump.text = "Jumping: " + this.preset.jumping;
         this.m.loadoutNum.text = this.preset.num.toString();
      }
      
      public function getPreset() : Preset
      {
         return this.preset;
      }
      
      override public function remove() : *
      {
         this.character.remove();
         this.character = null;
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
