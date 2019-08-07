package alternativa.tanks.sfx
{
   import alternativa.tanks.IGraphicEffect;
   import alternativa.math.Vector3;
   import alternativa.tanks.Game;
   import away3d.cameras.Camera3D;
   import away3d.containers.ObjectContainer3D;
   
   public class AnimatedPlaneEffect implements IGraphicEffect
   {
      
      private static const BASE_SIZE:Number = 100;
       
      private var scaleSpeed:Number;
      
      private var scale:Number;
      
      private var baseScale:Number;
      
      private var plane:alternativa.tanks.sfx.AnimatedPlane;
      
      private var currentTime:int;
      
      private var maxTime:int;
      
      public function AnimatedPlaneEffect()
      {
         super();
         this.plane = new AnimatedPlane(BASE_SIZE);
      }
      
      public function init(param1:Number, param2:Vector3, param3:Vector3, param4:Number, param5:TextureAnimation, param6:Number) : void
      {
         this.plane.init(param5,0.001 * param4);
         this.maxTime = this.plane.getOneLoopTime();
         this.currentTime = 0;
         this.scaleSpeed = 0.001 * param6;
         this.baseScale = param1 / BASE_SIZE;
         this.scale = this.baseScale;
         this.plane.x = param2.x - BASE_SIZE * 0.5;
         this.plane.y = param2.y - BASE_SIZE * 0.5;
         this.plane.z = param2.z;
         this.plane.rotationX = param3.x;
         this.plane.rotationY = param3.y;
         this.plane.rotationZ = param3.z;
		 //addToContainer(null,null);
      }
      
      public function addToContainer(param1:ObjectContainer3D, param2:Game) : void
      {
         Main.instance.game.container.addChild(this.plane);
      }
      
      public function play(param1:int, param2:Number, param3:Camera3D) : Boolean
      {
         if(this.currentTime >= this.maxTime)
         {
            return false;
         }
         this.plane.setTime(this.currentTime);
         this.currentTime = this.currentTime + param1;
         this.plane.scaleX = this.scale;
         this.plane.scaleY = this.scale;
         this.scale = this.scale + this.baseScale * this.scaleSpeed * param1;
         return true;
      }
      
      public function destroy() : void
      {
         Main.instance.game.container.removeChild(this.plane);
         this.plane.clear();
      }
      
      public function kill() : void
      {
         this.currentTime = this.maxTime;
      }
   }
}
