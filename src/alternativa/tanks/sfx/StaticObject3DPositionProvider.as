package alternativa.tanks.sfx
{
   import alternativa.math.Vector3;
   import away3d.cameras.Camera3D;
   import away3d.containers.ObjectContainer3D;
   
   public class StaticObject3DPositionProvider implements Object3DPositionProvider
   {
      
      private static const toCamera:Vector3 = new Vector3();
       
      private var position:Vector3;
      
      private var offsetToCamera:Number;
      
      public function StaticObject3DPositionProvider()
      {
         super();
         this.position = new Vector3();
      }
      
      public function init(param1:Vector3, param2:Number) : void
      {
         this.position.vCopy(param1);
         this.offsetToCamera = param2;
      }
      
      public function setPosition(param1:Vector3) : void
      {
      }
      
      public function initPosition(param1:ObjectContainer3D) : void
      {
      }
      
      public function updateObjectPosition(param1:ObjectContainer3D, param2:Camera3D, param3:int) : void
      {
         toCamera.x = param2.x - this.position.x;
         toCamera.y = param2.y - this.position.y;
         toCamera.z = param2.z - this.position.z;
         toCamera.normalize();
         param1.x = this.position.x + this.offsetToCamera * toCamera.x;
         param1.y = this.position.y + this.offsetToCamera * toCamera.y;
         param1.z = this.position.z + this.offsetToCamera * toCamera.z;
      }
      
      public function destroy() : void
      {
      }
   }
}
