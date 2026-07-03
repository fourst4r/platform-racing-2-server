package package_21
{
   public class ReplyMessageButton extends HoverDelayPopup
   {
       
      
      private var m:ReplyMessageButtonGraphic;
      
      public function ReplyMessageButton()
      {
         this.m = new ReplyMessageButtonGraphic();
         addChild(this.m);
         super("Reply to Message","You\'ve got something to say, and someone\'s gonna hear it.");
      }
   }
}
