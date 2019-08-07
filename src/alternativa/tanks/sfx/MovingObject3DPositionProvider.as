package alternativa.tanks.sfx
{
   import alternativa.math.Vector3;
   import away3d.cameras.Camera3D;
   import away3d.containers.ObjectContainer3D;
   
   public class MovingObject3DPositionProvider implements Object3DPositionProvider
   {
       
      private var initialPosition:Vector3;
      
      private var velocity:Vector3;
      
      private var acceleration:Number;
      
      public function MovingObject3DPositionProvider()
      {
         super();
         this.initialPosition = new Vector3();
         this.velocity = new Vector3();
      }
      
      public function initPosition(param1:ObjectContainer3D) : void
      {
         param1.x = this.initialPosition.x;
         param1.y = this.initialPosition.y;
         param1.z = this.initialPosition.z;
      }
      
      public function init(param1:Vector3, param2:Vector3, param3:Number) : void
      {
         this.initialPosition.vCopy(param1);
         this.velocity.vCopy(param2);
         this.acceleration = param3;
      }
      
      public function updateObjectPosition(param1:ObjectContainer3D, param2:Camera3D, param3:int) : void
      {
         var _loc4_:Number = 0.001 * param3;
         param1.x = param1.x + this.velocity.x * _loc4_;
         param1.y = param1.y + this.velocity.y * _loc4_;
         param1.z = param1.z + this.velocity.z * _loc4_;
         var _loc5_:Number = this.velocity.vLength();
         _loc5_ = _loc5_ + this.acceleration * _loc4_;
         if(_loc5_ <= 0)
         {
            this.velocity.vReset();
         }
         else
         {
            this.velocity.vNormalize();
            this.velocity.vScale(_loc5_);
         }
      }
      
      public function destroy() : void
      {
      }
   }
}
