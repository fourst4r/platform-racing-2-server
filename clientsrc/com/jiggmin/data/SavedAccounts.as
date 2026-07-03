package com.jiggmin.data
{
   import flash.net.*;
   
   public class SavedAccounts
   {
      
      private static var cookieId:*;
      
      private static var accounts:Array = null;
       
      
      public function SavedAccounts()
      {
         super();
      }
      
      public static function init() : *
      {
         cookieId = Main.baseURL.substr(-3) === "dev" ? "pr2hub_dev_logged_in" : "pr2hub_logged_in";
         getCookie();
      }
      
      private static function getCookie() : *
      {
         var _loc1_:SharedObject = null;
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         accounts = [];
         try
         {
            _loc1_ = SharedObject.getLocal(cookieId);
            _loc2_ = 0;
            while(_loc2_ < _loc1_.data.accounts.length)
            {
               _loc3_ = _loc1_.data.accounts[_loc2_];
               _loc3_.name = Data.trimWhitespace(_loc3_.name);
               if(_loc3_.name != "")
               {
                  accounts.push(_loc3_);
               }
               _loc2_++;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private static function setCookie() : *
      {
         var _loc1_:SharedObject = null;
         var _loc2_:int = 0;
         try
         {
            _loc1_ = SharedObject.getLocal(cookieId);
            _loc1_.data.accounts = [];
            _loc2_ = 0;
            while(_loc2_ < accounts.length)
            {
               _loc1_.data.accounts.push(accounts[_loc2_]);
               _loc2_++;
            }
            _loc1_.flush();
         }
         catch(e:Error)
         {
         }
         getCookie();
      }
      
      public static function getAll() : *
      {
         return accounts;
      }
      
      private static function getArrayPos(param1:String, param2:String = "name") : *
      {
         var _loc4_:Object = null;
         var _loc3_:int = 0;
         while(_loc3_ < accounts.length)
         {
            _loc4_ = accounts[_loc3_];
            if(param2 === "name" && _loc4_.name.toLowerCase() === Data.trimWhitespace(param1).toLowerCase() || param2 === "token" && _loc4_.token === param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public static function getByName(param1:String) : *
      {
         var _loc2_:int = int(getArrayPos(param1));
         return _loc2_ > -1 ? accounts[_loc2_] : null;
      }
      
      public static function add(param1:String, param2:String) : *
      {
         if(Data.trimWhitespace(param1) == "")
         {
            return;
         }
         if(getByName(param1) !== null)
         {
            updateToken(param1,param2);
            moveToTop(param1);
            return;
         }
         accounts.unshift({
            "name":Data.trimWhitespace(param1),
            "token":param2
         });
         setCookie();
      }
      
      public static function deleteAccount(param1:String, param2:String = "name") : *
      {
         var _loc3_:int = int(getArrayPos(param1,param2));
         if(_loc3_ === -1)
         {
            return false;
         }
         accounts.removeAt(_loc3_);
         setCookie();
      }
      
      private static function updateToken(param1:String, param2:String) : *
      {
         var _loc3_:int = int(getArrayPos(param1));
         if(_loc3_ === -1)
         {
            return false;
         }
         accounts[_loc3_].token = param2;
         setCookie();
      }
      
      private static function moveToTop(param1:String) : *
      {
         var _loc2_:int = int(getArrayPos(param1));
         if(_loc2_ <= -1)
         {
            return false;
         }
         accounts.unshift(accounts.removeAt(_loc2_));
         setCookie();
      }
   }
}
