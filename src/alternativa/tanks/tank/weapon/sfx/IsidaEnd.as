package alternativa.tanks.tank.weapon.sfx
{
   import alternativa.tanks.IGraphicEffect;
   import alternativa.engine3d.objects.AnimSprite;
   import flash.geom.Point;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.math.Vector3;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Object3DContainer;
   import alternativa.tanks.Game;
   
   public class IsidaEnd implements IGraphicEffect
   {
       
      private var sprite:AnimSprite;
      
      private var currFrame:Number = 0;
      
      private var animSpeed:Number;
      
      private var numFrames:int;
      
      private var killed:Boolean = false;
      
      public function IsidaEnd(param1:Vector.<Material>)
      {
         super();
         this.numFrames = param1.length;
         var _loc2_:Point = this.getWH(param1[0]);
         this.sprite = new AnimSprite(_loc2_.x,_loc2_.y,param1);
         this.sprite.scaleX = 2;
         this.sprite.scaleY = 2;
      }
      
      private function getWH(param1:Material) : Point
      {
         var _loc2_:TextureMaterial = param1 as TextureMaterial;
         return new Point(_loc2_.texture.width,_loc2_.texture.height);
      }
      
      public function setMaterials(param1:Vector.<Material>) : void
      {
         if(this.sprite.materials == param1)
         {
            return;
         }
         var _loc2_:Point = this.getWH(param1[0]);
         this.sprite.width = _loc2_.x;
         this.sprite.height = _loc2_.y;
         this.sprite.materials = param1;
         this.sprite.frame = 0;
         this.currFrame = 0;
         this.numFrames = param1.length;
      }
      
      public function updatePos(param1:Vector3) : void
      {
         this.sprite.x = param1.x;
         this.sprite.y = param1.y;
         this.sprite.z = param1.z;
      }
      
      public function play(param1:int, param2:Number, param3:Camera3D) : Boolean
      {
         if(this.sprite.visible)
         {
            this.currFrame++;
            if(this.currFrame >= this.numFrames)
            {
               this.currFrame = 0;
            }
            this.sprite.frame = this.currFrame;
         }
         return !this.killed;
      }
      
      public function setVisible(param1:Boolean) : void
      {
         this.sprite.visible = param1;
      }
      
      public function destroy() : void
      {
         if(this.sprite.parent != null)
         {
            this.sprite.parent.removeChild(this.sprite);
         }
      }
      
      public function addToContainer(param1:Object3DContainer, param2:Game) : void
      {
         param1.addChild(this.sprite);
      }
      
      public function kill() : void
      {
         this.killed = true;
      }
   }
}
