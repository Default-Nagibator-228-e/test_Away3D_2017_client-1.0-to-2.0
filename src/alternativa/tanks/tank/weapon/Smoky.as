package alternativa.tanks.tank.weapon
{
   import TankGUI4_fla.iconSound_81;
   import alternativa.tanks.resources.ImageLib;
   import alternativa.tanks.sfx.AnimSprite;
   import alternativa.tanks.tank.weapon.sfx.CrossPlaneShotEffect;
   import alternativa.tanks.tank.weapon.sfx.GunShotExplosion;
   import away3d.containers.ObjectContainer3D;
   import away3d.controllers.HoverController;
   import away3d.entities.Mesh;
   import away3d.entities.Sprite3D;
   import away3d.materials.TextureMaterial;
   import away3d.primitives.PlaneGeometry;
   import away3d.utils.Cast;
   import awayphysics.collision.dispatch.AWPCollisionObject;
   import awayphysics.collision.shapes.AWPConvexHullShape;
   import awayphysics.dynamics.AWPRigidBody;
   import awayphysics.events.AWPEvent;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.utils.getTimer;
   import alternativa.tanks.tank.Tank;
   import alternativa.math.Vector3;
   import alternativa.tanks.Game;
   import flash.geom.Vector3D;
   import mishin870.net.SocketClass;
   
   public class Smoky extends Weapon
   {
      
      private static const UP_ANGLE:Number = 10 * Math.PI / 180;
      
      private static const DOWN_ANGLE:Number = 10 * Math.PI / 180;
      
      private static const UP_RAYS:int = 10;
      
      private static const DOWN_RAYS:int = 10;
       
      private var returnForce:Number;
      
      private var force:Number;
      
      private var FIRE_DELAY:uint = 2000;
      
      private var shotMaterial:TextureMaterial;
      
      private var explosionSprite:AnimSprite;
      
      private var minD:Number = 4;
      
      private var maxD:Number = 16;
	  
	  private var bod:AWPRigidBody;
	  
	  private var tanl:Vector.<Tank>;
      
      public var readyTime:uint;
      
      public var shotDelay:Number;
      
      public var lastShotTime:Number;
      
      protected var active:Boolean;
	  
	  private var li:Mesh = new Mesh(new PlaneGeometry(1, 1));
	  
	  private var li2:Mesh = new Mesh(new PlaneGeometry(1, 1));
	  
	  private var li1:Mesh = new Mesh(new PlaneGeometry(1, 1));
	  
	  private var li3:Mesh = new Mesh(new PlaneGeometry(1, 1));
	  
	  private var plane255:Mesh = new Mesh(new PlaneGeometry(1, 10));
	  
	  private var tempController:SimpleObjectController = new SimpleObjectController(Main.instance.stage, li, 100000);
      
      public function Smoky()
      {
         super();
         this.shotDelay = this.FIRE_DELAY;
		 tanl = Main.instance.game.tanks;
		 //Main.instance.game.container.addChild(li1);
      }
      
      override public function destroy() : void
      {
         try
         {
            this.explosionSprite = null;
            this.shotMaterial = null;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      override public function loadProfile(param1:XML) : void
      {
		 this.returnForce = param1.child("returnForce").@val;
         this.force = param1.child("force").@val;
         this.FIRE_DELAY = param1.child("fireDelay").@val;
         turretSpeed = param1.child("turretSpeed").@val;
         this.minD = param1.child("minDamage").@val;
         this.maxD = param1.child("maxDamage").@val;
         this.shotDelay = this.FIRE_DELAY;
         var _loc2_:BitmapData = ImageLib.getImage(param1.child("shot").@id);
		 var s:Number = Math.max(128 / _loc2_.width , 32 / _loc2_.height);
		 var mat:Matrix = new Matrix();
		 mat.scale(s, s);
		 var w:Number = s * _loc2_.width;
		 var h:Number = s * _loc2_.height;
		 //throw new Error(w + "	" + h);
		 var param4:BitmapData = new BitmapData(w, 32, true, 0);
		 param4.draw(_loc2_, mat, null, null, null, true);
         this.shotMaterial = new TextureMaterial(Cast.bitmapTexture(param4));
		 this.shotMaterial.alphaBlending = true;
         var _loc3_:BitmapData = ImageLib.getImage(param1.child("explosion").@id);
		 var s1:Number = Math.max(128 / _loc3_.width , 128 / _loc3_.height);
		 var mat1:Matrix = new Matrix();
		 mat1.scale(s1, s1);
		 var w1:Number = s1 * _loc3_.width;
		 var h1:Number = s1 * _loc3_.height;
		 var param5:BitmapData = new BitmapData(w1, h1, true, 0);
		 param5.draw(_loc3_, mat1, null, null, null, true);
         var _loc4_:Vector.<TextureMaterial> = getAnimBitmaps(param5);
         this.explosionSprite = new AnimSprite(param5.height, param5.height);
		 this.explosionSprite.materials = _loc4_;
         this.explosionSprite.scaleX = this.explosionSprite.scaleY = this.explosionSprite.scaleZ = 2;
      }
      
      override public function start(param1:int = 0) : void
      {
         if(this.active)
         {
            return;
         }
         this.active = true;
      }
      
      override public function stop() : void
      {
         if(!this.active)
         {
            return;
         }
         this.active = false;
      }
      
      public function getLashShotTime() : int
      {
         return this.lastShotTime;
      }
      
      public function getShotDelay() : int
      {
         return this.shotDelay;
      }
      
      override public function reset() : void
      {
         this.lastShotTime = getTimer() - this.shotDelay;
      }
      
      override public function update(param1:uint, param2:uint) : void
      {
         if(Boolean(this.active) && param1 >= this.readyTime)
         {
            this.readyTime = param1 + this.FIRE_DELAY;
            this.lastShotTime = getTimer();
            this.fire();
         }
      }
      
      override public function getStatus() : Number
      {
         var _loc1_:int = this.getLashShotTime();
         var _loc2_:int = this.getShotDelay();
         if(getTimer() >= _loc1_ + _loc2_)
         {
            return 100;
         }
         return Math.round((getTimer() - _loc1_) / (_loc2_ / 100));
      }
      
      public function fire() : void
      {
		  if (this.tank.carBody != null)
		  {
				var fu:Vector3D = this.tank.carBody.rotation.add(new Vector3D(0, getRot(this.tank.turretDirection)));
				var fu1:Vector3D = getp(fu);
				var shotEffect:CrossPlaneShotEffect = new CrossPlaneShotEffect(this, 60, 205, null, bod, shotMaterial,fu, explosionSprite,maxD,fu1);
				Main.instance.game.addGraphicsEffect(shotEffect);
		  }
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
			hj.scaleBy(20000);
			this.plane255.position = new Vector3D();
		return hj;
      }
	  
	  private function getTarget(param1:Vector3D) : Tank
      {
			var kl:int = 0;
			var kl1:Tank;
			for (var i:int = 1; i < tanl.length; i++) {
				if (tanl[i] != null) {
					tempController.setObjectPos(param1);
					tempController.lookAt(tanl[i].carBody.position);
					if (li.rotationZ < 10 && li.rotationZ > -10)
					{
						if (li.rotationY < 10 && li.rotationY > -10)
						{
							kl1 = tanl[i];
							i = tanl.length;
						}
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
			li1.moveForward(this.tank.turret.maxZ + 140);
			kl1 = li1.position.clone();
			li1 = li3;
		return kl1;
      }
   }
}
