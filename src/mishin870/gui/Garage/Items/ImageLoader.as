package mishin870.gui.Garage.Items
{
   import flash.events.EventDispatcher;
   import flash.display.Loader;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.display.Bitmap;
   import flash.system.Security;
   
   public class ImageLoader extends EventDispatcher
   {
       
      private var imgLoa:Loader = new Loader();
      
      public var img:BitmapData;
      
      public var url:String;
      
      public function ImageLoader(param1:String)
      {
         super();
         this.url = param1;
		 this.url = this.url.replace("http://f90573wp.beget.tech/","");
      }
      
      public function load() : void
      {
         imgLoa.contentLoaderInfo.addEventListener(Event.COMPLETE,image_loaded, false, 0, true);
         imgLoa.load(new URLRequest(this.url));
      }
      
      private function image_loaded(param1:Event) : void
      {
         this.img = (imgLoa.contentLoaderInfo.content as Bitmap).bitmapData;
		 imgLoa.contentLoaderInfo.removeEventListener(Event.COMPLETE,image_loaded);
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
