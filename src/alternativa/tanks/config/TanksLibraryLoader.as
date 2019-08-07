package alternativa.tanks.config
{
   import alternativa.tanks.tank.TankPart;
   import alternativa.tanks.tank.loaders.TankTurretLoader;
   import alternativa.tanks.tank.loaders.TankHullLoader;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import alternativa.tanks.resources.TanksLib;
   import alternativa.tanks.tank.TankTurret;
   import alternativa.tanks.tank.TankHull;
   import flash.net.URLRequest;
   import flash.display.Bitmap;
   
   public class TanksLibraryLoader extends SimpleLoader
   {
       
      private var xml:XML;
      
      private var turretLoaders:Vector.<TankTurretLoader>;
      
      private var hullLoaders:Vector.<TankHullLoader>;
      
      private var colormapNames:Vector.<String>;
      
      private var currTurretLoader:TankTurretLoader;
      
      private var currHullLoader:TankHullLoader;
      
      private var currColormapLoader:Loader;
      
      public function TanksLibraryLoader(param1:XML)
      {
         this.turretLoaders = new Vector.<TankTurretLoader>();
         this.hullLoaders = new Vector.<TankHullLoader>();
         this.colormapNames = new Vector.<String>();
         super();
         this.xml = param1;
		 //Main.instance.game.tankslib.turrets = new Vector.<TankTurret>();
		 //Main.instance.game.tankslib.hulls = new Vector.<TankHull>();
		 //Main.instance.game.tankslib.colormaps = new Vector.<BitmapData>();
      }
      
      override public function load() : void
      {
         var _loc4_:XML = null;
         var _loc5_:XML = null;
         var _loc6_:int = 0;
         var _loc1_:XMLList = this.xml.colormaps[0].child("colormap");
         var _loc2_:XMLList = this.xml.hulls[0].child("hull");
         var _loc3_:XMLList = this.xml.turrets[0].child("turret");
         for each(_loc4_ in _loc1_)
         {
            this.colormapNames.push(_loc4_.@path + "image.jpg");
         }
         for each(_loc5_ in _loc3_)
         {
            this.turretLoaders.push(new TankTurretLoader(_loc5_));
         }
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length())
         {
            this.hullLoaders.push(new TankHullLoader(_loc2_[_loc6_],this.xml.profiles[0].profile[_loc6_]));
            _loc6_++;
         }
         this.loadNextTurret();
      }
      
      private function loadNextTurret() : void
      {
         if(this.turretLoaders.length > 0)
         {
            this.currTurretLoader = this.turretLoaders.shift();
            this.currTurretLoader.addEventListener(Event.COMPLETE,this.turretCom);
            this.currTurretLoader.load();
         }
         else
         {
            this.loadNextHull();
         }
      }
      
      private function turretCom(param1:Event) : void
      {
         this.currTurretLoader.removeEventListener(Event.COMPLETE, this.turretCom);
		 //this.currTurretLoader.data = new TankPart();
		 //throw new Error(this.currTurretLoader.data);
         Main.instance.game.tankslib.turrets.push(this.currTurretLoader.data as TankTurret);
		 //throw new Error(this.currTurretLoader.op);
         this.loadNextTurret();
      }
      
      private function loadNextHull() : void
      {
         if(this.hullLoaders.length > 0)
         {
            this.currHullLoader = this.hullLoaders.shift();
            this.currHullLoader.addEventListener(Event.COMPLETE,this.hullCom);
            this.currHullLoader.load();
         }
         else
         {
            this.loadNextColormap();
         }
      }
      
      private function hullCom(param1:Event) : void
      {
         this.currHullLoader.removeEventListener(Event.COMPLETE, this.hullCom);
		 //this.currHullLoader.data = new TankPart();
		 //throw new Error("Пошло1!");
         Main.instance.game.tankslib.hulls.push(this.currHullLoader.data as TankHull);
         this.loadNextHull();
      }
      
      private function loadNextColormap() : void
      {
         var _loc1_:String = null;
         if(this.colormapNames.length > 0)
         {
            _loc1_ = this.colormapNames.shift();
            this.currColormapLoader = new Loader();
            this.currColormapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.colormapCom);
            this.currColormapLoader.load(new URLRequest(_loc1_));
         }
         else
         {
            this.hullLoaders = null;
            this.turretLoaders = null;
            this.colormapNames = null;
            completeLoading();
         }
      }
      
      private function colormapCom(param1:Event) : void
      {
         this.currColormapLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.colormapCom);
		 //throw new Error("Пошло1!");
         Main.instance.game.tankslib.colormaps.push((this.currColormapLoader.content as Bitmap).bitmapData);
         this.loadNextColormap();
      }
   }
}
