package ui
{
   import flash.events.*;
   import flash.geom.*;
   import flash.media.*;
   
   public class MuteButton extends Removable
   {
      
      public static var muted:Boolean = true;
       
      
      private var m:MuteButtonGraphic;
      
      public function MuteButton()
      {
         this.m = new MuteButtonGraphic();
         super();
         addChild(this.m);
         addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         addEventListener(MouseEvent.MOUSE_OVER,this.hoverOverColorChange,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.hoverOutColorChange);
         this.doToggle(false);
      }
      
      public function toggle() : *
      {
         this.doToggle(!MuteButton.muted);
      }
      
      public function doToggle(param1:Boolean) : *
      {
         var _loc2_:SoundTransform = new SoundTransform();
         MuteButton.muted = param1;
         this.m.button.waves.visible = !MuteButton.muted;
         if(MuteButton.muted)
         {
            _loc2_.volume = 0;
         }
         else
         {
            _loc2_.volume = 1;
         }
         SoundMixer.soundTransform = _loc2_;
      }
      
      private function onClick(param1:MouseEvent) : *
      {
         this.toggle();
      }
      
      private function hoverOverColorChange(param1:MouseEvent) : *
      {
         var _loc2_:ColorTransform = new ColorTransform(0.5,0.5,0.5,1,127,127,127,0);
         this.m.button.transform.colorTransform = _loc2_;
      }
      
      private function hoverOutColorChange(param1:MouseEvent) : *
      {
         var _loc2_:ColorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
         this.m.button.transform.colorTransform = _loc2_;
      }
      
      override public function remove() : *
      {
         removeEventListener(MouseEvent.CLICK,this.onClick);
         removeEventListener(MouseEvent.MOUSE_OVER,this.hoverOverColorChange);
         removeEventListener(MouseEvent.MOUSE_OUT,this.hoverOutColorChange);
         removeChild(this.m);
         this.m = null;
         super.remove();
      }
   }
}
