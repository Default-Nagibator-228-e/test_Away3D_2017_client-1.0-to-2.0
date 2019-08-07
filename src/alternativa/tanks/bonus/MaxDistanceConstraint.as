package alternativa.tanks.bonus
{
   import alternativa.physics.constraints.Constraint;
   import alternativa.physics.altphysics;
   import alternativa.physics.Body;
   import alternativa.math.Vector3;
   import alternativa.math.Matrix3;
   
   use namespace altphysics;
   
   public class MaxDistanceConstraint extends Constraint
   {
       
      altphysics var body1:Body;
      
      altphysics var body2:Body;
      
      altphysics var r1:Vector3;
      
      altphysics var r2:Vector3;
      
      altphysics var maxDistance:Number;
      
      altphysics var wr1:Vector3;
      
      altphysics var wr2:Vector3;
      
      private var minClosingVel:Number;
      
      private var velByUnitImpulseN:Number;
      
      private var impulseDirection:Vector3;
      
      public function MaxDistanceConstraint(param1:Body, param2:Body, param3:Vector3, param4:Vector3, param5:Number)
      {
         this.wr1 = new Vector3();
         this.wr2 = new Vector3();
         this.impulseDirection = new Vector3();
         super();
         this.body1 = param1;
         this.body2 = param2;
         this.r1 = param3.vClone();
         this.r2 = param4.vClone();
         this.maxDistance = param5;
      }
      
      override public function preProcess(param1:Number) : void
      {
         var _loc2_:Matrix3 = null;
         var _loc3_:Vector3 = null;
         var _loc4_:Number = NaN;
         var _loc6_:Vector3 = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         _loc2_ = this.body1.baseMatrix;
         this.wr1.x = _loc2_.a * this.r1.x + _loc2_.b * this.r1.y + _loc2_.c * this.r1.z;
         this.wr1.y = _loc2_.e * this.r1.x + _loc2_.f * this.r1.y + _loc2_.g * this.r1.z;
         this.wr1.z = _loc2_.i * this.r1.x + _loc2_.j * this.r1.y + _loc2_.k * this.r1.z;
         if(this.body2 != null)
         {
            _loc2_ = this.body2.baseMatrix;
            this.wr2.x = _loc2_.a * this.r2.x + _loc2_.b * this.r2.y + _loc2_.c * this.r2.z;
            this.wr2.y = _loc2_.e * this.r2.x + _loc2_.f * this.r2.y + _loc2_.g * this.r2.z;
            this.wr2.z = _loc2_.i * this.r2.x + _loc2_.j * this.r2.y + _loc2_.k * this.r2.z;
         }
         else
         {
            this.wr2.x = this.r2.x;
            this.wr2.y = this.r2.y;
            this.wr2.z = this.r2.z;
         }
         _loc3_ = this.body1.state.pos;
         this.impulseDirection.x = this.wr2.x - this.wr1.x - _loc3_.x;
         this.impulseDirection.y = this.wr2.y - this.wr1.y - _loc3_.y;
         this.impulseDirection.z = this.wr2.z - this.wr1.z - _loc3_.z;
         if(this.body2 != null)
         {
            _loc6_ = this.body2.state.pos;
            this.impulseDirection.x = this.impulseDirection.x + _loc6_.x;
            this.impulseDirection.y = this.impulseDirection.y + _loc6_.y;
            this.impulseDirection.z = this.impulseDirection.z + _loc6_.z;
         }
         _loc4_ = Math.sqrt(this.impulseDirection.x * this.impulseDirection.x + this.impulseDirection.y * this.impulseDirection.y + this.impulseDirection.z * this.impulseDirection.z);
         var _loc5_:Number = _loc4_ - this.maxDistance;
         if(_loc5_ > 0)
         {
            satisfied = false;
            if(_loc4_ < 0.001)
            {
               this.impulseDirection.x = 1;
            }
            else
            {
               _loc4_ = 1 / _loc4_;
               this.impulseDirection.x = this.impulseDirection.x * _loc4_;
               this.impulseDirection.y = this.impulseDirection.y * _loc4_;
               this.impulseDirection.z = this.impulseDirection.z * _loc4_;
            }
            this.minClosingVel = _loc5_ / (world.penResolutionSteps * param1);
            if(this.minClosingVel > world.maxPenResolutionSpeed)
            {
               this.minClosingVel = world.maxPenResolutionSpeed;
            }
            this.velByUnitImpulseN = 0;
            if(this.body1.movable)
            {
               _loc10_ = this.wr1.y * this.impulseDirection.z - this.wr1.z * this.impulseDirection.y;
               _loc11_ = this.wr1.z * this.impulseDirection.x - this.wr1.x * this.impulseDirection.z;
               _loc12_ = this.wr1.x * this.impulseDirection.y - this.wr1.y * this.impulseDirection.x;
               _loc2_ = this.body1.invInertiaWorld;
               _loc7_ = _loc2_.a * _loc10_ + _loc2_.b * _loc11_ + _loc2_.c * _loc12_;
               _loc8_ = _loc2_.e * _loc10_ + _loc2_.f * _loc11_ + _loc2_.g * _loc12_;
               _loc9_ = _loc2_.i * _loc10_ + _loc2_.j * _loc11_ + _loc2_.k * _loc12_;
               _loc10_ = _loc8_ * this.wr1.z - _loc9_ * this.wr1.y;
               _loc11_ = _loc9_ * this.wr1.x - _loc7_ * this.wr1.z;
               _loc12_ = _loc7_ * this.wr1.y - _loc8_ * this.wr1.x;
               this.velByUnitImpulseN = this.velByUnitImpulseN + (this.body1.invMass + _loc10_ * this.impulseDirection.x + _loc11_ * this.impulseDirection.y + _loc12_ * this.impulseDirection.z);
            }
            if(this.body2 != null && Boolean(this.body2.movable))
            {
               _loc10_ = this.wr2.y * this.impulseDirection.z - this.wr2.z * this.impulseDirection.y;
               _loc11_ = this.wr2.z * this.impulseDirection.x - this.wr2.x * this.impulseDirection.z;
               _loc12_ = this.wr2.x * this.impulseDirection.y - this.wr2.y * this.impulseDirection.x;
               _loc2_ = this.body2.invInertiaWorld;
               _loc7_ = _loc2_.a * _loc10_ + _loc2_.b * _loc11_ + _loc2_.c * _loc12_;
               _loc8_ = _loc2_.e * _loc10_ + _loc2_.f * _loc11_ + _loc2_.g * _loc12_;
               _loc9_ = _loc2_.i * _loc10_ + _loc2_.j * _loc11_ + _loc2_.k * _loc12_;
               _loc10_ = _loc8_ * this.wr2.z - _loc9_ * this.wr2.y;
               _loc11_ = _loc9_ * this.wr2.x - _loc7_ * this.wr2.z;
               _loc12_ = _loc7_ * this.wr2.y - _loc8_ * this.wr2.x;
               this.velByUnitImpulseN = this.velByUnitImpulseN + (this.body2.invMass + _loc10_ * this.impulseDirection.x + _loc11_ * this.impulseDirection.y + _loc12_ * this.impulseDirection.z);
            }
         }
         else
         {
            satisfied = true;
         }
      }
      
      override public function apply(param1:Number) : void
      {
         if(satisfied)
         {
            return;
         }
         var _loc2_:Vector3 = this.body1.state.velocity;
         var _loc3_:Vector3 = this.body1.state.rotation;
         var _loc4_:Number = _loc2_.x + _loc3_.y * this.wr1.z - _loc3_.z * this.wr1.y;
         var _loc5_:Number = _loc2_.y + _loc3_.z * this.wr1.x - _loc3_.x * this.wr1.z;
         var _loc6_:Number = _loc2_.z + _loc3_.x * this.wr1.y - _loc3_.y * this.wr1.x;
         if(this.body2 != null)
         {
            _loc2_ = this.body2.state.velocity;
            _loc3_ = this.body2.state.rotation;
            _loc4_ = _loc4_ - (_loc2_.x + _loc3_.y * this.wr2.z - _loc3_.z * this.wr2.y);
            _loc5_ = _loc5_ - (_loc2_.y + _loc3_.z * this.wr2.x - _loc3_.x * this.wr2.z);
            _loc6_ = _loc6_ - (_loc2_.z + _loc3_.x * this.wr2.y - _loc3_.y * this.wr2.x);
         }
         var _loc7_:Number = _loc4_ * this.impulseDirection.x + _loc5_ * this.impulseDirection.y + _loc6_ * this.impulseDirection.z;
         if(_loc7_ > this.minClosingVel)
         {
            return;
         }
         var _loc8_:Number = (this.minClosingVel - _loc7_) / this.velByUnitImpulseN;
         if(this.body1.movable)
         {
            this.body1.applyRelPosWorldImpulse(this.wr1,this.impulseDirection,_loc8_);
         }
         if(this.body2 != null && Boolean(this.body2.movable))
         {
            this.body2.applyRelPosWorldImpulse(this.wr2,this.impulseDirection,-_loc8_);
         }
      }
   }
}
