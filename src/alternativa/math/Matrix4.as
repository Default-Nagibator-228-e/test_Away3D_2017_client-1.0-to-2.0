package alternativa.math
{
   public class Matrix4
   {
      
      public static const IDENTITY:alternativa.math.Matrix4 = new alternativa.math.Matrix4();
       
      public var a:Number;
      
      public var b:Number;
      
      public var c:Number;
      
      public var d:Number;
      
      public var e:Number;
      
      public var f:Number;
      
      public var g:Number;
      
      public var h:Number;
      
      public var i:Number;
      
      public var j:Number;
      
      public var k:Number;
      
      public var l:Number;
      
      public function Matrix4(param1:Number = 1, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 1, param7:Number = 0, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:Number = 1, param12:Number = 0)
      {
         super();
         this.a = param1;
         this.b = param2;
         this.c = param3;
         this.d = param4;
         this.e = param5;
         this.f = param6;
         this.g = param7;
         this.h = param8;
         this.i = param9;
         this.j = param10;
         this.k = param11;
         this.l = param12;
      }
      
      public function toIdentity() : alternativa.math.Matrix4
      {
         this.a = this.f = this.k = 1;
         this.b = this.c = this.e = this.g = this.i = this.j = this.d = this.h = this.l = 0;
         return this;
      }
      
      public function invert() : alternativa.math.Matrix4
      {
         var _loc1_:Number = this.a;
         var _loc2_:Number = this.b;
         var _loc3_:Number = this.c;
         var _loc4_:Number = this.d;
         var _loc5_:Number = this.e;
         var _loc6_:Number = this.f;
         var _loc7_:Number = this.g;
         var _loc8_:Number = this.h;
         var _loc9_:Number = this.i;
         var _loc10_:Number = this.j;
         var _loc11_:Number = this.k;
         var _loc12_:Number = this.l;
         var _loc13_:Number = -_loc3_ * _loc6_ * _loc9_ + _loc2_ * _loc7_ * _loc9_ + _loc3_ * _loc5_ * _loc10_ - _loc1_ * _loc7_ * _loc10_ - _loc2_ * _loc5_ * _loc11_ + _loc1_ * _loc6_ * _loc11_;
         this.a = (-_loc7_ * _loc10_ + _loc6_ * _loc11_) / _loc13_;
         this.b = (_loc3_ * _loc10_ - _loc2_ * _loc11_) / _loc13_;
         this.c = (-_loc3_ * _loc6_ + _loc2_ * _loc7_) / _loc13_;
         this.d = (_loc4_ * _loc7_ * _loc10_ - _loc3_ * _loc8_ * _loc10_ - _loc4_ * _loc6_ * _loc11_ + _loc2_ * _loc8_ * _loc11_ + _loc3_ * _loc6_ * _loc12_ - _loc2_ * _loc7_ * _loc12_) / _loc13_;
         this.e = (_loc7_ * _loc9_ - _loc5_ * _loc11_) / _loc13_;
         this.f = (-_loc3_ * _loc9_ + _loc1_ * _loc11_) / _loc13_;
         this.g = (_loc3_ * _loc5_ - _loc1_ * _loc7_) / _loc13_;
         this.h = (_loc3_ * _loc8_ * _loc9_ - _loc4_ * _loc7_ * _loc9_ + _loc4_ * _loc5_ * _loc11_ - _loc1_ * _loc8_ * _loc11_ - _loc3_ * _loc5_ * _loc12_ + _loc1_ * _loc7_ * _loc12_) / _loc13_;
         this.i = (-_loc6_ * _loc9_ + _loc5_ * _loc10_) / _loc13_;
         this.j = (_loc2_ * _loc9_ - _loc1_ * _loc10_) / _loc13_;
         this.k = (-_loc2_ * _loc5_ + _loc1_ * _loc6_) / _loc13_;
         this.l = (_loc4_ * _loc6_ * _loc9_ - _loc2_ * _loc8_ * _loc9_ - _loc4_ * _loc5_ * _loc10_ + _loc1_ * _loc8_ * _loc10_ + _loc2_ * _loc5_ * _loc12_ - _loc1_ * _loc6_ * _loc12_) / _loc13_;
         return this;
      }
      
      public function append(param1:alternativa.math.Matrix4) : alternativa.math.Matrix4
      {
         var _loc2_:Number = this.a;
         var _loc3_:Number = this.b;
         var _loc4_:Number = this.c;
         var _loc5_:Number = this.d;
         var _loc6_:Number = this.e;
         var _loc7_:Number = this.f;
         var _loc8_:Number = this.g;
         var _loc9_:Number = this.h;
         var _loc10_:Number = this.i;
         var _loc11_:Number = this.j;
         var _loc12_:Number = this.k;
         var _loc13_:Number = this.l;
         this.a = param1.a * _loc2_ + param1.b * _loc6_ + param1.c * _loc10_;
         this.b = param1.a * _loc3_ + param1.b * _loc7_ + param1.c * _loc11_;
         this.c = param1.a * _loc4_ + param1.b * _loc8_ + param1.c * _loc12_;
         this.d = param1.a * _loc5_ + param1.b * _loc9_ + param1.c * _loc13_ + param1.d;
         this.e = param1.e * _loc2_ + param1.f * _loc6_ + param1.g * _loc10_;
         this.f = param1.e * _loc3_ + param1.f * _loc7_ + param1.g * _loc11_;
         this.g = param1.e * _loc4_ + param1.f * _loc8_ + param1.g * _loc12_;
         this.h = param1.e * _loc5_ + param1.f * _loc9_ + param1.g * _loc13_ + param1.h;
         this.i = param1.i * _loc2_ + param1.j * _loc6_ + param1.k * _loc10_;
         this.j = param1.i * _loc3_ + param1.j * _loc7_ + param1.k * _loc11_;
         this.k = param1.i * _loc4_ + param1.j * _loc8_ + param1.k * _loc12_;
         this.l = param1.i * _loc5_ + param1.j * _loc9_ + param1.k * _loc13_ + param1.l;
         return this;
      }
      
      public function prepend(param1:alternativa.math.Matrix4) : alternativa.math.Matrix4
      {
         var _loc2_:Number = this.a;
         var _loc3_:Number = this.b;
         var _loc4_:Number = this.c;
         var _loc5_:Number = this.d;
         var _loc6_:Number = this.e;
         var _loc7_:Number = this.f;
         var _loc8_:Number = this.g;
         var _loc9_:Number = this.h;
         var _loc10_:Number = this.i;
         var _loc11_:Number = this.j;
         var _loc12_:Number = this.k;
         var _loc13_:Number = this.l;
         this.a = _loc2_ * param1.a + _loc3_ * param1.e + _loc4_ * param1.i;
         this.b = _loc2_ * param1.b + _loc3_ * param1.f + _loc4_ * param1.j;
         this.c = _loc2_ * param1.c + _loc3_ * param1.g + _loc4_ * param1.k;
         this.d = _loc2_ * param1.d + _loc3_ * param1.h + _loc4_ * param1.l + _loc5_;
         this.e = _loc6_ * param1.a + _loc7_ * param1.e + _loc8_ * param1.i;
         this.f = _loc6_ * param1.b + _loc7_ * param1.f + _loc8_ * param1.j;
         this.g = _loc6_ * param1.c + _loc7_ * param1.g + _loc8_ * param1.k;
         this.h = _loc6_ * param1.d + _loc7_ * param1.h + _loc8_ * param1.l + _loc9_;
         this.i = _loc10_ * param1.a + _loc11_ * param1.e + _loc12_ * param1.i;
         this.j = _loc10_ * param1.b + _loc11_ * param1.f + _loc12_ * param1.j;
         this.k = _loc10_ * param1.c + _loc11_ * param1.g + _loc12_ * param1.k;
         this.l = _loc10_ * param1.d + _loc11_ * param1.h + _loc12_ * param1.l + _loc13_;
         return this;
      }
      
      public function add(param1:alternativa.math.Matrix4) : alternativa.math.Matrix4
      {
         this.a = this.a + param1.a;
         this.b = this.b + param1.b;
         this.c = this.c + param1.c;
         this.d = this.d + param1.d;
         this.e = this.e + param1.e;
         this.f = this.f + param1.f;
         this.g = this.g + param1.g;
         this.h = this.h + param1.h;
         this.i = this.i + param1.i;
         this.j = this.j + param1.j;
         this.k = this.k + param1.k;
         this.l = this.l + param1.l;
         return this;
      }
      
      public function subtract(param1:alternativa.math.Matrix4) : alternativa.math.Matrix4
      {
         this.a = this.a - param1.a;
         this.b = this.b - param1.b;
         this.c = this.c - param1.c;
         this.d = this.d - param1.d;
         this.e = this.e - param1.e;
         this.f = this.f - param1.f;
         this.g = this.g - param1.g;
         this.h = this.h - param1.h;
         this.i = this.i - param1.i;
         this.j = this.j - param1.j;
         this.k = this.k - param1.k;
         this.l = this.l - param1.l;
         return this;
      }
      
      public function transformVector(param1:Vector3, param2:Vector3) : void
      {
         param2.x = this.a * param1.x + this.b * param1.y + this.c * param1.z + this.d;
         param2.y = this.e * param1.x + this.f * param1.y + this.g * param1.z + this.h;
         param2.z = this.i * param1.x + this.j * param1.y + this.k * param1.z + this.l;
      }
      
      public function transformVectorInverse(param1:Vector3, param2:Vector3) : void
      {
         var _loc3_:Number = param1.x - this.d;
         var _loc4_:Number = param1.y - this.h;
         var _loc5_:Number = param1.z - this.l;
         param2.x = this.a * _loc3_ + this.e * _loc4_ + this.i * _loc5_;
         param2.y = this.b * _loc3_ + this.f * _loc4_ + this.j * _loc5_;
         param2.z = this.c * _loc3_ + this.g * _loc4_ + this.k * _loc5_;
      }
      
      public function transformVectors(param1:Vector.<Vector3>, param2:Vector.<Vector3>) : void
      {
         var _loc4_:Vector3 = null;
         var _loc5_:Vector3 = null;
         var _loc3_:int = param1.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = param1[_loc6_];
            _loc5_ = param2[_loc6_];
            _loc5_.x = this.a * _loc4_.x + this.b * _loc4_.y + this.c * _loc4_.z + this.d;
            _loc5_.y = this.e * _loc4_.x + this.f * _loc4_.y + this.g * _loc4_.z + this.h;
            _loc5_.z = this.i * _loc4_.x + this.j * _loc4_.y + this.k * _loc4_.z + this.l;
            _loc6_++;
         }
      }
      
      public function transformVectorsN(param1:Vector.<Vector3>, param2:Vector.<Vector3>, param3:int) : void
      {
         var _loc4_:Vector3 = null;
         var _loc5_:Vector3 = null;
         var _loc6_:int = 0;
         while(_loc6_ < param3)
         {
            _loc4_ = param1[_loc6_];
            _loc5_ = param2[_loc6_];
            _loc5_.x = this.a * _loc4_.x + this.b * _loc4_.y + this.c * _loc4_.z + this.d;
            _loc5_.y = this.e * _loc4_.x + this.f * _loc4_.y + this.g * _loc4_.z + this.h;
            _loc5_.z = this.i * _loc4_.x + this.j * _loc4_.y + this.k * _loc4_.z + this.l;
            _loc6_++;
         }
      }
      
      public function transformVectorsInverse(param1:Vector.<Vector3>, param2:Vector.<Vector3>) : void
      {
         var _loc4_:Vector3 = null;
         var _loc5_:Vector3 = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc3_:int = param1.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = param1[_loc6_];
            _loc5_ = param2[_loc6_];
            _loc7_ = _loc4_.x - this.d;
            _loc8_ = _loc4_.y - this.h;
            _loc9_ = _loc4_.z - this.l;
            _loc5_.x = this.a * _loc7_ + this.e * _loc8_ + this.i * _loc9_;
            _loc5_.y = this.b * _loc7_ + this.f * _loc8_ + this.j * _loc9_;
            _loc5_.z = this.c * _loc7_ + this.g * _loc8_ + this.k * _loc9_;
            _loc6_++;
         }
      }
      
      public function transformVectorsInverseN(param1:Vector.<Vector3>, param2:Vector.<Vector3>, param3:int) : void
      {
         var _loc4_:Vector3 = null;
         var _loc5_:Vector3 = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc6_:int = 0;
         while(_loc6_ < param3)
         {
            _loc4_ = param1[_loc6_];
            _loc5_ = param2[_loc6_];
            _loc7_ = _loc4_.x - this.d;
            _loc8_ = _loc4_.y - this.h;
            _loc9_ = _loc4_.z - this.l;
            _loc5_.x = this.a * _loc7_ + this.e * _loc8_ + this.i * _loc9_;
            _loc5_.y = this.b * _loc7_ + this.f * _loc8_ + this.j * _loc9_;
            _loc5_.z = this.c * _loc7_ + this.g * _loc8_ + this.k * _loc9_;
            _loc6_++;
         }
      }
      
      public function getAxis(param1:int, param2:Vector3) : void
      {
         switch(param1)
         {
            case 0:
               param2.x = this.a;
               param2.y = this.e;
               param2.z = this.i;
               return;
            case 1:
               param2.x = this.b;
               param2.y = this.f;
               param2.z = this.j;
               return;
            case 2:
               param2.x = this.c;
               param2.y = this.g;
               param2.z = this.k;
               return;
            case 3:
               param2.x = this.d;
               param2.y = this.h;
               param2.z = this.l;
               return;
            default:
               return;
         }
      }
      
      public function deltaTransformVector(param1:Vector3, param2:Vector3) : void
      {
         param2.x = this.a * param1.x + this.b * param1.y + this.c * param1.z + this.d;
         param2.y = this.e * param1.x + this.f * param1.y + this.g * param1.z + this.h;
         param2.z = this.i * param1.x + this.j * param1.y + this.k * param1.z + this.l;
      }
      
      public function deltaTransformVectorInverse(param1:Vector3, param2:Vector3) : void
      {
         param2.x = this.a * param1.x + this.e * param1.y + this.i * param1.z;
         param2.y = this.b * param1.x + this.f * param1.y + this.j * param1.z;
         param2.z = this.c * param1.x + this.g * param1.y + this.k * param1.z;
      }
      
      public function copy(param1:alternativa.math.Matrix4) : alternativa.math.Matrix4
      {
         this.a = param1.a;
         this.b = param1.b;
         this.c = param1.c;
         this.d = param1.d;
         this.e = param1.e;
         this.f = param1.f;
         this.g = param1.g;
         this.h = param1.h;
         this.i = param1.i;
         this.j = param1.j;
         this.k = param1.k;
         this.l = param1.l;
         return this;
      }
      
      public function setFromMatrix3(param1:Matrix3, param2:Vector3) : alternativa.math.Matrix4
      {
         this.a = param1.a;
         this.b = param1.b;
         this.c = param1.c;
         this.d = param2.x;
         this.e = param1.e;
         this.f = param1.f;
         this.g = param1.g;
         this.h = param2.y;
         this.i = param1.i;
         this.j = param1.j;
         this.k = param1.k;
         this.l = param2.z;
         return this;
      }
      
      public function setOrientationFromMatrix3(param1:Matrix3) : alternativa.math.Matrix4
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
      
      public function setRotationMatrix(param1:Number, param2:Number, param3:Number) : alternativa.math.Matrix4
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
      
      public function setMatrix(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : alternativa.math.Matrix4
      {
         var _loc7_:Number = Math.cos(param4);
         var _loc8_:Number = Math.sin(param4);
         var _loc9_:Number = Math.cos(param5);
         var _loc10_:Number = Math.sin(param5);
         var _loc11_:Number = Math.cos(param6);
         var _loc12_:Number = Math.sin(param6);
         var _loc13_:Number = _loc11_ * _loc10_;
         var _loc14_:Number = _loc12_ * _loc10_;
         this.a = _loc11_ * _loc9_;
         this.b = _loc13_ * _loc8_ - _loc12_ * _loc7_;
         this.c = _loc13_ * _loc7_ + _loc12_ * _loc8_;
         this.d = param1;
         this.e = _loc12_ * _loc9_;
         this.f = _loc14_ * _loc8_ + _loc11_ * _loc7_;
         this.g = _loc14_ * _loc7_ - _loc11_ * _loc8_;
         this.h = param2;
         this.i = -_loc10_;
         this.j = _loc9_ * _loc8_;
         this.k = _loc9_ * _loc7_;
         this.l = param3;
         return this;
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
      
      public function setPosition(param1:Vector3) : void
      {
         this.d = param1.x;
         this.h = param1.y;
         this.l = param1.z;
      }
      
      public function clone() : alternativa.math.Matrix4
      {
         return new alternativa.math.Matrix4(this.a,this.b,this.c,this.d,this.e,this.f,this.g,this.h,this.i,this.j,this.k,this.l);
      }
      
      public function toString() : String
      {
         return "[Matrix4 [" + this.a.toFixed(3) + " " + this.b.toFixed(3) + " " + this.c.toFixed(3) + " " + this.d.toFixed(3) + "] [" + this.e.toFixed(3) + " " + this.f.toFixed(3) + " " + this.g.toFixed(3) + " " + this.h.toFixed(3) + "] [" + this.i.toFixed(3) + " " + this.j.toFixed(3) + " " + this.k.toFixed(3) + " " + this.l.toFixed(3) + "]]";
      }
   }
}
