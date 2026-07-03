package replay
{
   import com.jiggmin.data.Data;
   import fl.controls.Button;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;

   public class ReplayHUD extends Sprite
   {
      private var session:ReplaySession;
      private var playButton:Button;
      private var speedButton:Button;
      private var exitButton:Button;
      private var timeField:TextField;
      private var speedField:TextField;

      public function ReplayHUD(param1:ReplaySession)
      {
         this.session = param1;
         super();
         this.mouseEnabled = true;
         this.createUI();
      }

      private function createUI() : void
      {
         this.playButton = this.createButton("Play");
         this.playButton.move(0,0);
         this.playButton.addEventListener(MouseEvent.CLICK,this.handleTogglePlay,false,0,true);
         addChild(this.playButton);

         this.speedButton = this.createButton("1x");
         this.speedButton.move(70,0);
         this.speedButton.addEventListener(MouseEvent.CLICK,this.handleCycleSpeed,false,0,true);
         addChild(this.speedButton);

         this.exitButton = this.createButton("Exit");
         this.exitButton.move(140,0);
         this.exitButton.addEventListener(MouseEvent.CLICK,this.handleExit,false,0,true);
         addChild(this.exitButton);

         this.timeField = this.createLabel();
         this.timeField.x = 0;
         this.timeField.y = -22;
         addChild(this.timeField);

         this.speedField = this.createLabel();
         this.speedField.x = 70;
         this.speedField.y = -22;
         addChild(this.speedField);
      }

      private function createButton(param1:String) : Button
      {
         var btn:Button = new Button();
         btn.setSize(60,22);
         btn.label = param1;
         btn.useHandCursor = true;
         return btn;
      }

      private function createLabel() : TextField
      {
         var tf:TextField = new TextField();
         tf.defaultTextFormat = new TextFormat("_sans",12,0xFFFFFF);
         tf.autoSize = TextFieldAutoSize.LEFT;
         tf.selectable = false;
         tf.mouseEnabled = false;
         return tf;
      }

      private function handleTogglePlay(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         this.session.togglePlay();
      }

      private function handleCycleSpeed(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         this.session.cycleSpeed();
      }

      private function handleExit(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         this.session.requestExit();
      }

      public function refreshState(param1:Boolean, param2:Number) : void
      {
         var label:String = param1 ? "Pause" : "Play";
         this.setButtonLabel(this.playButton,label);
         this.setButtonLabel(this.speedButton,param2.toFixed(param2 == int(param2) ? 0 : 1) + "x");
      }

      public function refreshTime(param1:int, param2:int) : void
      {
         var elapsed:Number = param1 / 1000;
         var total:Number = param2 / 1000;
         this.timeField.text = Data.formatTime(elapsed) + " / " + Data.formatTime(total);
      }

      private function setButtonLabel(param1:Button, param2:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.label = param2;
      }

      public function dispose() : void
      {
         if(this.playButton != null)
         {
            this.playButton.removeEventListener(MouseEvent.CLICK,this.handleTogglePlay);
         }
         if(this.speedButton != null)
         {
            this.speedButton.removeEventListener(MouseEvent.CLICK,this.handleCycleSpeed);
         }
         if(this.exitButton != null)
         {
            this.exitButton.removeEventListener(MouseEvent.CLICK,this.handleExit);
         }
         this.session = null;
      }
   }
}
