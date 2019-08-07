package alternativa.tanks.tank.weapon.sfx
{
   import alternativa.tanks.IGraphicEffect;
   import alternativa.math.Vector3;
   import alternativa.tanks.sfx.AnimSprite;
   import alternativa.tanks.tank.weapon.RailGun;
   import alternativa.tanks.tank.weapon.Weapon;
   import alternativa.tanks.Game;
   import away3d.cameras.Camera3D;
   import away3d.containers.ObjectContainer3D;
   import away3d.entities.Mesh;
   import away3d.materials.TextureMaterial;
   import away3d.primitives.PlaneGeometry;
   import awayphysics.dynamics.AWPRigidBody;
   import flash.geom.Vector3D;
   
   public class RailGunBeam implements IGraphicEffect
   {
       
      public var mesh:CrossPlaneMesh;
	  
	  private var vmesh:Vector.<CrossPlaneMesh> = new Vector.<CrossPlaneMesh>();
      
      private var timetoLive:int;
      
      private var turret:AWPRigidBody;
      
      private var muzzleLocalPos:Vector3D;
      
      private var weapon:Weapon;
	  
	  private var jet:Vector3D = new Vector3D();
	  
	  private var li:Mesh = new Mesh(new PlaneGeometry(1, 1));
      
      public function RailGunBeam(param1:RailGun, param2:Number, param3:Number, param4:Vector3D, param6:TextureMaterial, param7:Vector3D, param9:Number, param10:Vector3D)
      {
         super();
         this.weapon = param1;
         //this.muzzleLocalPos = param4;
         //this.muzzleLocalPos.z = this.muzzleLocalPos.z + 50;
         //this.muzzleLocalPos.x = this.muzzleLocalPos.x + 5;
		 //jet = param10;
		 li.position = param10;
		 rotat(li, param7);
		 li.moveForward(param3/2);
         this.timetoLive = 1000;
		 this.mesh = new CrossPlaneMesh(param2,param3,this.weapon.tank,param7,param4,param9,li.position,param1);
		 this.mesh.setMaterial(param6);
		 /*
		 for (var i:int = 0; i < 5; i++)
		 {
				li.moveForward(512);
				mesh = new CrossPlaneMesh(param2,param3,this.weapon.tank,param7,param4,param9,li.position);
				mesh.setMaterial(param6);
				vmesh.push(mesh);
				for (var i1:int = 0; i1 < vmesh.length; i++)
				 {
					if (vmesh[i1].call)
					{
						i = 118;
					}
				 }
		 }
		 */
      }
	  
	  private function rotat(param1:Mesh,param2:Vector3D) : void
      {
         param1.rotationX = param2.x;
		 param1.rotationY = param2.y;
		 param1.rotationZ = param2.z;
      }
      
      public function play(param1:int, param2:Number, param3:Camera3D) : Boolean
      {
         if(this.timetoLive < 0)
         {
            return false;
			destroy();
         }
         this.timetoLive = this.timetoLive - param1;
		 //this.mesh.plane1.applyCentralImpulse(new Vector3D(0,10,0));
		 //Main.instance.game.fpsLabel.text = "FPS: " + this.mesh.plane1.position.x + this.mesh.plane1.position.y + this.mesh.plane1.position.z;
		 //Main.instance.game.fpsLabel.text = "FPS: Ахринеть кокой";
         return true;
      }
      
      public function destroy() : void
      {
		  if (this.mesh != null)
		  {
			Main.instance.game.container.removeChild(this.mesh);
			this.mesh.destroy();
			this.mesh = null;
		  }
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
import alternativa.tanks.tank.weapon.RailGun;
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
   
   private var plane2:Mesh;
   
   private var plane25:Mesh = new Mesh(new PlaneGeometry(1, 10));
   
   private var plane2555:Mesh = new Mesh(new PlaneGeometry(1, 10));
   
   private var plane255:Mesh = new Mesh(new PlaneGeometry(1, 10));
   
   private var maxv:int = 20000;
   
   private var d:Number;
   
   public var call:RailGun;
   
   private var tempController:SimpleObjectController = new SimpleObjectController(Main.instance.stage, plane25, 100000);
   
   public function CrossPlaneMesh(param1:Number, param2:Number, param4:Tank, param5:Vector3D, param7:Vector3D, param8:Number, param9:Vector3D, param10:RailGun)
   {
		super();
		this.plane2 = new Mesh(new PlaneGeometry(param1,param2));
		//this.plane2.rotationY = 0.5 * Math.PI;
		d = param8;
		call = param10;
		addChild(this.plane2);
		//this.plane2.rotationZ = param5.z;
		plane1 = new AWPRigidBody(new AWPConvexHullShape(new PlaneGeometry(param1, param2)), this.plane2, 0);
		plane1.activationState = AWPCollisionObject.DISABLE_DEACTIVATION;
		plane1.friction = 1;
		plane1.position = param9;
		plane1.rotation = param5;
		Main.instance.game.fpsLabel.text = param5.z + "";
		if (param7 != null)
		{
			this.plane2555.position = param9;
			plane2555.lookAt(param7);
			Main.instance.game.fpsLabel.text = "fg";
			plane1.rotationZ = plane2555.rotationZ;
			Main.instance.game.fpsLabel.text = plane1.rotation + "";
		}
		Main.instance.game.physics.addRigidBody(plane1);
		plane1.addEventListener(AWPEvent.COLLISION_ADDED, crash);
      }
	  
	  private function crash(e:AWPEvent) : void
      {
		  var frl:Boolean = false;
		  //Main.instance.game.fpsLabel.text += "1";
			for (var i:int = 1; i < Main.instance.game.tanks.length; i++) {
				if (Main.instance.game.tanks[i] != null) {
					if (Main.instance.game.tanks[i].carBody == e.collisionObject)
					{
						Main.instance.game.physics.removeRigidBody(plane1);
					}
				}
			}
			if (Main.instance.game.tanks[0].carBody != e.collisionObject)
			{
				  Main.instance.game.physics.removeRigidBody(plane1);
			}
      }
	  
	  private function getf(param1:Vector3D,param2:Vector3D) : Vector3D
      {
			var tu:Vector3D = new Vector3D();
			tu.x = param2.x - param1.x;
			tu.y = param2.y - param1.y;
			tu.z = param2.z - param1.z;
		return tu;
      }
	  
	  public function destroy() : void
	  {
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
