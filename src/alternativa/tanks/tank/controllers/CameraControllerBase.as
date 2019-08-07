package alternativa.tanks.tank.controllers
{
   import alternativa.math.Vector3;
   import away3d.cameras.Camera3D;
   
   public class CameraControllerBase
   {
       
      public var camera:Camera3D;
      
      protected var pos:Vector3;
      
      protected var rotation:Vector3;
      
      public function CameraControllerBase()
      {
         this.pos = new Vector3();
         this.rotation = new Vector3();
         super();
      }
      
      protected function setPosition(param1:Vector3) : void
      {
         this.pos.vCopy(param1);
      }
      
      protected function setRotation(param1:Vector3) : void
      {
         this.rotation.vCopy(param1);
      }
      
      protected function moveBy(param1:Number, param2:Number, param3:Number) : void
      {
         this.pos.x = this.pos.x + param1;
         this.pos.y = this.pos.y + param2;
         this.pos.z = this.pos.z + param3;
      }
      
      protected function rotateBy(param1:Number, param2:Number, param3:Number) : void
      {
         this.rotation.x = this.rotation.x + param1;
         this.rotation.y = this.rotation.y + param2;
         this.rotation.z = this.rotation.z + param3;
      }
      
      protected function updateCameraTransform() : void
      {
         this.camera.x = this.pos.x;
         this.camera.y = this.pos.y;
         this.camera.z = this.pos.z;
         this.camera.rotationX = this.rotation.x;
         this.camera.rotationY = this.rotation.y;
         this.camera.rotationZ = this.rotation.z;
      }
      
      protected function initCameraComponents() : void
      {
         this.pos.vReset(this.camera.x,this.camera.y,this.camera.z);
         this.rotation.vReset(this.camera.rotationX,this.camera.rotationY,this.camera.rotationZ);
      }
   }
}
