package alternativa.tanks.tank.weapon.ts
{
   import alternativa.math.Vector3;
   import alternativa.tanks.tank.Tank;
   import alternativa.math.Matrix3;
   import alternativa.physics.Body;
   
   public class CommonTargetSystem
   {
      
      private static const collisionGroup:int = 1;
      
      private static var rayDir1:Vector3 = new Vector3();
      
      private static var rayDir2:Vector3 = new Vector3();
       
      private var nearestTank:Tank;
      
      private var tmin:Number;
      
      private var bestDir:Vector3;
      
      private var matrix:Matrix3;
      
      //private var intersection:RayIntersection;
      
      private var predicate:GunPredicate;
      
      public function CommonTargetSystem()
      {
         this.bestDir = new Vector3();
         this.matrix = new Matrix3();
         //this.intersection = new RayIntersection();
         this.predicate = new GunPredicate();
         super();
      }
      
      private function clearAll() : void
      {
         this.bestDir = new Vector3();
         this.matrix = new Matrix3();
         //this.intersection = new RayIntersection();
         this.predicate = new GunPredicate();
         rayDir1 = new Vector3();
         rayDir2 = new Vector3();
      }
      
      public function getTarget(param1:Number, param2:Vector3, param3:Vector3, param4:Vector3, param5:Number, param6:int, param7:Number, param8:int, param9:ICollisionDetector, param10:Tank, param11:CommonHitInfo) : Boolean
      {
         //var _loc12_:Chassis = null;
         this.nearestTank = null;
         this.tmin = 10000000000;
         //this.predicate.shooter = param10.chassis;
         //if(param9.intersectRay(param2,param3,collisionGroup,this.tmin,this.predicate,this.intersection))
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
            param11.pos.vCopy(param2).vAddScaled(this.tmin,this.bestDir);
            param11.body = this.nearestTank != null?this.nearestTank.chassis:null;
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
            if(param6.intersectRay(param1,rayDir2,collisionGroup,10000000000,this.predicate,this.intersection))
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
