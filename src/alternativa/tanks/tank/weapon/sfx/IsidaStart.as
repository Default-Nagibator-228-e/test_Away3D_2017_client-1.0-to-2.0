package alternativa.tanks.tank.weapon.sfx
{
   import alternativa.tanks.IGraphicEffect;
   import alternativa.engine3d.objects.AnimSprite;
   import alternativa.tanks.tank.weapon.Weapon;
   import flash.geom.Point;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.engine3d.core.Object3DContainer;
   import alternativa.tanks.Game;
   
   public class IsidaStart implements IGraphicEffect
   {
       
      private var sprite:AnimSprite;
      
      private var currFrame:Number = 0;
      
      private var weapon:Weapon;
      
      private var animSpeed:Number;
      
      private var numFrames:int;
      
      private var killed:Boolean = false;
      
      public function IsidaStart(param1:Weapon, param2:Vector.<Material>)
      {
         super();
         this.weapon = param1;
         this.numFrames = param2.length;
         var _loc3_:Point = this.getWH(param2[0]);
         this.sprite = new AnimSprite(_loc3_.x,_loc3_.y,param2);
         this.updatePos();
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
      
      private function updatePos() : void
      {
         this.weapon.calcTurretParams(0);
         this.sprite.x = this.weapon.barrelOrigin.x;
         this.sprite.y = this.weapon.barrelOrigin.y;
         this.sprite.z = this.weapon.barrelOrigin.z;
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
            this.updatePos();
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
