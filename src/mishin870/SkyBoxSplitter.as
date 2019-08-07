package mishin870
{
   import alternativa.engine3d.objects.SkyBox;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import alternativa.engine3d.materials.TextureMaterial;
   
   public class SkyBoxSplitter
   {
       
      public function SkyBoxSplitter()
      {
         super();
      }
      
      public static function getSkyBox(param1:Number, param2:BitmapData) : SkyBox
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc21_:* = new Matrix();
         var _loc22_:* = new BitmapData(param2.height,param2.height,false,0);
         _loc22_.draw(param2);
         _loc3_ = _loc22_.clone();
         _loc9_ = new TextureMaterial(_loc3_);
         _loc21_.tx = -_loc22_.width;
         _loc22_.draw(param2,_loc21_);
         _loc4_ = _loc22_.clone();
         _loc10_ = new TextureMaterial(_loc4_);
         _loc21_.tx = -2 * _loc22_.width;
         _loc22_.draw(param2,_loc21_);
         _loc5_ = _loc22_.clone();
         _loc11_ = new TextureMaterial(_loc5_);
         _loc21_.tx = -3 * _loc22_.width;
         _loc22_.draw(param2,_loc21_);
         _loc6_ = _loc22_.clone();
         _loc12_ = new TextureMaterial(_loc6_);
         _loc21_.tx = -4 * _loc22_.width;
         _loc22_.draw(param2,_loc21_);
         _loc7_ = _loc22_.clone();
         _loc13_ = new TextureMaterial(_loc7_);
         _loc21_.tx = -5 * _loc22_.width;
         _loc22_.draw(param2,_loc21_);
         _loc8_ = _loc22_;
         _loc14_ = new TextureMaterial(_loc8_);
         return new SkyBox(param1,_loc9_,_loc11_,_loc12_,_loc10_,_loc14_,_loc13_,0.01);
      }
   }
}
