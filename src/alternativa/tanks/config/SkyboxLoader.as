package alternativa.tanks.config
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.display.Bitmap;
   
   public class SkyboxLoader extends SimpleLoader
   {
       
      private var skyLoader:Loader;
      
      private var config:Config;
      
      public function SkyboxLoader(param1:Config)
      {
         super();
         this.config = param1;
      }
      
      override public function load() : void
      {
         //this.skyLoader = new Loader();
         //this.skyLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.skyCom);
         //this.skyLoader.load(new URLRequest("http://f90573wp.beget.tech/data/images/skyboxes/" + int(this.config.mapXml.skybox[0].@val) + ".jpg"));
		 completeLoading();
		 Main.instance.game.configCom();
      }
      
      private function skyCom(param1:Event) : void
      {
		 //Main.instance.game.configCom();
         //Main.instance.game.skybox = SkyBoxSplitter.getSkyBox(1000000,(this.skyLoader.content as Bitmap).bitmapData);
         completeLoading();
      }
   }
}
