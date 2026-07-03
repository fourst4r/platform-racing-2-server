package menu
{
   import com.jiggmin.data.*;
   import package_4.*;
   
   public class KongOutfitPopup extends OutfitPopup
   {
       
      
      public function KongOutfitPopup()
      {
         var message:String = String(Data.urlify("https://kongregate.com/","Kongregate"));
         message += " sponsored this game way back in 2008. Since then, the game has logged over 30 million plays on Kongregate alone! In honor of all the success PR2 has had in partnership with Kong, will you accept this special outfit?";
         var outfit:Object = {
            "hats":[3,1,1,1],
            "head":20,
            "body":17,
            "feet":16,
            "colors":{
               "hats":[[10027008,-1]],
               "head":[10027008,-1],
               "body":[10027008,-1],
               "feet":[10027008,-1]
            }
         };
         super(function():*
         {
            Main.awardKongNextLogin = true;
            new MessagePopup("Great success! You\'ll receive the Ant Set and the Kong Hat the next time you log in.");
            startFadeOut();
         },outfit,message);
      }
   }
}
