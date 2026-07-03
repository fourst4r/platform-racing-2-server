package package_9
{
   public class class_178 extends Effect
   {
       
      
      private var m:class_239;
      
      public function class_178(param1:Number, param2:Number)
      {
         this.m = new class_239();
         super();
         x = param1;
         y = param2;
         addChild(this.m);
         method_2(15);
      }
      
      override public function remove() : *
      {
         this.m = null;
         super.remove();
      }
   }
}
