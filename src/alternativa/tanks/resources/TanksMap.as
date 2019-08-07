package alternativa.tanks.resources
{
   import alternativa.engine3d.containers.BSPContainer;
   import alternativa.physics.collision.CollisionPrimitive;
   import flash.geom.Vector3D;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.core.Sorting;
   import alternativa.engine3d.core.Clipping;
   
   public class TanksMap extends BSPContainer
   {
       
      public var collisionPrimitives:Vector.<CollisionPrimitive>;
      
      public function TanksMap()
      {
         this.collisionPrimitives = new Vector.<CollisionPrimitive>();
         super();
      }
      
      public function addPrimitive(param1:CollisionPrimitive) : void
      {
         this.collisionPrimitives.push(param1);
      }
      
      public function removeAl() : void
      {
         while(true)
         {
            try
            {
               continue;
               return;
            }
            catch(e:Error)
            {
               return;
            }
            return;
         }
      }
      
      public function addProp(param1:String, param2:String, param3:String, param4:String, param5:Vector3D, param6:Vector3D) : void
      {
         if(Proplibs.libs[param1] == null)
         {
            throw new Error("Библиотека пропов \'\'" + param1 + "\'\' не найдена!");
         }
         if(Proplibs.libs[param1].groups[param2] == null)
         {
            throw new Error("Группа пропов \'\'" + param2 + "\'\' в библиотеке пропов \'\'" + param1 + "\'\' не найдена!");
         }
         if(Proplibs.libs[param1].groups[param2].props[param3] == null)
         {
            throw new Error("Проп \'\'" + param3 + "\'\' из группы пропов \'\'" + param2 + "\'\' в библиотеке пропов \'\'" + param1 + "\'\' не найдена!");
         }
         var _loc7_:Prop = Proplibs.libs[param1].groups[param2].props[param3];
         var _loc8_:Object3D = _loc7_.getProp(param4);
         _loc8_.x = param5.x;
         _loc8_.y = param5.y;
         _loc8_.z = param5.z;
         _loc8_.rotationX = param6.x;
         _loc8_.rotationY = param6.y;
         _loc8_.rotationZ = param6.z;
         if(_loc8_ is Mesh)
         {
            Mesh(_loc8_).sorting = Sorting.DYNAMIC_BSP;
            Mesh(_loc8_).optimizeForDynamicBSP();
            Mesh(_loc8_).clipping = Clipping.FACE_CLIPPING;
            Mesh(_loc8_).calculateBounds();
            Mesh(_loc8_).calculateFacesNormals();
         }
         addChild(_loc8_);
      }
   }
}
