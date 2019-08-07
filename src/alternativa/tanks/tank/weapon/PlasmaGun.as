package alternativa.tanks.tank.weapon
{
   import alternativa.tanks.resources.ImageLib;
   import alternativa.tanks.sfx.AnimSprite;
   import alternativa.tanks.tank.Tank;
   import alternativa.tanks.tank.weapon.sfx.GunShotExplosion;
   import alternativa.tanks.tank.weapon.sfx.PlasmaGunGraphicEffect;
   import alternativa.tanks.tank.weapon.sfx.PlasmaShotEffect;
   import away3d.entities.Mesh;
   import away3d.materials.TextureMaterial;
   import away3d.primitives.PlaneGeometry;
   import awayphysics.dynamics.AWPRigidBody;
   import flash.display.BitmapData;
   import alternativa.math.Vector3;
   import alternativa.tanks.Game;
   import flash.geom.Matrix;
   import flash.geom.Vector3D;
   import flash.utils.getTimer;
   
   public class PlasmaGun extends Weapon
   {
      
      private static const UP_ANGLE:Number = 0.261799;
      
      private static const DOWN_ANGLE:Number = 0.261799;
      
      private static const UP_RAYS:int = 10;
      
      private static const DOWN_RAYS:int = 10;
       
      private var delay:Number;
      
      protected var active:Boolean;
      
      private var particleMaterials:Vector.<TextureMaterial>;
      
      private var effect:PlasmaGunGraphicEffect;
      
      private var particleSize:Number;
      
      private var muzzle:Boolean = false;
      
      private var shotSprite:AnimSprite;
      
      private var explosionSprite:AnimSprite;
      
      private var maxParticles:Number;
      
      private var particleSpeed:Number;
      
      private var range:Number;
      
      private var particleDamage:Number;
      
      private var damageDownDistance:Number;
      
      private var returnForce:Number;
      
      private var force:Number;
	  
	  private var ch:int = 0;
	  
	  private var bod:AWPRigidBody;
	  
	  private var li:Mesh = new Mesh(new PlaneGeometry(10, 100));
	  
	  private var li1:Mesh = new Mesh(new PlaneGeometry(100, 100));
	  
	  private var li2:Mesh = new Mesh(new PlaneGeometry(100, 100));
	  
	  private var li3:Mesh = new Mesh(new PlaneGeometry(100, 100));
	  
	  private var tempController:SimpleObjectController = new SimpleObjectController(Main.instance.stage, li, 100000);
	  
	  private var tanl:Vector.<Tank>;
	  
	  public var readyTime:uint;
      
      public var shotDelay:Number;
      
      public var lastShotTime:Number;
      
      public function PlasmaGun()
      {
         super();
		 tanl = Main.instance.game.tanks;
      }
      
      override public function destroy() : void
      {
         try
         {
            this.effect.destroy();
            this.effect = null;
            this.explosionSprite = null;
            this.shotSprite = null;
            this.particleMaterials = null;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      override public function loadProfile(param1:XML) : void
      {
         this.delay = param1.child("delay").@val;
         turretSpeed = param1.child("turretSpeed").@val;
         this.range = param1.child("range").@val;
         this.maxParticles = param1.child("maxParticles").@val;
         this.particleSpeed = param1.child("particleSpeed").@val;
         this.particleDamage = param1.child("particleDamage").@val;
         this.damageDownDistance = param1.child("damageDownDistance").@val;
         this.returnForce = param1.child("returnForce").@val;
         this.force = param1.child("force").@val;
		 this.shotDelay = delay;
         var _loc2_:BitmapData = ImageLib.getImage(param1.child("particles").@id);
		 var s:Number = Math.max(128 / _loc2_.width , 128 / _loc2_.height);
		 var mat:Matrix = new Matrix();
		 mat.scale(s, s);
		 var w:Number = s * _loc2_.width;
		 var h:Number = s * _loc2_.height;
		 //throw new Error(w + "	" + h);
		 var param4:BitmapData = new BitmapData(w, 128, true, 0);
		 param4.draw(_loc2_, mat, null, null, null, true);
         this.particleSize = param4.height;
         this.particleMaterials = getAnimBitmaps(param4);
         var _loc3_:BitmapData = ImageLib.getImage(param1.child("shot").@id);
		 var s1:Number = Math.max(128 / _loc3_.width , 128 / _loc3_.height);
		 var mat1:Matrix = new Matrix();
		 mat1.scale(s1, s1);
		 var w1:Number = s1 * _loc3_.width;
		 var h1:Number = s1 * _loc3_.height;
		 //throw new Error(w + "	" + h);
		 var param5:BitmapData = new BitmapData(w1, 128, true, 0);
		 param5.draw(_loc3_, mat1, null, null, null, true);
         var _loc4_:Vector.<TextureMaterial> = getAnimBitmaps(param5);
         this.shotSprite = new AnimSprite(param5.height,param5.height);
         this.shotSprite.materials = this.particleMaterials;
         this.shotSprite.scaleX = this.shotSprite.scaleY = this.shotSprite.scaleZ = 2;
         var _loc5_:BitmapData = ImageLib.getImage(param1.child("explosion").@id);
		 var s2:Number = Math.max(128 / _loc5_.width , 128 / _loc5_.height);
		 var mat2:Matrix = new Matrix();
		 mat2.scale(s2, s2);
		 var w2:Number = s2 * _loc5_.width;
		 var h2:Number = s2 * _loc5_.height;
		 //throw new Error(w + "	" + h);
		 var param6:BitmapData = new BitmapData(w2, 128, true, 0);
		 param6.draw(_loc5_, mat2, null, null, null, true);
         var _loc6_:Vector.<TextureMaterial> = getAnimBitmaps(param6);
         this.explosionSprite = new AnimSprite(param6.height,param6.height);
         this.explosionSprite.materials = _loc6_;
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
            this.readyTime = param1 + delay;
            this.lastShotTime = getTimer();
            this.fire();
			ch += 1;
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
			var fu1:Vector.<Vector3D> = new Vector.<Vector3D>();
			fu1 = getp(fu);
				if (ch == 1)
				{
					this.effect = new PlasmaGunGraphicEffect(this, 210, 210, null, bod, shotSprite,fu, explosionSprite,this.getDamage,fu1[0]);
					Main.instance.game.addGraphicsEffect(effect);
				}
				if (ch == 2)
				{
					this.effect = new PlasmaGunGraphicEffect(this, 210, 210, null, bod, shotSprite,fu, explosionSprite,this.getDamage,fu1[1]);
					Main.instance.game.addGraphicsEffect(effect);
					ch = 0;
				}
		  }
      }
	  
	  private function getTarget() : Tank
      {
			var kl:int = 0;
			var kl1:Tank;
			for (var i:int = 1; i < tanl.length; i++) {
				if (tanl[i] != null) {
					tempController.setObjectPos(tanl[0].muzzlePoint.position);
					tempController.lookAt(tanl[i].position);
					if (li.rotationZ < 10 && li.rotationZ > -10)
					{
						if (li.rotationY < 10 && li.rotationY > -10)
						{
							kl = i;
							i = tanl.length;
						}
					}
				}
			}
			if (kl == 0)
			{
				kl1 = null;
			}
			if (kl > 0)
			{
				kl1 = tanl[kl]
			}
		return kl1;
      }
	  
	  private function getp(param1:Vector3D) : Vector.<Vector3D>
      {
			var kl1:Vector.<Vector3D> = new Vector.<Vector3D>();
			li1.position = this.tank.carBody.position.add(new Vector3D(0, this.tank.turret.position.y + this.tank.turret.maxY*.75));
			li1.rotationX = param1.x;
			li1.rotationY = this.tank.carBody.rotationY;
			li1.rotationZ = param1.z;
			li1.moveForward(this.tank.turret.z);
			li1.rotationY = param1.y;
			li1.moveLeft(this.tank.turret.maxX * 0.6);
			li1.moveForward(this.tank.turret.maxZ + 140);
			kl1.push(li1.position.clone());
			li1 = li3;
			li2.position = this.tank.carBody.position.add(new Vector3D(0, this.tank.turret.position.y + this.tank.turret.maxY*.75));
			li2.rotationX = param1.x;
			li2.rotationY = this.tank.carBody.rotationY;
			li2.rotationZ = param1.z;
			li2.moveForward(this.tank.turret.z);
			li2.rotationY = param1.y;
			li2.moveRight(this.tank.turret.maxX * 0.6);
			li2.moveForward(this.tank.turret.maxZ + 140);
			kl1.push(li2.position.clone());
			li2 = li3;
		return kl1;
      }
      
      
      override public function getDamage(param1:Vector3 = null, param2:Vector3 = null) : Number
      {
         var _loc3_:Number = calcDistance(param1,param2) / Main.METR_TO_PIXELS;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         var _loc4_:Number = this.particleDamage;
         if(_loc3_ >= 40)
         {
            _loc4_ = this.particleDamage / 2;
         }
         if(_loc3_ >= 60)
         {
            _loc4_ = 0;
         }
         return _loc4_;
      }
   }
}
