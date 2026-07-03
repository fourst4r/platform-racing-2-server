package package_6
{
   import com.jiggmin.data.*;
   
   public class DrawingInfo extends Removable
   {
       
      
      private var m:DrawingInfoGraphic;
      
      private var cm:CommandHandler;
      
      private var names:Array;
      
      public function DrawingInfo()
      {
         this.m = new DrawingInfoGraphic();
         this.cm = CommandHandler.commandHandler;
         this.names = new Array();
         super();
         this.m.info1.anim0.visible = this.m.info1.anim1.visible = this.m.info1.anim2.visible = this.m.info1.anim3.visible = this.m.info2.anim0.visible = this.m.info2.anim1.visible = this.m.info2.anim2.visible = this.m.info2.anim3.visible = false;
         this.m.info1.anim4.visible = this.m.info1.anim5.visible = this.m.info1.anim6.visible = this.m.info1.anim7.visible = this.m.info2.anim4.visible = this.m.info2.anim5.visible = this.m.info2.anim6.visible = this.m.info2.anim7.visible = false;
         addChild(this.m);
         this.cm.defineCommand("finishDrawing",this.finishDrawing);
         this.cm.defineCommand("finishTimes",this.finishRace);
      }
      
      public function finishRace(param1:Array) : *
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:* = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:Array = null;
         this.clear();
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ + 1 < param1.length)
         {
            if(this.m.info1["nameBox0"].text == "" && _loc2_ > 0)
            {
               _loc2_ = 0;
            }
            _loc4_ = String(param1[_loc3_]);
            _loc5_ = String(param1[_loc3_ + 1]);
            _loc6_ = Boolean(param1[_loc3_ + 2]);
            _loc7_ = Boolean(param1[_loc3_ + 3]);
            var localSecs = Number(param1[_loc3_ + 4]) / 1000;
            if(_loc4_.toLowerCase() == Main.loggedInAs.toLowerCase() && _loc5_ != "forfeit")
            {
               _loc9_ = Course.course.getCourseID();
               _loc10_ = "";
               if(_loc9_ == 50815)
               {
                  _loc10_ = "Newbieland 2";
               }
               if(_loc9_ == 80814)
               {
                  _loc10_ = "Mario Bros Remix";
               }
               if(_loc9_ == 7376)
               {
                  _loc10_ = "Soul Temple";
               }
               if(_loc9_ == 102573)
               {
                  _loc10_ = "Razor Blade";
               }
               if(_loc9_ == 81998)
               {
                  _loc10_ = "New York";
               }
               if(_loc9_ == 1990682)
               {
                  _loc10_ = "Blacklight";
               }
               if(_loc9_ == 3460484)
               {
                  _loc10_ = "Candyland";
               }
               if(_loc9_ == 76127)
               {
                  _loc10_ = "Zerostar";
               }
               if(_loc9_ == 84156)
               {
                  _loc10_ = "Hat Factory";
               }
               if(_loc10_ != "")
               {
                  if(Main.instance.kongAPI != null)
                  {
                     Main.instance.kongAPI.stats.submit(_loc10_,_loc5_);
                  }
               }
            }
            _loc8_ = "";
            if(_loc6_)
            {
               this.m.info1["anim" + _loc2_].visible = this.m.info2["anim" + _loc2_].visible = true;
            }
            else if(Course.course.gameMode == Modes.obj)
            {
               _loc8_ = (_loc11_ = _loc5_.split(","))[0] != "forfeit" ? String(Data.formatTime(localSecs,"decimal")) : String(_loc11_[0]);
               // _loc8_ = (_loc11_ = _loc5_.split(","))[0] != "forfeit" ? String(Data.formatTime(Number(_loc11_[0]),"decimal")) : String(_loc11_[0]);
               if(_loc11_[1] != null && _loc11_[2] != null)
               {
                  _loc8_ += " (" + int(_loc11_[1]) + "/" + int(_loc11_[2]) + ")";
               }
            }
            else if(_loc5_ > 0 && _loc5_ != "forfeit" && Course.course != null && Course.course.gameMode != "egg")
            {
               _loc8_ = Data.formatTime(localSecs,"decimal");
               // _loc8_ = String(Data.formatTime(Number(_loc5_),"decimal"));
            }
            else
            {
               _loc8_ = _loc5_;
            }
            // Append local player's frame count like "@532"
            if(_loc4_.toLowerCase() == Main.loggedInAs.toLowerCase() && _loc5_ != "forfeit" && Course.course != null && Course.course.localFinishFrames >= 0)
            {
               _loc8_ += " @" + Course.course.localFinishFrames;
            }
            if(!_loc7_)
            {
               _loc8_ += " (gone)";
            }
            this.m.info1["timeBox" + _loc2_].text = this.m.info2["timeBox" + _loc2_].text = _loc8_;
            this.m.info1["nameBox" + _loc2_].text = this.m.info2["nameBox" + _loc2_].text = _loc4_;
            _loc2_++;
            _loc3_ += 5;
         }
         while(_loc2_ < 8)
         {
            this.m.info1["timeBox" + _loc2_].text = this.m.info2["timeBox" + _loc2_].text = "";
            this.m.info1["nameBox" + _loc2_].text = this.m.info2["nameBox" + _loc2_].text = "";
            this.m.info1["anim" + _loc2_].visible = this.m.info2["anim" + _loc2_].visible = false;
            _loc2_++;
         }
      }
      
      public function finishDrawing(param1:Array) : *
      {
         var _loc2_:int = int(param1[0]);
         this.m.info1["anim" + _loc2_].visible = this.m.info2["anim" + _loc2_].visible = false;
      }
      
      public function method_138(param1:String, param2:int) : *
      {
         this.names[param2] = param1;
         this.m.info1["nameBox" + param2].text = this.m.info2["nameBox" + param2].text = param1;
         this.m.info1["anim" + param2].visible = this.m.info2["anim" + param2].visible = true;
      }
      
      public function clear() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            if(this.m.info1["timeBox" + _loc1_].text == "")
            {
               this.m.info1["nameBox" + _loc1_].text = this.m.info2["nameBox" + _loc1_].text = "";
            }
            if(this.m.info1["anim" + _loc1_].parent == this.m.info1)
            {
               this.m.info1["anim" + _loc1_].visible = this.m.info2["anim" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      override public function remove() : *
      {
         this.cm.defineCommand("finishTimes",null);
         this.cm.defineCommand("finishDrawing",null);
         this.names = null;
         super.remove();
      }
   }
}
