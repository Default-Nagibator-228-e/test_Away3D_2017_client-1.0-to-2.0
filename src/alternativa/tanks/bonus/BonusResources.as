package alternativa.tanks.bonus
{
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.loaders.Parser3DS;
   import flash.utils.ByteArray;
   import alternativa.engine3d.core.Object3D;
   
   public class BonusResources
   {
      
      [Embed(source = "data/box_med.3ds", mimeType = "application/octet-stream")] private static const boxdata:Class;
      
      [Embed(source = "data/parachute.3ds", mimeType = "application/octet-stream")] private static const parachute_data:Class;
      
      [Embed(source = "data/parachutei.3ds", mimeType = "application/octet-stream")] private static const parachutei_data:Class;
      
      public static var box:Mesh;
      
      public static var parachute:Mesh;
      
      public static var parachutei:Mesh;
       
      public function BonusResources()
      {
         super();
      }
      
      public function init() : void
      {
         if(box != null)
         {
            return;
         }
         var _loc1_:Parser3DS = new Parser3DS();
         box = setupBox(_loc1_,new boxdata());
         parachute = setupBox(_loc1_,new parachute_data());
         parachutei = setupBox(_loc1_,new parachutei_data());
      }
      
      private static function setupBox(param1:Parser3DS, param2:ByteArray) : Mesh
      {
         var _loc3_:Object3D = null;
         var _loc4_:Mesh = null;
         var _loc5_:Mesh = null;
         param1.parse(param2);
         for each(_loc3_ in param1.objects)
         {
            _loc5_ = _loc3_ as Mesh;
            if(_loc5_ != null)
            {
               _loc5_.setMaterialToAllFaces(null);
            }
         }
         _loc4_ = param1.objects[0] as Mesh;
         return _loc4_;
      }
   }
}
