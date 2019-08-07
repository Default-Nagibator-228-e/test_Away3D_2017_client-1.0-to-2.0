package mishin870.gui.Garage
{
   import flash.events.EventDispatcher;
   import flash.net.URLLoader;
   import flash.display.Loader;
   import flash.display.BitmapData;
   import flash.geom.Vector3D;
   import flash.events.Event;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.display.Bitmap;
   
   public class TankPart extends EventDispatcher
   {
       
      private var url:String;
      
      private var loader:URLLoader;
      
      private var iLoader:Loader;
            
      public var lightmap:BitmapData;
      
      public var details:BitmapData;
      
      public var turretPos:Vector3D;
      
      public function TankPart(param1:String)
      {
         super();
         this.url = param1;
      }
      
      public function load() : void
      {
         this.loader = new URLLoader();
         this.loader.addEventListener(Event.COMPLETE,this.meshCom);
         this.loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.loader.load(new URLRequest(this.url + "model.3ds"));
      }
      
      public function meshCom(param1:Event) : void
      {
         this.loader = null;
         this.iLoader = new Loader();
         this.iLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.lightmapCom);
         this.iLoader.load(new URLRequest(this.url + "lightmap.jpg"));
      }
      
      public function lightmapCom(param1:Event) : void
      {
         var _loc2_:Bitmap = this.iLoader.content as Bitmap;
         this.lightmap = _loc2_.bitmapData;
         this.iLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.lightmapCom);
         this.iLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.detailsCom);
         this.iLoader.load(new URLRequest(this.url + "details.png"));
      }
      
      public function detailsCom(param1:Event) : void
      {
         var _loc2_:Bitmap = this.iLoader.content as Bitmap;
         this.details = _loc2_.bitmapData;
         this.iLoader = null;
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
