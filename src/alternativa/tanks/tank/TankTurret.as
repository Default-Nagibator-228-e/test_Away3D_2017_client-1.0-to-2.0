package alternativa.tanks.tank
{
   import alternativa.tanks.tank.physics.CollisionBoxData;
   import alternativa.math.Vector3;
   import away3d.entities.Mesh;
   
   public class TankTurret extends TankPart
   {
       
      public var turretBoxes:Vector.<CollisionBoxData>;
      
      public var barrelBoxes:Vector.<CollisionBoxData>;
      
      public var muzzlePoints:Vector.<Vector3>;
      
      public var flagMountPoint:Vector3;
      
      public function TankTurret()
      {
         this.turretBoxes = new Vector.<CollisionBoxData>();
         this.barrelBoxes = new Vector.<CollisionBoxData>();
         this.muzzlePoints = new Vector.<Vector3>();
         this.flagMountPoint = new Vector3();
         super();
      }
      
      public function clone() : TankTurret
      {
         var _loc1_:TankTurret = new TankTurret();
         _loc1_.turretBoxes = this.turretBoxes;
         _loc1_.barrelBoxes = this.barrelBoxes;
         _loc1_.muzzlePoints = this.muzzlePoints;
         _loc1_.flagMountPoint = this.flagMountPoint;
         _loc1_.skin = skin;
         _loc1_.lightmap = lightmap;
         _loc1_.details = details;
         return _loc1_;
      }
   }
}
