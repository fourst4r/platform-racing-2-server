package package_18
{
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.utils.*;
   import package_18.PartInfo.*;
   import package_22.*;
   import package_4.*;
   import package_8.Character;
   
   public class PlayerDisplay extends Removable
   {
       
      
      private var character:Character;
      
      private var yStart:Number = 24;
      
      public var randomButton:RandomizeStyleButton;
      
      public var hatSelect:PartSelector;
      
      public var headSelect:PartSelector;
      
      public var bodySelect:PartSelector;
      
      public var feetSelect:PartSelector;
      
      private var hover:HoverPopup;
      
      private var hoverTimer:uint;
      
      public function PlayerDisplay(param1:Character, param2:Array, param3:Array, param4:Array, param5:Array, param6:int, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int, param13:int, param14:Array, param15:Array, param16:Array, param17:Array, param18:int, param19:int, param20:int, param21:int)
      {
         this.randomButton = new RandomizeStyleButton();
         super();
         this.character = param1;
         this.hatSelect = new PartSelector(param2,param6,param10,param14,param18);
         this.headSelect = new PartSelector(param3,param7,param11,param15,param19);
         this.bodySelect = new PartSelector(param4,param8,param12,param16,param20);
         this.feetSelect = new PartSelector(param5,param9,param13,param17,param21);
         this.hatSelect.y = 0;
         this.headSelect.y = this.yStart * 1;
         this.bodySelect.y = this.yStart * 2;
         this.feetSelect.y = this.yStart * 3;
         this.randomButton.addEventListener(MouseEvent.CLICK,this.onRandomClick,false,0,true);
         this.hatSelect.addEventListener(Event.CHANGE,this.updateDisplay,false,0,true);
         this.headSelect.addEventListener(Event.CHANGE,this.updateDisplay,false,0,true);
         this.bodySelect.addEventListener(Event.CHANGE,this.updateDisplay,false,0,true);
         this.feetSelect.addEventListener(Event.CHANGE,this.updateDisplay,false,0,true);
         this.hatSelect.infoButton.addEventListener(MouseEvent.CLICK,this.onInfoMouseEvent,false,0,true);
         this.hatSelect.infoButton.addEventListener(MouseEvent.MOUSE_OVER,this.onInfoMouseEvent,false,0,true);
         this.hatSelect.infoButton.addEventListener(MouseEvent.MOUSE_OUT,this.onInfoMouseEvent,false,0,true);
         this.headSelect.infoButton.addEventListener(MouseEvent.CLICK,this.onInfoMouseEvent,false,0,true);
         this.headSelect.infoButton.addEventListener(MouseEvent.MOUSE_OVER,this.onInfoMouseEvent,false,0,true);
         this.headSelect.infoButton.addEventListener(MouseEvent.MOUSE_OUT,this.onInfoMouseEvent,false,0,true);
         this.bodySelect.infoButton.addEventListener(MouseEvent.CLICK,this.onInfoMouseEvent,false,0,true);
         this.bodySelect.infoButton.addEventListener(MouseEvent.MOUSE_OVER,this.onInfoMouseEvent,false,0,true);
         this.bodySelect.infoButton.addEventListener(MouseEvent.MOUSE_OUT,this.onInfoMouseEvent,false,0,true);
         this.feetSelect.infoButton.addEventListener(MouseEvent.CLICK,this.onInfoMouseEvent,false,0,true);
         this.feetSelect.infoButton.addEventListener(MouseEvent.MOUSE_OVER,this.onInfoMouseEvent,false,0,true);
         this.feetSelect.infoButton.addEventListener(MouseEvent.MOUSE_OUT,this.onInfoMouseEvent,false,0,true);
         this.randomButton.height = this.randomButton.width = 15;
         this.randomButton.x += 122.5;
         this.randomButton.y = (param2.length > 1 ? this.yStart : 0) * -1 + 4.5;
         addChild(this.randomButton);
         if(param2.length > 1)
         {
            addChild(this.hatSelect);
         }
         addChild(this.headSelect);
         addChild(this.bodySelect);
         addChild(this.feetSelect);
         addChild(this.randomButton);
         this.updateDisplay(new Event(Event.CHANGE));
      }
      
      private function onInfoMouseEvent(param1:* = null) : *
      {
         var partType:String = null;
         var pluralType:String = null;
         var e:* = param1;
         if(this.hover != null)
         {
            this.hover.remove();
            this.hover = null;
         }
         partType = e is String ? e : "";
         if(partType == "")
         {
            if(e.currentTarget == this.hatSelect.infoButton)
            {
               partType = "hat";
            }
            else if(e.currentTarget == this.headSelect.infoButton)
            {
               partType = "head";
            }
            else if(e.currentTarget == this.bodySelect.infoButton)
            {
               partType = "body";
            }
            else if(e.currentTarget == this.feetSelect.infoButton)
            {
               partType = "feet";
            }
         }
         clearTimeout(this.hoverTimer);
         if(e is String)
         {
            pluralType = partType == "body" ? "bodies" : (partType == "feet" ? partType : partType + "s");
            this.hover = new HoverPopup(Data.ucfirst(partType) + " Information","See and learn how to obtain all the " + pluralType + " in Platform Racing 2.",this[partType + "Select"].infoButton);
            this.hover.x += this.hover.width + 25;
         }
         if(e is String || e.type == MouseEvent.MOUSE_OUT)
         {
            return;
         }
         if(e.type == MouseEvent.MOUSE_OVER)
         {
            this.hoverTimer = setTimeout(function():*
            {
               onInfoMouseEvent(partType);
            },500);
         }
         else if(e.type == MouseEvent.CLICK)
         {
            new PartInfoPopup(partType,this[partType + "Select"].partArray,this[partType + "Select"].epicArray);
         }
      }
      
      private function onRandomClick(param1:MouseEvent) : *
      {
         this.hatSelect.randomize();
         this.headSelect.randomize();
         this.bodySelect.randomize();
         this.feetSelect.randomize();
         this.updateDisplay(param1);
      }
      
      private function updateDisplay(param1:Event) : *
      {
         this.character.setHatId(this.hatSelect.getValue());
         this.character.setHeadId(this.headSelect.getValue());
         this.character.setBodyId(this.bodySelect.getValue());
         this.character.setFeetId(this.feetSelect.getValue());
         this.character.setHatColors(this.hatSelect.getColor(),this.hatSelect.getColor2());
         this.character.setHeadColors(this.headSelect.getColor(),this.headSelect.getColor2());
         this.character.setBodyColors(this.bodySelect.getColor(),this.bodySelect.getColor2());
         this.character.setFeetColors(this.feetSelect.getColor(),this.feetSelect.getColor2());
         if(this.character.hat1 != AccountInfo.currentHat)
         {
            AccountInfo.currentHat = this.character.hat1;
            if(LevelListing.levelListing != null)
            {
               LevelListing.levelListing.dispatchEvent(new Event("testLevelAccess"));
            }
         }
      }
      
      private function onHatInfoClick(param1:Event) : *
      {
         new PartInfoPopup("hat",this.hatSelect.partArray,this.hatSelect.epicArray);
      }
      
      private function onHeadInfoClick(param1:Event) : *
      {
         new PartInfoPopup("head",this.headSelect.partArray,this.headSelect.epicArray);
      }
      
      private function onBodyInfoClick(param1:Event) : *
      {
         new PartInfoPopup("body",this.bodySelect.partArray,this.bodySelect.epicArray);
      }
      
      private function onFeetInfoClick(param1:Event) : *
      {
         new PartInfoPopup("feet",this.feetSelect.partArray,this.feetSelect.epicArray);
      }
      
      private function removePartSelector(param1:PartSelector) : *
      {
         param1.removeEventListener(Event.CHANGE,this.updateDisplay);
         param1.remove();
         param1 = null;
      }
      
      override public function remove() : *
      {
         this.character = null;
         this.removePartSelector(this.hatSelect);
         this.removePartSelector(this.headSelect);
         this.removePartSelector(this.bodySelect);
         this.removePartSelector(this.feetSelect);
         this.onInfoMouseEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
         this.randomButton.removeEventListener(MouseEvent.CLICK,this.onRandomClick);
         super.remove();
      }
   }
}
