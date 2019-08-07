package alternativa.tanks.resources
{
   import alternativa.engine3d.objects.Sprite3D;
   import alternativa.engine3d.core.Object3D;
   import flash.display.BitmapData;
   import alternativa.engine3d.materials.TextureMaterial;
   
   public class PropSprite extends Prop
   {
       
      public var sprite:Sprite3D;
      
      public function PropSprite(param1:BitmapData)
      {
         super("PropSprite");
         var _loc2_:TextureMaterial = new TextureMaterial(param1);
         this.sprite = new Sprite3D(param1.width,param1.height,_loc2_);
      }
      
      override public function getProp(param1:String) : Object3D
      {
         return this.sprite.clone() as Sprite3D;
      }
   }
}
