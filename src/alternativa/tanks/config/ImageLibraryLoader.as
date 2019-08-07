package alternativa.tanks.config
{
   import flash.display.Loader;
   import flash.events.Event;
   import alternativa.tanks.resources.ImageLib;
   import flash.display.Bitmap;
   
   public class ImageLibraryLoader extends SimpleLoader
   {
       
      private var urls:Vector.<alternativa.tanks.config.NamedUrlRequest>;
      
      private var currName:String;
      
      private var loader:Loader;
      
      private var baseUrl:String;
      
      private var imagesXml:XMLList;
      
      public function ImageLibraryLoader(param1:XMLList)
      {
         this.urls = new Vector.<alternativa.tanks.config.NamedUrlRequest>();
         this.loader = new Loader();
         super();
         this.imagesXml = param1;
      }
      
      override public function load() : void
      {
         this.baseUrl = this.imagesXml.@baseUrl;
         for each(var _loc1_:XML in this.imagesXml.elements("image"))
         {
			//try
			//{
				this.urls.push(new alternativa.tanks.config.NamedUrlRequest(_loc1_.@id, "" + this.baseUrl + _loc1_.@url));
			//}
			//catch(e:Error)
			//{
				//throw new Error("http://f90573wp.beget.tech/" + this.baseUrl + _loc1_.@url);
			//}
         }
         this.loadNextImage();
      }
      
      private function loadNextImage() : void
      {
         var _loc1_:alternativa.tanks.config.NamedUrlRequest = null;
         if(this.urls.length > 0)
         {
            _loc1_ = this.urls.shift();
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.imageCom);
            this.currName = _loc1_.name;
            this.loader.load(_loc1_.req);
         }
         else
         {
            this.loader = null;
            completeLoading();
         }
      }
      
      private function imageCom(param1:Event) : void
      {
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.imageCom);
         ImageLib.addImage(this.currName,(this.loader.content as Bitmap).bitmapData);
         this.loadNextImage();
      }
   }
}
