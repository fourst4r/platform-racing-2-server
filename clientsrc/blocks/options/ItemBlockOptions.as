package blocks.options
{
   import blocks.Block;
   import fl.controls.CheckBox;
   import items.*;
   import page.*;
   
   public class ItemBlockOptions extends BlockOptions
   {  
      private const NUM_ITEMS:int = Items.getAllCodes().length;
      
      public function ItemBlockOptions(param1:Block)
      {
         var _loc4_:CheckBox = null;
         m = new ItemBlockOptionsGraphic();
         super(param1);
         var itemPairs = [];
         var ammos = [];
         if(param1.options == "")
         {
            itemPairs = GamePage.course.allowedItems.join("-").split("-");
         }
         else if(param1.options != "none")
         {
            itemPairs = param1.options.split("-");
         }

         for (var i:int = 1; i <= this.NUM_ITEMS; i++)
            this.m["check" + i].selected = false;
         for each (var item:String in itemPairs)
         {
            var split = item.split(":");
            var code:int = int(split[0]);
            var ammo:String = split.length > 1 ? split[1] : "";
            this.m["check" + code].selected = true;
            if (this.m["ammo" + code])
               this.m["ammo" + code].text = ammo;
         }
      }
      
      override public function remove() : *
      {
         var itemPairs = [];
         for (var i:int = 1; i <= this.NUM_ITEMS; i++)
         {
            if (this.m["check" + i].selected)
            {
               if (this.m["ammo" + i] && int(this.m["ammo" + i].text) > 0)
               {
                  // we got the code:ammo pair
                  var ammo:String = this.m["ammo" + i].text;
                  itemPairs.push(i + ":" + ammo);
               }
               else
               {
                  // we got just the code
                  itemPairs.push(String(i));
               }
            }
         }
         var options:String = itemPairs.length > 0 ? itemPairs.join("-") : "none";
         trace("applying: "+options);
         block.applyOptions(options);

         super.remove();
      }
   }
}
