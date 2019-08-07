package alternativa.tanks.tank.physics
{
   import alternativa.math.Vector3;
   import alternativa.physics.collision.types.RayIntersection;
   import alternativa.math.Matrix3;
   import alternativa.physics.BodyState;
   
   public class SuspensionRay
   {
       
      public var collisionGroup:int;
      
      public var _track:alternativa.tanks.tank.physics.Track;
      
      private var relPos:Vector3;
      
      private var relDir:Vector3;
      
      public var worldPos:Vector3;
      
      public var worldDir:Vector3;
      
      public var lastCollided:Boolean = false;
      
      public var lastIntersection:RayIntersection;
      
      private var prevDisplacement:Number = 100;
      
      private var predicate:RayPredicate;
      
      private var dynamicFriction:Number = 0;
      
      private var sideFriction:Number = 0;
      
      private var powerCoeff:Number = 0;
      
      private var inner:Boolean;
      
      public function SuspensionRay(param1:alternativa.tanks.tank.physics.Track, param2:Vector3, param3:Vector3, param4:int)
      {
         this.worldPos = new Vector3();
         this.worldDir = new Vector3();
         this.lastIntersection = new RayIntersection();
         super();
         this._track = param1;
         this.relPos = param2.vClone();
         this.relDir = param3.vClone();
         this.collisionGroup = param4;
         this.predicate = new RayPredicate(param1._chassis);
      }
      
      public function updateCachedValues() : void
      {
         var _loc1_:Chassis = this._track._chassis;
         var _loc2_:int = _loc1_._moveDirection;
         var _loc3_:int = _loc1_._turnDirection;
         var _loc4_:TankPhysicsData = _loc1_._currentProfile;
         if(_loc2_ == 0)
         {
            if(_loc3_ == 0)
            {
               this.powerCoeff = 0;
               this.sideFriction = _loc4_.sideFriction;
               this.dynamicFriction = _loc4_.dynamicFriction;
            }
            else
            {
               if(_loc3_ < 0 && this.relPos.x < 0 || _loc3_ > 0 && this.relPos.x > 0)
               {
                  this.powerCoeff = -_loc4_.spotTurnPowerCoeff;
               }
               else
               {
                  this.powerCoeff = _loc4_.spotTurnPowerCoeff;
               }
               this.sideFriction = _loc4_.spotTurnSideFriction;
               this.dynamicFriction = _loc4_.spotTurnDynamicFriction;
            }
         }
         else if(_loc3_ == 0)
         {
            if(_loc2_ < 0)
            {
               this.powerCoeff = -1;
            }
            else
            {
               this.powerCoeff = 1;
            }
            this.sideFriction = _loc4_.sideFriction;
            this.dynamicFriction = _loc4_.dynamicFriction;
         }
         else
         {
            if(_loc3_ < 0 && this.relPos.x < 0 || _loc3_ > 0 && this.relPos.x > 0)
            {
               this.inner = true;
               this.powerCoeff = _loc4_.moveTurnPowerCoeffInner;
               this.dynamicFriction = _loc4_.moveTurnDynamicFrictionInner;
            }
            else
            {
               this.inner = false;
               this.powerCoeff = _loc4_.moveTurnPowerCoeffOuter;
               this.dynamicFriction = _loc4_.moveTurnDynamicFrictionOuter;
            }
            if(_loc2_ < 0)
            {
               this.powerCoeff = -this.powerCoeff;
            }
            this.sideFriction = _loc4_.moveTurnSideFriction;
         }
      }
      
      public function calculateIntersection() : Boolean
      {
         var _loc3_:Vector3 = null;
         var _loc1_:Chassis = this._track._chassis;
         var _loc2_:Matrix3 = this._track._chassis.baseMatrix;
         _loc2_.transformVector(this.relDir,this.worldDir);
         _loc2_.transformVector(this.relPos,this.worldPos);
         _loc3_ = _loc1_.state.pos;
         this.worldPos.x = this.worldPos.x + _loc3_.x;
         this.worldPos.y = this.worldPos.y + _loc3_.y;
         this.worldPos.z = this.worldPos.z + _loc3_.z;
         if(this.lastCollided)
         {
            this.prevDisplacement = this._track._rayRestLength - this.lastIntersection.t;
         }
         this.lastCollided = _loc1_.world.collisionDetector.intersectRay(this.worldPos,this.worldDir,this.collisionGroup,this._track._rayRestLength,this.predicate,this.lastIntersection);
         return this.lastCollided;
      }
      
      public function addForce(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc44_:Number = NaN;
         var _loc45_:Number = NaN;
         var _loc46_:Number = NaN;
         var _loc47_:Number = NaN;
         var _loc48_:Number = NaN;
         if(!this.lastCollided)
         {
            return;
         }
         var _loc4_:Chassis = this._track._chassis;
         param3 = param3 * this.powerCoeff;
         var _loc5_:TankPhysicsData = _loc4_._currentProfile;
         var _loc6_:Vector3 = _loc4_.state.rotation;
         var _loc7_:Matrix3 = _loc4_.baseMatrix;
         var _loc8_:Number = _loc6_.x * _loc7_.c + _loc6_.y * _loc7_.g + _loc6_.z * _loc7_.k;
         var _loc9_:Number = this.lastIntersection.normal.x;
         var _loc10_:Number = this.lastIntersection.normal.y;
         var _loc11_:Number = this.lastIntersection.normal.z;
         var _loc12_:Number = _loc7_.b;
         var _loc13_:Number = _loc7_.f;
         var _loc14_:Number = _loc7_.j;
         var _loc15_:Number = _loc13_ * _loc11_ - _loc14_ * _loc10_;
         var _loc16_:Number = _loc14_ * _loc9_ - _loc12_ * _loc11_;
         var _loc17_:Number = _loc12_ * _loc10_ - _loc13_ * _loc9_;
         var _loc18_:Number = _loc15_ * _loc15_ + _loc16_ * _loc16_ + _loc17_ * _loc17_;
         if(_loc18_ == 0)
         {
            _loc15_ = _loc7_.a;
            _loc16_ = _loc7_.e;
            _loc17_ = _loc7_.i;
         }
         else
         {
            _loc18_ = 1 / Math.sqrt(_loc18_);
            _loc15_ = _loc15_ * _loc18_;
            _loc16_ = _loc16_ * _loc18_;
            _loc17_ = _loc17_ * _loc18_;
         }
         var _loc19_:Number = _loc10_ * _loc17_ - _loc11_ * _loc16_;
         var _loc20_:Number = _loc11_ * _loc15_ - _loc9_ * _loc17_;
         var _loc21_:Number = _loc9_ * _loc16_ - _loc10_ * _loc15_;
         var _loc22_:BodyState = _loc4_.state;
         _loc12_ = this.lastIntersection.pos.x - _loc22_.pos.x;
         _loc13_ = this.lastIntersection.pos.y - _loc22_.pos.y;
         _loc14_ = this.lastIntersection.pos.z - _loc22_.pos.z;
         var _loc23_:Number = _loc6_.y * _loc14_ - _loc6_.z * _loc13_ + _loc22_.velocity.x;
         var _loc24_:Number = _loc6_.z * _loc12_ - _loc6_.x * _loc14_ + _loc22_.velocity.y;
         var _loc25_:Number = _loc6_.x * _loc13_ - _loc6_.y * _loc12_ + _loc22_.velocity.z;
         if(this.lastIntersection.primitive.body != null)
         {
            _loc22_ = this.lastIntersection.primitive.body.state;
            _loc12_ = this.lastIntersection.pos.x - _loc22_.pos.x;
            _loc13_ = this.lastIntersection.pos.y - _loc22_.pos.y;
            _loc14_ = this.lastIntersection.pos.z - _loc22_.pos.z;
            _loc6_ = _loc22_.rotation;
            _loc23_ = _loc23_ - (_loc6_.y * _loc14_ - _loc6_.z * _loc13_ + _loc22_.velocity.x);
            _loc24_ = _loc24_ - (_loc6_.z * _loc12_ - _loc6_.x * _loc14_ + _loc22_.velocity.y);
            _loc25_ = _loc25_ - (_loc6_.x * _loc13_ - _loc6_.y * _loc12_ + _loc22_.velocity.z);
         }
         var _loc26_:Number = Math.sqrt(_loc23_ * _loc23_ + _loc24_ * _loc24_ + _loc25_ * _loc25_);
         var _loc27_:Number = _loc23_ * _loc19_ + _loc24_ * _loc20_ + _loc25_ * _loc21_;
         var _loc31_:Number = _loc5_.drivingForceOffsetZ;
         var _loc32_:int = this._track._chassis._moveDirection;
         var _loc33_:int = this._track._chassis._turnDirection;
         var _loc34_:Number = _loc4_.baseMatrix.c;
         var _loc35_:Number = _loc4_.baseMatrix.g;
         var _loc36_:Number = _loc4_.baseMatrix.k;
         var _loc37_:Number = this.lastIntersection.t;
         var _loc38_:Number = this._track._rayRestLength - _loc37_;
         var _loc39_:Number = param2 * _loc38_ * (_loc34_ * this.lastIntersection.normal.x + _loc35_ * this.lastIntersection.normal.y + _loc36_ * this.lastIntersection.normal.z);
         var _loc40_:Number = (_loc38_ - this.prevDisplacement) / param1;
         if(_loc40_ > 0)
         {
            _loc39_ = _loc39_ + _loc40_ * _loc5_.springDamping;
         }
         if(_loc39_ < 0)
         {
            _loc39_ = 0;
         }
         _loc28_ = -_loc39_ * this.worldDir.x;
         _loc29_ = -_loc39_ * this.worldDir.y;
         _loc30_ = -_loc39_ * this.worldDir.z;
         if(_loc26_ > 0.001)
         {
            _loc44_ = _loc23_ * _loc15_ + _loc24_ * _loc16_ + _loc25_ * _loc17_;
            _loc45_ = _loc5_.smallVelocity;
            _loc46_ = this.sideFriction * _loc39_ * _loc44_ / _loc26_;
            if(_loc44_ > -_loc45_ && _loc44_ < _loc45_)
            {
               _loc46_ = _loc46_ * (_loc44_ / _loc45_);
               if(_loc44_ < 0)
               {
                  _loc46_ = -_loc46_;
               }
            }
            _loc28_ = _loc28_ - _loc46_ * _loc15_;
            _loc29_ = _loc29_ - _loc46_ * _loc16_;
            _loc30_ = _loc30_ - _loc46_ * _loc17_;
            if(_loc27_ <= 0 && param3 >= 0 || _loc27_ >= 0 && param3 <= 0)
            {
               _loc47_ = _loc5_.brakeFriction;
            }
            else
            {
               _loc47_ = this.dynamicFriction;
            }
            _loc46_ = _loc47_ * _loc39_ * _loc27_ / _loc26_;
            if(_loc27_ > -_loc45_ && _loc27_ < _loc45_)
            {
               _loc46_ = _loc46_ * (_loc27_ / _loc45_);
               if(_loc27_ < 0)
               {
                  _loc46_ = -_loc46_;
               }
            }
            _loc28_ = _loc28_ - _loc46_ * _loc19_;
            _loc29_ = _loc29_ - _loc46_ * _loc20_;
            _loc30_ = _loc30_ - _loc46_ * _loc21_;
         }
         _loc12_ = this.worldPos.x + _loc31_ * this.worldDir.x;
         _loc13_ = this.worldPos.y + _loc31_ * this.worldDir.y;
         _loc14_ = this.worldPos.z + _loc31_ * this.worldDir.z;
         var _loc41_:Number = _loc5_.maxForwardSpeed;
         var _loc42_:Number = _loc5_.maxBackwardSpeed;
         var _loc43_:Number = _loc5_.maxTurnSpeed;
         if(_loc32_ == 0)
         {
            param3 = param3 * _loc4_.tank.speedMultipler;
            if(_loc33_ < 0 && _loc8_ > _loc43_ || _loc33_ > 0 && _loc8_ < -_loc43_)
            {
               param3 = param3 * 0.1;
            }
         }
         else
         {
            _loc48_ = _loc33_ != 0 && Boolean(this.inner)?Number(_loc5_.moveTurnSpeedCoeffInner):Number(_loc5_.moveTurnSpeedCoeffOuter);
            param3 = param3 * _loc4_.tank.speedMultipler;
            _loc48_ = _loc48_ * _loc4_.tank.speedMultipler;
            if(param3 > 0 && _loc27_ > _loc48_ * _loc41_ || param3 < 0 && -_loc27_ > _loc48_ * _loc42_)
            {
               param3 = param3 * 0.1;
            }
         }
         _loc28_ = _loc28_ + param3 * _loc19_;
         _loc29_ = _loc29_ + param3 * _loc20_;
         _loc30_ = _loc30_ + param3 * _loc21_;
         _loc4_.addWorldForceXYZ(_loc12_,_loc13_,_loc14_,_loc28_,_loc29_,_loc30_);
      }
   }
}

import alternativa.physics.collision.IRayCollisionPredicate;
import alternativa.physics.Body;

class RayPredicate implements IRayCollisionPredicate
{
    
   private var body:Body;
   
   function RayPredicate(param1:Body)
   {
      super();
      this.body = param1;
   }
   
   public function considerBody(param1:Body) : Boolean
   {
      return this.body != param1;
   }
}
