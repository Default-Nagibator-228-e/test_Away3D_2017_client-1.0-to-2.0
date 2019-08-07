package alternativa.tanks.tank.loaders
{
   import alternativa.tanks.tank.TankHull;
   import away3d.entities.Mesh;
   import flash.geom.Vector3D;
   import alternativa.tanks.tank.physics.CollisionBoxData;
   import alternativa.math.Vector3;
   import alternativa.math.Matrix4;
   
   public class TankHullParser
   {
      
      private var leftSprings:Array;
      
      private var rightSprings:Array;
	  
	  private var asder:TankHull;
       
      public function TankHullParser(param1:TankHull)
      {
         asder = param1;
      }
      
      public function parse(param1:Mesh) : void
      {
		 if(param1.name.search("mount") != -1)
         {
            parseMountPoint(param1);
         }
		 if(param1.name.search("hull") != -1)
         {
            parseSkin(param1);
         }
      }
      
      private function parseSkin(param1:Mesh) : void
      {
         asder.skin = param1;
      }
      
      private function parseMountPoint(param1:Mesh) : void
      {
         var param2:Vector3D = param1.position;
         asder.turretBodyMountPoint.x = param2.x;
         asder.turretBodyMountPoint.y = param2.y;
         asder.turretBodyMountPoint.z = param2.z;
         asder.turretSkinMountPoint.x = param2.x;
         asder.turretSkinMountPoint.y = param2.y;
		 asder.turretSkinMountPoint.z = param2.z;
		 if (asder.skin != null)
		 {
			asder.turretBodyMountPoint.z = param2.z - asder.skin.z;
			asder.turretSkinMountPoint.z = param2.z - asder.skin.z;
		 }
      }
   }
}
