package package_23
{
   import com.jiggmin.data.*;
   
   public class Online extends PlayersTabList
   {
       
      
      private var cm:CommandHandler;
      
      public function Online()
      {
         this.cm = CommandHandler.commandHandler;
         super();
         hideLoadingGraphic();
         this.cm.defineCommand("addUser",this.addUser);
         Main.socket.write("get_online_list`");
      }
      
      public function addUser(param1:Array) : *
      {
         var _loc2_:String = String(param1[0]);
         var _loc3_:String = String(param1[1]);
         var _loc4_:int = int(param1[2]);
         var _loc5_:int = int(param1[3]);
         method_138(_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      override public function remove() : *
      {
         this.cm.defineCommand("addUser",null);
         this.cm = null;
         super.remove();
      }
   }
}
