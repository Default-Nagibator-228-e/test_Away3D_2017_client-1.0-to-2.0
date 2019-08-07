package alternativa.tanks.config 
{
	import alternativa.tanks.utils.PhysicsUtils;
   import alternativa.tanks.config.Config;
   import alternativa.tanks.physics.PhysicsScene3D;
   import alternativa.tanks.vos.RigidBodyVO;
   import away3d.bounds.AxisAlignedBoundingBox;
   import away3d.containers.ObjectContainer3D;
   import away3d.utils.Cast;
   import awayphysics.collision.dispatch.AWPCollisionObject;
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
	/**
	 * ...
	 * @author 
	 */
	public class TrackLoader extends SimpleLoader
	{
		
		private var _container:Loader3D = new Loader3D();
		private var dfr:Game = Main.instance.game;
		private var carBody : AWPRigidBody;
		private var carBody1 : AWPRigidBody;
		private var carBody2 : AWPRigidBody;
		private var carBody3 : AWPRigidBody;
		private var carShape : AWPCompoundShape = new AWPCompoundShape();
		
		public function TrackLoader() 
		{
			super();
		}
		
		override public function load() : void
		{
			_container.addEventListener(LoaderEvent.RESOURCE_COMPLETE, xmlCom);
			_container.addEventListener(LoaderEvent.LOAD_ERROR, onResourceLoadingError);
			_container.load(new URLRequest("50.3ds"));
		}
	  
	  private function xmlCom(event:LoaderEvent) : void
      {
			//if (event.asset.assetType == AssetType.MESH) {
				dfr.ind1 += 1;
				dfr.container1 = ObjectContainer3D(event.target);
				//dfr._view.scene.addChild(dfr.container1);
				var mesh : Mesh;
				for (var i : int = 0; i < dfr.container1.numChildren; i++) {
					mesh = Mesh(dfr.container1.getChildAt(i));
					mesh.geometry.scale(10);
				}
				completeLoading();
				/*
				dfr.gus = (event.asset as Mesh);
				dfr.gus1 = (event.asset as Mesh).clone() as Mesh;
				dfr.gus2 = (event.asset as Mesh).clone() as Mesh;
				dfr.gus3 = (event.asset as Mesh).clone() as Mesh;
				dfr.container.addChild(dfr.gus);
				//dfr.gus.geometry.scale(2);
				dfr.container.addChild(dfr.gus1);
				//dfr.gus1.geometry.scale(2);
				dfr.container.addChild(dfr.gus2);
				//dfr.gus2.geometry.scale(2);
				dfr.container.addChild(dfr.gus3);
				completeLoading();
				*/
				//dfr.gus3.geometry.scale(2);
				
				carBody = new AWPRigidBody(new AWPConvexHullShape((dfr.container1.getChildAt(0) as Mesh).geometry), dfr.container1.getChildAt(0), 10);
				carBody.activationState = AWPCollisionObject.DISABLE_DEACTIVATION;
				carBody.friction = 1;
				carBody.linearDamping = 0.25;
				carBody.angularDamping = 0.75;
				carBody.position = new Vector3D(0, 500, 0);
				dfr.physics.addRigidBody(carBody);
				carBody1 = new AWPRigidBody(new AWPConvexHullShape((dfr.container1.getChildAt(1) as Mesh).geometry), dfr.container1.getChildAt(1), 10);
				carBody1.activationState = AWPCollisionObject.DISABLE_DEACTIVATION;
				carBody1.friction = 1;
				carBody1.linearDamping = 0.25;
				carBody1.angularDamping = 0.75;
				carBody1.position = new Vector3D(0, 500, 0);
				dfr.physics.addRigidBody(carBody1);
				carBody2 = new AWPRigidBody(new AWPConvexHullShape((dfr.container1.getChildAt(2) as Mesh).geometry), dfr.container1.getChildAt(2), 10);
				carBody2.activationState = AWPCollisionObject.DISABLE_DEACTIVATION;
				carBody2.friction = 1;
				carBody2.linearDamping = 0.25;
				carBody2.angularDamping = 0.75;
				carBody2.position = new Vector3D(0, 500, 0);
				dfr.physics.addRigidBody(carBody2);
				carBody3 = new AWPRigidBody(new AWPConvexHullShape((dfr.container1.getChildAt(3) as Mesh).geometry), dfr.container1.getChildAt(3), 10);
				carBody3.activationState = AWPCollisionObject.DISABLE_DEACTIVATION;
				carBody3.friction = 1;
				carBody3.linearDamping = 0.25;
				carBody3.angularDamping = 0.75;
				carBody3.position = new Vector3D(0, 500, 0);
				dfr.physics.addRigidBody(carBody3);
				
			//}
		}
		
		//private function createCarShape(param1:Mesh) : AWPCompoundShape {
			//var carShape : AWPCompoundShape = new AWPCompoundShape();
			//var up:Vector3D = param1.transform.deltaTransformVector(Vector3D.Y_AXIS);
			//up.negate();
			//carShape.addChildShape(new AWPConvexHullShape(param1.geometry), new Vector3D(), new Vector3D());
			//carShape.addChildShape(new AWPConvexHullShape(param1.geometry), new Vector3D(), new Vector3D());
			//return carShape;
		//}
		
		private function onResourceLoadingError(event:AssetEvent) : void
		{
			new Error("Картейке не дали догрузиться =)");
		}
		
	}

}