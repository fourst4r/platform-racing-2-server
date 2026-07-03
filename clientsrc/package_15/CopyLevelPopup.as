package package_15
{
   import com.adobe.crypto.MD5;
   import com.hurlant.util.Hex;
   import com.jiggmin.data.Env;
   import flash.events.Event;
   import flash.net.*;
   import flash.utils.ByteArray;
   import package_4.*;

   public class CopyLevelPopup extends UploadingPopup
   {
      private var levelID:String;
      private var version:int;

      private var overrideBanConfirmed:Boolean = false;
      private var overwriteExistingConfirmed:Boolean = false;

      private var cachedVars:URLVariables = null;

      public function CopyLevelPopup(levelID:String, version:int)
      {
         super();
         this.levelID = levelID;
         this.version = version;
         this.m.textBox.text = "Downloading level...";

         var levelsURL:String = levelID.indexOf("8p_") == 0 ? Main.levelsURL : Main.phLevelsURL;

         var req:URLRequest = new URLRequest(levelsURL + "/" + this.levelID + ".txt?version=" + this.version);
         // Use a fresh loader dedicated to this operation
         loader = new SuperLoader();
         loader.addEventListener(SuperLoader.d, this.onDownloaded, false, 0, true);
         loader.addEventListener(SuperLoader.e, this.errorHandler, false, 0, true);
         loader.load(req);
      }

      private function onDownloaded(e:Event) : void
      {
         var is8P:Boolean = this.levelID.indexOf("8p_") == 0;
         var raw:String = String(e.target.data);
         // Verify hash like LoadingLevelPopup
         var hashStart:int = raw.length - 32;
         var provided:String = raw.substr(hashStart);
         var payload:String = raw.substr(0, hashStart);
         var expected:String = MD5.hash(this.version.toString() + this.levelID.toString() + payload + Env.LEVEL_SALT_2);
         if (!is8P && expected != provided)
         {
            new MessagePopup("Warning: The course download was unable to be verified, but we'll proceed anyway.");
         }
         else if (expected != provided || payload == "")
         {
            new MessagePopup("Error: The course did not download correctly.");
            startFadeOut();
            return;
         }

         // Parse payload into URLVariables without invoking the LE
         var dlVars:URLVariables = new URLVariables(payload);
         this.cachedVars = dlVars;
         this.beginUpload();
      }

      private function beginUpload() : void
      {
         if (this.cachedVars == null)
         {
            startFadeOut();
            return;
         }

         // Build upload variables similar to LevelEditor.method_344()
         var up:URLVariables = new URLVariables();
         up.title = this.cachedVars.title || "Untitled Level";
         up.note = this.cachedVars.note || "";
         up.data = this.cachedVars.data;
         up.credits = this.cachedVars.credits || "";
         up.live = "0";
         up.min_level = this.cachedVars.min_level || "0";
         up.song = this.cachedVars.song || "";
         up.gravity = this.cachedVars.gravity || "1";
         up.max_time = this.cachedVars.max_time || "0";
         up.items = this.cachedVars.items || "1`2`3`4`5`6`7`8`9";
         up.badHats = this.cachedVars.badHats || "";
         up.hasPass = this.cachedVars.hasPass || "0";
         up.gameMode = this.cachedVars.gameMode || "r";
         up.cowboyChance = this.cachedVars.cowboyChance || "0";
         // passHash only if provided (we don't know the original plain pass)
         if (this.cachedVars.hasOwnProperty("passHash"))
         {
            up.passHash = this.cachedVars.passHash;
         }

         // Compute upload hash: title + username + data + salt
         var s:String = String(up.title) + Main.loggedInAs.toLowerCase() + String(up.data) + Env.LEVEL_SALT;
         up.hash = MD5.hash(s);

         up.to_newest = 0;
         up.override_banned = int(this.overrideBanConfirmed);
         up.overwrite_existing = int(this.overwriteExistingConfirmed);

         this.m.textBox.text = "Uploading level...";
         var post:URLRequest = new URLRequest(Main.baseURL + "/upload_level.php");
         post.method = URLRequestMethod.POST;
         post.data = up;
         trace("uploading " + up.toString());

         // Reset and post
         loader.removeEventListener(SuperLoader.d, this.onDownloaded);
         loader.removeEventListener(SuperLoader.e, this.errorHandler);
         loader = new SuperLoader();
         loader.addEventListener(SuperLoader.d, this.onUploaded, false, 0, true);
         loader.addEventListener(SuperLoader.e, this.errorHandler, false, 0, true);
         loader.load(post);
      }

      private function onUploaded(e:Event) : void
      {
         // Reuse UploadingLevelPopup flow for banned/exist checks
         this.parsedData = loader.parsedData;
         if (parsedData != null && parsedData.status == "banned")
         {
            var scope:String = parsedData.scope === "s" ? "socially " : "";
            new ConfirmPopup(this.overrideBanConfirmUploadLevel, "Because you are currently " + com.jiggmin.data.Data.urlify(Main.baseURL + "/bans/show_record.php?ban_id=" + parsedData.ban_id, scope + "banned") + ", you can only save this level as unpublished without a password. Is it okay to continue with these settings?");
            return;
         }
         if (parsedData != null && parsedData.status == "exists")
         {
            new ConfirmPopup(this.overwriteConfirmUploadLevel, "You have another level with this title. Is it okay to overwrite the existing level with this save?");
            return;
         }
         // Otherwise, close
         startFadeOut();
      }

      private function overrideBanConfirmUploadLevel() : *
      {
         this.overrideBanConfirmed = true;
         this.beginUpload();
      }

      private function overwriteConfirmUploadLevel() : *
      {
         this.overwriteExistingConfirmed = true;
         this.beginUpload();
      }
   }
}

