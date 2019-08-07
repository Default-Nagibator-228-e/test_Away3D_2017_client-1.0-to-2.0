package alternativa.tanks.tank.weapon.sfx
{
   import alternativa.tanks.IGraphicEffect;
   import alternativa.math.Vector3;
   import alternativa.tanks.sfx.AnimSprite;
   import alternativa.tanks.tank.weapon.Weapon;
   import alternativa.tanks.Game;
   import away3d.cameras.Camera3D;
   import away3d.containers.ObjectContainer3D;
   import away3d.entities.Mesh;
   import away3d.materials.TextureMaterial;
   import awayphysics.dynamics.AWPRigidBody;
   import flash.geom.Vector3D;
   
   public class PlasmaGunGraphicEffect implements IGraphicEffect
   {
       
      private var mesh:CrossPlaneMesh;
	  
	  private var meshm:AnimSprite;
      
      private var timetoLive:int;
      
      private var turret:AWPRigidBody;
      
      private var muzzleLocalPos:Vector3D;
      
      private var weapon:Weapon;
      
      public function PlasmaGunGraphicEffect(param1:Weapon, param2:Number, param3:Number, param4:Vector3D, param5:AWPRigidBody, param6:AnimSprite, param7:Vector3D, param8:AnimSprite, param9:Function, param10:Vector3D)
      {
         super();
         weapon = param1;
         //this.muzzleLocalPos = param4;
         //this.muzzleLocalPos.z = this.muzzleLocalPos.z + 50;
         //this.muzzleLocalPos.x = this.muzzleLocalPos.x + 5;
         turret = param5;
		 meshm = param6;
         timetoLive = 100;
         mesh = new CrossPlaneMesh(param2,param3,turret,weapon.tank,param7,param8,param4,param9,param10);
      }
      
      public function play(param1:int, param2:Number, param3:Camera3D) : Boolean
      {
         //if(this.timetoLive < 0)
         //{
            //return false;
         //}
         //this.timetoLive = this.timetoLive - param1;
		 //Main.instance.game.fpsLabel.text = "FPS: " + this.mesh.plane1.position.x + this.mesh.plane1.position.y + this.mesh.plane1.position.z;
		 //Main.instance.game.fpsLabel.text = "FPS: Ахринеть кокой";
		 this.mesh.setMaterial(meshm.material as TextureMaterial);
         return true;
      }
      
      public function destroy() : void
      {
         this.mesh.parent.removeChild(this.mesh);
      }
      
      public function kill() : void
      {
         this.timetoLive = -1;
      }
      
      public function setVisible(param1:Boolean) : void
      {
         this.mesh.visible = param1;
      }
      
      public function addToContainer(param1:ObjectContainer3D, param2:Game) : void
      {
         Main.instance.game.container.addChild(this.mesh);
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
   
   private var maxv:int = 20000;
   
   private var d:Function;
   
   private var mat:AnimSprite;
   
   private var tempController:SimpleObjectController = new SimpleObjectController(Main.instance.stage, plane25, 100000);
   
   public function CrossPlaneMesh(param1:Number, param2:Number, param3:AWPRigidBody, param4:Tank, param5:Vector3D, param6:AnimSprite, param7:Vector3D, param8:Function, param9:Vector3D)
   {
		super();
		this.plane2 = new Sprite3D(null,param1,param2);
		//this.plane2.rotationY = 0.5 * Math.PI;
		d = param8;
		addChild(this.plane2);
		plane1 = param3;
		mat = param6;
		plane1 = new AWPRigidBody(new AWPConvexHullShape(new PlaneGeometry(param1, param2)), this.plane2, 10);
		plane1.activationState = AWPCollisionObject.DISABLE_DEACTIVATION;
		plane1.friction = 1;
		plane1.position = param9;
		plane1.rotation = param5;
		Main.instance.game.physics.addRigidBody(plane1);
		if (param7 == null)
		{
			plane1.applyCentralForce(getf(param9,param5));
		}else{
			tempController.setObjectPos(param9);
			tempController.lookAt(param7);
			plane1.applyCentralForce(getf(param9, new Vector3D(0,plane25.rotationY)));
		}
		plane1.addEventListener(AWPEvent.COLLISION_ADDED, crash);
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
			this.plane255.position = new Vector3D();
		return hj;
      }
	  
	  private function crash(e:AWPEvent) : void
      {
			var explosionEffect:GunShotExplosion = new GunShotExplosion(plane1.position, Main.instance.game._view.camera, mat, 800);
			Main.instance.game.addGraphicsEffect(explosionEffect);
			plane2.visible = false;
			Main.instance.game.physics.removeRigidBody(plane1);
      }
	  /*
	  private function getv(e:Number) : Vector3D
      {
			var u:Number = e - (360 * int(e / 360));
			var i:Vector3D = new Vector3D();
			if (u < 0)
			{
				u = -u;
				u = 360 - u;
			}
			var o:Number = u/90;
			if (u >= 0 && u < 90)
			{
				i = new Vector3D(maxv * o,0,maxv * (1-o));
			}
			if (u > 90 && u < 180)
			{
				i = new Vector3D(maxv * (2-o),0,-maxv * (o-1));
			}
			if (u > 180 && u < 270)
			{
				i = new Vector3D(-maxv * (o-2),0,-maxv * (3-o));
			}
			if (u > 270)
			{
				i = new Vector3D(-maxv * (4-o),0,maxv * (o-3));
			}
			return i;
      }
	  
	  private function getv1(e:Number) : Vector3D
      {
			var u:Number = e - (360 * int(e / 360));
			var o:Number = maxv;
			var p:Number = maxv;
			var o1:Number = u/90;
			var p1:Number = 1-u/90;
			var i:Vector3D = new Vector3D();
			if (o1>2)
			{
				o =-o;
			}
			if ((p1>1 && p1<2)||(p1>3 && p1<4))
			{
				p =-p;
			}
			if (o1 > 1)
			{
				o1 -= int(o1);
				if (o1<0)
				{
					o1 += 1;
				}
				o *= o1;
			}
			if (p1 > 1)
			{
				p1 -= int(p1);
				if (p1<0)
				{
					p1 += 1;
				}
				p *= p1;
			}
			i = new Vector3D(o,0,p);
			return i;
      }
	  */
   
   public function setMaterial(param1:TextureMaterial) : void
   {
      //this.plane1.material = param1;
      plane2.material = param1;
   }
}