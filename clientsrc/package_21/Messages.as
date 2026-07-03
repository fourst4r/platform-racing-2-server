package package_21
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.net.*;
   import package_4.*;
   import page.Page;
   import ui.*;
   
   public class Messages extends Page
   {
       
      
      private var m:MessagesGraphic;
      
      private var scrollBar:CustomScrollBar;
      
      private var loadingGraphic:LoadingGraphic;
      
      private var pageNavigation:PageNavigation;
      
      private var loader:SuperLoader;
      
      private var messagesArray:Array;
      
      private var uploading:UploadingPopup;
      
      private var var_167:int = 1;
      
      private var var_564:int = 10;
      
      public function Messages()
      {
         this.m = new MessagesGraphic();
         this.scrollBar = new CustomScrollBar();
         this.loadingGraphic = new LoadingGraphic();
         super();
         this.pageNavigation = new PageNavigation(this,"minimal",1,99,110);
         this.loader = new SuperLoader(true,SuperLoader.j);
         this.messagesArray = new Array();
         this.scrollBar.x = 176;
         this.scrollBar.init(this.m.var_295,340,330);
         addChild(this.scrollBar);
         this.pageNavigation.x = 33;
         this.m.sendMessage_bt.addEventListener(MouseEvent.CLICK,this.clickSend,false,0,true);
         this.m.deleteAll_bt.addEventListener(MouseEvent.CLICK,this.clickDeleteAll,false,0,true);
         addChild(this.m);
         this.loadingGraphic.x = 88;
         this.loadingGraphic.y = 150;
         this.loader.addEventListener(SuperLoader.d,this.handleData);
         this.loader.addEventListener(SuperLoader.e,this.handleError);
         this.getMessages();
         UnreadNotif.updateLastRead();
      }
      
      private function clickSend(param1:MouseEvent) : *
      {
         new SendMessagePopup();
      }
      
      private function getMessages() : *
      {
         this.removeMessages();
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.start = (this.var_167 - 1) * this.var_564;
         _loc1_.count = this.var_564;
         var _loc2_:URLRequest = new URLRequest(Main.baseURL + "/messages_get.php");
         _loc2_.data = _loc1_;
         this.loader.load(_loc2_);
         addChild(this.loadingGraphic);
      }
      
      private function handleData(param1:Event) : *
      {
         var _loc2_:Object = null;
         var _loc3_:MessagesItem = null;
         removeChild(this.loadingGraphic);
         this.pageNavigation.y = 50;
         this.m.var_295.addChild(this.pageNavigation);
         this.scrollBar.position(0);
         for each(_loc2_ in this.loader.parsedData.messages)
         {
            _loc3_ = new MessagesItem(this,_loc2_.message_id,_loc2_.name,_loc2_.group,_loc2_.message,_loc2_.guild_message,_loc2_.time,_loc2_.user_id);
            this.messagesArray.push(_loc3_);
         }
         this.populateMessages();
      }
      
      private function populateMessages() : *
      {
         var _loc3_:MessagesItem = null;
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.messagesArray.length)
         {
            _loc3_ = this.messagesArray[_loc2_];
            _loc3_.y = _loc1_;
            this.m.var_295.addChild(_loc3_);
            _loc1_ += Math.round(_loc3_.height) + 18;
            _loc2_++;
         }
         this.pageNavigation.y = _loc1_ + 10;
      }
      
      private function removeMessages() : *
      {
         var _loc2_:MessagesItem = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.messagesArray.length)
         {
            _loc2_ = this.messagesArray[_loc1_];
            _loc2_.remove();
            _loc1_++;
         }
         this.messagesArray = new Array();
         if(this.pageNavigation.parent == this.m.var_295)
         {
            this.m.var_295.removeChild(this.pageNavigation);
         }
      }
      
      public function doReport(param1:MessagesItem) : *
      {
         param1.alpha = 0.5;
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.message_id = param1.messageId;
         var _loc3_:URLRequest = new URLRequest(Main.baseURL + "/message_report.php");
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         this.uploading = new UploadingPopup(_loc3_,"json","Reporting message...");
      }
      
      public function doDelete(param1:MessagesItem) : *
      {
         param1.alpha = 0.25;
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.message_id = param1.messageId;
         var _loc3_:URLRequest = new URLRequest(Main.baseURL + "/message_delete.php");
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         this.uploading = new UploadingPopup(_loc3_,"json","Deleting message...");
      }
      
      private function handleError(param1:Event) : *
      {
         removeChild(this.loadingGraphic);
      }
      
      private function clickDeleteAll(param1:MouseEvent) : *
      {
         new ConfirmPopup(this.doDeleteAll,"Are you sure you want to delete all of your messages?");
      }
      
      public function doDeleteAll() : *
      {
         var _loc1_:URLVariables = new URLVariables();
         var _loc2_:URLRequest = new URLRequest(Main.baseURL + "/messages_delete_all.php");
         _loc2_.data = _loc1_;
         _loc2_.method = URLRequestMethod.POST;
         new UploadingPopup(_loc2_,"json","Deleting messages...");
         this.removeMessages();
      }
      
      public function setPageNum(param1:int) : *
      {
         this.var_167 = param1;
         this.getMessages();
      }
      
      override public function remove() : *
      {
         this.removeMessages();
         this.m.sendMessage_bt.removeEventListener(MouseEvent.CLICK,this.clickSend);
         this.m.deleteAll_bt.removeEventListener(MouseEvent.CLICK,this.clickDeleteAll);
         this.loader.removeEventListener(SuperLoader.d,this.handleData);
         this.loader.removeEventListener(SuperLoader.e,this.handleError);
         this.loader.remove();
         this.loader = null;
         this.pageNavigation.remove();
         this.scrollBar.remove();
         this.messagesArray = new Array();
         if(this.uploading != null)
         {
            this.uploading.remove();
            this.uploading = null;
         }
         super.remove();
      }
   }
}
