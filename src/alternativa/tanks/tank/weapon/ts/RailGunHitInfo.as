package alternativa.tanks.tank.weapon.ts
{
   import alternativa.physics.Body;
   import alternativa.math.Vector3;
   
   public class RailGunHitInfo
   {
       
      public var t:Number;
      
      public var body:Vector.<Body>;
      
      public var pos:Vector.<Vector3>;
      
      public var dir:Vector3;
      
      public var endDir:Vector3 = null;
      
      public var endPos:Vector3 = null;
      
      public function RailGunHitInfo()
      {
         this.body = new Vector.<Body>();
         this.pos = new Vector.<Vector3>();
         this.dir = new Vector3();
         super();
      }
   }
}
