package menu
{
   import fl.controls.ComboBox;
   import flash.events.Event;
   import flash.net.*;
   import flash.utils.*;
   
   public class CheckServers
   {
      
      private static var interval:uint;
      
      private static var target:ComboBox;
      
      private static var servers:Array;
      
      private static var superLoader:SuperLoader = new SuperLoader(true,SuperLoader.j);
      
      private static var active:Boolean = false;
       
      
      public function CheckServers()
      {
         super();
      }
      
      public static function activate() : *
      {
         if(!active)
         {
            deactivate();
            active = true;
            interval = setInterval(load,60000);
            load();
         }
      }
      
      public static function deactivate() : *
      {
         clearInterval(interval);
         active = false;
      }
      
      public static function reload() : *
      {
         load();
      }
      
      private static function maybeLoad() : *
      {
         if(servers == null || servers.length == 0)
         {
            load();
         }
         else
         {
            target.enabled = true;
            target.prompt = "";
         }
      }
      
      private static function load() : *
      {
         if(target != null)
         {
            target.enabled = false;
            target.prompt = "Loading...";
         }
         var _loc1_:URLRequest = new URLRequest(Main.baseURL + "/files/server_status_2.txt");
         superLoader.addEventListener(SuperLoader.d,parseData,false,0,true);
         superLoader.addEventListener(SuperLoader.e,handleError,false,0,true);
         superLoader.load(_loc1_);
      }
      
      private static function parseData(param1:Event) : *
      {
         var _loc2_:Object = null;
         servers = superLoader.parsedData.servers;
         if(target != null)
         {
            if(servers == null || servers.length == 0)
            {
               target.enabled = false;
               target.prompt = "No servers found. :(";
               return;
            }
            target.enabled = true;
            target.prompt = "";
         }
         for each(_loc2_ in servers)
         {
            _loc2_.guild_id = parseInt(_loc2_.guild_id);
            _loc2_.server_id = parseInt(_loc2_.server_id);
            _loc2_.population = parseInt(_loc2_.population);
            _loc2_.port = parseInt(_loc2_.port);
         }
         if(target != null)
         {
            selectServer(target);
         }
      }
      
      private static function handleError(param1:Event) : *
      {
         if(target != null)
         {
            target.enabled = false;
            target.prompt = "No servers found. :(";
         }
      }
      
      public static function determineServer(param1:ComboBox) : *
      {
         target = param1;
         maybeLoad();
         if(servers != null)
         {
            selectServer(target);
         }
      }
      
      public static function removeBox() : *
      {
         target = null;
      }
      
      private static function selectServer(param1:ComboBox) : *
      {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = param1.length;
         if(_loc3_ > 0)
         {
            _loc2_ = true;
         }
         servers.sort(CheckServers.sortServers);
         for each(_loc4_ in servers)
         {
            addToList(param1,_loc4_);
         }
         if(!_loc2_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               if((_loc5_ = param1.getItemAt(_loc6_)).server.guild_id != 0 && _loc5_.server.guild_id == Main.guild && _loc5_.server.status == "open")
               {
                  param1.selectedItem = _loc5_;
                  _loc2_ = true;
                  param1.validateNow();
                  return;
               }
               _loc6_++;
            }
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               if((_loc5_ = param1.getItemAt(_loc6_)).server.guild_id == 0 && _loc5_.server.status == "open" && _loc5_.server.population < 180)
               {
                  param1.selectedItem = _loc5_;
                  _loc2_ = true;
                  param1.validateNow();
                  return;
               }
               _loc6_++;
            }
         }
      }
      
      private static function sortServers(param1:Object, param2:Object) : int
      {
         if(Main.guild != 0)
         {
            if(param1.guild_id == Main.guild && param1.status !== "down")
            {
               return -1;
            }
            if(param2.guild_id == Main.guild)
            {
               return 1;
            }
         }
         if(param1.guild_id == 0 && param2.guild_id != 0)
         {
            return -1;
         }
         if(param1.guild_id != 0 && param2.guild_id == 0)
         {
            return 1;
         }
         if(param1.guild_id == 0 && param2.guild_id == 0)
         {
            if(int(param1.port) < int(param2.port))
            {
               return -1;
            }
            return 1;
         }
         if(param1.guild_id != 0 && param2.guild_id != 0)
         {
            if(int(param1.population) > int(param2.population))
            {
               return -1;
            }
            return 1;
         }
      }
      
      private static function addToList(param1:ComboBox, param2:Object) : *
      {
         var _loc3_:Object = getServerFromId(param2.server_id,param1);
         var _loc4_:*;
         if((_loc4_ = String(param2.status)) == "open")
         {
            _loc4_ = param2.population + " online";
         }
         var _loc5_:* = param2.server_name + " (" + _loc4_ + ")";
         if(param2.happy_hour == 1)
         {
            _loc5_ = "!! " + _loc5_;
         }
         if(param2.guild_id != 0)
         {
            _loc5_ = "* " + _loc5_;
         }
         if(_loc3_ == null)
         {
            _loc3_ = {
               "label":_loc5_,
               "server":param2
            };
            if(Main.beta == false || Main.beta == true && param2.guild_id == 205)
            {
               param1.addItem(_loc3_);
            }
         }
      }
      
      private static function getServerFromId(param1:int, param2:ComboBox) : Object
      {
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         while(_loc3_ < _loc4_)
         {
            if((_loc5_ = param2.getItemAt(_loc3_)).server.server_id == param1)
            {
               _loc6_ = _loc5_;
               break;
            }
            _loc3_++;
         }
         return _loc6_;
      }
   }
}
