package alternativa.tanks.tank
{
   import alternativa.tanks.TankController;
   import assets.icons.HelpWindow;
   import away3d.controllers.HoverController;
   import away3d.entities.Mesh;
   import away3d.events.AssetEvent;
   import away3d.events.LoaderEvent;
   import away3d.library.assets.AssetType;
   import away3d.loaders.Loader3D;
   import away3d.materials.TextureMaterial;
   import alternativa.math.Vector3;
   import alternativa.tanks.tank.loaders.TankTurretLoader;
   import alternativa.tanks.tank.loaders.TankHullLoader;
   import away3d.containers.ObjectContainer3D;
   import away3d.entities.Mesh;
   import away3d.loaders.Loader3D;
   import away3d.materials.TextureMaterial;
   import away3d.materials.methods.TripleFilteredShadowMapMethod;
   import away3d.primitives.CapsuleGeometry;
   import away3d.primitives.CylinderGeometry;
   import away3d.primitives.PlaneGeometry;
   import away3d.primitives.SphereGeometry;
   import away3d.utils.Cast;
   import awayphysics.events.AWPEvent;
   import flash.display.Loader;
   import alternativa.tanks.tank.controllers.SimpleTankController;
   import alternativa.tanks.tank.controllers.FollowCameraController;
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   import gui.Alert;
   //import alternativa.tanks.tank.physics.Chassis;
   import alternativa.tanks.tank.weapon.Weapon;
   import flash.display.BitmapData;
   import alternativa.tanks.tank.title.UserTitle;
   import alternativa.tanks.Game;
   import alternativa.tanks.resources.ImageLib;
   import flash.display.Shape;
   import flash.display.BlendMode;
   //import alternativa.tanks.physics.TanksCollisionDetector;
   import flash.ui.Keyboard;
   import flash.geom.Vector3D;
   import alternativa.math.Matrix3;
   import flash.utils.getTimer;
   import mishin870.net.SocketClass;
   import alternativa.math.Quaternion;
   //import alternativa.physics.collision.types.RayIntersection;
   import awayphysics.collision.dispatch.AWPCollisionObject;
   import awayphysics.collision.shapes.*;
   import awayphysics.dynamics.*;
   import awayphysics.dynamics.vehicle.*;
   
   public class Tank extends ObjectContainer3D
   {
      
      private static const TIME_TO_SEND_POS:int = 1;
      
      public static var num:int = 0;
       
      private var timeSendPos:int = 100;
      
      private var MAX_HEALTH:int = 30;
      
      private var health:int = 30;
      
      private var visib:Boolean = true;
      
      private var thisNum:int;
      
      public var muzzlePoint:Mesh = new Mesh(new PlaneGeometry(1,1));
      
      public var turret:Mesh = new Mesh(null,null);
      
      public var hull:Mesh = new Mesh(null,null);
      
      private var mountPoint:Vector3;
      
      private var turretLoader:TankTurretLoader;
      
      private var hullLoader:TankHullLoader;
      
      private var colormapLoader:Loader;
      
      private var callBackUploadResources:Function;
      
      private var callBackDisposeResources:Function;
      
      private var _turretDirection:Number = 0;
      
      public var isUploaded:Boolean = false;
      
      public var isLoading:Boolean = false;
      
      public var controller:SimpleTankController;
      
      public var cameraController:FollowCameraController;
      
      //public var chassis:Chassis;
      
      public var tankHull:alternativa.tanks.tank.TankHull;
      
      public var tankTurret:alternativa.tanks.tank.TankTurret;
      
      public var weapon:Weapon;
      
      public var weaponStarted:Boolean = false;
      
      public var title:UserTitle = new UserTitle();
      
      public var tankName:String;
      
      private var isEnemy:Boolean = false;
      
      public var tankId:int;
      
      private var hNormMaterial:TextureMaterial;
      
      private var tNormMaterial:TextureMaterial;
      
      private var hExplMaterial:TextureMaterial;
      
      private var tExplMaterial:TextureMaterial;
      
      public var TIME_UNVIS:int = 5000;
      
      public var exp:Boolean = false;
      
      public var speedMultipler:Number = 1;
      
      public var TEAM:BattleTeamType;
      
      private var eulerAngles:Vector3 = new Vector3();
	  
	  public var car : AWPRaycastVehicle;
	  
	  public var car1 : AWPRaycastVehicle;
	  
	  public var car2 : AWPRaycastVehicle;
	  
	  public var car3 : AWPRaycastVehicle;
	  
	  public var keyRight : Boolean = false;
	  
	  public var keyLeft : Boolean = false;
	  
	  public var _engineForce : Number = 0;
	  
	  public var _breakingForce : Number = 0;
	  
	  public var _engineForce1 : Number = 0;
	  
	  public var _breakingForce1 : Number = 0;
		
	  public var _vehicleSteering : Number = 0;
	  
	  public var _vehicleSteering1 : Number = 0;
	  
	  private var ru : Number = Math.PI / 6;
	  
	  private var tim:Timer;
	  
	  private var rer:Game = Main.instance.game;
	  
	  private var _container:Loader3D;
	  
	  private var container : ObjectContainer3D;
	  
	  public var swj:ObjectContainer3D = new ObjectContainer3D();
	  
	  public var carBody : AWPRigidBody;
	  
	  public var contrt:TankController;
      
      public function Tank(param1:Function, param2:Function, param3:int, param4:int, param5:String, param6:BattleTeamType, param7:Boolean, param8:int, param9:Number)
      {
         super();
         this.thisNum = num;
         num++;
         this.controller = new SimpleTankController(Main.instance.stage,this);
         this.callBackUploadResources = param1;
         this.callBackDisposeResources = param2;
         //this.chassis = new Chassis(this);
		 _container = new Loader3D();
		 //_container.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onSceneResourceComplete);
		 //_container.addEventListener(LoaderEvent.LOAD_ERROR, onResourceLoadingError);
		 //_container.load(new URLRequest("50.3ds"));
         this.tankId = param8;
         this.isEnemy = param7;
         this.tankName = param5;
         this.MAX_HEALTH = param9 * 100;
         this.health = this.MAX_HEALTH;
         this.title.MAX_HEALTH = this.MAX_HEALTH;
         this.title.setLabelText(param5);
         this.title.setRank(param4);
         this.title.setHealth(this.health);
         this.title.setWeaponStatus(100);
         this.title.setConfiguration(param3);
         this.TEAM = param6;
         this.title.setTeamType(param6);
         this.title.update(getTimer(),1);
         if(param8 == -1)
         {
            return;
         }
      }
	  
	  private function onResourceLoadingError(event:AssetEvent) : void
		{
			new Error("Картейке не дали догрузиться =)");
		}
	  
	  private function onSceneResourceComplete(event : LoaderEvent) : void {
			container = ObjectContainer3D(event.target);
			rer._view.scene.addChild(container);
		}
      
      public function destroy() : void
      {
         Game.getInstance().tankManager.removeTank(this);
         this.controller.stopAll();
         removeChild(this.turret);
         removeChild(this.hull);
         this.turret = null;
         this.hull = null;
         this.muzzlePoint = null;
         this.mountPoint = null;
         //this.chassis = null;
         this.cameraController = null;
         this.controller.setEnabled(false);
         this.controller = null;
         this.weapon.destroy();
         this.weapon = null;
      }
      
      public function explosion() : void
      {
         if(this.tankId == -1)
         {
            this.controller.setEnabled(false);
            this.controller.stopAll();
         }
		 this.carBody.applyCentralForce(new Vector3D(0,2500000,0));
         this.title.sprite.visible = false;
         //this.chassis.state.velocity.z = this.chassis.state.velocity.z + 500;
         //this.chassis.state.rotation.vReset(2,2,2);
         this.hull.material = this.hExplMaterial;
         this.turret.material = this.tExplMaterial;
         Game.getInstance().tankExplosionFactory.createEffect(this);
         this.exp = true;
         this.stopEffects();
		 tim = new Timer(10000,1);
         tim.addEventListener(TimerEvent.TIMER_COMPLETE,function(param1:Event):void
         {
			carBody.position = new Vector3D(0,500);
         });
         tim.start();
      }
      
      public function setHealth(param1:int) : void
      {
         this.health = param1 * 100;
         this.title.setHealth(this.health);
      }
      
      public function addToContainer(param1:ObjectContainer3D) : void
      {
         param1.addChild(this);
         this.title.addToContainer(this);
      }
      
      public function removeFromContainer() : void
      {
         try
         {
            parent.removeChild(this);
         }
         catch(e:Error)
         {
         }
         this.title.removeFromContainer();
      }
      
      public function setControllerEnabled(param1:Boolean, param2:Boolean = false) : void
      {
         //this.controller.setEnabled(param1,param2);
      }
	  
	  private function createCarShape(param1:Mesh,param2:Mesh) : AWPCompoundShape {
			var carShape : AWPCompoundShape = new AWPCompoundShape();
			//var up:Vector3D = param1.transform.deltaTransformVector(Vector3D.Y_AXIS);
			//up.negate();
			carShape.addChildShape(new AWPConvexHullShape(param1.geometry));
			//carShape.addChildShape(new AWPConvexHullShape(param2.geometry), new Vector3D(0, this.hull.y + this.hull.bounds.max.y,this.mountPoint.z));
			//carShape.addChildShape(new AWPConvexHullShape(param2.geometry), new Vector3D(0,this.hull.bounds.max.y,this.mountPoint.z), new Vector3D());
			
			//var boxShape1 : AWPBoxShape = new AWPBoxShape(260, 60, 570);
			//var boxShape2 : AWPBoxShape = new AWPBoxShape(240, 70, 300);
			
			//carShape.addChildShape(boxShape1, new Vector3D(0, 100, 0), new Vector3D());
			//carShape.addChildShape(boxShape2, new Vector3D(0, 150, -30), new Vector3D());

			//var carShape : AWPCompoundShape = new AWPCompoundShape();
			//carShape.addChildShape(new AWPBoxShape(param1.maxX * 2, param1.maxY - 50), new Vector3D(), new Vector3D());
			//carShape.addChildShape(new AWPBvhTriangleMeshShape(param1.geometry), new Vector3D(), new Vector3D());
			//carShape.addChildShape(new AWPStaticPlaneShape(up), new Vector3D(), new Vector3D());
			return carShape;
		}
	  
	  private function setPhysics(param1:Mesh,param2:Mesh) : void
      {
			rer.container.addChild(swj);
			swj.addChild(param1);
			swj.addChild(param2);
			//param2.position = new Vector3D(0, this.hull.bounds.max.y, this.mountPoint.z);
			this.carBody = new AWPRigidBody(this.createCarShape(param1,param2),this.swj,11500);
			 this.carBody.activationState = AWPCollisionObject.DISABLE_DEACTIVATION;
			 this.carBody.friction = 1;
			 this.carBody.position = new Vector3D(0,500,-3000);
			 this.rer.physics.addRigidBody(this.carBody);
			this.carBody.addEventListener(AWPEvent.COLLISION_ADDED, crashThis);
			// create vehicle
			var id3:int = (rer.container1.getChildAt(0) as Mesh).maxY;
			var id4:int = id3/2;
			var turning : AWPVehicleTuning = new AWPVehicleTuning();
			turning.frictionSlip = 2;
			turning.suspensionStiffness = 200;
			turning.suspensionDamping = 2986.64;
			turning.suspensionCompression = 0;
			turning.maxSuspensionTravelCm = id4;
			turning.maxSuspensionForce = 40000;
			this.car = new AWPRaycastVehicle(turning, this.carBody);
			rer.physics.addVehicle(car);
			var turning1 : AWPVehicleTuning = new AWPVehicleTuning();
			turning1.frictionSlip = 2;
			turning1.suspensionStiffness = 200;
			turning1.suspensionDamping = 2986.64;
			turning1.suspensionCompression = 0;
			turning1.maxSuspensionTravelCm = id4;
			turning1.maxSuspensionForce = 40000;
			this.car1 = new AWPRaycastVehicle(turning1, this.carBody);
			rer.physics.addVehicle(car1);
			var turning2 : AWPVehicleTuning = new AWPVehicleTuning();
			turning2.frictionSlip = 2;
			turning2.suspensionStiffness = 200;
			turning2.suspensionDamping = 2986.64;//k>1 //k*2*sqrt(Stiffness)
			turning2.suspensionCompression = 0;
			turning2.maxSuspensionTravelCm = id4;
			turning2.maxSuspensionForce = 40000;
			this.car2 = new AWPRaycastVehicle(turning2, this.carBody);
			rer.physics.addVehicle(car2);
			var turning3 : AWPVehicleTuning = new AWPVehicleTuning();
			turning3.frictionSlip = 2;
			turning3.suspensionStiffness = 200;
			turning3.suspensionDamping = 2986.64;
			turning3.suspensionCompression = 0;
			turning3.maxSuspensionTravelCm = id4;
			turning3.maxSuspensionForce = 40000;
			this.car3 = new AWPRaycastVehicle(turning3, this.carBody);
			rer.physics.addVehicle(car3);
			var v:Vector3D = new Vector3D(-110, id4, 140);
			var v1:Vector3D = new Vector3D(-120, id4, -200);
			var v2:Vector3D = new Vector3D(110, id4, 140);
			var v3:Vector3D = new Vector3D(120, id4, -200);
			var v4:Vector3D = new Vector3D(0, -1, 0);
			var v5:Vector3D = new Vector3D(-1, 0, 0);
			var v6:Vector3D = new Vector3D();
			this.car.addWheel(rer.container1.getChildAt(0), v, v4, v5, id4, id3, turning, true);
			this.car1.addWheel(rer.container1.getChildAt(3), v1, v4, v5, id4, id3, turning1, false);
			this.car2.addWheel(rer.container1.getChildAt(1), v2, v4, v5, id4, id3, turning2, true);
			this.car3.addWheel(rer.container1.getChildAt(2), v3, v4, v5, id4, id3, turning3, false);

			for (var i1:int = 0; i1 < this.car.getNumWheels(); i1++) {
				var wheel : AWPWheelInfo = this.car.getWheelInfo(i1);
				wheel.wheelsDampingRelaxation = 25;
				wheel.wheelsDampingCompression = 4.24;
				//wheel.wheelsDampingRelaxation = 59.5;
				//wheel.wheelsDampingCompression = 59.5;
				wheel.suspensionRestLength1 = id4*4;
				wheel.rollInfluence = 0.01;
			}
			
			for (var i12:int = 0; i12 < this.car1.getNumWheels(); i12++) {
				var wheel : AWPWheelInfo = this.car1.getWheelInfo(i12);
				wheel.wheelsDampingRelaxation = 25;
				wheel.wheelsDampingCompression = 4.24;
				//wheel.wheelsDampingRelaxation = 59.5;
				//wheel.wheelsDampingCompression = 59.5;
				wheel.suspensionRestLength1 = id4*4;
				wheel.rollInfluence = 0.01;
			}
			
			for (var i123:int = 0; i123 < this.car2.getNumWheels(); i123++) {
				var wheel : AWPWheelInfo = this.car2.getWheelInfo(i123);
				wheel.wheelsDampingRelaxation = 25;
				wheel.wheelsDampingCompression = 4.24;
				//wheel.wheelsDampingRelaxation = 59.5;
				//wheel.wheelsDampingCompression = 59.5;
				wheel.suspensionRestLength1 = id4*4;
				wheel.rollInfluence = 0.01;
			}
			
			for (var i142:int = 0; i142 < this.car3.getNumWheels(); i142++) {
				var wheel : AWPWheelInfo = this.car3.getWheelInfo(i142);
				wheel.wheelsDampingRelaxation = 25;
				wheel.wheelsDampingCompression = 4.24;
				//wheel.wheelsDampingRelaxation = 59.5;
				//wheel.wheelsDampingCompression = 59.5;
				wheel.suspensionRestLength1 = id4*4;
				wheel.rollInfluence = 0.01;
			}
      }

	private function crashThis(e:AWPEvent):void {
		//e.collisionObject
		//var al:Alert = new Alert(Main.instance.stage);
        //al.add = "Хоп зей лалалей!";
	} 
      
    public function setWeapon(param1:Weapon) : void
    {
        param1.tank = this;
        this.controller.maxTurretSpeed = param1.turretSpeed;
        this.weapon = param1;
    }
      
      public function setTank(param1:TankTurret, param2:TankHull, param3:BitmapData) : void
      {
         try
         {
            removeChild(this.hull);
         }
         catch(e:Error)
         {
         }
         try
         {
            removeChild(this.turret);
         }
         catch(e:Error)
         {
         }
         this.hull = param2.skin.clone() as Mesh;
         this.mountPoint = param2.turretSkinMountPoint;
         addChild(this.hull);
         //this.chassis.setHull(param2);
         this.turret = param1.skin.clone() as Mesh;
         addChild(this.turret);
		 this.muzzlePoint.position = param1.muzzlePoints[0];
         //this.chassis.setTurret(param1);
		 setPhysics(this.hull,this.turret);
         this.tankTurret = param1;
         this.tankHull = param2;
         this.addToContainer(rer.container);
         this.updateTankParts();
         this.updatePartTexture(this.tankHull,this.hull,param3);
         this.updatePartTexture(this.tankTurret,this.turret,param3);
         this.hNormMaterial = this.hull.material as TextureMaterial;
         this.tNormMaterial = this.turret.material as TextureMaterial;
         this.hExplMaterial = this.getMaterial(this.tankHull,ImageLib.getImage("explColormap"));
         this.tExplMaterial = this.getMaterial(this.tankTurret,ImageLib.getImage("explColormap"));
         if(!this.isUploaded)
         {
            Game.getInstance().tankManager.addTankToWorld(this);
         }
         this.loadingComplete();
         //this.chassis._turretDirection = this._turretDirection;
         this.turret.rotationZ = this._turretDirection;
         this.weapon.tankLoaded();
      }
      
      public function resetColormap() : void
      {
         this.exp = false;
         if(this.tankId == -1)
         {
            if(Game.getInstance().keyEnab)
            {
               this.controller.setEnabled(true);
            }
         }
         this.hull.material = this.hNormMaterial;
         this.turret.material = this.tNormMaterial;
         this.title.sprite.visible = true;
      }
      
      private function updatePartTexture(param1:TankPart, param2:Mesh, param3:BitmapData) : void
      {
         if(param1 == null || param3 == null)
         {
            return;
         }
         var _loc4_:Shape = new Shape();
         _loc4_.graphics.beginBitmapFill(param3);
         _loc4_.graphics.drawRect(0,0,param1.lightmap.width,param1.lightmap.height);
         var _loc5_:BitmapData = new BitmapData(param1.lightmap.width, param1.lightmap.height, false, 0);
         _loc5_.draw(_loc4_,null,null,null,null,true);
         _loc5_.draw(param1.lightmap,null,null,BlendMode.HARDLIGHT,null,true);
         _loc5_.draw(param1.details, null, null, null, null, true);
		 var s:Number = Math.max(2048 / _loc5_.width , 2048 / _loc5_.height);
		 var mat:Matrix = new Matrix();
		 mat.scale(s, s);
		 var w:Number = s * _loc5_.width;
		 var h:Number = s * _loc5_.height;
		 var param4:BitmapData = new BitmapData(w, h, false, 0);
		 param4.draw(_loc5_, mat, null, null, null, true);
		 var texture:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(param4));
		 texture.shadowMethod = new TripleFilteredShadowMapMethod(rer._light);
		 //texture.shadowMethod.epsilon = .007;
		 texture.lightPicker = rer._lightPicker;
		 texture.smooth = true;
		 //texture.specular = 0.17;
		 //texture.ambient = 0.6;
         param2.material = texture;
      }
      
      private function getMaterial(param1:TankPart, param2:BitmapData) : TextureMaterial
      {
         if(param1 == null || param2 == null)
         {
            return null;
         }
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginBitmapFill(param2);
         _loc3_.graphics.drawRect(0,0,param1.lightmap.width,param1.lightmap.height);
         var _loc4_:BitmapData = new BitmapData(param1.lightmap.width,param1.lightmap.height, false, 0);
         _loc4_.draw(_loc3_,null,null,null,null,true);
         _loc4_.draw(param1.lightmap,null,null,BlendMode.HARDLIGHT,null,true);
         _loc4_.draw(param1.details, null, null, null, null, true);
		 var s:Number = Math.max(2048 / _loc4_.width , 2048 / _loc4_.height);
		 var mat:Matrix = new Matrix();
		 mat.scale(s, s);
		 var w:Number = s * _loc4_.width;
		 var h:Number = s * _loc4_.height;
		 var param4:BitmapData = new BitmapData(w, h, false, 0);
		 param4.draw(_loc4_, mat, null, null, null, true);
		 var texture:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(param4));
		 texture.shadowMethod = new TripleFilteredShadowMapMethod(rer._light);
		 //texture.shadowMethod.epsilon = .007;
		 texture.lightPicker = rer._lightPicker;
		 texture.smooth = true;
		 //texture.specular = 0.17;
		 //texture.ambient = 0.6;
         return texture;
      }
      
      private function loadingComplete() : void
      {
         this.isUploaded = true;
         this.isLoading = false;
         //this.chassis.collisionGroup = 1;
      }
      
      public function updateTankParts() : void
      {
         this.hull.position = new Vector3D();
		 this.turret.x = this.carBody.x;
         this.turret.y = this.hull.y + this.hull.bounds.max.y;
         this.turret.z = this.mountPoint.z;// this.hull.z - (this.hull.bounds.max.z * 0.38);
		 if (rer.tanks[0] == this)
		 {
			rer._view.camera.position = new Vector3D(this.hull.x, this.turret.y + this.turret.maxY + 30, this.hull.maxZ - 150);
		 }
		 this.title.sprite.x = this.turret.x;
         this.title.sprite.y = this.turret.y + this.turret.bounds.max.y * 0.175;
         this.title.sprite.z = this.turret.z - (this.turret.bounds.max.z * 0.5);
		 //rer.container.addChild(this.muzzlePoint);
		 this.muzzlePoint.x = 0;
		 this.muzzlePoint.y = this.title.sprite.y + 50;
		 this.muzzlePoint.z = 0;
		 rer.cunt1 = new HoverController(this.muzzlePoint, null, 0, 90, -this.turret.maxZ, -180, 180);
		 rer.cunt1.tiltAngle = 180;
		 swj.addChild(this.title.sprite);
		 //this.muzzlePoint.x = this.turret.x;
         //this.muzzlePoint.y = this.turret.y;
         //this.muzzlePoint.z = this.turret.z;
		 swj.addChild(this.muzzlePoint);
		 //rer.container.addChild(this.muzzlePoint);
		 if (rer.tanks[0] == this)
		 {
			swj.addChild(rer._view.camera);
		 }
      }
      
      public function set turretDirection(param1:Number) : void
      {
         this._turretDirection = param1;
		 if (swj != null)
		 {
			swj.getChildAt(1).rotationY = this._turretDirection;
			if (rer.tanks[0] == this)
			{
				rer.cunt.panAngle = this._turretDirection;
			}
			rer.cunt1.panAngle = this._turretDirection;
			//swj.rotationZ = this._turretDirection;
		 }
      }
      
      public function get turretDirection() : Number
      {
         return this._turretDirection;
      }
      
      public function addToGame(param1:Game) : void
      {
         //param1.world.addBody(this.chassis);
         //TanksCollisionDetector(param1.world.collisionDetector).addBody(this.chassis);
      }
      
      public function removeFromGame(param1:Game) : void
      {
         //param1.world.removeBody(this.chassis);
         //TanksCollisionDetector(param1.world.collisionDetector).removeBody(this.chassis);
      }
      
      public function set vis(param1:Boolean) : void
      {
         if(this.tankId == -1)
         {
            //this.controller.setFire(param1);
            //if(!param1)
            //{
               //this.controller.setControl(Keyboard.SPACE,true);
            //}
         }
         this.visib = param1;
         this.tNormMaterial.alpha = !!param1?Number(1):Number(0.5);
         this.hNormMaterial.alpha = !!param1?Number(1):Number(0.5);
      }
      
      public function get vis() : Boolean
      {
         return this.visib;
      }
      
      public function update() : void
      {
		 //var param1:Number = 1;
			if (this.keyLeft) {
				this._vehicleSteering -= 0.05;
				if (this._vehicleSteering < -ru) {
					this._vehicleSteering = -ru;
				}
			}
			
			if (this.keyRight) {
				this._vehicleSteering += 0.05;
				if (this._vehicleSteering > ru) {
					this._vehicleSteering = ru;
				}
			}
			
			if (!this.keyLeft && !this.keyRight) {
				this._vehicleSteering = 0;
			}

			if (this.car && this.car1 && this.car2 && this.car3) {
				// control the car
				this.car.applyEngineForce(this._engineForce, 0);
				this.car1.applyEngineForce(this._engineForce, 0);
				this.car2.applyEngineForce(this._engineForce1, 0);
				this.car3.applyEngineForce(this._engineForce1, 0);
				
				this.car.setBrake(this._breakingForce, 0);
				this.car1.setBrake(this._breakingForce, 0);
				this.car2.setBrake(this._breakingForce1, 0);
				this.car3.setBrake(this._breakingForce1, 0);
			}
				this.car.setSteeringValue(this._vehicleSteering, 0);
				this.car2.setSteeringValue(this._vehicleSteering, 0);
				this._vehicleSteering *= 0.9;
			//if (this.turret != null && this.mountPoint != null && this.carBody != null && this.muzzlePoint != null && this.title.sprite != null)
			//{
				//this.turret.x = this.carBody.x;
				//this.turret.y = this.carBody.y + this.hull.bounds.max.y;
				//this.turret.z = this.mountPoint.z + this.carBody.z;// this.hull.z - (this.hull.bounds.max.z * 0.38);
				//this.turret.rotationX = this.carBody.rotationX;
				//this.turret.rotationY = this.carBody.rotationY;
				//this.turret.rotationZ = this.carBody.rotationZ;
				//this.title.sprite.x = this.turret.x;
				//this.title.sprite.y = this.turret.y + this.turret.bounds.max.y * 0.25;
				//this.title.sprite.z = this.turret.z - (this.turret.bounds.max.z * 0.5);
				//this.muzzlePoint.x = this.turret.x;
				//this.muzzlePoint.y = this.turret.y;
				//this.muzzlePoint.z = this.turret.z;
			//}
            this.weapon.update(getTimer(),1000);
			//this.carBody.rotationX = 0;
			//this.carBody.rotationY = 0;
            if(this.thisNum == 0)
            {
               this.title.setWeaponStatus(this.weapon.getStatus());
            }
            this.title.update(getTimer(), 1000);
			this.contrt.update();
            //this.controller.update(param1);
            //if(this.cameraController != null)
            //{
               //this.cameraController.onUpdate(1);
            //}
            if(this.tankId != -1)
            {
               return;
            }
            if(!this.vis)
            {
               this.TIME_UNVIS = this.TIME_UNVIS - 1000;
               if(this.TIME_UNVIS <= 0)
               {
                  this.TIME_UNVIS = 0;
                  if(carBody != null)
                  {
                     this.vis = true;
                  }
               }
            }
            this.timeSendPos = this.timeSendPos - 1000;
            if(this.timeSendPos <= 0)
            {
               this.timeSendPos = TIME_TO_SEND_POS;
               this.sendPos();
            }
            return;
         //}
         //catch(e:Error)
         //{
            //return;
         //}
      }
      
      public function interpolate(param1:int) : void
      {
      }
      
      public function addBonusEffect(param1:int, param2:int) : void
      {
         if(param1 == 2)
         {
            this.speedMultipler = 1.3;
         }
         if(param1 == 3)
         {
            this.title.showIndicator(0,param2);
         }
         if(param1 >= 0 && param1 < 3)
         {
            this.title.showIndicator(param1 + 1,param2);
         }
      }
      
      public function stopBonusEffect(param1:int) : void
      {
         if(param1 == 2)
         {
            this.speedMultipler = 1;
         }
      }
      
      public function stopEffects() : void
      {
         this.title.hideIndicator(0);
         this.title.hideIndicator(1);
         this.title.hideIndicator(2);
         this.title.hideIndicator(3);
      }
      
      private function m3tostr(param1:Matrix3) : String
      {
         return param1.a + "@" + param1.b + "@" + param1.c + "@" + param1.e + "@" + param1.f + "@" + param1.g + "@" + param1.i + "@" + param1.j + "@" + param1.k;
      }
      
      private function v3tostr(param1:Vector3D) : String
      {
         return param1.x + "@" + param1.y + "@" + param1.z;
      }
      
      private function qtostr(param1:Quaternion) : String
      {
         return param1.w + "@" + param1.x + "@" + param1.y + "@" + param1.z;
      }
      
      public function sendPos() : void
      {
		 //Main.instance.ftr.send("r;" + this.contrt.getControlsToSend());
      }
      /*
      public function dropMine() : Boolean
      {
         var _loc1_:RayIntersection = new RayIntersection();
         if(Game.getInstance().world.collisionDetector.intersectRay(this.chassis.state.pos,new Vector3(0,0,-1),255,10000000,null,_loc1_))
         {
            SocketClass.send("minec;" + this.v3tostr(_loc1_.pos) + ";" + this.v3tostr(new Vector3(rotationX,rotationY,rotationZ)));
            return true;
         }
         return false;
      }
      */
      override public function toString() : String
      {
         return "[Tank " + this.thisNum + "]";
      }
   }
}
