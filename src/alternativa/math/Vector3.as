package alternativa.math
{
   import flash.geom.Vector3D;
   
   public class Vector3 extends Vector3D
   {
      
      public static const ZERO:alternativa.math.Vector3 = new alternativa.math.Vector3(0,0,0);
      
      public static const X_AXIS:alternativa.math.Vector3 = new alternativa.math.Vector3(1,0,0);
      
      public static const Y_AXIS:alternativa.math.Vector3 = new alternativa.math.Vector3(0,1,0);
      
      public static const Z_AXIS:alternativa.math.Vector3 = new alternativa.math.Vector3(0,0,1);
       
      public function Vector3(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.z = param3;
      }
      
      public function vLength() : Number
      {
         return Math.sqrt(x * x + y * y + z * z);
      }
      
      public function vLengthSqr() : Number
      {
         return x * x + y * y + z * z;
      }
      
      public function vSetLength(param1:Number) : alternativa.math.Vector3
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = x * x + y * y + z * z;
         if(_loc2_ == 0)
         {
            x = param1;
         }
         else
         {
            _loc3_ = param1 / Math.sqrt(x * x + y * y + z * z);
            x = x * _loc3_;
            y = y * _loc3_;
            z = z * _loc3_;
         }
         return this;
      }
      
      public function vNormalize() : alternativa.math.Vector3
      {
         var _loc1_:Number = x * x + y * y + z * z;
         if(_loc1_ == 0)
         {
            x = 1;
         }
         else
         {
            _loc1_ = Math.sqrt(_loc1_);
            x = x / _loc1_;
            y = y / _loc1_;
            z = z / _loc1_;
         }
         return this;
      }
      
      public function vAdd(param1:alternativa.math.Vector3) : alternativa.math.Vector3
      {
         x = x + param1.x;
         y = y + param1.y;
         z = z + param1.z;
         return this;
      }
      
      public function vAddScaled(param1:Number, param2:alternativa.math.Vector3) : alternativa.math.Vector3
      {
         x = x + param1 * param2.x;
         y = y + param1 * param2.y;
         z = z + param1 * param2.z;
         return this;
      }
      
      public function vSubtract(param1:alternativa.math.Vector3) : alternativa.math.Vector3
      {
         x = x - param1.x;
         y = y - param1.y;
         z = z - param1.z;
         return this;
      }
      
      public function vSum(param1:alternativa.math.Vector3, param2:alternativa.math.Vector3) : alternativa.math.Vector3
      {
         x = param1.x + param2.x;
         y = param1.y + param2.y;
         z = param1.z + param2.z;
         return this;
      }
      
      public function vDiff(param1:alternativa.math.Vector3, param2:alternativa.math.Vector3) : alternativa.math.Vector3
      {
         x = param1.x - param2.x;
         y = param1.y - param2.y;
         z = param1.z - param2.z;
         return this;
      }
      
      public function vScale(param1:Number) : alternativa.math.Vector3
      {
         x = x * param1;
         y = y * param1;
         z = z * param1;
         return this;
      }
      
      public function vReverse() : alternativa.math.Vector3
      {
         x = -x;
         y = -y;
         z = -z;
         return this;
      }
      
      public function vDot(param1:alternativa.math.Vector3) : Number
      {
         return x * param1.x + y * param1.y + z * param1.z;
      }
      
      public function vCross(param1:alternativa.math.Vector3) : alternativa.math.Vector3
      {
         var _loc2_:Number = y * param1.z - z * param1.y;
         var _loc3_:Number = z * param1.x - x * param1.z;
         var _loc4_:Number = x * param1.y - y * param1.x;
         x = _loc2_;
         y = _loc3_;
         z = _loc4_;
         return this;
      }
      
      public function vCross2(param1:alternativa.math.Vector3, param2:alternativa.math.Vector3) : alternativa.math.Vector3
      {
         x = param1.y * param2.z - param1.z * param2.y;
         y = param1.z * param2.x - param1.x * param2.z;
         z = param1.x * param2.y - param1.y * param2.x;
         return this;
      }
      
      public function vTransformBy3(param1:Matrix3) : alternativa.math.Vector3
      {
         var _loc2_:Number = x;
         var _loc3_:Number = y;
         var _loc4_:Number = z;
         x = param1.a * _loc2_ + param1.b * _loc3_ + param1.c * _loc4_;
         y = param1.e * _loc2_ + param1.f * _loc3_ + param1.g * _loc4_;
         z = param1.i * _loc2_ + param1.j * _loc3_ + param1.k * _loc4_;
         return this;
      }
      
      public function vTransformBy3Tr(param1:Matrix3) : alternativa.math.Vector3
      {
         var _loc2_:Number = x;
         var _loc3_:Number = y;
         var _loc4_:Number = z;
         x = param1.a * _loc2_ + param1.e * _loc3_ + param1.i * _loc4_;
         y = param1.b * _loc2_ + param1.f * _loc3_ + param1.j * _loc4_;
         z = param1.c * _loc2_ + param1.g * _loc3_ + param1.k * _loc4_;
         return this;
      }
      
      public function vTransformBy4(param1:Matrix4) : alternativa.math.Vector3
      {
         var _loc2_:Number = x;
         var _loc3_:Number = y;
         var _loc4_:Number = z;
         x = param1.a * _loc2_ + param1.b * _loc3_ + param1.c * _loc4_ + param1.d;
         y = param1.e * _loc2_ + param1.f * _loc3_ + param1.g * _loc4_ + param1.h;
         z = param1.i * _loc2_ + param1.j * _loc3_ + param1.k * _loc4_ + param1.l;
         return this;
      }
      
      public function vTransformInverseBy4(param1:Matrix4) : alternativa.math.Vector3
      {
         var _loc2_:Number = x - param1.d;
         var _loc3_:Number = y - param1.h;
         var _loc4_:Number = z - param1.l;
         x = param1.a * _loc2_ + param1.e * _loc3_ + param1.i * _loc4_;
         y = param1.b * _loc2_ + param1.f * _loc3_ + param1.j * _loc4_;
         z = param1.c * _loc2_ + param1.g * _loc3_ + param1.k * _loc4_;
         return this;
      }
      
      public function vDeltaTransformBy4(param1:Matrix4) : alternativa.math.Vector3
      {
         var _loc2_:Number = x;
         var _loc3_:Number = y;
         var _loc4_:Number = z;
         x = param1.a * _loc2_ + param1.b * _loc3_ + param1.c * _loc4_;
         y = param1.e * _loc2_ + param1.f * _loc3_ + param1.g * _loc4_;
         z = param1.i * _loc2_ + param1.j * _loc3_ + param1.k * _loc4_;
         return this;
      }
      
      public function vReset(param1:Number = 0, param2:Number = 0, param3:Number = 0) : alternativa.math.Vector3
      {
         this.x = param1;
         this.y = param2;
         this.z = param3;
         return this;
      }
      
      public function vCopy(param1:alternativa.math.Vector3) : alternativa.math.Vector3
      {
         x = param1.x;
         y = param1.y;
         z = param1.z;
         return this;
      }
      
      public function vClone() : alternativa.math.Vector3
      {
         return new alternativa.math.Vector3(x,y,z);
      }
      
      public function toVector3D(param1:Vector3D) : Vector3D
      {
         param1.x = x;
         param1.y = y;
         param1.z = z;
         return param1;
      }
      
      public function copyFromVector3D(param1:Vector3D) : alternativa.math.Vector3
      {
         x = param1.x;
         y = param1.y;
         z = param1.z;
         return this;
      }
      
      override public function toString() : String
      {
         return "Vector3(" + x + "," + y + ", " + z + ")";
      }
   }
}
