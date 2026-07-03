package package_9
{
   import com.jiggmin.data.*;
   import flash.geom.*;
   import package_6.*;
   
   public class Hat extends class_81
   {
       
      
      private var m:HatGraphic;
      
      private var id:int;
      
      private var sentReturnToStart:Boolean = false;
      
      public function Hat(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int)
      {
         var _loc9_:ColorTransform = null;
         this.m = new HatGraphic();
         super(param1,param2,param3);
         this.id = param7;
         velY = -5;
         scaleX = scaleY = 0.15;
         this.m.gotoAndStop(param4);
         this.m.colorMC.gotoAndStop(param4);
         this.m.colorMC2.gotoAndStop(param4);
         var _loc8_:ColorTransform;
         (_loc8_ = new ColorTransform()).color = param5;
         this.m.colorMC.transform.colorTransform = _loc8_;
         if(param6 == -1 && param4 != 16)
         {
            this.m.colorMC2.visible = false;
         }
         else
         {
            (_loc9_ = new ColorTransform()).color = param4 == 16 && param6 == -1 ? 0 : uint(param6);
            this.m.colorMC2.transform.colorTransform = _loc9_;
         }
         addChild(this.m);
         Course.course.looseHats[this.id] = this;
         CommandHandler.commandHandler.defineCommand("removeHat" + this.id,this.remoteRemove);
      }
      
      override protected function onTouchLocalPlayer() : *
      {
         if(!Course.course.isDonePlaying())
         {
            this.remove();
            Main.socket.write("get_hat`" + this.id);
         }
      }
      
      public function getInfo() : Object
      {
         return {
            "x":posX,
            "y":posY,
            "rot":rot,
            "num":this.m.currentFrame,
            "color":this.m.colorMC.transform.colorTransform.color,
            "color2":this.m.colorMC2.transform.colorTransform.color,
            "id":this.id
         };
      }
      
      public function getPos() : Point
      {
         return new Point(posX,posY);
      }
      
      public function getRot() : int
      {
         return rot;
      }
      
      public function getId() : int
      {
         return this.id;
      }
      
      public function returningToStart() : *
      {
         this.sentReturnToStart = true;
      }
      
      public function remoteRemove(param1:Array) : *
      {
         this.remove();
      }
      
      override public function remove() : *
      {
         if(Course.course != null)
         {
            delete Course.course.looseHats[this.id];
         }
         CommandHandler.commandHandler.defineCommand("removeHat" + this.id,null);
         super.remove();
      }
   }
}
