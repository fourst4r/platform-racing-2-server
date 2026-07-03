package package_4
{
   import com.jiggmin.data.*;
   import flash.display.DisplayObject;
   
   public class OptionsArtQualityMenu extends class_264
   {
      
      public static var instance:*;
       
      
      private var m:OptionsArtQualityMenuGraphic;
      
      public function OptionsArtQualityMenu(param1:DisplayObject)
      {
         this.m = new OptionsArtQualityMenuGraphic();
         if(OptionsArtQualityMenu.instance != null)
         {
            OptionsArtQualityMenu.instance.remove();
         }
         OptionsArtQualityMenu.instance = this;
         addChild(this.m);
         super(param1);
         this.m.lossless_chk.selected = Settings.getValue(Settings.ART_LOSSLESS_QUALITY,false);
      }
      
      override public function remove() : *
      {
         if(OptionsArtQualityMenu.instance === this)
         {
            OptionsArtQualityMenu.instance = null;
         }
         Settings.setValue(Settings.ART_LOSSLESS_QUALITY,this.m.lossless_chk.selected);
         super.remove();
      }
   }
}
