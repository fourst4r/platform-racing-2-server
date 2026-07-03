package package_4
{
   import com.jiggmin.data.*;
   import flash.net.*;
   
   public class DiscordVerificationPopup extends UploadingPopup
   {
       
      
      public function DiscordVerificationPopup(param1:String)
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.code = param1;
         _loc2_.pr2_name = Data.trimWhitespace(Main.loggedInAs);
         var _loc3_:URLRequest = new URLRequest("https://jiggmin2.com/discord/verify_pr2.php");
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         super(_loc3_,SuperLoader.j);
         m.textBox.text = "Verifying...";
      }
   }
}
