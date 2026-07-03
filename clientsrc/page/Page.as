package page
{
   import flash.display.Sprite;
   
   public class Page extends Sprite
   {
       
      
      public var var_677:String = "0";
      
      public function Page()
      {
         super();
      }
      
      public function initialize() : *
      {
      }
      
      public function remove() : *
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}
