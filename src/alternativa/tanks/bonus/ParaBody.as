package alternativa.tanks.bonus
{
   import alternativa.physics.rigid.DoubleSkinnedBody3D;
   import alternativa.math.Vector3;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.math.Matrix3;
   import alternativa.engine3d.core.Sorting;
   import alternativa.physics.PhysicsUtils;
   
   public class ParaBody extends DoubleSkinnedBody3D
   {
       
      private var _force:Vector3;
      
      private var para:Mesh;
      
      private var parai:Mesh;
      
      public function ParaBody(param1:Mesh, param2:Mesh)
      {
         this._force = new Vector3();
         super(1 / 10,Matrix3.IDENTITY);
         this.para = param1;
         this.parai = param2;
         param1.sorting = Sorting.DYNAMIC_BSP;
         param2.sorting = Sorting.DYNAMIC_BSP;
         param1.calculateBounds();
         param2.calculateBounds();
         param1.optimizeForDynamicBSP();
         param2.optimizeForDynamicBSP();
         skin = param1;
         skin2 = param2;
         PhysicsUtils.getCylinderInvInertia(10,180,10,invInertia);
      }
      
      public function set alpha(param1:Number) : void
      {
         skin.alpha = param1;
         skin2.alpha = param1;
      }
      
      public function get alpha() : Number
      {
         return skin.alpha;
      }
      
      override public function updateSkin(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc6_:Number = NaN;
         super.updateSkin(param1);
         var _loc2_:Number = state.velocity.x;
         _loc3_ = state.velocity.y;
         var _loc4_:Number = state.velocity.z;
         var _loc5_:Number = Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_ + _loc4_ * _loc4_);
         if(_loc5_ < 0.001)
         {
            return;
         }
         _loc2_ = _loc2_ / _loc5_;
         _loc3_ = _loc3_ / _loc5_;
         _loc4_ = _loc4_ / _loc5_;
         _loc6_ = 0.8 * _loc5_ * _loc5_;
         this._force.x = -_loc2_ * _loc6_;
         this._force.y = -_loc3_ * _loc6_;
         this._force.z = -_loc4_ * _loc6_;
         addForce(this._force);
      }
   }
}
