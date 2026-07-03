package package_21
{
   public class DeleteMessageButton extends HoverDelayPopup
   {
       
      
      private var m:DeleteMessageButtonGraphic;
      
      public function DeleteMessageButton()
      {
         this.m = new DeleteMessageButtonGraphic();
         addChild(this.m);
         super("Delete Message","Erase this flimsy correspondence from existence.");
      }
   }
}
