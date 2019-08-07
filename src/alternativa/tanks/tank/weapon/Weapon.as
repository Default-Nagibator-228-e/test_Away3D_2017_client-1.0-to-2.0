package alternativa.tanks.tank.weapon
{
   import alternativa.tanks.tank.Tank;
   import alternativa.math.Vector3;
   import away3d.materials.TextureMaterial;
   import away3d.utils.Cast;
   import flash.geom.Vector3D;
   import flash.geom.Matrix3D;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.geom.Point;
   
   public class Weapon
   {
       
      public var tank:Tank;
      
      public var turretSpeed:Number;
      
      public var barrelOrigin:Vector3;
      
      public var gunDir:Vector3;
      
      public var xAxis:Vector3;
      
      public var turretRotation:Vector3D;
      
      public function Weapon()
      {
         this.barrelOrigin = new Vector3();
         this.gunDir = new Vector3();
         this.xAxis = new Vector3();
         this.turretRotation = new Vector3D();
         super();
      }
      
      public function destroy() : void
      {
      }
      
      public function tankLoaded() : void
      {
         this.tankComplete();
      }
      
      public function tankComplete() : void
      {
      }
      
      public function reset() : void
      {
      }
      
      public function start(param1:int = 0) : void
      {
      }
      
      public function stop() : void
      {
      }
      
      public function update(param1:uint, param2:uint) : void
      {
      }
      
      public function loadProfile(param1:XML) : void
      {
      }
      
      public function getStatus() : Number
      {
         return 100;
      }
	  
	  public function getRot(param1:Number) : Number
      {
		 var hjk:Number = 1;
		 var u:Number = param1 - (360 * int(param1 / 360));
		 var k:Number = u - (90 * int(u / 90));
		 if (u > 90 || u > -90)
		 {
			 hjk = 90 + (90-u);
		 }else{
			 hjk = k;
		 }
         return hjk;
      }
      
      public function getDamage(param1:Vector3 = null, param2:Vector3 = null) : Number
      {
         return 0;
      }
      
      public final function calcTurretParams(param1:Number) : void
      {
         var _loc2_:Vector3 = this.tank.tankTurret.muzzlePoints[param1];
         this.calcTurretParams2(_loc2_);
      }
      
      public final function calcTurretParams2(param1:Vector3, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
      {
         var _loc5_:Vector.<Number> = Vector.<Number>([0,0,0,1,0,0,0,1,0,0,0,0]);
         var _loc6_:Vector.<Number> = Vector.<Number>([0,0,0,1,0,0,0,1,0,0,0,0]);
         var _loc7_:Matrix3D = this.tank.turret.transform;
         _loc5_[9] = param1.x + param2;
         _loc5_[10] = param1.y + param3;
         _loc5_[11] = param1.z + param4;
         _loc7_.transformVectors(_loc5_,_loc6_);
         this.barrelOrigin.x = _loc6_[9];
         this.barrelOrigin.y = _loc6_[10];
         this.barrelOrigin.z = _loc6_[11];
         this.xAxis.x = _loc6_[0];
         this.xAxis.y = _loc6_[1];
         this.xAxis.z = _loc6_[2];
         this.gunDir.x = _loc6_[6] - this.xAxis.x;
         this.gunDir.y = _loc6_[7] - this.xAxis.y;
         this.gunDir.z = _loc6_[8] - this.xAxis.z;
         this.xAxis.x = _loc6_[3] - this.xAxis.x;
         this.xAxis.y = _loc6_[4] - this.xAxis.y;
         this.xAxis.z = _loc6_[5] - this.xAxis.z;
         var _loc8_:Vector.<Vector3D> = this.tank.turret.transform.decompose();
         this.turretRotation = _loc8_[1];
      }
      
      public function calcDistance(param1:Vector3, param2:Vector3) : Number
      {
         var _loc3_:Vector3 = new Vector3(param2.x - param1.x,param2.y - param1.y,param2.z - param1.z);
         return Math.sqrt(this.x2(_loc3_.x) + this.x2(_loc3_.y) + this.x2(_loc3_.z));
      }
      
      public function x2(param1:Number) : Number
      {
         return param1 * param1;
      }
      
      public function getAnimBitmaps(param1:BitmapData) : Vector.<TextureMaterial>
      {
         var _loc8_:BitmapData = null;
         var _loc2_:Vector.<TextureMaterial> = new Vector.<TextureMaterial>();
         var _loc3_:int = param1.height;
         var _loc4_:Rectangle = new Rectangle(0,0,_loc3_,_loc3_);
         var _loc5_:Point = new Point();
         var _loc6_:int = param1.width / _loc3_;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = new BitmapData(_loc3_,_loc3_,true,0);
            _loc4_.x = _loc3_ * _loc7_;
            _loc8_.copyPixels(param1, _loc4_, _loc5_);
			var op:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(_loc8_));
			op.alphaBlending = true;
            _loc2_.push(op);
            _loc7_++;
         }
         return _loc2_;
      }
      
      public function getAnimBitmapsByWH(param1:Number, param2:Number, param3:BitmapData) : Vector.<TextureMaterial>
      {
         var _loc9_:BitmapData = null;
         var _loc4_:Vector.<TextureMaterial> = new Vector.<TextureMaterial>();
         var _loc5_:Rectangle = new Rectangle(0,0,param1,param2);
         var _loc6_:Point = new Point();
         var _loc7_:int = param3.width / param1;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc9_ = new BitmapData(param1,param2,true,0);
            _loc5_.x = param1 * _loc8_;
            _loc9_.copyPixels(param3,_loc5_,_loc6_);
            _loc4_.push(new TextureMaterial(Cast.bitmapTexture(_loc9_)));
            _loc8_++;
         }
         return _loc4_;
      }
   }
}
