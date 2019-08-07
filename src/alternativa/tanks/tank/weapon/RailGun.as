package alternativa.tanks.tank.weapon
{
   import AWPC_Run.domainClass;
   import alternativa.tanks.resources.ImageLib;
   import alternativa.tanks.tank.Tank;
   import alternativa.tanks.tank.weapon.sfx.RailGunShotEffect;
   import away3d.entities.Mesh;
   import away3d.materials.TextureMaterial;
   import away3d.primitives.PlaneGeometry;
   import away3d.utils.Cast;
   import awayphysics.collision.dispatch.AWPCollisionObject;
   import awayphysics.collision.shapes.AWPConvexHullShape;
   import awayphysics.dynamics.AWPRigidBody;
   import awayphysics.events.AWPEvent;
   import flash.display.BitmapData;
   import alternativa.tanks.Game;
   import alternativa.math.Vector3;
   import flash.geom.Matrix;
   import flash.geom.Vector3D;
   import alternativa.tanks.tank.weapon.sfx.RailGunBeam;
   import flash.sampler.ClassFactory;
   import flash.utils.getTimer;
   import mishin870.net.SocketClass;
   
   public class RailGun extends Weapon
   {
      
      private static const UP_ANGLE:Number = 10 * Math.PI / 180;
      
      private static const DOWN_ANGLE:Number = 10 * Math.PI / 180;
      
      private static const UP_RAYS:int = 10;
      
      private static const DOWN_RAYS:int = 10;
      
      protected var active:Boolean = false;
      
      public var lastShot:uint = 0;
      
      private var fireStarted:Boolean = false;
      
      private var fireReady:Number = 0;
      
      private var shotEffect:RailGunShotEffect;
      
      private var maxD:Number;
      
      private var minD:Number;
	  
	  private var plane11:AWPRigidBody;
      
      private var force:Number;
      
      private var returnForce:Number;
      
      private var damageDownDistance:Number;
      
      private var fireReadyDelay:Number = 1100;
      
      public var delay:Number = 6400;
      
      private var timePart2:Number;
      
      private var timePart3:Number;
      
      private var charge1:TextureMaterial;
      
      private var charge2:TextureMaterial;
      
      private var charge3:TextureMaterial;
      
      private var beamMaterial:TextureMaterial;
	  
	  private var li:Mesh = new Mesh(new PlaneGeometry(1, 1));
	  
	  private var li1:Mesh = new Mesh(new PlaneGeometry(1, 1));
	  
	  private var li4:Mesh = new Mesh(new PlaneGeometry(1, 1));
	  
	  private var li3:Mesh = new Mesh(new PlaneGeometry(1, 1));
	  
	  //private var tempController:SimpleObjectController = new SimpleObjectController(Main.instance.stage, li, 100000);
	  
	  private var tanl:Vector.<Tank>;
	  
	  public var call:Boolean;
	  
	  private var plane255:Mesh = new Mesh(new PlaneGeometry(1, 10));
      
      public function RailGun()
      {
         super();
		 tanl = Main.instance.game.tanks;
      }
      
      override public function destroy() : void
      {
         try
         {
            this.shotEffect.destroy();
            this.shotEffect = null;
            this.charge1 = null;
            this.charge2 = null;
            this.charge3 = null;
            this.beamMaterial = null;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      override public function loadProfile(param1:XML) : void
      {
         turretSpeed = param1.child("turretSpeed").@val;
         this.force = param1.child("force").@val;
         this.returnForce = param1.child("returnForce").@val;
         this.damageDownDistance = param1.child("damageDownDistance").@val;
         this.minD = param1.child("minDamage").@val;
         this.maxD = param1.child("maxDamage").@val;
         this.delay = param1.child("delay").@val;
         this.fireReadyDelay = param1.child("fireReadyDelay").@val;
         this.timePart2 = param1.child("timePart2").@val;
         this.timePart3 = param1.child("timePart3").@val;
         this.charge1 = new TextureMaterial(Cast.bitmapTexture(res(ImageLib.getImage(param1.child("charge1").@id), new Vector3D(128, 128))));
		 this.charge1.alphaBlending = true;
         this.charge2 = new TextureMaterial(Cast.bitmapTexture(res(ImageLib.getImage(param1.child("charge2").@id), new Vector3D(256, 256))));
		 this.charge2.alphaBlending = true;
         this.charge3 = new TextureMaterial(Cast.bitmapTexture(res(ImageLib.getImage(param1.child("charge3").@id), new Vector3D(128, 128))));
		 this.charge3.alphaBlending = true;
         this.beamMaterial = new TextureMaterial(Cast.bitmapTexture(res(ImageLib.getImage(param1.child("beam").@id), new Vector3D(16, 512))));
		 this.beamMaterial.alphaBlending = true;
      }
	  
	  public function res(param1:BitmapData,param2:Vector3D) : BitmapData
      {
         var s:Number = Math.max(param2.x / param1.width , param2.y / param1.height);
		 var mat:Matrix = new Matrix();
		 mat.scale(s, s);
		 var w:Number = s * param1.width;
		 var h:Number = s * param1.height;
		 //throw new Error(w + "	" + h);
		 var param4:BitmapData = new BitmapData(param2.x, param2.y, true, 0);
		 param4.draw(param1, mat, null, null, null, true);
		 return param4;
      }
      
      override public function start(param1:int = 0) : void
      {
         this.active = true;
      }
      
      override public function getDamage(param1:Vector3 = null, param2:Vector3 = null) : Number
      {
         var _loc3_:Number = this.maxD;
         return _loc3_;
      }
	  
	  private function rotat(param1:Mesh,param2:Vector3D) : void
      {
         param1.rotationX = param2.x;
		 param1.rotationY = param2.y;
		 param1.rotationZ = param2.z;
      }
      
      public function fire() : void
      {
         this.lastShot = getTimer();
		 if (this.tank.carBody != null)
		  {
			var fu:Vector3D = this.tank.carBody.rotation.add(new Vector3D(0, this.tank.turretDirection));
			var fu1:Vector3D = getp(fu);
			var fh:Number = getTarget(fu1, fu);
			fu = fu.add(new Vector3D(0,0,fh));
			var shotEffect1:RailGunBeam;
			var opu:int = 0;
			var plane1:AWPRigidBody;
			li4 = li3;
			plane1 = new AWPRigidBody(new AWPConvexHullShape(li4.geometry), li4, 10);
			plane1.activationState = AWPCollisionObject.DISABLE_DEACTIVATION;
			plane1.friction = 1;
			plane1.position = fu1;
			Main.instance.game.physics.addRigidBody(plane1);
			plane1.applyCentralForce(getf(fu1,fu));
			plane1.addEventListener(AWPEvent.COLLISION_ADDED, crash);
			//shotEffect = new RailGunBeam(this, 16, 60000, null, beamMaterial,fu,maxD,fu1);
			//Main.instance.game.addGraphicsEffect(shotEffect);
			//var li4:Mesh = li3;
			//li4.position = fu1;
			//rotat(li4, fu);
			//li4.moveForward(520);
			//shotEffect = new RailGunBeam(this, 16, call, null, beamMaterial,fu,maxD,fu1);
			//Main.instance.game.addGraphicsEffect(shotEffect);
			//if (fh == null)
			//{
				//shotEffect1 = new RailGunBeam(this, 16, 60000, null, beamMaterial,fu,maxD,fu1);
				//Main.instance.game.addGraphicsEffect(shotEffect1);
				/*
				for (var i:int = 0; i < 118; i++)
				 {
					opu += 512;
					if (this.call)
					{
						this.call = false;
						i = 118;
					}
					shotEffect = new RailGunBeam(this, 16, opu, null, beamMaterial,fu,maxD,fu1);
					Main.instance.game.addGraphicsEffect(shotEffect);
				 }
				 */
			//}
			//if (fh != null)
			//{
			//}
		  }
      }
	  
	  private function crash(e:AWPEvent):void
			{
				var ghk:Vector3D = new Vector3D();
				//ghk = fu1;
				//ghk.negate();
				//Main.instance.game.fpsLabel.text = plane1.position.add(ghk).length + "";
				//shotEffect1 = new RailGunBeam(this, 16, plane1.position.add(ghk).length, null, beamMaterial,fu.add(new Vector3D(0,0,fh)),maxD,fu1);
				//Main.instance.game.addGraphicsEffect(shotEffect1);
			}
	  
	  private function getf(param1:Vector3D,param2:Vector3D) : Vector3D
      {
			var tu:Vector3D = new Vector3D();
			this.plane255.position = param1;
			this.plane255.rotationX = param2.x;
			this.plane255.rotationY = param2.y;
			this.plane255.rotationZ = param2.z;
			this.plane255.moveForward(1);
			tu = this.plane255.position;
			//tu.scaleBy(10);
			var hj:Vector3D = new Vector3D();
			tu.negate();
			hj = param1.add(tu);
			hj.negate();
			hj.scaleBy(50000);
			this.plane255.position = new Vector3D();
		return hj;
      }
	  
	  private function getTarget(param1:Vector3D,param2:Vector3D) : Number
      {
			var kl:int = 0;
			var kl1:Number = 0;
			for (var i:int = 1; i < tanl.length; i++) {
				if (tanl[i] != null) {
					li = li3;
					li.position = param1;
					li.lookAt(tanl[i].carBody.position.add(new Vector3D(0,tanl[i].turret.y)));
					if (li.rotationZ < 7 && li.rotationZ > -45)
					{
						kl1 = -45;
						i = tanl.length;
					}
				}
			}
		return kl1;
      }
	  
	  private function getp(param1:Vector3D) : Vector3D
      {
			var kl1:Vector3D = new Vector3D();
			li1.position = this.tank.carBody.position.add(new Vector3D(0, this.tank.turret.position.y + this.tank.turret.maxY*.75));
			li1.rotationX = param1.x;
			li1.rotationY = this.tank.carBody.rotationY;
			li1.moveForward(this.tank.turret.z);
			li1.rotationZ = param1.z;
			li1.rotationY = param1.y;
			li1.moveForward(this.tank.turret.maxZ-20);
			kl1 = li1.position.clone();
			li1 = li3;
		return kl1;
      }
      
      override public function stop() : void
      {
		  this.active = false;
      }
      
      override public function getStatus() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!this.fireStarted)
         {
            _loc1_ = this.lastShot;
            _loc2_ = this.delay;
            if(getTimer() >= _loc1_ + _loc2_)
            {
               return 100;
            }
            return Math.round((getTimer() - _loc1_) / (_loc2_ / 100));
         }
         return Math.round(this.fireReady / (this.fireReadyDelay / 100));
      }
      
      private function getTimeToShot() : Number
      {
         return this.lastShot + this.delay - getTimer();
      }
      
      override public function update(param1:uint, param2:uint) : void
      {
         if(Boolean(this.active) && !this.fireStarted)
         {
            if(this.getTimeToShot() <= 0)
            {
               this.fireStarted = true;
               this.fireReady = this.fireReadyDelay;
               this.shotEffect = new RailGunShotEffect(this,this.charge1,this.charge2,this.charge3,this.timePart2,this.timePart3,this.fireReadyDelay);
               Game.getInstance().addGraphicsEffect(this.shotEffect);
               return;
            }
         }
         if(this.fireStarted)
         {
            this.fireReady = this.fireReady - param2;
            if(this.fireReady <= 0)
            {
               this.fireStarted = false;
               this.fire();
               this.shotEffect.kill();
            }
         }
      }
   }
}
