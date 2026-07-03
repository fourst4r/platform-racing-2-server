package ui
{
   import com.jiggmin.data.*;
   import flash.display.Loader;
   import flash.events.*;
   import package_4.*;
   
   public class GuildName extends Removable
   {
       
      
      private var m:GuildNameGraphic;
      
      private var loader:Loader;
      
      private var guildId:int;
      
      public function GuildName(param1:int, param2:String, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super();
         this.guildId = param1;
         this.m = new GuildNameGraphic();
         addChild(this.m);
         useHandCursor = true;
         buttonMode = true;
         mouseChildren = false;
         if(param4)
         {
            this.m.nameBox.htmlText = "<b>" + Data.escapeString(param2) + "</b>";
         }
         else
         {
            this.m.nameBox.text = param2;
         }
         this.m.nameBox.width = param5 ? 145 : 110;
         addEventListener(MouseEvent.CLICK,this.clickHandler,false,0,true);
      }
      
      public function makeWidth(param1:Number) : *
      {
         this.m.nameBox.width = param1;
      }
      
      private function clickHandler(param1:MouseEvent) : *
      {
         new GuildPopup(this.guildId);
      }
      
      override public function remove() : *
      {
         removeEventListener(MouseEvent.CLICK,this.clickHandler);
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
