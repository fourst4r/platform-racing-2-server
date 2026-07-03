package package_14
{
   import com.jiggmin.data.*;
   import package_19.*;
   
   public class Backgrounds extends SideBar
   {
       
      
      public var cp_btn:BackgroundColorPickerButton;
      
      public function Backgrounds()
      {
         this.cp_btn = new BackgroundColorPickerButton();
         super();
         addItem(this.cp_btn);
         addItem(new class_222(Objects.BG1Code,8172673));
         addItem(new class_222(Objects.BG2Code,13283754));
         addItem(new class_222(Objects.BG3Code,528392));
         addItem(new class_222(Objects.BG4Code,14731448));
         addItem(new class_222(Objects.BG5Code,0));
         addItem(new class_222(Objects.BG6Code,0));
         addItem(new class_222(Objects.BG7Code,0));
      }
   }
}
