package PR2_Graphics_1_Apr_2014_fla
{
   import fl.controls.Button;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class loginInfo_398 extends MovieClip
   {
       
      
      public var logoutButton:Button;
      
      public var textBox:TextField;
      
      public function loginInfo_398()
      {
         super();
         this.logoutButton.label = "Logout";
         this.__setProp_logoutButton_Symbol413_Layer1_0();
      }
      
      internal function __setProp_logoutButton_Symbol413_Layer1_0() : *
      {
         try
         {
            this.logoutButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.logoutButton.emphasized = false;
         this.logoutButton.enabled = true;
         this.logoutButton.label = "Logout";
         this.logoutButton.labelPlacement = "right";
         this.logoutButton.selected = false;
         this.logoutButton.toggle = false;
         this.logoutButton.visible = true;
         try
         {
            this.logoutButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
