package mishin870.gui.Garage.m2
{
   import flash.display.Sprite;
   
   public class MIndicatorSmall2 extends Sprite
   {
      
      [Embed(source="MIndicatorSmall2/e.png")] private var eClass:Class;
      
      [Embed(source="MIndicatorSmall2/f.png")] private var fClass:Class;
       
      public function MIndicatorSmall2()
      {
         super();
      }
      
      public function setSel(param1:Boolean) : void
      {
         try
         {
            removeChildAt(0);
         }
         catch(e:Error)
         {
         }
         if(param1)
         {
            addChild(new fClass());
         }
         else
         {
            addChild(new eClass());
         }
      }
   }
}
