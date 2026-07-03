package blocks
{
   import blocks.options.*;
   import com.jiggmin.data.*;
   import package_8.LocalCharacter;
   import page.*;
   import sounds.*;
   
   public class ItemBlock extends SupplyBlock
   {
       
      
      public function ItemBlock(param1:int = 110)
      {
         optionsMenu = ItemBlockOptions;
         super(param1);
      }
      
      public function applyOptions(param1:String) : *
      {
         if(GamePage.course == null)
         {
            return;
         }
         var newOptions:Array = param1.split("-");
         var oldOptions:Array = options.split("-");
         var courseOptions:Array = GamePage.course.allowedItems.join("-").split("-");
         if(newOptions.toString() == courseOptions.toString() || newOptions.toString() == "0" && courseOptions.toString() == "")
         {
            options = "";
         }
         else
         {
            if(newOptions == oldOptions)
            {
               return;
            }
            if(newOptions.length == 0 || newOptions.length == 1 && newOptions[0] == 0)
            {
               options = "none";
            }
            else
            {
               options = newOptions.join("-");
            }
         }
      }
      
      public function updateGameItems() : *
      {
         if(options == "")
         {
            return;
         }
         var courseOptions:Array = GamePage.course.allowedItems.join("-").split("-");
         if(options == courseOptions.join("-") || options == "none" && courseOptions.length == 0)
         {
            options = "";
         }
      }
      
      override protected function useSupply(lc:LocalCharacter) : *
      {
         super.useSupply(lc);
         var item:Array = [];
         if(options == "")
         {
            item = GamePage.course.allowedItems.sort(Array.NUMERIC).join("-").split("-");
         }
         else if(options != "none")
         {
            item = options.split("-");
         }
         if(item.length > 0)
         {
            var _loc3_:Number = Math.floor(Math.random() * item.length);
            var split = item[_loc3_].split(":");
            var code:int = int(split[0]);
            var ammo:int = split.length > 1 ? int(split[1]) : 0;
            lc.setItem(code);
            if (ammo > 0)
               lc.setItemUses(ammo);
         }
         SoundEffects.playSound(new StarSound(),0.6 * (Settings.soundLevel / 100));
      }
   }
}
