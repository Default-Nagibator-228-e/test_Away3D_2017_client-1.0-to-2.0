package alternativa.tanks.config
{
   import flash.net.URLLoader;
   import alternativa.math.Vector3;
   import flash.events.Event;
   import flash.net.URLRequest;
   
   public class Config extends alternativa.tanks.config.SimpleLoader
   {
       
      private var loaders:Vector.<alternativa.tanks.config.SimpleLoader>;
      
      private var currLoader:alternativa.tanks.config.SimpleLoader;
      
      private var xmlLoader:URLLoader;
      
      public var xml:XML;
      
      public var mapXml:XML;
      
      private var url:String;
      
      public function Config(param1:String)
      {
         this.loaders = new Vector.<alternativa.tanks.config.SimpleLoader>();
         this.xmlLoader = new URLLoader();
         super();
         this.url = param1;
      }
      
      public function loadConfig(param1:XML = null, param2:String = "") : void
      {
         if(param1 == null)
         {
            this.xmlLoader.addEventListener(Event.COMPLETE,this.xmlCom);
            this.xmlLoader.load(new URLRequest(param2));
         }
         else
         {
            this.xml = param1;
            this.loadXml();
         }
      }
      
      private function xmlCom(param1:Event) : void
      {
         this.xml = XML(this.xmlLoader.data);
         this.loadXml();
      }
      
      private function loadXml() : void
      {
		 this.loaders.push(new TanksMapLoader(this,this.url));
         this.loaders.push(new ImageLibraryLoader(this.xml.child("images")));
         this.loaders.push(new SkyboxLoader(this));
         this.loadNext();
      }
      
      private function loadNext() : void
      {
         if(this.loaders.length > 0)
         {
            this.currLoader = this.loaders.shift();
            this.currLoader.addEventListener(Event.COMPLETE,this.currLoaderComplete);
            this.currLoader.load();
         }
         else
         {
            completeLoading();
         }
      }
      
      private function currLoaderComplete(param1:Event) : void
      {
         this.loadNext();
      }
   }
}
