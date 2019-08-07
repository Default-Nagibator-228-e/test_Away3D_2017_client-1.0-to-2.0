package alternativa.tanks.tank.weapon.ts
{
   import alternativa.math.Vector3;
   
   public class TurretParams
   {
       
      public var xAxis:Vector3;
      
      public var barrelOrigin:Vector3;
      
      public var gunDir:Vector3;
      
      public function TurretParams(param1:Vector3, param2:Vector3, param3:Vector3)
      {
         super();
         this.xAxis = param1;
         this.barrelOrigin = param2;
         this.gunDir = param3;
      }
   }
}
