package blocks
{
    import com.jiggmin.data.*;
    import flash.events.*;
    import flash.geom.Point;
    import package_6.*;
    import package_8.LocalCharacter;

    public class MudBlock extends Block
    {

        private var isFading:Boolean = false;

        public function MudBlock()
        {
            super(Objects.BLOCK_MUD);
            safeStand = false;
            active = false;
        }

        override public function onTouch(lc:LocalCharacter):*
        {
            super.onTouch(lc);
            if (!frozen)
            {
                if (!lc.grounded && lc.mode != "freeze" && lc.mode != "hurt" && lc.mode != "frozenSolid2")
                {
                    lc.setMode("water");
                    lc.var_240 = 2;
                    lc.swimAccelXMultiplier = 0.4;
                    lc.swimAccelYMultiplier = 0.55;
                    lc.swimVelDamping = 0.85;
                }
                else
                {
                    lc.targetVelX *= 0.6;
                    lc.traction = 0.1;
                }
                if (lc.parent == Course.course.frontBackground)
                {
                    Course.course.backBackground.addChild(lc);
                }
                var _loc2_:Point = method_18();
                var _loc3_:Point = getSeg();
                lc.var_407 = _loc3_.x;
                lc.var_366 = _loc3_.y;
                // lc.lastSafeX = _loc2_.x + 15;
                // lc.lastSafeY = _loc2_.y + 15;
                this.handleFadeOut();
            }
        }

        public function method_584():*
        {
            this.handleFadeOut();
        }

        private function handleFadeOut():*
        {
            alpha -= 0.1;
            if (alpha < 0.5)
            {
                alpha = 0.5;
            }
            if (!this.isFading)
            {
                this.isFading = true;
                addEventListener(Event.ENTER_FRAME, this.handleFadeIn, false, 0, true);
            }
        }

        private function handleFadeIn(param1:Event):*
        {
            alpha += 0.03;
            if (alpha >= 1)
            {
                alpha = 1;
                this.isFading = false;
                removeEventListener(Event.ENTER_FRAME, this.handleFadeIn);
            }
        }

        override public function remove():*
        {
            removeEventListener(Event.ENTER_FRAME, this.handleFadeIn);
            super.remove();
        }
    }
}
