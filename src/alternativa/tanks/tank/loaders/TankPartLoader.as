package alternativa.tanks.tank.loaders
{
   import away3d.entities.Mesh;
   import flash.display.BitmapData;
   import flash.events.EventDispatcher;
   import alternativa.tanks.tank.physics.CollisionBoxData;
   import alternativa.math.Vector3;
   import flash.geom.Vector3D;
   import alternativa.math.Matrix4;
   import alternativa.tanks.tank.TankPart;
   import flash.net.URLLoader;
   import flash.display.Loader;
   import flash.net.URLLoaderDataFormat;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.display.Bitmap;
   
   public class TankPartLoader extends EventDispatcher
   {
       
      public var data:TankPart;
      
      private var modelUrl:String;
      
      private var oldModel:String;
      
      private var lightmapUrl:String;
      
      private var detailmapUrl:String;
      
      private var modelLoader:URLLoader;
      
      private var imageLoader:Loader;
	  
	  private var l1:BitmapData;
	  
	  private var l2:BitmapData;
      
      public function TankPartLoader(param1:String, param2:String, param3:String, param4:TankPart)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("Parameter modelUrl cannot be null");
         }
         if(param2 == null)
         {
            throw new ArgumentError("Parameter lightmapUrl cannot be null");
         }
         if(param3 == null)
         {
            throw new ArgumentError("Parameter detailsUrl cannot be null");
         }
         this.modelUrl = param1;
         this.lightmapUrl = param2;
         this.detailmapUrl = param3;
		 this.data = param4;
      }
      
      public function load() : void
      {
         loadImage(this.lightmapUrl, this.onLightmapLoadingComplete);
		 //throw new Error("dsfh");
      }
	  
	  public function loadImage(param1:String, param2:Function) : void
      {
         if(this.imageLoader == null)
         {
            this.imageLoader = new Loader();
         }
		 //new Error(param1);
         this.imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,param2);
         this.imageLoader.load(new URLRequest(param1));
      }
      
      private function onLightmapLoadingComplete(param1:Event) : void
      {
         this.data.lightmap = (this.imageLoader.content as Bitmap).bitmapData;
		 //l1 = new BitmapData(1024, 1024);
         this.imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLightmapLoadingComplete);
         this.loadImage(this.detailmapUrl,this.onDetailsLoadingComplete);
      }
      
      private function onDetailsLoadingComplete(param1:Event) : void
      {
         this.data.details = (this.imageLoader.content as Bitmap).bitmapData;
         this.imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onDetailsLoadingComplete);
         this.imageLoader = null;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      override public function toString() : String
      {
         return "[TankPartLoader " + this.modelUrl + ", " + this.lightmapUrl + ", " + this.detailmapUrl + "]";
      }
   }
}
