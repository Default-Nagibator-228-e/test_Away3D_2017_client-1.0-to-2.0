package alternativa.math
{
   import flash.geom.Vector3D;
   
   public class Matrix3
   {
      
      public static const ZERO:alternativa.math.Matrix3 = new alternativa.math.Matrix3(0,0,0,0,0,0,0,0,0);
      
      public static const IDENTITY:alternativa.math.Matrix3 = new alternativa.math.Matrix3();
       
      public var a:Number;
      
      public var b:Number;
      
      public var c:Number;
      
      public var e:Number;
      
      public var f:Number;
      
      public var g:Number;
      
      public var i:Number;
      
      public var j:Number;
      
      public var k:Number;
      
      public function Matrix3(param1:Number = 1, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 1, param6:Number = 0, param7:Number = 0, param8:Number = 0, param9:Number = 1)
      {
         super();
         this.a = param1;
         this.b = param2;
         this.c = param3;
         this.e = param4;
         this.f = param5;
         this.g = param6;
         this.i = param7;
         this.j = param8;
         this.k = param9;
      }
      
      public function toIdentity() : alternativa.math.Matrix3
      {
         this.a = this.f = this.k = 1;
         this.b = this.c = this.e = this.g = this.i = this.j = 0;
         return this;
      }
      
      public function invert() : alternativa.math.Matrix3
      {
         var _loc1_:Number = this.a;
         var _loc2_:Number = this.b;
         var _loc3_:Number = this.c;
         var _loc4_:Number = this.e;
         var _loc5_:Number = this.f;
         var _loc6_:Number = this.g;
         var _loc7_:Number = this.i;
         var _loc8_:Number = this.j;
         var _loc9_:Number = this.k;
         var _loc10_:Number = 1 / (-_loc3_ * _loc5_ * _loc7_ + _loc2_ * _loc6_ * _loc7_ + _loc3_ * _loc4_ * _loc8_ - _loc1_ * _loc6_ * _loc8_ - _loc2_ * _loc4_ * _loc9_ + _loc1_ * _loc5_ * _loc9_);
         this.a = (_loc5_ * _loc9_ - _loc6_ * _loc8_) * _loc10_;
         this.b = (_loc3_ * _loc8_ - _loc2_ * _loc9_) * _loc10_;
         this.c = (_loc2_ * _loc6_ - _loc3_ * _loc5_) * _loc10_;
         this.e = (_loc6_ * _loc7_ - _loc4_ * _loc9_) * _loc10_;
         this.f = (_loc1_ * _loc9_ - _loc3_ * _loc7_) * _loc10_;
         this.g = (_loc3_ * _loc4_ - _loc1_ * _loc6_) * _loc10_;
         this.i = (_loc4_ * _loc8_ - _loc5_ * _loc7_) * _loc10_;
         this.j = (_loc2_ * _loc7_ - _loc1_ * _loc8_) * _loc10_;
         this.k = (_loc1_ * _loc5_ - _loc2_ * _loc4_) * _loc10_;
         return this;
      }
      
      public function append(param1:alternativa.math.Matrix3) : alternativa.math.Matrix3
      {
         var _loc2_:Number = this.a;
         var _loc3_:Number = this.b;
         var _loc4_:Number = this.c;
         var _loc5_:Number = this.e;
         var _loc6_:Number = this.f;
         var _loc7_:Number = this.g;
         var _loc8_:Number = this.i;
         var _loc9_:Number = this.j;
         var _loc10_:Number = this.k;
         this.a = param1.a * _loc2_ + param1.b * _loc5_ + param1.c * _loc8_;
         this.b = param1.a * _loc3_ + param1.b * _loc6_ + param1.c * _loc9_;
         this.c = param1.a * _loc4_ + param1.b * _loc7_ + param1.c * _loc10_;
         this.e = param1.e * _loc2_ + param1.f * _loc5_ + param1.g * _loc8_;
         this.f = param1.e * _loc3_ + param1.f * _loc6_ + param1.g * _loc9_;
         this.g = param1.e * _loc4_ + param1.f * _loc7_ + param1.g * _loc10_;
         this.i = param1.i * _loc2_ + param1.j * _loc5_ + param1.k * _loc8_;
         this.j = param1.i * _loc3_ + param1.j * _loc6_ + param1.k * _loc9_;
         this.k = param1.i * _loc4_ + param1.j * _loc7_ + param1.k * _loc10_;
         return this;
      }
      
      public function prepend(param1:alternativa.math.Matrix3) : alternativa.math.Matrix3
      {
         var _loc2_:Number = this.a;
         var _loc3_:Number = this.b;
         var _loc4_:Number = this.c;
         var _loc5_:Number = this.e;
         var _loc6_:Number = this.f;
         var _loc7_:Number = this.g;
         var _loc8_:Number = this.i;
         var _loc9_:Number = this.j;
         var _loc10_:Number = this.k;
         this.a = _loc2_ * param1.a + _loc3_ * param1.e + _loc4_ * param1.i;
         this.b = _loc2_ * param1.b + _loc3_ * param1.f + _loc4_ * param1.j;
         this.c = _loc2_ * param1.c + _loc3_ * param1.g + _loc4_ * param1.k;
         this.e = _loc5_ * param1.a + _loc6_ * param1.e + _loc7_ * param1.i;
         this.f = _loc5_ * param1.b + _loc6_ * param1.f + _loc7_ * param1.j;
         this.g = _loc5_ * param1.c + _loc6_ * param1.g + _loc7_ * param1.k;
         this.i = _loc8_ * param1.a + _loc9_ * param1.e + _loc10_ * param1.i;
         this.j = _loc8_ * param1.b + _loc9_ * param1.f + _loc10_ * param1.j;
         this.k = _loc8_ * param1.c + _loc9_ * param1.g + _loc10_ * param1.k;
         return this;
      }
      
      public function prependTransposed(param1:alternativa.math.Matrix3) : alternativa.math.Matrix3
      {
         var _loc2_:Number = this.a;
         var _loc3_:Number = this.b;
         var _loc4_:Number = this.c;
         var _loc5_:Number = this.e;
         var _loc6_:Number = this.f;
         var _loc7_:Number = this.g;
         var _loc8_:Number = this.i;
         var _loc9_:Number = this.j;
         var _loc10_:Number = this.k;
         this.a = _loc2_ * param1.a + _loc3_ * param1.b + _loc4_ * param1.c;
         this.b = _loc2_ * param1.e + _loc3_ * param1.f + _loc4_ * param1.g;
         this.c = _loc2_ * param1.i + _loc3_ * param1.j + _loc4_ * param1.k;
         this.e = _loc5_ * param1.a + _loc6_ * param1.b + _loc7_ * param1.c;
         this.f = _loc5_ * param1.e + _loc6_ * param1.f + _loc7_ * param1.g;
         this.g = _loc5_ * param1.i + _loc6_ * param1.j + _loc7_ * param1.k;
         this.i = _loc8_ * param1.a + _loc9_ * param1.b + _loc10_ * param1.c;
         this.j = _loc8_ * param1.e + _loc9_ * param1.f + _loc10_ * param1.g;
         this.k = _loc8_ * param1.i + _loc9_ * param1.j + _loc10_ * param1.k;
         return this;
      }
      
      public function add(param1:alternativa.math.Matrix3) : alternativa.math.Matrix3
      {
         this.a = this.a + param1.a;
         this.b = this.b + param1.b;
         this.c = this.c + param1.c;
         this.e = this.e + param1.e;
         this.f = this.f + param1.f;
         this.g = this.g + param1.g;
         this.i = this.i + param1.i;
         this.j = this.j + param1.j;
         this.k = this.k + param1.k;
         return this;
      }
      
      public function subtract(param1:alternativa.math.Matrix3) : alternativa.math.Matrix3
      {
         this.a = this.a - param1.a;
         this.b = this.b - param1.b;
         this.c = this.c - param1.c;
         this.e = this.e - param1.e;
         this.f = this.f - param1.f;
         this.g = this.g - param1.g;
         this.i = this.i - param1.i;
         this.j = this.j - param1.j;
         this.k = this.k - param1.k;
         return this;
      }
      
      public function transpose() : alternativa.math.Matrix3
      {
         var _loc1_:Number = this.b;
         this.b = this.e;
         this.e = _loc1_;
         _loc1_ = this.c;
         this.c = this.i;
         this.i = _loc1_;
         _loc1_ = this.g;
         this.g = this.j;
         this.j = _loc1_;
         return this;
      }
      
      public function transformVector(param1:Vector3, param2:Vector3) : void
      {
         param2.x = this.a * param1.x + this.b * param1.y + this.c * param1.z;
         param2.y = this.e * param1.x + this.f * param1.y + this.g * param1.z;
         param2.z = this.i * param1.x + this.j * param1.y + this.k * param1.z;
      }
      
      public function transformVectorInverse(param1:Vector3, param2:Vector3) : void
      {
         param2.x = this.a * param1.x + this.e * param1.y + this.i * param1.z;
         param2.y = this.b * param1.x + this.f * param1.y + this.j * param1.z;
         param2.z = this.c * param1.x + this.g * param1.y + this.k * param1.z;
      }
      
      public function transformVector3To3D(param1:Vector3, param2:Vector3D) : void
      {
         param2.x = this.a * param1.x + this.b * param1.y + this.c * param1.z;
         param2.y = this.e * param1.x + this.f * param1.y + this.g * param1.z;
         param2.z = this.i * param1.x + this.j * param1.y + this.k * param1.z;
      }
      
      public function createSkewSymmetric(param1:Vector3) : alternativa.math.Matrix3
      {
         this.a = this.f = this.k = 0;
         this.b = -param1.z;
         this.c = param1.y;
         this.e = param1.z;
         this.g = -param1.x;
         this.i = -param1.y;
         this.j = param1.x;
         return this;
      }
      
      public function copy(param1:alternativa.math.Matrix3) : alternativa.math.Matrix3
      {
         this.a = param1.a;
         this.b = param1.b;
         this.c = param1.c;
         this.e = param1.e;
         this.f = param1.f;
         this.g = param1.g;
         this.i = param1.i;
         this.j = param1.j;
         this.k = param1.k;
         return this;
      }
      
      public function setRotationMatrix(param1:Number, param2:Number, param3:Number) : alternativa.math.Matrix3
      {
         var _loc4_:Number = Math.cos(param1);
         var _loc5_:Number = Math.sin(param1);
         var _loc6_:Number = Math.cos(param2);
         var _loc7_:Number = Math.sin(param2);
         var _loc8_:Number = Math.cos(param3);
         var _loc9_:Number = Math.sin(param3);
         var _loc10_:Number = _loc8_ * _loc7_;
         var _loc11_:Number = _loc9_ * _loc7_;
         this.a = _loc8_ * _loc6_;
         this.b = _loc10_ * _loc5_ - _loc9_ * _loc4_;
         this.c = _loc10_ * _loc4_ + _loc9_ * _loc5_;
         this.e = _loc9_ * _loc6_;
         this.f = _loc11_ * _loc5_ + _loc8_ * _loc4_;
         this.g = _loc11_ * _loc4_ - _loc8_ * _loc5_;
         this.i = -_loc7_;
         this.j = _loc6_ * _loc5_;
         this.k = _loc6_ * _loc4_;
         return this;
      }
      
      public function fromAxisAngle(param1:Vector3, param2:Number) : void
      {
         var _loc3_:Number = Math.cos(param2);
         var _loc4_:Number = Math.sin(param2);
         var _loc5_:Number = 1 - _loc3_;
         var _loc6_:Number = param1.x;
         var _loc7_:Number = param1.y;
         var _loc8_:Number = param1.z;
         this.a = _loc5_ * _loc6_ * _loc6_ + _loc3_;
         this.b = _loc5_ * _loc6_ * _loc7_ - _loc8_ * _loc4_;
         this.c = _loc5_ * _loc6_ * _loc8_ + _loc7_ * _loc4_;
         this.e = _loc5_ * _loc6_ * _loc7_ + _loc8_ * _loc4_;
         this.f = _loc5_ * _loc7_ * _loc7_ + _loc3_;
         this.g = _loc5_ * _loc7_ * _loc8_ - _loc6_ * _loc4_;
         this.i = _loc5_ * _loc6_ * _loc8_ - _loc7_ * _loc4_;
         this.j = _loc5_ * _loc7_ * _loc8_ + _loc6_ * _loc4_;
         this.k = _loc5_ * _loc8_ * _loc8_ + _loc3_;
      }
      
      public function clone() : alternativa.math.Matrix3
      {
         return new alternativa.math.Matrix3(this.a,this.b,this.c,this.e,this.f,this.g,this.i,this.j,this.k);
      }
      
      public function toString() : String
      {
         return "[Matrix3 (" + this.a + ", " + this.b + ", " + this.c + "), (" + this.e + ", " + this.f + ", " + this.g + "), (" + this.i + ", " + this.j + ", " + this.k + ")]";
      }
      
      public function getEulerAngles(param1:Vector3) : void
      {
         if(-1 < this.i && this.i < 1)
         {
            param1.x = Math.atan2(this.j,this.k);
            param1.y = -Math.asin(this.i);
            param1.z = Math.atan2(this.e,this.a);
         }
         else
         {
            param1.x = 0;
            param1.y = this.i <= -1?Number(Math.PI):Number(-Math.PI);
            param1.y = param1.y * 0.5;
            param1.z = Math.atan2(-this.b,this.f);
         }
      }
   }
}
