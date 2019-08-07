package alternativa.tanks.tank.loaders
{
   import away3d.entities.Mesh;
   import away3d.events.AssetEvent;
   import away3d.events.LoaderEvent;
   import away3d.library.assets.AssetType;
   import away3d.loaders.Loader3D;
   import away3d.loaders.parsers.Parsers;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import alternativa.tanks.tank.TankHull;
   import alternativa.tanks.tank.physics.TankPhysicsData;
   
   public class TankHullLoader extends TankPartLoader
   {
       
      public var xml:XML;
      
      public var xmlTrack:XML;
	  
	  private var ur:String;
	  
	  private var xa:TankHull = new TankHull();
	  
	  private var sdfrtr:TankHullParser = new TankHullParser(xa);
      
      public function TankHullLoader(param1:XML, param2:XML)
      {
         super(param1.@path + "model.3ds",param1.@path + "lightmap.jpg",param1.@path + "details.png", xa);
         this.xml = param2;
		 ur = param1.@path + "model.3ds";
		 parseModelData();
      }
      
      private function parseModelData() : void
      {
		 Parsers.enableAllBundled();
         var _container:Loader3D = new Loader3D();
		 _container.scale(10);
		 _container.addEventListener(AssetEvent.ASSET_COMPLETE, onResourceComplete);
		 _container.addEventListener(LoaderEvent.LOAD_ERROR, onResourceLoadingError);
		 _container.load(new URLRequest(ur));
      }
	  
	  private function onResourceComplete(event:AssetEvent) : void
		{
			if (event.asset.assetType == AssetType.MESH) {
				var hull:Mesh = event.asset as Mesh;
				hull.castsShadows = true;
				sdfrtr.parse(hull);
			}
		}
   
	  private function onResourceLoadingError(event:AssetEvent) : void
		{
			new Error("Модельке корпуса не дали догрузиться =)");
		}
   }
}
