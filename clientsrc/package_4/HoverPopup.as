package package_4
{
   import flash.display.DisplayObject;
   import flash.text.*;
   
   public class HoverPopup extends InfoPopup
   {
       
      
      public function HoverPopup(param1:String, param2:String, param3:DisplayObject)
      {
         var _loc4_:TextField = null;
         var _loc5_:TextField = null;
         var _loc6_:ShadowBG = null;
         if(param1 != "" || param2 != "")
         {
            (_loc4_ = this.generateTextBox()).htmlText = "<b>" + param1 + "</b>";
            _loc4_.y = 5;
            (_loc5_ = this.generateTextBox()).htmlText = param2;
            _loc5_.y = _loc4_.height + _loc4_.y + 5;
            (_loc6_ = new ShadowBG()).width = width + 10;
            _loc6_.height = height + 12;
            addChildAt(_loc6_,0);
            super(param3);
            Main.stage.addChild(this);
         }
      }
      
      private function generateTextBox() : TextField
      {
         var _loc1_:TextField = null;
         _loc1_ = new TextField();
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.font = "Arial";
         _loc1_.defaultTextFormat = _loc2_;
         _loc1_.width = 150;
         _loc1_.height = 1;
         _loc1_.x = 5;
         _loc1_.multiline = true;
         _loc1_.wordWrap = true;
         _loc1_.selectable = false;
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         _loc1_.antiAliasType = AntiAliasType.ADVANCED;
         addChild(_loc1_);
         return _loc1_;
      }
   }
}
