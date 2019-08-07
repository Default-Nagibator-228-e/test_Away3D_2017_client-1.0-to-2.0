package alternativa.tanks.tank.weapon.ts
{
   import alternativa.math.Vector3;
   import alternativa.tanks.tank.Tank;
   import alternativa.math.Matrix3;
   import alternativa.physics.collision.types.RayIntersection;
   import alternativa.physics.collision.ICollisionDetector;
   import alternativa.tanks.tank.physics.Chassis;
   import alternativa.physics.altphysics;
   
   use namespace altphysics;
   
   public class RailGunTargetSystem
   {
      
      private static var rayDir1:Vector3 = new Vector3();
      
      private static var rayDir2:Vector3 = new Vector3();
       
      private const collisionGroup:int = 1;
      
      private var nearestTank:Tank;
      
      private var tmin:Number;
      
      private var bestDir:Vector3;
      
      private var matrix:Matrix3;
      
      private var intersection:RayIntersection;
      
      private var predicate:GunPredicate;
      
      private var prevCG:Vector.<alternativa.tanks.tank.weapon.ts.RailGunTargetSystemTCG>;
      
      public function RailGunTargetSystem()
      {
         this.bestDir = new Vector3();
         this.matrix = new Matrix3();
         this.intersection = new RayIntersection();
         this.predicate = new GunPredicate();
         this.prevCG = new Vector.<alternativa.tanks.tank.weapon.ts.RailGunTargetSystemTCG>();
         super();
      }
      
      public function getTarget(param1:Number, param2:Vector3, param3:Vector3, param4:Vector3, param5:Number, param6:int, param7:Number, param8:int, param9:ICollisionDetector, param10:Tank, param11:RailGunHitInfo) : Boolean
      {
         var _loc12_:Chassis = null;
         var _loc13_:Vector3 = null;
         var _loc14_:Number = NaN;
         var _loc15_:Chassis = null;
         this.nearestTank = null;
         this.tmin = 10000000000;
         this.predicate.shooter = param10.chassis;
         if(param9.intersectRay(param2,param3,this.collisionGroup,param1,this.predicate,this.intersection))
         {
            this.tmin = this.intersection.t;
            this.bestDir.vCopy(param3);
            _loc12_ = this.intersection.primitive.body as Chassis;
            if(_loc12_ != null)
            {
               if(_loc12_.tank != null)
               {
                  this.nearestTank = _loc12_.tank;
               }
            }
         }
         if(param6 > 0)
         {
            this.checkSector(param2,param3,param4,param6,param5 / param6,param9);
         }
         if(param8 > 0)
         {
            this.checkSector(param2,param3,param4,param8,-param7 / param8,param9);
         }
         this.predicate.shooter = null;
         if(this.tmin < param1)
         {
            param11.t = this.tmin;
            param11.dir.vCopy(this.bestDir);
            if(this.nearestTank != null)
            {
               param11.endDir = new Vector3();
               param11.endDir.vCopy(this.bestDir);
               _loc13_ = new Vector3();
               _loc13_.vCopy(param2).vAddScaled(this.tmin,this.bestDir);
               param11.pos.push(_loc13_.vClone());
               param11.body.push(this.nearestTank.chassis);
               this.prevCG.push(new alternativa.tanks.tank.weapon.ts.RailGunTargetSystemTCG(this.nearestTank));
               this.nearestTank.chassis.collisionGroup = 0;
               this.getTarget(param1,param11.pos[param11.pos.length - 1],param3,param4,param5,param6,param7,param8,param9,param10,param11);
               _loc14_ = 0;
               while(_loc14_ < this.prevCG.length)
               {
                  _loc15_ = this.prevCG[_loc14_].nearestTank.chassis;
                  _loc15_.collisionGroup = 1;
                  _loc14_++;
               }
            }
            else
            {
               param11.endPos = new Vector3();
               param11.endPos.vCopy(this.intersection.pos);
            }
            return true;
         }
         return false;
      }
      
      private function checkSector(param1:Vector3, param2:Vector3, param3:Vector3, param4:int, param5:Number, param6:ICollisionDetector) : void
      {
         var _loc8_:Chassis = null;
         var _loc9_:Tank = null;
         this.matrix.fromAxisAngle(param3,param5);
         rayDir2.vCopy(param2);
         var _loc7_:int = 1;
         while(_loc7_ <= param4)
         {
            rayDir1.vCopy(rayDir2);
            this.matrix.transformVector(rayDir1,rayDir2);
            if(param6.intersectRay(param1,rayDir2,this.collisionGroup,10000000000,this.predicate,this.intersection))
            {
               _loc8_ = this.intersection.primitive.body as Chassis;
               if(_loc8_ != null)
               {
                  _loc9_ = _loc8_.tank;
                  if(this.nearestTank == null || this.intersection.t < this.tmin)
                  {
                     this.tmin = this.intersection.t;
                     this.bestDir.vCopy(rayDir2);
                     this.nearestTank = _loc9_;
                  }
               }
            }
            _loc7_++;
         }
      }
   }
}

import alternativa.physics.collision.IRayCollisionPredicate;
import alternativa.physics.Body;
import alternativa.tanks.tank.physics.Chassis;

class GunPredicate implements IRayCollisionPredicate
{
    
   public var shooter:Body;
   
   function GunPredicate()
   {
      super();
   }
   
   public function considerBody(param1:Body) : Boolean
   {
      if(param1 == this.shooter)
      {
         return false;
      }
      var _loc2_:Chassis = param1 as Chassis;
      if(_loc2_ != null)
      {
         if(!_loc2_.tank.vis)
         {
            return false;
         }
      }
      return true;
   }
}
