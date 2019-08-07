package
{
   import flash.events.DataEvent;
   import flash.events.NetStatusEvent;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.system.SecurityDomain;
   import alternativa.tanks.Game;
   import flash.display.*;
   import flash.events.Event;
   import flash.net.*;
   import flash.text.TextField;
   
   public class Main extends Sprite
   {
      
      [Embed(source = 'font.ttf', fontName = 'MyriadPro', mimeType = 'application/x-font', embedAsCFF = 'false')] private static var abc:Class;
      
      public static const METR_TO_PIXELS:int = 128;
      
      public static var instance:Main;
      
      public static var sbid:int = 1;
      
      public static var inBattle:Boolean = false;
      
      public static var isLoading:Boolean = false;
      
      public static var userName:String;
      
      public static var crys:int;
	  
	  public static var idv:Number = 1 / 255;
	  
	  public static var idc:Number = 1 / 65025;
	  
	  public static var idg:Number = 1 / 16581375;
      
      public static var score:int;
      
      public var xml:XML;
      
      public var game:Game;
	  
	  public static var stage3d:Stage3D;
	  
	  private var loader:URLLoader = new URLLoader();
	  
	  public var context:LoaderContext;
      
      public function Main()
      {
		 super();
		 instance = this;
		 Security.allowDomain("*");
		 Security.loadPolicyFile("policy.xml");
		 context = new LoaderContext(false, ApplicationDomain.currentDomain);
		 loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE, dfet);
		 loader.load(new URLRequest("config.xml"));
      }
	  
	  private function dfet(param1:Event) : void
	  {
			this.xml = new XML(param1.currentTarget.data);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.BEST;
			stage.stageFocusRect = false;
			mouseEnabled = false;
			tabEnabled = false;
			stage.frameRate = 60;
            this.game = new Game(stage, stage3d, "pesok.awd");
			addChild(this.game);
      }
      
      public function stopGame() : void {
		 try{
				 game.destroy();
				 game = null;
		 } catch (e:Error) { }
      }
   }
}
