package alternativa.tanks
{
   //import Vector;
   import alternativa.tanks.utils.PhysicsUtils;
   import alternativa.tanks.config.Config;
   import alternativa.tanks.physics.PhysicsScene3D;
   import alternativa.tanks.vos.RigidBodyVO;
   import away3d.bounds.AxisAlignedBoundingBox;
   import away3d.controllers.HoverController;
   import away3d.core.base.Geometry;
   import away3d.core.math.MathConsts;
   import away3d.core.math.Vector3DUtils;
   import away3d.primitives.PlaneGeometry;
   import away3d.tools.helpers.ParticleGeometryHelper;
   import away3d.tools.helpers.data.ParticleGeometryTransform;
   import awayphysics.collision.dispatch.AWPCollisionObject;
   import awayphysics.collision.shapes.AWPBoxShape;
   import awayphysics.collision.shapes.AWPBvhTriangleMeshShape;
   import awayphysics.collision.shapes.AWPCollisionShape;
   import awayphysics.collision.shapes.AWPCompoundShape;
   import awayphysics.collision.shapes.AWPConeShape;
   import awayphysics.collision.shapes.AWPConvexHullShape;
   import awayphysics.collision.shapes.AWPCylinderShape;
   import awayphysics.collision.shapes.AWPHeightfieldTerrainShape;
   import awayphysics.collision.shapes.AWPSphereShape;
   import awayphysics.collision.shapes.AWPStaticPlaneShape;
   import awayphysics.debug.AWPDebugDraw;
   import awayphysics.dynamics.AWPDynamicsWorld;
   import awayphysics.dynamics.AWPRigidBody;
   import awayphysics.extend.AWPTerrain;
   //import alternativa.engine3d.core.*;
   //import alternativa.engine3d.objects.SkyBox;
   //import alternativa.engine3d.lights.*
   import flash.display.DisplayObjectContainer;
   //import alternativa.engine3d.controllers.SimpleObjectController;
   //import alternativa.engine3d.containers.ConflictContainer;
   import alternativa.tanks.resources.*;
   //import alternativa.tanks.bonus.Bonus;
   import alternativa.tanks.tank.controllers.FollowCameraController;
   //import alternativa.tanks.bonus.BonusPointsManager;
   import flash.text.TextField;
   import controls.TankInput;
   import controls.SuicideIndicator;
   import controls.Label;
   //import alternativa.tanks.mine.Mine;
   import flash.utils.setTimeout;
   import flash.geom.Vector3D;
   //import alternativa.tanks.physics.TanksCollisionDetector;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   import alternativa.math.Vector3;
   import alternativa.math.Matrix3;
   import alternativa.math.Quaternion;
   import alternativa.tanks.tank.*;
   //import alternativa.tanks.bonus.BonusResources;
   import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.events.Stage3DEvent;
	import away3d.library.assets.AssetType;
	import away3d.lights.DirectionalLight;
	import away3d.lights.shadowmaps.DirectionalShadowMapper;
	import away3d.lights.shadowmaps.NearDirectionalShadowMapper;
	import away3d.loaders.Loader3D;
	import away3d.loaders.parsers.AWDParser;
	import away3d.loaders.parsers.Max3DSParser;
	import away3d.materials.TextureMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FilteredShadowMapMethod;
	import away3d.materials.methods.HardShadowMapMethod;
	import away3d.materials.methods.NearShadowMapMethod;
	import away3d.materials.methods.SoftShadowMapMethod;
	import away3d.materials.methods.TripleFilteredShadowMapMethod;
	import away3d.utils.Cast;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.Keyboard;
	import flash.utils.*;
   
   public class Game extends Sprite
   {
      
      private static var instance:alternativa.tanks.Game;
       
      public var config:Config;
      
      public var camera:Camera3D;
      
      //public var skybox:SkyBox;
            
      public var physicsStepMsec:Number = 30;
      
      //private var stage:DisplayObjectContainer;
	  //private var stage:Stage;
      
      public var time:uint;
      
      //private var freeCameraController:SimpleObjectController;
      
      //public var rootContainer:ConflictContainer = new ConflictContainer();
      
      private const PHYSICS_FRAME_SAMPLES:int = 30;
      
      private var physicsFrameCounter:int;
      
      private var physicsFrameAccumulatedTime:Number = 0;
      
      private var doPhysics:Boolean = true;
      
      private var doRender:Boolean = true;
      
      //public var map:TanksMap = new TanksMap();
      
      //public var bonuses:Vector.<Bonus> = new Vector.<Bonus>();
      
      public var tanks:Vector.<Tank> = new Vector.<Tank>();
      
      //private var followCameraController:FollowCameraController;
      
      public var followTank:Tank;
      
      public var spawnPointsManager:SpawnPointsManager = new SpawnPointsManager();
      
      //public var bonusPointsManager:BonusPointsManager = new BonusPointsManager();
      
      private var effects:Vector.<alternativa.tanks.IGraphicEffect> = new Vector.<alternativa.tanks.IGraphicEffect>();
      
      public var tankManager:alternativa.tanks.TankManager;
      
      private var followCameraUp:Boolean = false;
      
      private var followCameraDown:Boolean = false;
      
      private var turretNum:int;
      
      private var turretM:int;
      
      private var hullNum:int;
      
      private var hullM:int;
	  
	  private var fgr:int = 0;
      
      private var colormapNum:int;
      
      private var profileNum:int;
      
      private var profile:String;
      
      private var team:BattleTeamType;
      
      private var MAX_HEALTH:int;
      
      private var MAX_SCORE:int;
	  
	  private var TIME:int;
                  
      private var debug:TextField;
                  
      public var keyEnab:Boolean = true;
      
      private var chatF:TankInput = new TankInput();
            
      private var si:SuicideIndicator = new SuicideIndicator();
      
      private var isSD:Boolean = false;
      
      public var INTERPOLATE_TIME:int;
      
      public var battleType:int;
      
      private var bonusNums:Vector.<int> = new Vector.<int>(5);
            
      public var tankExplosionFactory:TankExplosionFactory = new TankExplosionFactory();
      
      public var taskManager:alternativa.tanks.TaskManager = new alternativa.tanks.TaskManager();
      
      private var bPause:Boolean = false;
      
      public var fpsLabel:Label = new Label();
      
      private var fps:int = 0;
      
      private var timeFps:int = 1000;
      
      //public var mines:Vector.<Mine> = new Vector.<Mine>();
	  
	  //public var stage3d:Stage3D;
	  
	  //private var bonusr:BonusResources = new BonusResources();
	  public var _view : View3D;
	  private var _container : Loader3D;
	  public var container : ObjectContainer3D = new ObjectContainer3D();
	  public var container1 : ObjectContainer3D = new ObjectContainer3D();
	  private var contr:FlyController;
	  public var _light:DirectionalLight;
	  public var _lightPicker:StaticLightPicker;
	  public var tanksmap:Mesh = new Mesh(null,null);
	  public var tankslib:TanksLib = new TanksLib();
	  public var physics:AWPDynamicsWorld;
	  private var debugDraw:AWPDebugDraw;
	  private var dv:Vector3D = new Vector3D();
	  public var ind:int = 0;
	  public var ind1:int = 0;
	  public var pingf:uint = 0;
	  public var p:Vector.<Vector3D> = new Vector.<Vector3D>();
	  public var r:Vector.<Vector3D> = new Vector.<Vector3D>();
	  public var m:Vector.<Mesh> = new Vector.<Mesh>();
	  public var gus:Mesh = new Mesh(null);
	  public var gus1:Mesh = new Mesh(null);
	  public var gus2:Mesh = new Mesh(null);
	  public var gus3:Mesh = new Mesh(null);
	  public var cunt:HoverController;
	  public var cunt1:HoverController;
	  public var cunt2:HoverController;
	  private var num:int = 0;
		private var i:int = 0;
		private var isr:Boolean = false;
		private var t:Tank = null;
		private var id:int = 0;
		private var bt:int = 0;
		private var data:String = null;
		private var arr2:Array = null;
		private var type:int = 0;
		private var l:String = null;
		private var r1:int = 0;
		private var text:String = null;
		private var f:int = 0;
		private var sc:int = 0;
		private var ds:int = 0;
		private var r2:int = 0;
		private var l2:String = null;
		//var b:Bonus = null;
		private var effectNum:int = 0;
		private var effectTime:int = 0;
		private var tim:Timer = null;
		//var m:Mine = null;
		private var arr:Array;
      
      public function Game(param1:DisplayObjectContainer, param500:Stage3D, param2:String)
		{
         super();
         if(instance != null)
         {
            throw new Error("Game class is singleton");
         }
         instance = this;
		 //this.stage3d = param500;
		 this.initVieport();
		 this.initLights();
		 //throw new Error("");
         this.config = new Config(param2);
         //this.config.addEventListener(Event.COMPLETE,this.configCom);
         this.config.loadConfig(null, "config.xml");
      }
      
      public static function getInstance() : alternativa.tanks.Game
      {
         return instance;
      }
      
      public function destroy() : void
      {
		    var _loc1_:Tank = null;
			//var _loc2_:Bonus = null;
         for each(_loc1_ in this.tanks)
         {
            _loc1_.destroy();
            this.tanks.shift();
            _loc1_ = null;
         }
         this.tanks = null;
         //for each(_loc2_ in this.bonuses)
         //{
            //_loc2_.removeFromWorld();
            //this.bonuses.shift();
            //_loc2_ = null;
         //}
			for each (var effect:IGraphicEffect in effects) {
				effect.destroy();
				effect = null;
			}
			effects = null;
			stage.removeEventListener(KeyboardEvent.KEY_UP, ku);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, kd);
			stage.removeEventListener(Event.ENTER_FRAME, tick);
			stage.removeEventListener(Event.RESIZE, res);
			tankManager = null;
			spawnPointsManager = null;
			//bonusPointsManager = null;
			config = null;
			//map = null;
			tanks = null;
			//followCameraController = null;
			//followTank = null;
			//freeCameraController = null;
			//skybox = null;
			camera = null;
			//rootContainer = null;
			instance = null;
      }
      
		public function addGraphicsEffect(effect:IGraphicEffect):void {
			effects.push(effect);
			effect.addToContainer(this.container, this);
		}
      
		public function removeGraphicsEffect(effect:IGraphicEffect):void {
			effect.destroy();
			for (var i:Number = 0; i < effects.length; i++) {
				if (effects[i] == effect) {
					effects.splice(i, 1);
					return;
				}
			}
			effect = null;
		}
      
      public function configCom(param1:Event = null) : void
      {
         //this.spawnPointsManager.initSpawnPoints(this.config.mapXml);
         //this.bonusPointsManager.initBonusPoints(this.config.mapXml);
         this.tankManager = new alternativa.tanks.TankManager();
         //this.tankManager.loadWeaponProfiles(this.config.xml.weapons[0]);
         this.init();
      }
      
      public function tick(param1:Event) : void
      {
         var _loc7_:alternativa.tanks.IGraphicEffect = null;
         var _loc2_:uint = this.time;
		 this.time = getTimer();
         _loc2_ = this.time - _loc2_;
		 for each(_loc7_ in effects) {
               if(!_loc7_.play(_loc2_, 1, _view.camera))
               {
                  removeGraphicsEffect(_loc7_);
			   }
		 }
		 contr.update();
        this._view.render();
        this.fps++;
        this.timeFps = this.timeFps - _loc2_;
        if(this.timeFps <= 0)
        {
            this.timeFps = 1000;
            this.fpsLabel.text = "FPS: " + fps;
            this.fps = 0;
        }
      }
      
      private function init() : void
      {
         this.initMap();
         this.completeInit();
      }
      
      private function initVieport() : void
      {
			this._view = new View3D();
			addChild(this._view);
			Main.instance.stage.frameRate = 60;
			addChild(new AwayStats(this._view));
			var camera:Camera3D = this._view.camera;
			camera.lens = new PerspectiveLens();
			camera.z = 500;
			this._view.antiAlias = 8;
			camera.lens.far = 12000;
			cunt = new HoverController(this._view.camera,null,0,90,1000,-180,180);
			this._view.scene.addChild(container);
			contr = new FlyController(this._view);
      }
      
      public function initLights() : void
	  {
		    _light = new DirectionalLight();
			_light.ambient = 0.5;
			_light.diffuse = 1;
			_light.specular = 0.37;
			_light.y = 90000;
			_light.x = 50000;
			_light.z = -10000;
			//_light.z = -10000;
			//_direction = new Vector3D(1, 10000, 1);
			//_light.direction = new Vector3D(50000, 70000);
			//_light.shadowMapper = new DirectionalShadowMapper();
			//_light.castsShadows = false;
			//_light.shadowMapper.depthMapSize = 2048;
			_light.lookAt(container.position);
			container.addChild(_light);
			_lightPicker = new StaticLightPicker([_light]);
	  }
      
		private function readVector3D(xmlVector:XMLList):Vector3D {
			var x:Number = xmlVector.child("x")!=null ? xmlVector.child("x") : 0;
			var y:Number = xmlVector.child("y")!=null ? xmlVector.child("y") : 0;
			var z:Number = xmlVector.child("z")!=null ? xmlVector.child("z") : 0;
			return new Vector3D(x, y, z);
		}
      
      private function initMap() : void
      {
		  this.container.addChild(this.tanksmap);
      }
      
      private function onResize(param1:Event) : void
      {
         this._view.width = Main.instance.stage.stageWidth;
         this._view.height = Main.instance.stage.stageHeight;
      }
      
      private function toggleSkyBox() : void
      {
         //this.skybox.visible = !this.skybox.visible;
      }
      
      private function completeInit() : void
      {
		 Main.instance.stage.addEventListener(KeyboardEvent.KEY_UP,this.ku);
         Main.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.kd);
		 Main.instance.stage.addEventListener(Event.ENTER_FRAME,this.tick);
         Main.instance.stage.addEventListener(Event.RESIZE, this.res);
         //this.setFollowCamera(this.tanks[0]);
		 //stage.addChild(new AwayStats(this._view));
		 try
         {
            Main.instance.stage.removeChildAt(1);
         }
         catch(e:Error)
         {
         }
         //this.stage.addChild(Main.instance.lobby);
		 /*
         this.dpg = new DownPanelGUI();
         this.stage.addChild(this.dpg);
         this.dpg.setScoreLabel(this.MAX_SCORE.toString());
		 this.dpg.setTimeLabel(this.TIME.toString());
		 if (TIME == 0) {
			this.dpg.setMode(1);
			this.dpg.type = 1;
		 }
		 if (MAX_SCORE == 0) {
			this.dpg.setMode(2);
			this.dpg.type = 2;
		 }
		 if (MAX_SCORE > 0 && TIME > 0) {
			this.dpg.setMode(3);
			this.dpg.type = 3;
		 }
         this.debug = new TextField();
         this.debug.background = true;
         this.debug.backgroundColor = 16777215;
         this.debug.autoSize = TextFieldAutoSize.LEFT;
         this.debug.multiline = true;
         this.debug.visible = false;
         this.stage.addChild(this.debug);
		 */
         this.chatF.x = 7;
         this.chatF.width = 335;
         this.chatF.visible = false;
         addChild(this.chatF);
         addChild(this.si);
         this.fpsLabel.text = "FPS: 0";
		 this.fpsLabel.textColor = 0;
         this.fpsLabel.x = Main.instance.stage.stageWidth - 10 - this.fpsLabel.width;
         addChild(this.fpsLabel);
         this.res(null);
         Main.isLoading = false;
		 //this._view.camera.position = new Vector3D( -1300, 2000, -2000);
		 //this._view.camera.rotationY = 45;
		 //this._view.camera.rotationY = 90;
      }
      
      public function setControlsEnabled(param1:Boolean) : void
      {
         this.keyEnab = param1;
         if(!this.keyEnab)
         {
            this.followCameraDown = false;
            this.followCameraUp = false;
         }
		 /*
         if(this.keyEnab)
         {
            this.freeCameraController.enable();
         }
         else
         {
            this.freeCameraController.disable();
         }
         if(this.followTank != null)
         {
            this.followTank.controller.setEnabled(this.keyEnab);
         }
		 */
      }
      
      public function showChat() : void
      {
         this.chatF.visible = true;
         Main.instance.stage.focus = this.chatF.textField;
      }
      
      public function hideChat() : void
      {
         this.chatF.visible = false;
      }
      
      private function resetBattle() : void
      {
         this.tanks[0].resetColormap();
         this.tankManager.respawn(this.tanks[0],this.tanks[0].TEAM);
         this.tanks[0].vis = false;
         this.bPause = false;
      }
      /*
      private function getBonusById(param1:int) : Bonus
      {
         var _loc2_:Bonus = null;
         for each(_loc2_ in this.bonuses)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
		 
         return null;
      }
	  */
      
      private function it(param1:Array) : int
      {
         return int(param1.shift());
      }
      
      private function n(param1:Array) : Number
      {
         return Number(param1.shift());
      }
      
      private function readm3(param1:Array) : Matrix3
      {
         return new Matrix3(this.n(param1),this.n(param1),this.n(param1),this.n(param1),this.n(param1),this.n(param1),this.n(param1),this.n(param1),this.n(param1));
      }
      
      private function readv3(param1:Array) : Vector3
      {
         return new Vector3(this.n(param1),this.n(param1),this.n(param1));
      }
	  
	  private function readv3d(param1:Array) : Vector3D
      {
         return new Vector3D(this.n(param1),this.n(param1),this.n(param1));
      }
      
      private function readq(param1:Array) : Quaternion
      {
         return new Quaternion(this.n(param1),this.n(param1),this.n(param1),this.n(param1));
      }
      
      private function getTankById(param1:int) : Tank
      {
         var _loc2_:Tank = null;
         for each(_loc2_ in this.tanks)
         {
            if(_loc2_.tankId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
	  
      
      public function res(param1:Event) : void
      {
         this._view.width = Main.instance.stage.stageWidth;
         this._view.height = Main.instance.stage.stageHeight;
         this.si.x = Main.instance.stage.stageWidth * 0.5;
         this.si.y = Main.instance.stage.stageHeight * 0.5;
         this.fpsLabel.y = Main.instance.stage.stageHeight - 25 - this.fpsLabel.height;
      }
      
      private function ku(param1:KeyboardEvent) : void
      {
         var _loc2_:Tank = null;
      }
      
      private function kd(param1:KeyboardEvent) : void
      {
         var tim:Timer = null;
         var e:KeyboardEvent = param1;
         if(!this.keyEnab)
         {
            return;
         }
		 /*
		 if(e.keyCode == Keyboard.NUMBER_1)
         {
            for (var i:int = 0; i < 993; i++) {
				m[i].material.blendMode = BlendMode.SCREEN;
			}
         }
		 if(e.keyCode == Keyboard.NUMBER_2)
         {
            for (var i:int = 0; i < 993; i++) {
				m[i].material.blendMode = BlendMode.SHADER;
			}
         }
		 if(e.keyCode == Keyboard.NUMBER_3)
         {
            for (var i:int = 0; i < 993; i++) {
				m[i].material.blendMode = BlendMode.SUBTRACT;
			}
         }
		 if(e.keyCode == Keyboard.NUMBER_4)
         {
            for (var i:int = 0; i < 993; i++) {
				m[i].material.blendMode = BlendMode.DIFFERENCE;
			}
         }
		 if(e.keyCode == Keyboard.NUMBER_5)
         {
            for (var i:int = 0; i < 993; i++) {
				m[i].material.blendMode = BlendMode.ERASE;
			}
         }
		 if(e.keyCode == Keyboard.NUMBER_6)
         {
            for (var i:int = 0; i < 993; i++) {
				m[i].material.blendMode = BlendMode.HARDLIGHT;
			}
         }
		 if(e.keyCode == Keyboard.NUMBER_7)
         {
            for (var i:int = 0; i < 993; i++) {
				m[i].material.blendMode = BlendMode.LAYER;
			}
         }
		 if(e.keyCode == Keyboard.NUMBER_8)
         {
            for (var i:int = 0; i < 993; i++) {
				m[i].material.blendMode = BlendMode.LIGHTEN;
			}
         }
		 if(e.keyCode == Keyboard.NUMBER_9)
         {
            for (var i:int = 0; i < 993; i++) {
				m[i].material.blendMode = BlendMode.MULTIPLY;
			}
         }
		 if(e.keyCode == Keyboard.NUMBER_0)
         {
            for (var i:int = 0; i < 993; i++) {
				m[i].material.blendMode = BlendMode.OVERLAY;
			}
         }
		 */
      }
      
      public function isTankNorm() : Boolean
      {
         return Boolean(this.tanks[0].vis) && !this.tanks[0].exp;
      }
      
      public function toggleCameraController() : void
      {
		  /*
         if(this.followCameraController == null)
         {
            this.setFollowCamera(this.followTank);
         }
         else
         {
            this.setFreeCamera();
         }
		 */
      }
      
      public function setFreeCamera() : void
      {
		 /*
         var _loc1_:Tank = null;
         for each(_loc1_ in this.tanks)
         {
            _loc1_.cameraController = null;
         }
         this.freeCameraController.disable();
         this.freeCameraController = new SimpleObjectController(this.stage,this.camera,1000);
         this.followCameraController = null;
         this.followTank.cameraController = null;
         this.followTank = null;
		 */
      }
      
      public function setFollowCamera(param1:Tank) : void
      {
		  /*
         var _loc2_:Tank = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in this.tanks)
         {
            _loc2_.setControllerEnabled(false);
            _loc2_.cameraController = null;
         }
         param1.setControllerEnabled(true);
         param1.cameraController = new FollowCameraController(1 << 4,param1);
         param1.cameraController.setLocked(false);
         param1.cameraController.onAddToGame(this);
         this.followCameraController = param1.cameraController;
         this.followTank = param1;
		 */
      }
      
      private function togglePhysics() : void
      {
		  /*
         this.doPhysics = !this.doPhysics;
         if(this.doPhysics)
         {
            this.world.time = getTimer();
         }
		 */
      }
      
      public function addBonus(param1:Number, param2:int, param3:Vector3) : void
      {
		  /*
         var _loc4_:Bonus = new Bonus(param1,param2);
         _loc4_.addToWorld(this.world,this.rootContainer,param3);
         this.bonuses.push(_loc4_);
		 */
      }
	  
	  public function adddBonus(param1:Number, param2:int, param3:Vector3) : void
      {
		  /*
         var _loc4_:Bonus = new Bonus(param1,param2);
         _loc4_.addToWorld(this.world,this.rootContainer,param3);
         this.bonuses.push(_loc4_);
		 _loc4_.state = Bonus.STATE_DROPPED;
		 */
      }
      /*
      public function removeBonus(param1:Bonus) : void
      {
         var _loc2_:Number = 0;
         while(_loc2_ < this.bonuses.length)
         {
            if(this.bonuses[_loc2_] == param1)
            {
               this.bonuses.splice(_loc2_,1);
               param1.removeFromWorld();
               return;
            }
            _loc2_++;
         }
      }
	  */
      
      private function toggleRender() : void
      {
         this.doRender = !this.doRender;
      }
   }
}
