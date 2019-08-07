package alternativa.tanks.tank.loaders
{
   import alternativa.tanks.tank.TankTurret;
   import alternativa.math.Vector3;
   import away3d.entities.Mesh;
   import flash.geom.Vector3D;
   
   public class TankTurretParser
   {
	   
	  private var hh:TankTurret;
       
      public function TankTurretParser(param1:TankTurret)
      {
         super();
		 hh = param1;
      }
      
      public function parse(param1:Mesh) : void
      {
		 if(param1.name.search("muzzle") != -1)
         {
            parseMuzzle(param1);
         }
		 if(param1.name.search("turret") != -1)
         {
            parseSkin(param1);
         }
      }
      
      private function parseSkin(param1:Mesh) : void
      {
         hh.skin = param1;
      }
      
      private function parseMuzzle(param1:Mesh) : void
      {
         var param2:Vector3D = param1.position;
         //hh.muzzlePoints.push(new Vector3(param2.x, param2.y, param2.z));
		 if (hh.skin != null)
		 {
			hh.muzzlePoints.push(new Vector3(param2.x, param2.y, param2.z - hh.skin.z));
		 }else{
			hh.muzzlePoints.push(new Vector3(param2.x, param2.y, param2.z));
		 }
      }
   }
}
