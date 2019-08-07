package alternativa.tanks.sfx
{
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
   
   public interface Object3DPositionProvider
   {
       
      function initPosition(param1:ObjectContainer3D) : void;
      
      function updateObjectPosition(param1:ObjectContainer3D, param2:Camera3D, param3:int) : void;
      
      function destroy() : void;
   }
}
