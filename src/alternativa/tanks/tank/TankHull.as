package alternativa.tanks.tank
{
   import alternativa.math.Vector3;
   import alternativa.tanks.tank.physics.CollisionBoxData;
   import alternativa.tanks.tank.physics.TankPhysicsData;
   import away3d.entities.Mesh;
   
   public class TankHull extends TankPart
   {
       
      public var trackFaceNums:Vector.<int>;
      
      public var turretBodyMountPoint:Vector3;
      
      public var turretSkinMountPoint:Vector3;
      
      public var bodyData:CollisionBoxData;
      
      public var detailedGeometry:Vector.<CollisionBoxData>;
      
      public var simpleGeometry:Vector.<CollisionBoxData>;
      
      public var leftSuspensionMountPoints:Vector.<Vector3>;
      
      public var rightSuspensionMountPoints:Vector.<Vector3>;
      
      public var physicsProfiles:Vector.<TankPhysicsData>;
      
      public function TankHull()
      {
		 super();
         this.trackFaceNums = new Vector.<int>();
         this.turretBodyMountPoint = new Vector3();
         this.turretSkinMountPoint = new Vector3();
         this.detailedGeometry = new Vector.<CollisionBoxData>();
         this.simpleGeometry = new Vector.<CollisionBoxData>();
         this.leftSuspensionMountPoints = new Vector.<Vector3>();
         this.rightSuspensionMountPoints = new Vector.<Vector3>();
         this.physicsProfiles = new Vector.<TankPhysicsData>();
      }
      
      public function clone() : TankHull
      {
         var _loc1_:TankHull = new TankHull();
         _loc1_.turretBodyMountPoint = this.turretBodyMountPoint;
         _loc1_.turretSkinMountPoint = this.turretSkinMountPoint;
         _loc1_.bodyData = this.bodyData;
         _loc1_.detailedGeometry = this.detailedGeometry;
         _loc1_.simpleGeometry = this.simpleGeometry;
         _loc1_.leftSuspensionMountPoints = this.leftSuspensionMountPoints;
         _loc1_.rightSuspensionMountPoints = this.rightSuspensionMountPoints;
         _loc1_.skin = skin.clone() as Mesh;
         _loc1_.lightmap = lightmap.clone();
         _loc1_.details = details.clone();
         _loc1_.physicsProfiles = this.physicsProfiles;
         _loc1_.trackFaceNums = this.trackFaceNums;
         return _loc1_;
      }
   }
}
