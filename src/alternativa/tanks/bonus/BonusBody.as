package alternativa.tanks.bonus
{
   import alternativa.physics.rigid.SkinnedBody3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Matrix3;
   import alternativa.math.Vector3;
   import alternativa.physics.collision.primitives.CollisionBox;
   import alternativa.physics.PhysicsUtils;
   import alternativa.engine3d.core.MipMapping;
   import alternativa.engine3d.core.Sorting;
   
   public class BonusBody extends SkinnedBody3D
   {
      
      public static const BOX_MASS:Number = 20;
      
      public static const BOX_SIZE:Number = 75;
       
      private var mater:TextureMaterial;
      
      private var data:BitmapData;
      
      public function BonusBody(param1:BitmapData, param2:Mesh, param3:Bonus)
      {
         super(1 / BOX_MASS,Matrix3.IDENTITY);
         canFreeze = true;
         var _loc4_:Vector3 = new Vector3(BOX_SIZE,BOX_SIZE,BOX_SIZE);
         var _loc5_:CollisionBox = new CollisionBox(_loc4_,2);
         _loc5_.postCollisionPredicate = new BonusPredicate(param3);
         addCollisionPrimitive(_loc5_);
         skin = param2;
         PhysicsUtils.getBoxInvInertia(BOX_MASS,_loc4_,invInertia);
         this.data = param1;
         var _loc6_:Mesh = skin as Mesh;
         _loc6_.setMaterialToAllFaces(new TextureMaterial(param1,false,true,MipMapping.OBJECT_DISTANCE,2.5));
         _loc6_.calculateFacesNormals();
         _loc6_.calculateBounds();
         _loc6_.optimizeForDynamicBSP();
         _loc6_.sorting = Sorting.DYNAMIC_BSP;
      }
      
      public function set alpha(param1:Number) : void
      {
         skin.alpha = param1;
      }
      
      public function get alpha() : Number
      {
         return skin.alpha;
      }
      
      public function set colorTransform(param1:ColorTransform) : void
      {
         (skin as Mesh).colorTransform = param1;
      }
      
      override public function updateSkin(param1:Number) : void
      {
         super.updateSkin(param1);
      }
   }
}

import alternativa.physics.collision.ICollisionPredicate;
import alternativa.tanks.bonus.Bonus;
import alternativa.physics.collision.CollisionPrimitive;

class BonusPredicate implements ICollisionPredicate
{
    
   private var bonus:Bonus;
   
   function BonusPredicate(param1:Bonus)
   {
      super();
      this.bonus = param1;
   }
   
   public function considerCollision(param1:CollisionPrimitive) : Boolean
   {
      if(this.bonus.state == Bonus.STATE_FALLING)
      {
         this.bonus.state = Bonus.STATE_DROPPED;
      }
      return true;
   }
}
