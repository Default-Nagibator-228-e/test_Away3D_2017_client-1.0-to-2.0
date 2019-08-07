package alternativa.tanks.sfx
{
	import away3d.materials.TextureMaterial;
   
   public class TextureAnimation
   {
	   
      public var material:Vector.<TextureMaterial>;
      
      public var fps:Number;
      
      public function TextureAnimation(param1:Vector.<TextureMaterial>, param2:Number)
      {
         super();
         this.material = param1;
         this.fps = param2;
		 //for (var fg:int = param1.length; fg > 0; fg--)
		 //{
			//this.material[fg].alphaBlending = false;
		 //}
      }
   }
}
