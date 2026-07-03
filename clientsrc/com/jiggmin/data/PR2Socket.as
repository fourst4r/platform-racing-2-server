package com.jiggmin.data
{
   import com.hurlant.crypto.hash.*;
   import com.hurlant.util.*;
   import flash.errors.IOError;
   import flash.events.*;
   import flash.net.Socket;
   import flash.utils.*;
   import menu.*;
   import package_22.*;
   import package_4.*;
   import package_6.*;
   import replay.ReplayCourse;
   
   public class PR2Socket extends Socket
   {
       
      
      private var pingInterval:uint;
      
      public var sendNum:int = 0;
      
      private var endChar:String;
      
      private var md5:MD5;
      
      private var var_363:Time;

      private var intentionalClose:Boolean = false;

      private var simulatedUnexpectedClose:Boolean = false;
      
      public function PR2Socket()
      {
         this.pingInterval = setInterval(this.sendPing,10000);
         this.endChar = String.fromCharCode(4);
         this.md5 = new MD5();
         this.var_363 = new Time();
         super();
         addEventListener(Event.CLOSE,this.closeHandler,false,0,true);
         addEventListener(Event.CONNECT,this.requestLoginId,false,0,true);
         addEventListener(IOErrorEvent.IO_ERROR,this.anyErrorHandler,false,0,true);
         addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.anyErrorHandler,false,0,true);
         addEventListener(ProgressEvent.SOCKET_DATA,this.read,false,0,true);
         CommandHandler.commandHandler.defineCommand("ping",this.receivePing);
      }
      
      override public function connect(param1:String, param2:int) : void
      {
         var wasConnected:Boolean = connected;
         this.close();
         if(!wasConnected)
         {
            this.intentionalClose = false;
         }
         CommandHandler.commandHandler.sendNum = -1;
         super.connect(param1,param2);
      }
      
      override public function close() : void
      {
         this.intentionalClose = true;
         if(connected)
         {
            this.write("close`");
            super.close();
            this.sendNum = 0;
            CommandHandler.commandHandler.sendNum = -1;
         }
         delete Memory.memory["coursePageNumcampaign"];
         delete Memory.memory["campaignInfo" + Campaign.campaignPage];
         Main.isSpecialUser = Main.isPrizer = Main.isTempMod = Main.isTrialMod = false;
         UnreadNotif.reset();
      }

      public function simulateUnexpectedDisconnect() : void
      {
         var handled:Boolean = false;
         if(!connected)
         {
            return;
         }
         this.intentionalClose = false;
         handled = RaceReconnectController.handleSocketClosed(this,new Event(Event.CLOSE));
         this.simulatedUnexpectedClose = handled;
         super.close();
      }
      
      public function write(param1:String) : *
      {
         var _loc2_:String = null;
         var _loc3_:ByteArray = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(connected)
         {
            ++this.sendNum;
            if(this.sendNum == 12)
            {
               ++this.sendNum;
            }
            param1 = this.sendNum + "`" + param1;
            _loc2_ = class_4.method_310(Main.server.server_id) + param1;
            _loc3_ = this.md5.hash(Hex.toArray(Hex.fromString(_loc2_)));
            param1 = (_loc5_ = (_loc4_ = String(Hex.fromArray(_loc3_))).substr(0,3)) + "`" + param1 + this.endChar;
            try
            {
               if(Main.testing == true)
               {
                  trace("Write: " + param1);
               }
               writeUTFBytes(param1);
               flush();
            }
            catch(e:IOError)
            {
            }
         }
      }
      
      private function read(param1:* = null) : *
      {
         CommandHandler.commandHandler.addText(readUTFBytes(bytesAvailable));
      }
      
      private function requestLoginId(param1:Event) : *
      {
         this.write("request_login_id`");
      }
      
      private function closeHandler(param1:Event) : *
      {
         if(this.simulatedUnexpectedClose)
         {
            this.simulatedUnexpectedClose = false;
            return;
         }
         if(this.intentionalClose)
         {
            this.intentionalClose = false;
            return;
         }
         if(RaceReconnectController.handleSocketClosed(this,param1))
         {
            return;
         }
         var currentPage = Main.pageHolder.getCurrentPage();
         if (currentPage is Course && !(currentPage is ReplayCourse))
         {
            var pg:Course = currentPage as Course;
            pg.chatBox.receiveSystemMessage(["D/ced from server. Err: " + param1.toString()]);
         }
         else if(!(currentPage is LoginPage))
         {
            new MessagePopup("Disconnected.");
            Main.pageHolder.changePage(new LoginPage());
         }
         delete Memory.memory["coursePageNumcampaign"];
         delete Memory.memory["campaignInfo" + Campaign.campaignPage];
      }
      
      private function anyErrorHandler(param1:*) : *
      {
         if(RaceReconnectController.handleSocketError())
         {
            return;
         }
         new MessagePopup("Could not connect. This could be because: \n A: My server is broken. \n B: The internet is broken. \n C: Evil aliens.");
         this.remove();
      }
      
      public function sendPing() : *
      {
         if(connected)
         {
            this.write("ping`");
         }
      }
      
      public function receivePing(param1:Array) : *
      {
         var _loc2_:Number = Number(param1);
         var _loc3_:Number = Number(this.var_363.getTimestamp());
         var _loc4_:Number;
         if((_loc4_ = Math.abs(_loc2_ - _loc3_)) > 2)
         {
            this.var_363.setTime(_loc2_);
         }
      }
      
      public function getMS() : Number
      {
         return this.var_363.getMS();
      }
      
      public function remove() : *
      {
         clearInterval(this.pingInterval);
         removeEventListener(Event.CLOSE,this.closeHandler);
         removeEventListener(Event.CONNECT,this.requestLoginId);
         removeEventListener(IOErrorEvent.IO_ERROR,this.anyErrorHandler);
         removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.anyErrorHandler);
         removeEventListener(ProgressEvent.SOCKET_DATA,this.read);
         this.close();
      }
   }
}
