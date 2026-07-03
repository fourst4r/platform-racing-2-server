package blocks
{
   public class StartBlock extends Block
   {
       
      
      public function StartBlock(param1:int, param2:int)
      {
         super(param1);
         var _loc3_:StartBlockText = new StartBlockText();
         _loc3_.textBox.text = param2.toString();
         addChild(_loc3_);
      }
   }
}
