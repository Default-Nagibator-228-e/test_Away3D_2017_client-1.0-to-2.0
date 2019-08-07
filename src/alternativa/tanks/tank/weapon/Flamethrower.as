package alternativa.tanks.tank.weapon
{
   import alternativa.tanks.sfx.AnimSprite;
   import alternativa.tanks.tank.Tank;
   import alternativa.tanks.tank.weapon.sfx.FlamethrowerGraphicEffect;
   import alternativa.tanks.resources.ImageLib;
   import away3d.entities.Mesh;
   import away3d.materials.TextureMaterial;
   import away3d.primitives.PlaneGeometry;
   import flash.display.BitmapData;
   import alternativa.math.Vector3;
   import flash.geom.Matrix;
   import flash.geom.Vector3D;
   import flash.utils.getTimer;
   import alternativa.tanks.Game;
   
   public class Flamethrower extends Weapon
   {
       
      public var delay:Number = 40;
      
      public var delay2:Number = 100;
      
      public var temptime:uint = 0;
      
      public var ballon:Number = 100;
      
      public var maxBallon:Number = 100;
      
      protected var active:Boolean;
      
      private var particleMaterials:Vector.<TextureMaterial>;
      
      private var effect:FlamethrowerGraphicEffect;
      
      private var particleSize:Number;
      
      private var coneHalfAngle:Number;
      
      private var maxParticles:Number;
      
      private var particleSpeed:Number;
      
      private var range:Number;
      
      private var particleDamage:Number;
	  
	  private var sprite:AnimSprite;
	  
	  private var li:Mesh = new Mesh(new PlaneGeometry(1, 1));
	  
	  private var li2:Mesh = new Mesh(new PlaneGeometry(1, 1));
	  
	  private var li1:Mesh = new Mesh(new PlaneGeometry(1, 1));
	  
	  private var li3:Mesh = new Mesh(new PlaneGeometry(1, 1));
	  
	  private var tempController:SimpleObjectController = new SimpleObjectController(Main.instance.stage, li, 100000);
	  
	  private var tanl:Vector.<Tank>;
      
      public function Flamethrower()
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
         this.delay2 = param1.child("delay2").@val;
         turretSpeed = param1.child("turretSpeed").@val;
         this.range = param1.child("range").@val;
         this.coneHalfAngle = param1.child("coneHalfAngle").@val;
         this.maxParticles = param1.child("maxParticles").@val;
         this.particleSpeed = param1.child("particleSpeed").@val;
         this.particleDamage = param1.child("particleDamage").@val;
         var _loc2_:BitmapData = ImageLib.getImage(param1.child("particles").@id);
		 var s:Number = Math.max(2048 / _loc2_.width , 256 / _loc2_.height);
		 var mat:Matrix = new Matrix();
		 mat.scale(s, s);
		 var w:Number = s * _loc2_.width;
		 var h:Number = s * _loc2_.height;
		 //throw new Error(w + "	" + h);
		 var param4:BitmapData = new BitmapData(w, 256, true, 0);
		 param4.draw(_loc2_, mat, null, null, null, true);
         this.particleSize = param4.height;
         this.particleMaterials = getAnimBitmaps(param4);
		 this.sprite = new AnimSprite(this.particleSize, this.particleSize);
		 this.sprite.materials = this.particleMaterials;
         this.sprite.scaleX = this.sprite.scaleY = this.sprite.scaleZ = 2;
      }
      
      override public function start(param1:int = 0) : void
      {
            //if(this.active)
            //{
               //return;
            //}
            this.temptime = getTimer();
            this.active = true;
            var fu:Vector3D = this.tank.carBody.rotation.add(new Vector3D(0, getRot(this.tank.turretDirection)));
			var fu1:Vector3D = getp(fu);
			var spritee:AnimSprite = new AnimSprite(this.particleSize, this.particleSize);
			spritee.materials = this.particleMaterials;
			spritee.scaleX = spritee.scaleY = spritee.scaleZ = 2;
			var effect1:FlamethrowerGraphicEffect = new FlamethrowerGraphicEffect(tank,particleSize,particleSize,this.range,fu,this.maxParticles,this.particleSpeed,spritee,null,this.particleDamage,fu1);
			Main.instance.game.addGraphicsEffect(effect1);
      }
      
      override public function stop() : void
      {
         try
         {
            if(!this.active)
            {
               return;
            }
            this.temptime = getTimer();
            this.active = false;
            this.effect.kill();
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      override public function getStatus() : Number
      {
         return Math.round(this.ballon / this.maxBallon * 100);
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
			li1.moveForward(this.tank.turret.maxZ + 250);
			kl1 = li1.position.clone();
			li1 = li3;
		return kl1;
      }
      
      override public function getDamage(param1:Vector3 = null, param2:Vector3 = null) : Number
      {
         return this.particleDamage;
      }
      
      override public function update(param1:uint, param2:uint) : void
      {
         var _loc3_:Number = NaN;
         if(this.active)
         {
            if(this.ballon > 0)
            {
               _loc3_ = param1 - this.temptime;
               if(_loc3_ >= this.delay)
               {
                  this.temptime = getTimer();
                  this.ballon--;
               }
			this.start();
            }
            else
            {
               this.stop();
            }
         }
         else if(this.ballon < this.maxBallon)
         {
            _loc3_ = param1 - this.temptime;
            if(_loc3_ >= this.delay2)
            {
               this.temptime = getTimer();
               this.ballon++;
            }
         }
      }
   }
}
