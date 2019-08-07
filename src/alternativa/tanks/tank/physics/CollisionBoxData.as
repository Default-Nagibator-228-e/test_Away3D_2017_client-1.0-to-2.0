package alternativa.tanks.tank.physics
{
   import alternativa.math.Vector3;
   import alternativa.math.Matrix4;
   
   public class CollisionBoxData
   {
       
      public var hs:Vector3;
      
      public var matrix:Matrix4;
      
      public var excludedFaces:int;
      
      public function CollisionBoxData(param1:Vector3, param2:Matrix4)
      {
         super();
         this.hs = param1;
         this.matrix = param2;
      }
   }
}
