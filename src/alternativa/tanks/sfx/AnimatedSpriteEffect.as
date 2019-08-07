package alternativa.tanks.sfx
{
   import alternativa.tanks.IGraphicEffect;
   import away3d.cameras.Camera3D;
   import away3d.containers.ObjectContainer3D;
   import flash.geom.ColorTransform;
   import alternativa.tanks.Game;
   
   public class AnimatedSpriteEffect implements IGraphicEffect
   {
       
      private var sprite:alternativa.tanks.sfx.AnimatedSprite3D;
      
      private var currentFrame:Number;
      
      private var framesPerMs:Number;
      
      private var loop:Boolean;
      
      private var positionProvider:Object3DPositionProvider;
      
      public function AnimatedSpriteEffect()
      {
         super();
         this.sprite = new alternativa.tanks.sfx.AnimatedSprite3D(1,1);
      }
      
      public function init(param1:Number, param2:Number, param3:TextureAnimation, param4:Number, param5:Number, param6:Object3DPositionProvider, param7:Number = 0.5, param8:Number = 0.5, param9:ColorTransform = null) : void
      {
         this.initSprite(param1,param2,param4,param7,param8,param9,param3);
         param6.initPosition(this.sprite);
         this.framesPerMs = 0.001 * param5;
         this.positionProvider = param6;
         this.currentFrame = 0;
         this.loop = false;
		 //addToContainer(null,null);
      }
      
      public function initLooped(param1:Number, param2:Number, param3:TextureAnimation, param4:Number, param5:Number, param6:Object3DPositionProvider, param7:Number = 0.5, param8:Number = 0.5, param9:ColorTransform = null) : void
      {
         this.init(param1,param2,param3,param4,param5,param6,param7,param8,param9);
         this.loop = true;
      }
      
      public function addToContainer(param1:ObjectContainer3D, param2:Game) : void
      {
         Main.instance.game.container.addChild(this.sprite);
      }
      
      public function play(param1:int, param2:Number, param3:Camera3D) : Boolean
      {
         if(Boolean(this.loop) || this.currentFrame < this.sprite.getNumFrames())
         {
            this.sprite.setFrameIndex(this.currentFrame);
            this.currentFrame = this.currentFrame + param1 * this.framesPerMs;
            this.positionProvider.updateObjectPosition(this.sprite,param3,param1);
            return true;
         }
         return false;
      }
      
      public function destroy() : void
      {
         Main.instance.game.container.removeChild(this.sprite);
         this.sprite.clear();
         this.positionProvider.destroy();
         this.positionProvider = null;
      }
      
      public function kill() : void
      {
         this.loop = false;
         this.currentFrame = this.sprite.getNumFrames();
      }
      
      private function initSprite(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:ColorTransform, param7:TextureAnimation) : void
      {
         this.sprite.width = param1;
         this.sprite.height = param2;
         //this.sprite.rotation = param3;
         //this.sprite.originX = param4;
         //this.sprite.originY = param5;
         //this.sprite.colorTransform = param6;
         this.sprite.setAnimationData(param7);
      }
   }
}
