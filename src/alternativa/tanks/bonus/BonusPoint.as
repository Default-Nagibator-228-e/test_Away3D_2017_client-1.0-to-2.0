package alternativa.tanks.bonus
{
   import alternativa.math.Vector3;
   
   public class BonusPoint
   {
       
      public var types:Vector.<int>;
      
      public var posMin:Vector3;
      
      public var posMax:Vector3;
      
      public var rot:Vector3;
      
      public function BonusPoint()
      {
         this.types = new Vector.<int>();
         super();
      }
   }
}
