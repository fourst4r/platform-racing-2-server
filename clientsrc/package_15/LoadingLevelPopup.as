package package_15
{
   import com.adobe.crypto.*;
   import flash.events.Event;
   import flash.net.*;
   import levelEditor.*;
   import package_4.*;
   
   public class LoadingLevelPopup extends UploadingPopup
   {
       
      
      private var levelID:String;
      
      private var version:int;
      
      private var report:Boolean = false;
      
      public function LoadingLevelPopup(param1:String, param2:int, param3:Boolean = false)
      {
         super();
         this.levelID = param1;
         this.version = param2;
         this.report = param3;
         m.textBox.text = "Loading level...";
         var _loc4_:URLRequest = new URLRequest(Main.levelsURL + "/" + this.levelID + ".txt?version=" + this.version);
         loader.useRandomNum = false;
         loader = new SuperLoader();
         loader.addEventListener(SuperLoader.d,this.onComplete,false,0,true);
         loader.addEventListener(SuperLoader.e,errorHandler,false,0,true);
         loader.load(_loc4_);
      }
      
      override protected function onComplete(param1:Event) : *
      {
         var _loc7_:LevelEditor = null;
         var _loc8_:URLVariables = null;
         var _loc2_:String = String(param1.target.data);
         var _loc3_:int = _loc2_.length - 32;
         var _loc4_:String = _loc2_.substr(_loc3_);
         var _loc5_:String = _loc2_.substr(0,_loc3_);
         var _loc6_:String;
         if((_loc6_ = String(MD5.hash(this.version.toString() + this.levelID.toString() + _loc5_ + Env.LEVEL_SALT_2))) != _loc4_)
         {
            new MessagePopup("Error: The course did not download correctly.");
         }
         else if(_loc5_ == "")
         {
            new MessagePopup("Error: The course did not load.");
         }
         else
         {
            _loc5_ = (_loc7_ = LevelEditor.editor).validateSaveString(_loc5_);
            _loc8_ = new URLVariables(_loc5_);
            _loc7_.setVariables(_loc8_);
         }
         super.onComplete(param1);
         super.parsedDataHandler(param1);
         LevelEditor.editor.menu.setReportsMode(this.report);
      }
      
      override public function remove() : *
      {
         super.remove();
      }
   }
}
