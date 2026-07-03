package levelEditor
{
   import com.jiggmin.ColorPicker.*;
   import com.jiggmin.data.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TextObject extends DrawObject
   {
      
      public static var var_380:int = 0;
       
      
      private var textField:TextField;
      
      private var editableTextField:TextField;
      
      private var editButton:EditTextButton;
      
      private var cp:ColorPicker;
      
      private var editing:Boolean = false;
      
      private var text:String;
      
      private var color:int;
      
      public function TextObject(param1:String, param2:int, param3:int, param4:int)
      {
         super(Objects.TextCode,param2,param3);
         this.textField = TextField(m);
         this.textField.wordWrap = false;
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.textField.multiline = true;
         this.textField.textColor = param4;
         this.showParsedText(param1);
         recordRealDimensions();
      }
      
      public static function escapeText(param1:String) : String
      {
         param1 = param1.replace(/#/g,"#35");
         param1 = param1.replace(/`/g,"#96");
         param1 = param1.replace(/&/g,"#38");
         param1 = param1.replace(/,/g,"#44");
         param1 = param1.replace(/\+/g,"#43");
         param1 = param1.replace(/-/g,"#45");
         return param1.replace(/;/g,"#59");
      }
      
      public static function parseText(param1:String) : String
      {
         param1 = param1.replace(/#96/g,"`");
         param1 = param1.replace(/#38/g,"&");
         param1 = param1.replace(/#44/g,",");
         param1 = param1.replace(/#59/g,";");
         param1 = param1.replace(/#43/g,"+");
         param1 = param1.replace(/#45/g,"-");
         return param1.replace(/#35/g,"#");
      }
      
      override protected function onDelPress(param1:KeyboardEvent) : *
      {
         if((this.editing === false || this.editableTextField.text === "") && (param1.keyCode === 46 || param1.keyCode === 8))
         {
            deleteObject();
         }
      }
      
      public function getText() : String
      {
         return this.textField.text;
      }
      
      public function setText(param1:String) : *
      {
         this.textField.text = param1;
         recordRealDimensions();
      }
      
      public function getEscapedText() : String
      {
         return escapeText(this.getText());
      }
      
      public function showParsedText(param1:String) : *
      {
         this.setText(parseText(param1));
      }
      
      public function getColor() : int
      {
         return this.textField.textColor;
      }
      
      public function setColor(param1:int) : *
      {
         this.textField.textColor = param1;
      }
      
      override public function select() : *
      {
         this.addEditButton();
         this.addColorPicker();
         super.select();
         addChild(this.editButton);
         addChild(this.cp);
         this.text = this.getText();
         this.color = this.getColor();
         stageRef.addEventListener(KeyboardEvent.KEY_DOWN,this.onDelPress);
      }
      
      override public function deselect() : *
      {
         super.deselect();
         this.stopEditing();
         this.removeEditButton();
         if(this.cp != null)
         {
            removeChild(this.cp);
         }
         if(this.textField != null && (this.getText() != this.text || this.getColor() != this.color))
         {
            editor.cur.recordChangeText(this);
         }
         stageRef.removeEventListener(KeyboardEvent.KEY_DOWN,this.onDelPress);
      }
      
      public function startEditing() : *
      {
         this.textField.visible = false;
         this.addEditBox();
         this.method_169(null);
         this.removeEditButton();
      }
      
      private function stopEditing() : *
      {
         if(this.editableTextField != null)
         {
            this.textField.visible = true;
            this.textField.text = this.editableTextField.text;
            this.removeEditBox();
            recordRealDimensions();
            if(this.textField.text.replace(/^\s+|\s+$/g,"") === "")
            {
               deleteObject();
            }
         }
      }
      
      private function addEditBox() : *
      {
         this.removeEditBox();
         this.editing = true;
         this.editableTextField = new TextObjectGraphic().textBox;
         m = this.editableTextField;
         addChildAt(this.editableTextField,1);
         Main.stage.focus = this.editableTextField;
         this.editableTextField.type = TextFieldType.INPUT;
         this.editableTextField.wordWrap = false;
         this.editableTextField.autoSize = TextFieldAutoSize.LEFT;
         this.editableTextField.multiline = true;
         this.editableTextField.background = true;
         this.editableTextField.border = true;
         this.editableTextField.selectable = true;
         this.editableTextField.width = this.textField.width;
         this.editableTextField.height = this.textField.height;
         this.editableTextField.maxChars = 500;
         this.editableTextField.text = this.textField.text;
         if(this.editableTextField.width < 100)
         {
            this.editableTextField.width = 100;
         }
         this.editableTextField.addEventListener(Event.CHANGE,this.method_169,false,0,true);
      }
      
      private function removeEditBox() : *
      {
         this.editing = false;
         if(this.editableTextField != null)
         {
            m = this.textField;
            this.editableTextField.removeEventListener(Event.CHANGE,this.method_169);
            this.editableTextField.text = "";
            removeChild(this.editableTextField);
            this.editableTextField = null;
         }
         Main.stage.focus = Main.stage;
      }
      
      private function addEditButton() : *
      {
         this.removeEditButton();
         this.editButton = new EditTextButton();
         this.editButton.addEventListener(MouseEvent.MOUSE_DOWN,this.clickEdit,false,0,true);
         addChild(this.editButton);
      }
      
      private function removeEditButton() : *
      {
         if(this.editButton != null)
         {
            this.editButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.clickEdit);
            removeChild(this.editButton);
            this.editButton = null;
         }
      }
      
      private function addColorPicker() : *
      {
         if(this.cp == null)
         {
            this.cp = new ColorPicker();
            this.cp.setColor(this.getColor());
            this.cp.addEventListener(MouseEvent.MOUSE_DOWN,this.openColorPicker,false,0,true);
            this.cp.addEventListener(Event.CLOSE,this.closeColorPicker,false,0,true);
         }
         addChild(this.cp);
      }
      
      private function removeColorPicker() : *
      {
         if(this.cp != null)
         {
            this.cp.removeEventListener(MouseEvent.MOUSE_DOWN,this.openColorPicker);
            this.cp.removeEventListener(Event.CLOSE,this.closeColorPicker);
            this.cp.remove();
            this.cp = null;
         }
      }
      
      private function openColorPicker(param1:MouseEvent) : *
      {
         this.editing = true;
         param1.stopImmediatePropagation();
      }
      
      private function closeColorPicker(param1:Event) : *
      {
         this.editing = false;
         TextObject.var_380 = this.cp.getColor();
         this.setColor(this.cp.getColor());
      }
      
      private function method_169(param1:Event) : *
      {
         recordRealDimensions();
         hideHighlight();
         this.positionInternals();
      }
      
      override protected function mouseDownHandler(param1:MouseEvent) : *
      {
         if(param1.target != this.editableTextField)
         {
            super.mouseDownHandler(param1);
         }
      }
      
      override protected function positionInternals() : *
      {
         super.positionInternals();
         if(this.editButton != null)
         {
            this.editButton.x = 0;
            this.editButton.y = 0;
            this.editButton.scaleX = buttonScaleX;
            this.editButton.scaleY = buttonScaleY;
         }
         if(this.cp != null)
         {
            this.cp.scaleX = buttonScaleX * 0.4;
            this.cp.scaleY = buttonScaleY * 0.4;
            if(this.cp.scaleX > 0)
            {
               this.cp.x = m.width - this.cp.width / 2;
            }
            else
            {
               this.cp.x = m.width + this.cp.width / 2;
            }
            if(this.cp.scaleY > 0)
            {
               this.cp.y = 0 - this.cp.height / 2;
            }
            else
            {
               this.cp.y = 0 + this.cp.height / 2;
            }
         }
      }
      
      private function clickEdit(param1:MouseEvent) : *
      {
         param1.stopImmediatePropagation();
         this.startEditing();
      }
      
      override public function remove() : *
      {
         this.removeEditBox();
         this.removeEditButton();
         this.removeColorPicker();
         removeChild(this.textField);
         this.textField = null;
         super.remove();
      }
   }
}
