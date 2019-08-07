package alternativa.tanks.tank.weapon.ts
{
   import alternativa.tanks.tank.Tank;
   import alternativa.math.Vector3;
   import alternativa.physics.altphysics;
   import flash.geom.Vector3D;
   import alternativa.physics.collision.types.RayIntersection;
   import alternativa.tanks.tank.physics.Chassis;
   import alternativa.tanks.Game;
   
   use namespace altphysics;
   
   public class IsidaTargetSystem
   {
       
      private var tanks:Vector.<Tank>;
      
      private var targets:Vector.<Tank>;
      
      private var shooter:Tank;
      
      private var range:Number;
      
      private var barrelOrigin:Vector3;
      
      private var gunDir:Vector3;
      
      private var predicate:GunPredicate;
      
      public function IsidaTargetSystem()
      {
         super();
      }
      
      public function getTarget(param1:Tank, param2:Vector.<Tank>, param3:Vector3, param4:Vector3, param5:IsidaHitInfo, param6:Number) : Boolean
      {
         var _loc8_:Tank = null;
         var _loc7_:Boolean = false;
         this.targets = new Vector.<Tank>();
         this.predicate = new GunPredicate();
         this.predicate.shooter = param1.chassis;
         this.range = param6;
         this.shooter = param1;
         this.tanks = param2;
         this.barrelOrigin = param3;
         this.gunDir = param4;
         for each(_loc8_ in param2)
         {
            if(this.testTank(_loc8_))
            {
               _loc7_ = true;
               this.targets.push(_loc8_);
            }
         }
         if(_loc7_)
         {
            param5.target = this.getOneTarget();
         }
         else
         {
            param5.target = null;
         }
         if(param5.target == null)
         {
            _loc7_ = false;
         }
         return _loc7_;
      }
      
      private function getOneTarget() : Tank
      {
         var _loc2_:Tank = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Vector3D = null;
         var _loc7_:Vector3D = null;
         var _loc1_:Vector.<Number> = new Vector.<Number>();
         for each(_loc2_ in this.targets)
         {
            _loc6_ = _loc2_.turret.localToGlobal(new Vector3D());
            _loc7_ = this.shooter.muzzlePoint.globalToLocal(_loc6_);
            _loc1_.push(_loc7_.y);
         }
         _loc3_ = 999999;
         _loc4_ = -1;
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            if(_loc1_[_loc5_] < _loc3_)
            {
               _loc3_ = _loc1_[_loc5_];
               _loc4_ = _loc5_;
            }
            _loc5_++;
         }
         if(_loc4_ == -1)
         {
            return null;
         }
         return this.targets[_loc4_];
      }
      
      private function testTank(param1:Tank) : Boolean
      {
         var _loc2_:Vector3D = null;
         var _loc3_:Vector3D = null;
         var _loc4_:Vector3D = null;
         var _loc5_:Vector3 = null;
         var _loc6_:Vector3D = null;
         var _loc7_:Vector3 = null;
         var _loc8_:Vector3 = null;
         var _loc9_:RayIntersection = null;
         var _loc10_:Chassis = null;
         if(param1 != this.shooter)
         {
            _loc2_ = param1.turret.localToGlobal(new Vector3D());
            _loc3_ = this.shooter.muzzlePoint.globalToLocal(_loc2_);
            if(_loc3_.x >= -400 && _loc3_.x <= 400 && _loc3_.y >= 0 && _loc3_.y <= this.range && _loc3_.z >= -400 && _loc3_.z <= 400)
            {
               _loc4_ = param1.hull.localToGlobal(new Vector3D());
               _loc5_ = new Vector3().copyFromVector3D(_loc4_);
               _loc6_ = this.shooter.muzzlePoint.localToGlobal(new Vector3D());
               _loc7_ = new Vector3().copyFromVector3D(_loc6_);
               _loc8_ = new Vector3();
               _loc8_ = _loc8_.vDiff(_loc5_,_loc7_);
               _loc8_.vScale(1 / _loc8_.vLength());
               this.shooter.weapon.calcTurretParams(0);
               _loc9_ = new RayIntersection();
               if(Game.getInstance().world.collisionDetector.intersectRay(_loc7_,_loc8_,1,this.range,this.predicate,_loc9_))
               {
                  _loc10_ = _loc9_.primitive.body as Chassis;
                  if(_loc10_ == null)
                  {
                     return false;
                  }
                  if(_loc10_.tank == param1)
                  {
                     return true;
                  }
                  return false;
               }
               return false;
            }
            return false;
         }
         return false;
      }
   }
}

import alternativa.physics.collision.IRayCollisionPredicate;
import alternativa.physics.Body;

class GunPredicate implements IRayCollisionPredicate
{
    
   public var shooter:Body;
   
   function GunPredicate()
   {
      super();
   }
   
   public function considerBody(param1:Body) : Boolean
   {
      return this.shooter != param1;
   }
}
