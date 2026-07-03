package package_9
{
   import background.*;
   import flash.utils.*;
   
   public class Effect extends Removable
   {
       
      
      private var var_529:uint;
      
      public function Effect(param1:Number = 0, param2:Number = 0)
      {
         super();
         x = param1;
         y = param2;
         EffectBackground.instance.addChild(this);
      }
      
      protected function method_2(param1:int) : *
      {
         var _loc2_:int = int(param1 * (1 / 24) * 1000);
         this.var_529 = setTimeout(this.remove,_loc2_);
      }
      
      override public function remove() : *
      {
         clearTimeout(this.var_529);
         super.remove();
      }
   }
}
