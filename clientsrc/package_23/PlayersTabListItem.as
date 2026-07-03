package package_23
{
   import com.jiggmin.data.*;
   
   public class PlayersTabListItem extends Removable
   {
       
      
      protected var m:PlayersTabListItemGraphic;
      
      protected var htmlNameMaker:HTMLNameMaker;
      
      public function PlayersTabListItem()
      {
         this.m = new PlayersTabListItemGraphic();
         this.htmlNameMaker = new HTMLNameMaker();
         super();
         addChild(this.m);
         this.htmlNameMaker.listenForLink(this.m.nameBox);
      }
      
      override public function remove() : *
      {
         this.htmlNameMaker.remove();
         this.htmlNameMaker = null;
         super.remove();
      }
   }
}
