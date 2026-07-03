package package_21
{
   public class ReportMessageButton extends HoverDelayPopup
   {
       
      
      private var m:ReportMessageButtonGraphic;
      
      public function ReportMessageButton()
      {
         this.m = new ReportMessageButtonGraphic();
         addChild(this.m);
         super("Report Message","If this message is inappropriate, you can report it to the moderators.");
      }
   }
}
