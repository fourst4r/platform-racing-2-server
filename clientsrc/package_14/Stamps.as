package package_14
{
   import package_19.*;
   
   public class Stamps extends SideBar
   {
       
      
      public function Stamps()
      {
         super();
         addItem(new BrushButton(),"Draw Menu","Switch to the draw menu to draw custom backgrounds.");
         addItem(new ObjectDeleterButton(),"Delete Tool","Click and drag the mouse to delete things with remarkable speed!");
         addItem(new TextToolButton(),"Text","Compose prose with style.");
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            addItem(new StampButton(_loc1_++));
         }
      }
   }
}
