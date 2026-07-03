package package_15
{
   import com.hurlant.crypto.hash.*;
   import com.hurlant.util.*;
   import com.jiggmin.data.*;
   import flash.events.Event;
   import flash.net.*;
   import flash.utils.*;
   import levelEditor.*;
   import package_4.*;
   
   public class UploadingLevelPopup extends UploadingPopup
   {
       
      
      private var editor:LevelEditor;
      
      private var waitTimeout:uint;
      
      private var overrideBanConfirmed:Boolean = false;
      
      private var overwriteExistingConfirmed:Boolean = false;
      
      public function UploadingLevelPopup(param1:Boolean = false, param2:Boolean = false)
      {
         this.editor = LevelEditor.editor;
         super();
         this.overrideBanConfirmed = param1;
         this.overwriteExistingConfirmed = param2;
         this.uploadLevel();
      }
      
      private function uploadLevel() : *
      {
         var _loc1_:MD5 = null;
         var _loc2_:URLVariables = null;
         var _loc3_:String = null;
         var _loc4_:ByteArray = null;
         var _loc5_:URLRequest = null;
         if(!this.editor.drawing)
         {
            _loc1_ = new MD5();
            _loc2_ = this.editor.method_344();
            if(_loc2_.data == "" || _loc2_.data == null)
            {
               new MessagePopup("The client is glitching out. Could not save your level.");
            }
            else
            {
               _loc3_ = _loc2_.title + Main.loggedInAs.toLowerCase() + _loc2_.data + Env.LEVEL_SALT;
               _loc4_ = _loc1_.hash(Hex.toArray(Hex.fromString(_loc3_)));
               _loc2_.hash = Hex.fromArray(_loc4_);
               _loc2_.to_newest = int(this.editor.toNewest);
               _loc2_.replays_public = int(this.editor.replaysPublic);
               _loc2_.override_banned = int(this.overrideBanConfirmed);
               _loc2_.overwrite_existing = int(this.overwriteExistingConfirmed);
               (_loc5_ = new URLRequest(Main.baseURL + "/upload_level.php")).method = URLRequestMethod.POST;
               _loc5_.data = _loc2_;
               loader = new SuperLoader();
               loader.addEventListener(SuperLoader.d,this.onParse,false,0,true);
               loader.addEventListener(SuperLoader.e,this.onError,false,0,true);
               loader.load(_loc5_);
            }
         }
         else
         {
            clearTimeout(this.waitTimeout);
            this.waitTimeout = setTimeout(this.uploadLevel,1000);
         }
      }
      
      private function onParse(param1:Event) : *
      {
         var _loc2_:String = null;
         super.parsedDataHandler(param1);
         if(parsedData.status == "banned")
         {
            _loc2_ = parsedData.scope === "s" ? "socially " : "";
            new ConfirmPopup(this.overrideBanConfirmUploadLevel,"Because you are currently " + Data.urlify(Main.baseURL + "/bans/show_record.php?ban_id=" + parsedData.ban_id,_loc2_ + "banned") + ", you can only save this level as unpublished without a password. Is it okay to continue with these settings?");
         }
         else if(parsedData.status == "exists")
         {
            new ConfirmPopup(this.overwriteConfirmUploadLevel,"You have another level with this title. Is it okay to overwrite the existing level with this save?");
         }
      }
      
      private function onError(param1:Event) : *
      {
         this.remove();
      }
      
      private function overrideBanConfirmUploadLevel() : *
      {
         this.overrideBanConfirmed = true;
         new UploadingLevelPopup(this.overrideBanConfirmed,this.overwriteExistingConfirmed);
      }
      
      private function overwriteConfirmUploadLevel() : *
      {
         this.overwriteExistingConfirmed = true;
         new UploadingLevelPopup(this.overrideBanConfirmed,this.overwriteExistingConfirmed);
      }
      
      override public function remove() : *
      {
         clearTimeout(this.waitTimeout);
         super.remove();
      }
   }
}
