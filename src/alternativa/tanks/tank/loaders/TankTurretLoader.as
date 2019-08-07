package alternativa.tanks.tank.loaders
{
   import alternativa.tanks.tank.TankTurret;
   import away3d.events.LoaderEvent;
   import away3d.entities.Mesh;
   import away3d.events.AssetEvent;
   import away3d.library.assets.AssetType;
   import away3d.loaders.Loader3D;
   import away3d.loaders.parsers.Parsers;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class TankTurretLoader extends TankPartLoader
   {
	   
	  private var ur:String;
	  private var op:TankTurret = new TankTurret();
	  private var oh:TankTurretParser = new TankTurretParser(op);
       
      public function TankTurretLoader(param1:XML)
      {
         super(param1.@path + "model.3ds", param1.@path + "lightmap.jpg", param1.@path + "details.png",op);
		 ur = param1.@path + "model.3ds";
		 parseModelData();
      }
      
      private function parseModelData() : void
      {
		 Parsers.enableAllBundled();
         var _container:Loader3D = new Loader3D();
		 _container.scale(10);
		 _container.addEventListener(AssetEvent.ASSET_COMPLETE, onResourceComplete);
		 //_container.addEventListener(LoaderEvent.RESOURCE_COMPLETE, gotovo);
		 _container.addEventListener(LoaderEvent.LOAD_ERROR, onResourceLoadingError);
		 _container.load(new URLRequest(ur));
      }
	  
	  private function onResourceComplete(event:AssetEvent) : void
		{
			if (event.asset.assetType == AssetType.MESH) {
				var turret:Mesh = event.asset as Mesh;
				turret.castsShadows = true;
				oh.parse(turret);
			}
		}
   
	  private function onResourceLoadingError(event:AssetEvent) : void
		{
			new Error("Модельке пушки не дали догрузиться =)");
		}
   }
}
