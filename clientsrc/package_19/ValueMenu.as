package package_19
{
   import flash.events.*;
   import package_4.class_264;
   
   public class ValueMenu extends class_264
   {
       
      
      private var m:ValueMenuGraphic;
      
      private var defineCommand:Function;
      
      private var defaultVal:String;
      
      public function ValueMenu(param1:ValueButton, param2:String, param3:String, param4:String, param5:Function, param6:Number = 9, param7:String = "0123456789", param8:String = "0", param9:Boolean = false)
      {
         this.m = new ValueMenuGraphic();
         this.defineCommand = param5;
         this.defaultVal = param8;
         this.m.titleBox.htmlText = "<b>-- " + param2 + " --</b>";
         this.m.descBox.htmlText = param3;
         this.m.valueBox.text = param4;
         this.m.valueBox.maxChars = param6;
         this.m.valueBox.restrict = param7;
         this.m.valueBox.displayAsPassword = param9;
         addChild(this.m);
         this.m.valueBox.addEventListener(Event.CHANGE,this.method_65);
         super(param1);
      }
      
      private function method_65(param1:Event) : *
      {
         var _loc2_:String = String(param1.target.text);
         if(_loc2_ == "")
         {
            _loc2_ = String(this.defaultVal);
         }
         this.defineCommand(_loc2_);
      }
      
      override public function remove() : *
      {
         this.m.valueBox.removeEventListener(Event.CHANGE,this.method_65);
         Main.stage.focus = Main.stage;
         super.remove();
      }
   }
}
