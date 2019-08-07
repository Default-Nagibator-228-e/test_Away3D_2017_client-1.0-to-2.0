package alternativa.tanks.tank.weapon.sfx
{
   import alternativa.tanks.IGraphicEffect;
   import alternativa.tanks.sfx.AnimSprite;
   import away3d.cameras.Camera3D;
   import away3d.containers.ObjectContainer3D;
   import flash.geom.Vector3D;
   import alternativa.tanks.Game;
   
   public class PlasmaShotEffect implements IGraphicEffect
   {
       
      private var sprite:AnimSprite;
      
      private var currFrame:Number = 0;
      
      private var comps:Vector.<Vector3D>;
      
      private var timeToLive:int;
      
      private var pos:Vector3D;
      
      private var camera:Camera3D;
      
      private var animSpeed:Number;
      
      private var numFrames:int;
      
      public function PlasmaShotEffect(param1:Vector3D, param2:Camera3D, param3:AnimSprite, param4:int)
      {
         super();
         this.timeToLive = param4;
         this.pos = param1.clone();
         this.camera = param2;
         this.timeToLive = param4;
         this.numFrames = param3.materials.length;
         this.animSpeed = this.numFrames / param4;
         this.sprite = param3.clone() as AnimSprite;
         this.sprite.x = param1.x;
         this.sprite.y = param1.y;
         this.sprite.z = param1.z;
      }
      
      public function play(param1:int, param2:Number, param3:Camera3D) : Boolean
      {
         if(this.timeToLive < 0)
         {
            return false;
         }
         this.timeToLive = this.timeToLive - param1;
         this.currFrame = this.currFrame + this.animSpeed * param1;
         if(this.currFrame >= this.numFrames)
         {
            this.currFrame = this.numFrames - 1;
         }
         this.sprite.frame = this.currFrame;
         return true;
      }
      
      public function destroy() : void
      {
         if(this.sprite.parent != null)
         {
            this.sprite.parent.removeChild(this.sprite);
         }
      }
      
      public function addToContainer(param1:ObjectContainer3D, param2:Game) : void
      {
         Main.instance.game.container.addChild(this.sprite);
      }
      
      public function kill() : void
      {
      }
   }
}
