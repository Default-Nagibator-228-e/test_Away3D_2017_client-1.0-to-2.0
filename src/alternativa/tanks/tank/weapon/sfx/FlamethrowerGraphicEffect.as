package alternativa.tanks.tank.weapon.sfx
{
   import alternativa.tanks.IGraphicEffect;
   import alternativa.tanks.sfx.AnimSprite;
   import away3d.cameras.Camera3D;
   import away3d.containers.ObjectContainer3D;
   import away3d.materials.TextureMaterial;
   import flash.geom.Vector3D;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.tanks.tank.Tank;
   import alternativa.tanks.Game;
   import mishin870.net.SocketClass;
   import flash.utils.getTimer;
   
   public class FlamethrowerGraphicEffect implements IGraphicEffect
   {
      
      private static const FPS:Number = 30;
      
      private static const START_SCALE:Number = 1.5;
      
      private static const END_SCALE:Number = 3;
       
      private var range:Number;
      
      private var k:Number;
      
      private var coneHalfAngleTan:Number;
      
      private var maxParticles:int;
      
      private var particleSpeed:Number;
      
      private var muzzleLocalPos:Vector3D;
      
      private var numParticles:int;
      
      private var numFrames:int;
      
      private var dead:Boolean;
      
      private var emissionDelta:uint;
      
      private var nextEmissionTime:uint;
      
      private var time:uint;
      
      private var framesPerDistance:Number;
      
      private var vin:Vector.<Number>;
      
      private var vout:Vector.<Number>;
      
      private var matrix:Matrix3;
      
      private var origin:Vector3;
      
      private var dir:Vector3;
      
      private var xAxis:Vector3;
      
      private var muzzleGlobalPos:Vector3;
      
      private var targetPoint:Vector3;
      
      private var comps:Vector.<Vector3D>;
      
      private var particleSize:Number;
      
      private var tank:Tank;
      
      private var particleDamage:Number;
	  
	  private var mesh:CrossPlaneMesh;
	  
	  private var timetoLive:int = 400;
	  
	  private var mat:AnimSprite;
      
      public function FlamethrowerGraphicEffect(param1:Tank, param2:Number, param3:Number, param4:Number, param5:Vector3D, param6:int, param7:Number, param8:AnimSprite, param9:Vector3D, param10:Number, param11:Vector3D)
      {
         super();
         this.range = param4;
         tank = param1;
		 mat = param8;
         //this.particleDamage = param11;
		 this.mesh = new CrossPlaneMesh(param2,param3,tank,param5,param8,param9,param10,param11);
         this.emissionDelta = 1000 * param4 / (param6 * param7);
         this.time = this.nextEmissionTime = getTimer();
      }
      
      public function addToContainer(param1:ObjectContainer3D, param2:Game) : void
      {
         Main.instance.game.container.addChild(this.mesh);
      }
      
      public function play(param1:int, param2:Number, param3:Camera3D) : Boolean
      {
		  if(this.timetoLive < 0)
         {
			 this.destroy();
            return false;
         }
         this.timetoLive = this.timetoLive - param1;
		this.nextEmissionTime = this.nextEmissionTime + this.emissionDelta;
		mesh.setMaterial(mat.material as TextureMaterial);
         return true;
      }
      
      public function destroy() : void
      {
		  mat = null;
		  if (mesh != null)
		  {
			Main.instance.game.container.removeChild(this.mesh);
			this.mesh.destroy();
			this.mesh = null;
		  }
      }
      
      public function kill() : void
      {
         this.dead = true;
      }
      
      public function revive() : void
      {
         this.dead = false;
      }
   }
}

import alternativa.tanks.sfx.AnimSprite;
import alternativa.tanks.tank.Tank;
import alternativa.tanks.tank.weapon.SimpleObjectController;
import away3d.containers.ObjectContainer3D;
import away3d.entities.Mesh;
import away3d.entities.Sprite3D;
import away3d.materials.TextureMaterial;
import away3d.primitives.PlaneGeometry;
import awayphysics.collision.dispatch.AWPCollisionObject;
import awayphysics.collision.shapes.AWPConvexHullShape;
import awayphysics.dynamics.AWPRigidBody;
import awayphysics.events.AWPEvent;
import flash.geom.Vector3D;
import alternativa.tanks.tank.weapon.sfx.GunShotExplosion;

class CrossPlaneMesh extends ObjectContainer3D
{
    
   public var plane1:AWPRigidBody;
   
   private var plane2:Sprite3D;
   
   private var plane25:Mesh = new Mesh(new PlaneGeometry(1, 10));
   
   private var plane255:Mesh = new Mesh(new PlaneGeometry(1, 10));
   
   private var maxv:int = 10000;
   
   private var d:int;
   
   private var tempController:SimpleObjectController = new SimpleObjectController(Main.instance.stage, plane25, 100000);
   
   public function CrossPlaneMesh(param1:Number, param2:Number, param4:Tank, param5:Vector3D, param6:AnimSprite, param7:Vector3D, param8:int, param9:Vector3D)
   {
		super();
		this.plane2 = new Sprite3D(null,param1,param2);
		d = param8;
		addChild(this.plane2);
		//mat = param6;
		//addChild(mat);
		plane1 = new AWPRigidBody(new AWPConvexHullShape(new PlaneGeometry(param1, param2)), plane2, 10);
		plane1.activationState = AWPCollisionObject.DISABLE_DEACTIVATION;
		plane1.friction = 1;
		plane1.position = param9;
		plane1.rotation = param5;
		Main.instance.game.physics.addRigidBody(plane1);
		plane1.applyCentralForce(getf(param9, param5));
		plane1.angularVelocity = new Vector3D(30, 30, 30);
		plane1.addEventListener(AWPEvent.COLLISION_ADDED, crash);
      }
	  
	  public function destroy() : void
	{
		plane2.visible = false;
		Main.instance.game.physics.removeRigidBody(plane1);
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
			hj.scaleBy(maxv);
			hj.y += 100;
			this.plane255.position = new Vector3D();
		return hj;
      }
	  
	  private function crash(e:AWPEvent) : void
      {
			for (var i:int = 0; i < Main.instance.game.tanks.length; i++) {
				if (Main.instance.game.tanks[i] != null) {
					if (Main.instance.game.tanks[i].carBody == e.collisionObject)
					{
						Main.instance.game.physics.removeRigidBody(plane1);
					}
				}
			}
      }
	  
	  private function getDamage(param1:Vector3D = null, param2:Vector3D = null, param3:int = 0) : Number
      {
		 var _loc7_:Vector3D = new Vector3D(param2.x - param1.x, param2.y - param1.y, param2.z - param1.z);
         var _loc3_:Number = Math.sqrt(_loc7_.x^2 + _loc7_.y^2 + _loc7_.z^2) / 128;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         var _loc4_:Number = param3;
         if(_loc3_ >= 50)
         {
            _loc4_ = param3 / 2;
         }
         if(_loc3_ >= 100)
         {
            _loc4_ = param3 / 5;
         }
         return _loc4_;
      }
   
   public function setMaterial(param1:TextureMaterial) : void
   {
      plane2.material = param1;
   }
}
