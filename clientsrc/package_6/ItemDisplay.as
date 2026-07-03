package package_6
{
   public class ItemDisplay extends Removable
   {
       
      
      private var m:ItemDisplayGraphic;
      
      public function ItemDisplay()
      {
         this.m = new ItemDisplayGraphic();
         super();
         addChild(this.m);
         this.m.gotoAndStop("None");
      }
      
      public function setItem(param1:String) : *
      {
         this.m.gotoAndStop(param1);
         this.m.holder1.textBox.text = this.m.holder2.textBox.text = param1;
         this.setAmmo(1);
         if(param1 == "None")
         {
            this.setAmmo(0);
         }
      }
      
      public function setAmmo(param1:int) : *
      {
         this.m.a1.visible = this.m.a2.visible = this.m.a3.visible = false;
         while(param1 > 0)
         {
            // Temporary fix for >3 ammo display
            if (this.m["a" + param1] == null) break;

            this.m["a" + param1].visible = true;
            param1--;
         }
      }
   }
}
