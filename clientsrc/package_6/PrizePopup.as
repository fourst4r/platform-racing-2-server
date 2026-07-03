package package_6
{
   import com.jiggmin.data.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import package_4.Popup;
   
   public class PrizePopup extends Popup
   {
      
      public static var instance:PrizePopup;
       
      
      private var m:PrizePopupGraphic;
      
      private var target:MovieClip;
      
      private var var_207:EpicFlash;
      
      public function PrizePopup(param1:String, param2:int, param3:String, param4:String = "", param5:Boolean = false, param6:Boolean = false)
      {
         this.m = new PrizePopupGraphic();
         this.var_207 = new EpicFlash();
         if(PrizePopup.instance !== null)
         {
            PrizePopup.instance.remove();
         }
         super(false);
         this.m.exp.visible = false;
         this.m.hat.visible = false;
         this.m.head.visible = false;
         this.m.body.visible = false;
         this.m.foot.visible = false;
         this.m.flavorBg.visible = false;
         this.m.flavor.visible = false;
         if(param4 != "" && param1 != "exp" && param1 != "cancel")
         {
            this.m.flavorBg.visible = true;
            this.m.flavor.visible = true;
            this.m.flavor.text = param4;
            this.m.flavor.autoSize = "left";
            this.m.flavorBg.height = this.m.flavor.height + 15;
         }
         else if((param1 == "eHat" || param1 == "eHead" || param1 == "eBody" || param1 == "eFeet") && param4 == "" && param6 == true)
         {
            this.m.flavorBg.visible = true;
            this.m.flavor.visible = true;
            this.m.flavor.htmlText = "This is an epic upgrade, not a part. For more information, please see <a href=\"https://jiggmin2.com/forums/showthread.php?tid=123\" target=\"_blank\"><font color=\"#0000FF\">this guide</font></a>.";
            this.m.flavor.autoSize = "left";
            this.m.flavorBg.height = this.m.flavor.height + 15;
         }
         this.m.head.hat1.visible = false;
         this.m.head.hat2.visible = false;
         this.m.head.hat3.visible = false;
         this.m.head.hat4.visible = false;
         if(param1 == "hat" || param1 == "eHat")
         {
            this.target = this.m.hat;
         }
         if(param1 == "head" || param1 == "eHead")
         {
            this.target = this.m.head;
         }
         if(param1 == "body" || param1 == "eBody")
         {
            this.target = this.m.body;
         }
         if(param1 == "feet" || param1 == "eFeet")
         {
            this.target = this.m.foot;
         }
         if(param1 == "exp")
         {
            this.m.titleBox.y = -105;
            this.target = this.m.exp;
            if(param4 != "")
            {
               this.target.y = -80;
               this.target.textBox.text = param4;
            }
            else
            {
               this.target.textBox.text = "You already have this prize, so here are " + Data.formatNumber(param2) + " experience points instead!";
            }
         }
         if(param1 == "cancel")
         {
            this.m.bg.y = -120;
            this.m.bg.height = 150;
            this.m.titleBox.y = -105;
            this.m.textBox.visible = false;
            this.m.close_bt.y = -10;
            this.target = this.m.exp;
            this.target.y = -80;
            this.target.textBox.text = param4 + " cancelled the prize for finishing this race.";
         }
         if(param1 == "eHat" || param1 == "eHead" || param1 == "eBody" || param1 == "eFeet")
         {
            this.activateEpicAnimation();
         }
         else if(param1 != "exp" && param1 != "cancel")
         {
            this.target.colorMC2.visible = param1 == "hat" && param2 == 16;
         }
         this.target.visible = true;
         if(param1 != "exp" && param1 != "cancel")
         {
            this.target.gotoAndStop(param2);
            this.target.colorMC.gotoAndStop(param2);
            this.target.colorMC2.gotoAndStop(param2);
         }
         var _loc7_:String = String(Data.aOrAn(param3));
         if(param1 == "feet")
         {
            _loc7_ = "a pair of";
         }
         if(param6)
         {
            this.m.textBox.text = "You won " + _loc7_ + ":";
         }
         else if(param5)
         {
            this.m.textBox.text = "Anyone who finishes this race wins " + _loc7_ + ":";
         }
         else
         {
            this.m.textBox.text = "The winner of this race will earn " + _loc7_ + ":";
         }
         this.m.titleBox.text = param1 === "cancel" ? "-- " + param3 + " --" : "--- " + param3 + "! ---";
         this.m.close_bt.addEventListener(MouseEvent.CLICK,this.clickClose,false,0,true);
         addChild(this.m);
         PrizePopup.instance = this;
      }
      
      private function activateEpicAnimation() : *
      {
         this.var_207.addItem(this.target.colorMC2);
         this.var_207.method_580(300);
         this.var_207.start();
      }
      
      private function clickClose(param1:MouseEvent) : *
      {
         startFadeOut();
      }
      
      override public function remove() : *
      {
         PrizePopup.instance = null;
         if(this.var_207 != null)
         {
            this.var_207.remove();
            this.var_207 = null;
         }
         this.m.close_bt.removeEventListener(MouseEvent.CLICK,this.clickClose);
         super.remove();
      }
   }
}
