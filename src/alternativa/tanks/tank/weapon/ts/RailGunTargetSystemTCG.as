package alternativa.tanks.tank.weapon.ts
{
   import alternativa.tanks.tank.Tank;
   
   public class RailGunTargetSystemTCG
   {
       
      public var nearestTank:Tank;
      
      public function RailGunTargetSystemTCG(param1:Tank)
      {
         super();
         this.nearestTank = param1;
      }
   }
}
