package mishin870.gui.Garage.m2
{
   import flash.display.Sprite;
   
   public class MIndicator2 extends Sprite
   {
       
      private var mb:Vector.<mishin870.gui.Garage.m2.MIndicatorSmall2>;
      
      public function MIndicator2(param1:int)
      {
         super();
         this.mb = new Vector.<mishin870.gui.Garage.m2.MIndicatorSmall2>();
         this.mb.push(new mishin870.gui.Garage.m2.MIndicatorSmall2());
         this.mb.push(new mishin870.gui.Garage.m2.MIndicatorSmall2());
         this.mb.push(new mishin870.gui.Garage.m2.MIndicatorSmall2());
         var _loc2_:int = 0;
         while(_loc2_ < this.mb.length)
         {
            this.mb[_loc2_].x = _loc2_ * 12;
            this.mb[_loc2_].setSel(_loc2_ < param1);
            addChild(this.mb[_loc2_]);
            _loc2_++;
         }
      }
      
      public function setM(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.mb.length)
         {
            this.mb[_loc2_].setSel(_loc2_ < param1);
            _loc2_++;
         }
      }
   }
}
