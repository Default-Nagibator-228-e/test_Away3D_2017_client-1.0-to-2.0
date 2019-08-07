package alternativa.tanks
{
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
   
   public interface IGraphicEffect
   {
       
      function addToContainer(param1:ObjectContainer3D, param2:Game) : void;
      
      function play(param1:int, param2:Number, param3:Camera3D) : Boolean;
      
      function destroy() : void;
      
      function kill() : void;
   }
}
