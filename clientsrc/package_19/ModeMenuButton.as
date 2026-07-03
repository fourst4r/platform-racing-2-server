package package_19
{
   import flash.events.MouseEvent;
   
   public class ModeMenuButton extends class_215
   {
       
      
      private var m:ValueButtonGraphic;
      
      private var value:String;
      
      public function ModeMenuButton()
      {
         this.m = new ValueButtonGraphic();
         super();
         addChild(this.m);
         this.m.titleBox.text = "mode";
         this.setValue("race");
      }
      
      public function setValue(param1:String) : *
      {
         this.value = param1;
         this.m.valueBox.text = param1;
      }
      
      override protected function onClick(param1:MouseEvent) : *
      {
         new ModeMenu(this);
      }
   }
}
