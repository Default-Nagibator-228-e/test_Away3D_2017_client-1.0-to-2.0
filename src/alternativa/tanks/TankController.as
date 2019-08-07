package alternativa.tanks
{
	import alternativa.tanks.tank.Tank;
	import away3d.cameras.Camera3D;
	import away3d.containers.View3D;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;

	public class TankController 
	{
		
		private var _move:Boolean = false;
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastMouseX:Number;
		private var _lastMouseY:Number;
		private var move:int = 10;
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
		private var prevKeyu:int = -1;
		private var prevKeyd:int = -1;
		private var pprevKeyu:int = -1;
		private var pprevKeyd:int = -1;
		private var ext:Boolean = false;
		private var ext1:Boolean = false;
		private static const MAX_TURRET_SPEED_DIVISOR:Number = 15;
		private static const MIN_TURRET_SPEED_DIVISOR:Number = 1;
		private static const MAX_TURRET_UPDATE_TIME:Number = 1;
		private var tank:Tank;
		private var turretSpeedDivisor:int = 15;
		private var turretRotateDirection:int = 0;
		private var turretUpdateTime:Number = 1;
		public var maxTurretSpeed:Number = 10;
		private var fh:Number = Math.PI / 180;
		private var prevKeyIsUp:Boolean = false;
		
		public function TankController(param1:Tank) 
		{
			tank = param1;
			if (param1 == Main.instance.game.tanks[0])
			{
				Main.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
				Main.instance.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			}
			setKeys(Keyboard.Z,Keyboard.X,Keyboard.UP,Keyboard.DOWN,Keyboard.LEFT,Keyboard.RIGHT,Keyboard.SPACE);
			setKeys2(188,190,Keyboard.W,Keyboard.S,Keyboard.A,Keyboard.D,Keyboard.SPACE);
		}
		
		public function getControlsToSend() : String
		{
			return this.prevKeyd + "@" + this.prevKeyu;
		}
		
		public function setControl(param1:int, param2:int) : void
		{
			pprevKeyd = param1;
			pprevKeyu = param2;
		}
		
		private function setKeys(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : void
		{
			turretLeft = param1;
			turretRight = param2;
			up = param3;
			down = param4;
			left = param5;
			right = param6;
			space = param7;
		}
      
		private function setKeys2(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : void
		  {
			 turretLeft2 = param1;
			 turretRight2 = param2;
			 up2 = param3;
			 down2 = param4;
			 left2 = param5;
			 right2 = param6;
			 space2 = param7;
		  }
		
		public function update():void
		{
			var _loc2_:Number = NaN;
			var param1:int = 0;
			param1 = param1 * 100;
			//keyDownHandler(null,pprevKeyd);
			//keyUpHandler(null,pprevKeyu);
			if(Boolean(this.tank.isUploaded) && !this.tank.isLoading)
			{
				this.turretUpdateTime = this.turretUpdateTime - param1;
				//if(this.turretUpdateTime <= 0)
				//{
					if(this.turretRotateDirection != 0)
					{
						//throw new Error("");
						this.turretSpeedDivisor = this.turretSpeedDivisor - 1;
						if(this.turretSpeedDivisor < MIN_TURRET_SPEED_DIVISOR)
						{
							this.turretSpeedDivisor = MIN_TURRET_SPEED_DIVISOR;
						}
						_loc2_ = this.maxTurretSpeed / this.turretSpeedDivisor * this.turretRotateDirection;
						_loc2_ = _loc2_ * fh;
						this.tank.turretDirection = this.tank.turretDirection + _loc2_;
					}
					this.turretUpdateTime = MAX_TURRET_UPDATE_TIME;
				//}
			}
			if (ext)
			{
				if (tank.carBody.linearVelocity.length < 1)
				{
					ext = false;
					tank._engineForce = 20000;
					tank._engineForce1 = 20000;
					tank._breakingForce = 0;
					tank._breakingForce1 = 0;
				}
			}
			
			if (ext1)
			{
				if (tank.carBody.linearVelocity.length < 1)
				{
					ext1 = false;
					tank._engineForce = -20000;
					tank._engineForce1 = -20000;
					tank._breakingForce = 0;
					tank._breakingForce1 = 0;
				}
			}
		}
		
		private function keyDownHandler(event : KeyboardEvent,param1:int = 0) : void {
				if (event != null)
				{
					if(event.keyCode == this.prevKeyd && !this.prevKeyIsUp)
					{
					   return;
					}
					this.prevKeyd = event.keyCode;
				}
			this.prevKeyIsUp = false;
			if(this.prevKeyd == this.turretLeft || this.prevKeyd == this.turretLeft2)
            {
               this.turretRotateDirection = -Math.PI;
               this.tank.sendPos();
               return;
            }
            if(this.prevKeyd == this.turretRight || this.prevKeyd == this.turretRight2)
            {
               this.turretRotateDirection = Math.PI;
               this.tank.sendPos();
               return;
            }
			if(this.prevKeyd == this.up || this.prevKeyd == this.up2)
            {
				//tank._engineForce = 20000;
				//tank._engineForce1 = 20000;
				if (tank._breakingForce > 0)
				{
					//throw new Error("");
					tank._breakingForce = 145000;
					tank._breakingForce1 = 145000;
					ext = true;
				}else{
					tank._engineForce = 20000;
					tank._engineForce1 = 20000;
					tank._breakingForce = 0;
					tank._breakingForce1 = 0;
				}
				this.tank.sendPos();
			}
			if(this.prevKeyd == this.down || this.prevKeyd == this.down2)
            {
				if (tank._breakingForce > 0)
				{
					//throw new Error("");
					tank._breakingForce = 145000;
					tank._breakingForce1 = 145000;
					ext1 = true;
				}else{
					tank._engineForce = -20000;
					tank._engineForce1 = -20000;
					tank._breakingForce = 0;
					tank._breakingForce1 = 0;
				}
				this.tank.sendPos();
			}
			if(this.prevKeyd == this.left || this.prevKeyd == this.left2)
            {
				if (tank._engineForce != 0)
				{
					tank.keyLeft = true;
				}
				if (tank._engineForce1 == 0 && tank._engineForce == 0) {
					tank._engineForce1 = 80000;
					tank._breakingForce = 2500;
				}
				this.tank.sendPos();
			}
			if(this.prevKeyd == this.right || this.prevKeyd == this.right2)
            {
				if (tank._engineForce1 != 0)
				{
					tank.keyRight = true;
				}
				if (tank._engineForce == 0 && tank._engineForce1 == 0) {
					tank._engineForce = 80000;
					tank._breakingForce1 = 2500;
				}
				this.tank.sendPos();
			}
			if(this.prevKeyd == this.space || this.prevKeyd == this.space2)
            {
				tank.weapon.start();
				this.tank.sendPos();
			}
		}
		
		private function keyUpHandler(event : KeyboardEvent,param1:int = 0) : void {
			if (event != null)
			{
				this.prevKeyu = event.keyCode;
			}
			//Main.instance.game.fpsLabel.text = "" + this.prevKeyu;
			this.prevKeyIsUp = true;
			if(this.prevKeyu == this.turretLeft || this.prevKeyu == this.turretRight || this.prevKeyu == this.turretLeft2 || this.prevKeyu == this.turretRight2)
            {
               this.turretRotateDirection = 0;
               this.turretSpeedDivisor = MAX_TURRET_SPEED_DIVISOR;
               this.tank.sendPos();
               return;
            }
			if(this.prevKeyu == this.up || this.prevKeyu == this.up2)
            {
				tank._engineForce = 0;
				tank._engineForce1 = 0;
				tank._breakingForce = 45000;
				tank._breakingForce1 = 45000;
				this.tank.sendPos();
				return;
            }
			if(this.prevKeyu == this.down || this.prevKeyu == this.down2)
            {
				tank._engineForce = 0;
				tank._engineForce1 = 0;
				tank._breakingForce = 45000;
				tank._breakingForce1 = 45000;
				this.tank.sendPos();
				return;
            }
            if(this.prevKeyu == this.left || this.prevKeyu == this.left2)
            {
				//if (tank._engineForce != 0 && tank._engineForce1 != 0)
				//{
					tank.keyLeft = false;
				//}
				if (tank._engineForce == 0)
				{
					tank._engineForce1 = 0;
				}
				tank._breakingForce = 0;
				this.tank.sendPos();
				return;
            }
			if(this.prevKeyu == this.right || this.prevKeyu == this.right2)
            {
				//if (tank._engineForce != 0 && tank._engineForce1 != 0)
				//{
					tank.keyRight = false;
				//}
				if (tank._engineForce1 == 0)
				{
					tank._engineForce = 0;
				}
				tank._breakingForce1 = 0;
				this.tank.sendPos();
				return;
            }
            if(this.prevKeyu == this.space || this.prevKeyu == this.space2)
            {
				tank.weapon.stop();
				this.tank.sendPos();
               return;
            }
		}
	}
}