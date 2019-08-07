package alternativa.tanks.tank.controllers
{
   import alternativa.tanks.tank.Tank;
   import flash.display.DisplayObject;
   import flash.events.KeyboardEvent;
   import flash.display.DisplayObjectContainer;
   import flash.ui.Keyboard;
   
   public class SimpleTankController
   {
      
      private static const MAX_TURRET_SPEED_DIVISOR:Number = 15;
      
      private static const MIN_TURRET_SPEED_DIVISOR:Number = 1;
      
      private static const MAX_TURRET_UPDATE_TIME:Number = 1;
       
      private var tank:Tank;
      
      private var turretSpeedDivisor:int = 15;
      
      private var turretRotateDirection:int = 0;
      
      private var turretUpdateTime:Number = 1;
      
      public var maxTurretSpeed:Number = 1;
      
      private var moveDir:int = 0;
      
      private var rotateDir:int = 0;
      
      private var turretLeft:uint;
      
      private var turretRight:uint;
      
      private var up:uint;
      
      private var down:uint;
      
      private var left:uint;
      
      private var right:uint;
      
      private var space:uint;
      
      private var turretLeft2:uint;
      
      private var turretRight2:uint;
      
      private var up2:uint;
      
      private var down2:uint;
      
      private var left2:uint;
      
      private var right2:uint;
      
      private var space2:uint;
      
      private var _enabled:Boolean = true;
      
      private var enemy:Boolean = false;
      
      private var prevKey:int = -1;
      
      private var prevKeyIsUp:Boolean = false;
      
      private var stage:DisplayObject;
      
      public var f:Boolean = true;
      
      public function SimpleTankController(param1:DisplayObjectContainer, param2:Tank)
      {
         super();
         this.tank = param2;
         this.stage = Main.instance.stage;
         Main.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.kd);
         Main.instance.stage.addEventListener(KeyboardEvent.KEY_UP,this.ku);
         this.setKeys(Keyboard.Z,Keyboard.X,Keyboard.UP,Keyboard.DOWN,Keyboard.LEFT,Keyboard.RIGHT,Keyboard.SPACE);
         this.setKeys2(188,190,Keyboard.W,Keyboard.S,Keyboard.A,Keyboard.D,Keyboard.SPACE);
      }
      
      private function getRot() : int
      {
         if(this.turretRotateDirection < 0)
         {
            return -1;
         }
         if(this.turretRotateDirection > 0)
         {
            return 1;
         }
         return 0;
      }
      
      public function getControlsToSend() : String
      {
         return this.getRot() + "@" + this.turretSpeedDivisor + "@" + this.tank.turretDirection + "@" + this.moveDir + "@" + this.rotateDir + "@" + (!!this.tank.weaponStarted?"1":"0");
      }
      
      public function setControls(param1:int, param2:int, param3:Number, param4:int, param5:int, param6:String) : void
      {
         this.turretRotateDirection = param1 * Math.PI;
         this.turretSpeedDivisor = param2;
         this.tank.turretDirection = param3;
         this.moveDir = param4;
         this.rotateDir = param5;
         this.tank.weaponStarted = param6 == "1";
         //if(this.tank.weaponStarted)
         //{
            //this.tank.weapon.start();
         //}
        // else
         //{
            //this.tank.weapon.stop();
         //}
      }
      
      public function setFire(param1:Boolean) : void
      {
         this.f = param1;
      }
      
      public function setEnabled(param1:Boolean, param2:Boolean = false) : void
      {
         if(this.tank.exp)
         {
            return;
         }
         this.enemy = param2;
         this._enabled = param1;
         if(!param1)
         {
            this.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.kd);
            this.stage.removeEventListener(KeyboardEvent.KEY_UP,this.ku);
            this.tank.weaponStarted = false;
            //this.tank.weapon.stop();
         }
         else if(!param2)
         {
            this.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.kd);
            this.stage.addEventListener(KeyboardEvent.KEY_UP,this.ku);
         }
         else
         {
            this.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.kd);
            this.stage.removeEventListener(KeyboardEvent.KEY_UP,this.ku);
         }
      }
      
      public function getEnabled() : Boolean
      {
         return this._enabled;
      }
      
      public function setKeys(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : void
      {
         this.turretLeft = param1;
         this.turretRight = param2;
         this.up = param3;
         this.down = param4;
         this.left = param5;
         this.right = param6;
         this.space = param7;
      }
      
      public function setKeys2(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : void
      {
         this.turretLeft2 = param1;
         this.turretRight2 = param2;
         this.up2 = param3;
         this.down2 = param4;
         this.left2 = param5;
         this.right2 = param6;
         this.space2 = param7;
      }
      
      public function stopAll() : void
      {
         this.turretRotateDirection = 0;
         this.turretSpeedDivisor = MAX_TURRET_SPEED_DIVISOR;
         this.moveDir = 0;
         this.rotateDir = 0;
         this.tank.weaponStarted = false;
         //this.tank.weapon.stop();
         if(this.moveDir == -1)
         {
           // this.tank.chassis.setControls(this.moveDir,-this.rotateDir,false);
         }
         else
         {
            //this.tank.chassis.setControls(this.moveDir,this.rotateDir,false);
         }
      }
      
      public function setControl(param1:int, param2:Boolean) : void
      {
         if(param2)
         {
            this.ku(new KeyboardEvent(KeyboardEvent.KEY_UP,true,false,0,param1),true);
         }
         else
         {
            this.kd(new KeyboardEvent(KeyboardEvent.KEY_DOWN,true,false,0,param1),true);
         }
      }
      
      private function ku(param1:KeyboardEvent, param2:Boolean = false) : void
      {
         if(this._enabled)
         {
            this.prevKey = param1.keyCode;
            this.prevKeyIsUp = true;
            if(this.prevKey == this.turretLeft || this.prevKey == this.turretRight || this.prevKey == this.turretLeft2 || this.prevKey == this.turretRight2)
            {
               this.turretRotateDirection = 0;
               this.turretSpeedDivisor = MAX_TURRET_SPEED_DIVISOR;
               if(!param2)
               {
                  this.tank.sendPos();
               }
               return;
            }
            if(this.prevKey == this.up || this.prevKey == this.down || this.prevKey == this.up2 || this.prevKey == this.down2)
            {
               this.moveDir = 0;
               if(!param2)
               {
                  this.tank.sendPos();
               }
               return;
            }
            if(this.prevKey == this.left || this.prevKey == this.right || this.prevKey == this.left2 || this.prevKey == this.right2)
            {
               this.rotateDir = 0;
               if(!param2)
               {
                  this.tank.sendPos();
               }
               return;
            }
            if(this.prevKey == this.space || this.prevKey == this.space2)
            {
               this.tank.weaponStarted = false;
               //this.tank.weapon.stop();
               if(!param2)
               {
                  this.tank.sendPos();
               }
               return;
            }
         }
      }
      
      private function kd(param1:KeyboardEvent, param2:Boolean = false) : void
      {
		  //throw new Error("");
         if(this._enabled)
         {
            if(param1.keyCode == this.prevKey && !this.prevKeyIsUp)
            {
               return;
            }
            this.prevKey = param1.keyCode;
            this.prevKeyIsUp = false;
            if(this.prevKey == this.turretLeft || this.prevKey == this.turretLeft2)
            {
               this.turretRotateDirection = Math.PI;
			   //throw new Error("");
               if(!param2)
               {
                  this.tank.sendPos();
               }
               return;
            }
            if(this.prevKey == this.turretRight || this.prevKey == this.turretRight2)
            {
               this.turretRotateDirection = -Math.PI;
               if(!param2)
               {
                  this.tank.sendPos();
               }
               return;
            }
            if(this.prevKey == this.up || this.prevKey == this.up2)
            {
               this.moveDir = 1;
               if(!param2)
               {
                  this.tank.sendPos();
               }
               return;
            }
            if(this.prevKey == this.down || this.prevKey == this.down2)
            {
               this.moveDir = -1;
               if(!param2)
               {
                  this.tank.sendPos();
               }
               return;
            }
            if(this.prevKey == this.left || this.prevKey == this.left2)
            {
               this.rotateDir = -1;
               if(!param2)
               {
                  this.tank.sendPos();
               }
               return;
            }
            if(this.prevKey == this.right || this.prevKey == this.right2)
            {
               this.rotateDir = 1;
               if(!param2)
               {
                  this.tank.sendPos();
               }
               return;
            }
            if((this.prevKey == this.space || this.prevKey == this.space2) && Boolean(this.f))
            {
               this.tank.weaponStarted = true;
               //this.tank.weapon.start();
               if(!param2)
               {
                  this.tank.sendPos();
               }
               return;
            }
         }
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(Boolean(this._enabled) || Boolean(this.enemy))
         {
			 //throw new Error("");
            param1 = param1 * 100;
            if(Boolean(this.tank.isUploaded) && !this.tank.isLoading)
            {
				//throw new Error("");
               this.turretUpdateTime = this.turretUpdateTime - param1;
               if(this.turretUpdateTime <= 0)
               {
				  // throw new Error("");
                  if(this.turretRotateDirection != 0)
                  {
					  //throw new Error("");
                     this.turretSpeedDivisor = this.turretSpeedDivisor - 1;
                     if(this.turretSpeedDivisor < MIN_TURRET_SPEED_DIVISOR)
                     {
                        this.turretSpeedDivisor = MIN_TURRET_SPEED_DIVISOR;
                     }
                     _loc2_ = this.maxTurretSpeed / this.turretSpeedDivisor * this.turretRotateDirection;
                     _loc2_ = _loc2_ * (Math.PI / 180);
                     this.tank.turretDirection = this.tank.turretDirection + _loc2_;
                  }
                  this.turretUpdateTime = MAX_TURRET_UPDATE_TIME;
               }
               if(this.moveDir == -1)
               {
                  //this.tank.chassis.setControls(this.moveDir,-this.rotateDir,false);
               }
               else
               {
                  //this.tank.chassis.setControls(this.moveDir,this.rotateDir,false);
               }
            }
         }
      }
   }
}
