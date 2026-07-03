package blocks.options
{
   import blocks.Block;
   import flash.display.MovieClip;
   import package_4.class_264;
   
   public class BlockOptions extends class_264
   {
      
      private static var instance:BlockOptions;
       
      
      protected var block:Block;
      
      protected var m:MovieClip;
      
      public function BlockOptions(param1:Block)
      {
         if(instance != null)
         {
            instance.remove();
         }
         instance = this;
         this.block = param1;
         addChild(this.m);
         super(param1);
      }
      
      override public function remove() : *
      {
         instance = null;
         super.remove();
      }
   }
}
