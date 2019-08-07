package alternativa.tanks.resources
{
   import alternativa.engine3d.objects.Mesh;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ErrorEvent;
   import flash.net.URLRequest;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.core.Sorting;
   import flash.utils.ByteArray;
   import alternativa.engine3d.loaders.Parser3DS;
   
   public class PropMesh extends Prop
   {
       
      public var mesh:Mesh;
      
      private var textures:Object;
      
      private var textureLoader:Loader;
      
      private var u:String;
      
      public function PropMesh(param1:String, param2:ByteArray)
      {
         this.textures = new Object();
         super("PropMesh");
         var _loc3_:Parser3DS = new Parser3DS();
         _loc3_.parse(param2);
         this.u = param1 + _loc3_.textureMaterials[0].diffuseMapURL;
         var _loc4_:Mesh = _loc3_.objects[0] as Mesh;
         _loc4_.calculateFacesNormals();
         _loc4_.calculateBounds();
         _loc4_.optimizeForDynamicBSP();
         this.mesh = _loc4_;
      }
      
      public function prepareTexture(param1:String) : void
      {
         if(this.u == null || this.u == "")
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            this.loadDefaultMaterial(this.u);
         }
      }
      
      private function loadDefaultMaterial(param1:String) : void
      {
         var url:String = param1;
         this.textureLoader = new Loader();
         this.textureLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.texCom);
         this.textureLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(param1:ErrorEvent):void
         {
            dispatchEvent(new Event(Event.COMPLETE));
         });
         this.textureLoader.load(new URLRequest(url));
      }
      
      private function texCom(param1:Event) : void
      {
         var _loc2_:BitmapData = (this.textureLoader.content as Bitmap).bitmapData;
         var _loc3_:TextureMaterial = new TextureMaterial(_loc2_,false,true);
         this.mesh.setMaterialToAllFaces(_loc3_);
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function addTexture(param1:String, param2:BitmapData) : void
      {
         this.textures[param1] = param2;
      }
      
      override public function getProp(param1:String) : Object3D
      {
         var _loc3_:TextureMaterial = null;
         var _loc2_:Mesh = this.mesh.clone() as Mesh;
         if(param1 != "" && param1 != null)
         {
            _loc3_ = new TextureMaterial(this.textures[param1],false,true);
            _loc2_.setMaterialToAllFaces(_loc3_);
         }
         _loc2_.sorting = Sorting.DYNAMIC_BSP;
         return _loc2_;
      }
   }
}
