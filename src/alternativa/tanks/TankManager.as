package alternativa.tanks
{
   import alternativa.tanks.tank.TankHull;
   import alternativa.tanks.tank.TankTurret;
   import alternativa.tanks.tank.TankWeaponProfile;
   import alternativa.tanks.tank.BattleTeamType;
   import alternativa.tanks.tank.Tank;
   import alternativa.tanks.resources.TanksLib;
   import alternativa.tanks.tank.weapon.Weapon;
   import alternativa.tanks.tank.weapon.Smoky;
   import alternativa.tanks.tank.weapon.Flamethrower;
   import alternativa.tanks.tank.weapon.PlasmaGun;
   import alternativa.tanks.tank.weapon.RailGun;
   //import alternativa.tanks.tank.weapon.Isida;
   import alternativa.tanks.tank.SpawnPoint;
   import alternativa.math.Vector3;
   import alternativa.math.Quaternion;
   import alternativa.tanks.tank.title.UserTitle;
   
   public class TankManager
   {
       
      private var profiles:Vector.<TankWeaponProfile>;
      
      public var CurrTeamType:BattleTeamType;
      
      private var currTurretNum:int = 0;
      
      private var currHullNum:int = 0;
      
      private var currColormapNum:int = 0;
      
      private var currProfile:int = 0;
      
      private var turretMax:int;
      
      private var hullMax:int;
      
      private var colormapMax:int;
      
      private var numProfiles:int;
      
      public function TankManager()
      {
         this.profiles = new Vector.<TankWeaponProfile>();
         this.CurrTeamType = BattleTeamType.NONE;
         super();
         var _loc1_:XML = Game.getInstance().config.xml;
         this.turretMax = _loc1_.turrets[0].child("turret").length();
         this.hullMax = _loc1_.hulls[0].child("hull").length();
         this.colormapMax = _loc1_.colormaps[0].child("colormap").length();
         this.numProfiles = 5;
      }
      
      public function ratherTurrets(param1:int) : void
      {
         this.currTurretNum = this.currTurretNum + param1;
         if(this.currTurretNum < 0)
         {
            this.currTurretNum = this.turretMax - 1;
         }
         if(this.currTurretNum >= this.turretMax)
         {
            this.currTurretNum = 0;
         }
         this.refreshTank();
      }
      
      public function ratherHulls(param1:int) : void
      {
         this.currHullNum = this.currHullNum + param1;
         if(this.currHullNum < 0)
         {
            this.currHullNum = this.hullMax - 1;
         }
         if(this.currHullNum >= this.hullMax)
         {
            this.currHullNum = 0;
         }
         this.refreshTank();
      }
      
      public function ratherColormaps(param1:int) : void
      {
         this.currColormapNum = this.currColormapNum + param1;
         if(this.currColormapNum < 0)
         {
            this.currColormapNum = this.colormapMax - 1;
         }
         if(this.currColormapNum >= this.colormapMax)
         {
            this.currColormapNum = 0;
         }
         this.refreshTank();
      }
      
      public function ratherProfiles(param1:int) : void
      {
         this.currProfile = this.currProfile + param1;
         if(this.currProfile < 0)
         {
            this.currProfile = this.numProfiles - 1;
         }
         if(this.currProfile >= this.numProfiles)
         {
            this.currProfile = 0;
         }
         this.refreshTank();
      }
      
      private function refreshTank() : void
      {
         var _loc1_:Tank = Game.getInstance().tanks[0];
         if(_loc1_ == null)
         {
            return;
         }
         try
         {
            _loc1_.weapon.stop();
            _loc1_.weapon = null;
         }
         catch(e:Error)
         {
         }
         _loc1_.setWeapon(this.getWeaponByNum(this.currProfile,"m0"));
         _loc1_.setTank(Main.instance.game.tankslib.turrets[this.currTurretNum].clone(),Main.instance.game.tankslib.hulls[this.currHullNum].clone(),Main.instance.game.tankslib.colormaps[this.currColormapNum].clone());
      }
      
      public function loadWeaponProfiles(param1:XML) : void
      {
         this.loadWeaponProfiles2("smoky",param1.child("smoky"));
         this.loadWeaponProfiles2("flamethrower",param1.child("flamethrower"));
         this.loadWeaponProfiles2("twins",param1.child("twins"));
         this.loadWeaponProfiles2("railgun",param1.child("railgun"));
         this.loadWeaponProfiles2("isida",param1.child("isida"));
      }
      
      private function loadWeaponProfiles2(param1:String, param2:XMLList) : void
      {
         var _loc3_:XML = null;
         var _loc4_:TankWeaponProfile = null;
         for each(_loc3_ in param2.elements("profile"))
         {
            _loc4_ = new TankWeaponProfile();
            _loc4_.weaponName = param1;
            _loc4_.id = _loc3_.@id;
            this.profiles.push(_loc4_);
         }
      }
      
      public function getNextWeapon() : Weapon
      {
         var _loc2_:Weapon = null;
         this.currProfile++;
         if(this.currProfile >= this.profiles.length)
         {
            this.currProfile = 0;
         }
         var _loc1_:TankWeaponProfile = this.profiles[this.currProfile];
         if(_loc1_.weaponName == "smoky")
         {
            _loc2_ = new Smoky();
         }
		 
		 if(_loc1_.weaponName == "twins")
         {
            _loc2_ = new PlasmaGun();
         }
		 
		 if(_loc1_.weaponName == "flamethrower")
         {
            _loc2_ = new Flamethrower();
         }
		 
		 if(_loc1_.weaponName == "railgun")
         {
            _loc2_ = new RailGun();
         }
		 /*
		 
         if(_loc1_.weaponName == "isida")
         {
            _loc2_ = new Isida();
         }
		 */
         this.loadTankWeaponProfile(_loc2_,_loc1_.weaponName,_loc1_.id);
         return _loc2_;
      }
      
      public function getWeapon(param1:Number) : Weapon
      {
         this.currProfile = param1 - 1;
         return this.getNextWeapon();
      }
	  
      
      private function uploadTank(param1:Tank) : void
      {
         param1.addToContainer(Main.instance.game.container);
         param1.updateTankParts();
         param1.weapon.tankLoaded();
      }
      
      public function addTankToWorld(param1:Tank) : void
      {
         param1.addToGame(Game.getInstance());
         this.respawn(param1,param1.TEAM);
      }
      
      public function respawn(param1:Tank, param2:BattleTeamType) : void
      {
         param1.vis = false;
         param1.TIME_UNVIS = 5000;
         //var _loc3_:SpawnPoint = Game.getInstance().spawnPointsManager.getSpawn(param2);
         //param1.chassis.state.velocity = new Vector3();
         //param1.chassis.state.rotation = new Vector3();
         //param1.chassis.state.pos = _loc3_.pos.vClone();
         param1.x = 0;
		 param1.y = 0;
		 param1.z = 0;
         param1.turretDirection = 0;
         param1.weapon.reset();
         param1.sendPos();
      }
      
      private function disposeTank(param1:Tank) : void
      {
      }
      
      public function createTank(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:String, param8:int, param9:BattleTeamType, param10:int, param11:String, param12:int, param13:Number) : void
      {
         var _loc15_:* = 0;
         var _loc14_:XML = Game.getInstance().config.xml.tanks[0];
         if(param8 == 0)
         {
            _loc15_ = UserTitle.BIT_HEALTH | UserTitle.BIT_WEAPON | UserTitle.BIT_EFFECTS;
         }
         if(param8 == 1)
         {
            _loc15_ = UserTitle.BIT_LABEL | UserTitle.BIT_HEALTH | UserTitle.BIT_EFFECTS;
         }
         if(param8 == 2)
         {
            _loc15_ = UserTitle.BIT_LABEL | UserTitle.BIT_EFFECTS;
         }
         var _loc16_:Tank = new Tank(this.uploadTank, this.disposeTank, _loc15_, param10 + 1, param11, param9, param8 != 0, param12, param13);
		 Game.getInstance().tanks.push(_loc16_);
		 _loc16_.contrt = new TankController(_loc16_);
		 _loc16_.setWeapon(this.getWeaponByNum(param6, param7));
         if(param2 < 0)
         {
            param2 = 0;
         }
         if(param4 < 0)
         {
            param4 = 0;
         }
         _loc16_.setTank(Main.instance.game.tankslib.turrets[param1 * 4 + param2].clone(), Main.instance.game.tankslib.hulls[param3 * 4 + param4].clone(), Main.instance.game.tankslib.colormaps[param5].clone());
      }
      
      public function addTank() : void
      {
      }
      
      public function removeTank(param1:Tank) : void
      {
         var _loc2_:Game = Game.getInstance();
         param1.removeFromContainer();
         param1.removeFromGame(_loc2_);
         //param1.removeEventListener(MouseEvent3D.CLICK,this.mu3d);
      }
      
      //private function mu3d(param1:MouseEvent3D) : void
      //{
        // var _loc2_:Mesh = param1.target as Mesh;
         //if(_loc2_ == null)
         //{
            //return;
         //}
         //Game.getInstance().setFollowCamera(_loc2_.parent as Tank);
      //}
      
      public function getWeaponByNum(param1:int, param2:String) : Weapon
      {
         var _loc3_:Weapon = null;
         var _loc4_:String = "";
         if(param1 == 0)
         {
            _loc4_ = "smoky";
            _loc3_ = new Smoky();
         }
		 
		 if(param1 == 1)
         {
            _loc4_ = "flamethrower";
            _loc3_ = new Flamethrower();
         }
		 
		 if(param1 == 2)
         {
            _loc4_ = "twins";
            _loc3_ = new PlasmaGun();
         }
		 
		 if(param1 == 3)
         {
            _loc4_ = "railgun";
            _loc3_ = new RailGun();
         }
		 /*
		 
         if(param1 == 4)
         {
            _loc4_ = "isida";
            _loc3_ = new Isida();
         }
		 */
         this.loadTankWeaponProfile(_loc3_,_loc4_,param2);
         return _loc3_;
      }
      
      public function loadTankWeaponProfile(param1:Weapon, param2:String, param3:String) : void
      {
         var _loc4_:XML = null;
         for each(_loc4_ in Game.getInstance().config.xml.child("weapons").child(param2).elements("profile"))
         {
            if(_loc4_.@id == param3)
            {
               param1.loadProfile(_loc4_);
               return;
            }
         }
      }
   }
}
