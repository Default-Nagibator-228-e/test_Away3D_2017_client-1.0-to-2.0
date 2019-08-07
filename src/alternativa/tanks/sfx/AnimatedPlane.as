package alternativa.tanks.sfx
{
	import away3d.animators.VertexAnimator;
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
   
   public class AnimatedPlane extends Mesh
   {
       
      //private var a:Vertex;
      
      //private var b:Vertex;
      
      //private var c:Vertex;
      
      //private var d:VertexAnimator;
      
      private var numFrames:int;
      
      private var framesPerTimeUnit:Number = 0;
      
      private var materials:Vector.<TextureMaterial>;
      
      public function AnimatedPlane(param1:Number)
      {
         super(new PlaneGeometry(param1, param1), null);
		 castsShadows = true;
      }
      
      public function init(param1:TextureAnimation, param2:Number) : void
      {
         this.materials = param1.material;
         this.setFrame(0);
         this.numFrames = this.materials.length;
         this.framesPerTimeUnit = param2;
      }
      
      public function setTime(param1:Number) : void
      {
         var _loc2_:int = param1 * this.framesPerTimeUnit;
         if(_loc2_ >= this.numFrames)
         {
            _loc2_--;
         }
         this.setFrame(_loc2_);
      }
      
      public function clear() : void
      {
         material = null;
         this.numFrames = 0;
      }
      
      public function getOneLoopTime() : Number
      {
         return this.numFrames / this.framesPerTimeUnit;
      }
      
      private function setFrame(param1:int) : void
      {
		 material = this.materials[param1];
      }
   }
}
