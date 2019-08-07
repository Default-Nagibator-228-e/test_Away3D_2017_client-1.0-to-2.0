package alternativa.tanks.config
{
   import alternativa.tanks.utils.PhysicsUtils;
   import alternativa.tanks.config.Config;
   import alternativa.tanks.physics.PhysicsScene3D;
   import alternativa.tanks.vos.RigidBodyVO;
   import away3d.bounds.AxisAlignedBoundingBox;
   import away3d.loaders.parsers.Parsers;
   import away3d.materials.methods.BasicNormalMethod;
   import away3d.materials.methods.HeightMapNormalMethod;
   import away3d.materials.methods.SimpleWaterNormalMethod;
   import away3d.materials.methods.SoftShadowMapMethod;
   import away3d.textures.BitmapTexture;
   import away3d.textures.Texture2DBase;
   import away3d.utils.Cast;
   import awayphysics.collision.shapes.AWPBoxShape;
   import awayphysics.collision.shapes.AWPBvhTriangleMeshShape;
   import awayphysics.collision.shapes.AWPCollisionShape;
   import awayphysics.collision.shapes.AWPCompoundShape;
   import awayphysics.collision.shapes.AWPConeShape;
   import awayphysics.collision.shapes.AWPConvexHullShape;
   import awayphysics.collision.shapes.AWPCylinderShape;
   import awayphysics.collision.shapes.AWPSphereShape;
   import awayphysics.collision.shapes.AWPStaticPlaneShape;
   import awayphysics.dynamics.AWPRigidBody;
   import away3d.entities.Mesh;
   import away3d.events.AssetEvent;
   import away3d.events.LoaderEvent;
   import away3d.library.assets.AssetType;
   import away3d.loaders.Loader3D;
   import away3d.materials.TextureMaterial;
   import alternativa.tanks.Game;
   import away3d.materials.methods.TripleFilteredShadowMapMethod;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Loader;
   import flash.events.TimerEvent;
   import flash.geom.Matrix3D;
   import flash.net.URLLoader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import alternativa.math.Vector3;
   import flash.geom.Vector3D;
   import alternativa.math.Matrix3;
   import flash.utils.Timer;
   
   public class TanksMapLoader extends SimpleLoader
   {
      
      private var url:String;
      
      private var _container:Loader3D;
	  
	  private var tim:Timer;
      
      public function TanksMapLoader(param1:Config, param2:String)
      {
         super();
         url = param2;
      }
      
      override public function load() : void
      {
		  //new 
			Parsers.enableAllBundled();
			_container = new Loader3D();
			_container.addEventListener(AssetEvent.ASSET_COMPLETE, xmlCom);
			_container.addEventListener(LoaderEvent.LOAD_ERROR, onResourceLoadingError);
			_container.load(new URLRequest(url));
      }
	  
	  private function xmlCom(event:AssetEvent) : void
      {
			if (event.asset.assetType == AssetType.MESH) {
				Main.instance.game.ind += 1;
				var texture1:TextureMaterial = (event.asset as Mesh).material as TextureMaterial;
				var nor:Texture2DBase;
				if (texture1.normalMap != null)
				{
					nor = texture1.normalMap;
				}
				var td:BitmapData = (texture1.texture as BitmapTexture).bitmapData;
				var texture:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(td),true,true);
				texture.shadowMethod = new SoftShadowMapMethod(Main.instance.game._light,32,0);
				//texture.shadowMethod.epsilon = .007;
				//texture.enableLightFallOff = true;
				texture.lightPicker = Main.instance.game._lightPicker;
				if (nor != null)
				{
					//texture.normalMap = nor;
				}
				//texture.specular = 0.17;
				(event.asset as Mesh).material = texture;
				//(event.asset as Mesh).x = int((event.asset as Mesh).x * 0.999999);
				//(event.asset as Mesh).z = int((event.asset as Mesh).z * 0.999999);
				//(event.asset as Mesh).y = int((event.asset as Mesh).y);
				//(event.asset as Mesh).geometry.scaleUV(1.00002);
				//(event.asset as Mesh).geometry.scale(1.0002);
				//var f:Vector.<Vector3D> = (event.asset as Mesh).transform.decompose();
				//Main.instance.game.p.push(f[0]);
				//Main.instance.game.r.push(f[1]);
				Main.instance.game.m.push(event.asset as Mesh);
				Main.instance.game.tanksmap.addChild(event.asset as Mesh);
				if (Main.instance.game.ind == 994)
				{
					completeLoading();
					url = null;
					_container = null;
					tim = null;
				}
			//tim = new Timer(40000, 1);
            //tim.addEventListener(TimerEvent.TIMER_COMPLETE,function(param1:Event):void
            //{
				//throw new Error(Main.instance.game.ind1);
				//completeLoading();
            //});
            //tim.start();
			}
      }
	  
	  private function createCarShape(param1:Mesh, param2:Vector3D, param3:Vector3D) : AWPCompoundShape {
			var carShape : AWPCompoundShape = new AWPCompoundShape();
			carShape.addChildShape(new AWPConvexHullShape(param1.geometry), param2, param3);
			return carShape;
		}
	  
	  private function onResourceLoadingError(event:AssetEvent) : void
		{
			new Error("Картейке не дали догрузиться =)");
		}
   }
}
