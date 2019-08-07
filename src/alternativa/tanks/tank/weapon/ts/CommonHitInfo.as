package alternativa.tanks.tank.weapon.ts
{
   import alternativa.physics.Body;
   import alternativa.math.Vector3;
   
   public class CommonHitInfo
   {
       
      public var t:Number;
      
      public var body:Body;
      
      public var pos:Vector3;
      
      public var dir:Vector3;
      
      public function CommonHitInfo()
      {
         this.pos = new Vector3();
         this.dir = new Vector3();
         super();
      }
   }
}
