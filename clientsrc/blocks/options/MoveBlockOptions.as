package blocks.options
{
   import blocks.Block;
   import fl.events.ComponentEvent;
   
   public class MoveBlockOptions extends BlockOptions
   {
      public function MoveBlockOptions(param1:Block)
      {
         m = new MoveBlockOptionsGraphic();
         super(param1);

         var opts:Array = param1.options.split(":");
         // If no options, show empty fields (not forced defaults)
         m.patternInput.text = opts[0] != null ? opts[0] : "";
         m.intervalInput.text = opts.length > 1 && opts[1] != null && opts[1] != "" ? opts[1] : "";

         var bitFlags:int = 1;
         if (opts.length > 2 && opts[2] != null && opts[2] != "") {
            var numericFlags:Number = Number(opts[2]);
            if (!isNaN(numericFlags)) {
               bitFlags = int(numericFlags);
            }
         }

         m.loopCheck.label = "Loop";
         m.loopCheck.selected = (bitFlags & 1) != 0;

         m.rigidCheck.label = "Rigid";
         m.rigidCheck.selected = (bitFlags & 2) != 0;

         m.patternInput.addEventListener(ComponentEvent.ENTER, validatePattern);
         m.intervalInput.addEventListener(ComponentEvent.ENTER, validateInterval);
      }

      private function validatePattern(e:*=null):void {
         var text:String = m.patternInput.text.toUpperCase();
         var valid:String = "";
         for(var i:int = 0; i < text.length; i++) {
            var char:String = text.charAt(i);
            if("NESW".indexOf(char) != -1) {
               valid += char;
            }
         }
         // Only set default if empty after validation
         m.patternInput.text = valid;
      }

      private function validateInterval(e:*=null):void {
         var num:Number = Number(m.intervalInput.text);
         if(isNaN(num) || num < 0.1) num = 5;
         m.intervalInput.text = String(num);
      }

      override public function remove():* {
         validatePattern();
         validateInterval();
         var bitFlags:int = 0;
         if (m.loopCheck.selected) {
            bitFlags |= 1;
         }
         if (m.rigidCheck && m.rigidCheck.selected) {
            bitFlags |= 2;
         }

         var parts:Array = [m.patternInput.text, m.intervalInput.text, String(bitFlags)];
         block.applyOptions(parts.join(":"));
         super.remove();
      }
   }
}
