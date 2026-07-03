package page
{
   public class PageHolder extends Removable
   {
       
      
      private var currentPage:Page;
      
      public function PageHolder(param1:Page = null)
      {
         super();
         if(param1 != null)
         {
            this.changePage(param1);
         }
      }
      
      public function changePage(param1:Page) : *
      {
         if(this.currentPage != null)
         {
            this.currentPage.remove();
            if(this.currentPage.parent != null)
            {
               this.currentPage.parent.removeChild(this.currentPage);
            }
         }
         if(param1 != null)
         {
            param1.initialize();
            addChild(param1);
            this.currentPage = param1;
         }
      }
      
      override public function remove() : *
      {
         if(this.currentPage != null)
         {
            this.currentPage.remove();
         }
         super.remove();
      }
      
      public function getCurrentPage() : Page
      {
         return this.currentPage;
      }
   }
}
