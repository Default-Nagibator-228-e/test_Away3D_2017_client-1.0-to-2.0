package alternativa.tanks.sfx
{
	import away3d.materials.TextureMaterial;
   
   public class AnimatedSprite3D extends AnimSprite
   {
       
      private var numFrames:int;
      
      public function AnimatedSprite3D(param1:Number, param2:Number, param3:Vector.<TextureMaterial> = null)
      {
         super(param1,param2,param3);
      }
      
      public function setAnimationData(param1:TextureAnimation) : void
      {
         materials = param1.material;
         this.numFrames = materials.length;
      }
      
      public function getNumFrames() : int
      {
         return this.numFrames;
      }
      
      public function clear() : void
      {
         this.numFrames = 0;
      }
      
      public function setFrameIndex(param1:int) : void
      {
         frame = param1 % this.numFrames;
      }
   }
}
