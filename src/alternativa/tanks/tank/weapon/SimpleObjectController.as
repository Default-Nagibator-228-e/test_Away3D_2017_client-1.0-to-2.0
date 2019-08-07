package alternativa.tanks.tank.weapon
{
   import away3d.cameras.Camera3D;
   import away3d.containers.ObjectContainer3D;
   import flash.display.InteractiveObject;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import flash.ui.Keyboard;
   import flash.utils.getTimer;
   
   public class SimpleObjectController
   {
      
      public static const ACTION_PITCH_UP:String = "ACTION_PITCH_UP";
      
      public static const ACTION_UP:String = "ACTION_UP";
      
      public static const ACTION_MOUSE_LOOK:String = "ACTION_MOUSE_LOOK";
      
      public static const ACTION_PITCH_DOWN:String = "ACTION_PITCH_DOWN";
      
      public static const ACTION_DOWN:String = "ACTION_DOWN";
      
      public static const ACTION_YAW_LEFT:String = "ACTION_YAW_LEFT";
      
      public static const ACTION_LEFT:String = "ACTION_LEFT";
      
      public static const ACTION_YAW_RIGHT:String = "ACTION_YAW_RIGHT";
      
      public static const ACTION_RIGHT:String = "ACTION_RIGHT";
      
      public static const ACTION_BACK:String = "ACTION_BACK";
      
      public static const ACTION_FORWARD:String = "ACTION_FORWARD";
      
      public static const ACTION_ACCELERATE:String = "ACTION_ACCELERATE";
       
      
      private var _down:Boolean;
      
      private var _forward:Boolean;
      
      protected var keyBindings:Object;
      
      private var _vout:Vector.<Number>;
      
      public var minPitch:Number = -1.0E22;
      
      private var displacement:Vector3D;
      
      private var _right:Boolean;
      
      private var desiredRotation:Vector3D;
      
      private var _up:Boolean;
      
      public var maxPitch:Number = 1.0E22;
      
      private var idleTime:Number = 0;
      
      private var _back:Boolean;
      
      public var speed:Number;
      
      private var time:int;
      
      public var mouseSensitivity:Number;
      
      private var eventSource:InteractiveObject;
      
      private var desiredCoords:Vector3D;
      
      private var _vin:Vector.<Number>;
      
      private var _object:ObjectContainer3D;
      
      private var mouseLook:Boolean;
      
      private var _left:Boolean;
      
      public var speedMultiplier:Number;
      
      private var mousePoint:Point;
      
      private var objectTransform:Vector.<Vector3D>;
      
      public var smoothingDelay:Number = 0;
      
      private var actionBindings:Object;
      
      private var _accelerate:Boolean;
      
      public function SimpleObjectController(param1:InteractiveObject, param2:ObjectContainer3D, param3:Number, param4:Number = 3, param5:Number = 1)
      {
         this.desiredCoords = new Vector3D();
         this.desiredRotation = new Vector3D();
         this.displacement = new Vector3D();
         this.mousePoint = new Point();
         this.actionBindings = {};
         this.keyBindings = {};
         this._vin = new Vector.<Number>(3);
         this._vout = new Vector.<Number>(3);
         super();
         this.eventSource = param1;
         this.object = param2;
         this.speed = param3;
         this.speedMultiplier = param4;
         this.mouseSensitivity = param5;
         this.actionBindings[ACTION_FORWARD] = this.moveForward;
         this.actionBindings[ACTION_BACK] = this.moveBack;
         this.actionBindings[ACTION_LEFT] = this.moveLeft;
         this.actionBindings[ACTION_RIGHT] = this.moveRight;
         this.actionBindings[ACTION_UP] = this.moveUp;
         this.actionBindings[ACTION_DOWN] = this.moveDown;
         this.actionBindings[ACTION_ACCELERATE] = this.accelerate;
         this.setDefaultBindings();
         this.enable();
      }
      
      private function onKey(param1:KeyboardEvent) : void
      {
         var _loc2_:Function = this.keyBindings[param1.keyCode];
         if(_loc2_ != null)
         {
            _loc2_.call(this,param1.type == KeyboardEvent.KEY_DOWN);
         }
      }
      
      public function enable() : void
      {
         this.eventSource.addEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
         this.eventSource.addEventListener(KeyboardEvent.KEY_UP,this.onKey);
         this.eventSource.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.eventSource.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      public function lookAtXYZ(param1:Number, param2:Number, param3:Number) : void
      {
         if(this._object == null)
         {
            return;
         }
         var _loc4_:Vector3D = this.objectTransform[0];
         var _loc5_:Number = param1 - _loc4_.x;
         var _loc6_:Number = param2 - _loc4_.y;
         var _loc7_:Number = param3 - _loc4_.z;
         _loc4_ = this.objectTransform[1];
         _loc4_.x = Math.atan2(_loc7_,Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_));
         if(this._object is Camera3D)
         {
            _loc4_.x = _loc4_.x - 0.5 * Math.PI;
         }
         _loc4_.y = 0;
         _loc4_.z = -Math.atan2(_loc5_,_loc6_);
         this._object.rotationX = _loc4_.x;
         this._object.rotationY = _loc4_.y;
         this._object.rotationZ = _loc4_.z;
         this.desiredRotation.x = _loc4_.x;
         this.desiredRotation.y = _loc4_.y;
         this.desiredRotation.z = _loc4_.z;
         this.idleTime = 0;
      }
      
      public function moveLeft(param1:Boolean) : void
      {
         this._left = param1;
      }
      
      public function stopMouseLook() : void
      {
         this.mouseLook = false;
      }
      
      private function deltaTransformVector(param1:Vector3D) : void
      {
         this._vin[0] = param1.x;
         this._vin[1] = param1.y;
         this._vin[2] = param1.z;
         this._object.transform.transformVectors(this._vin,this._vout);
         var _loc2_:Vector3D = this.objectTransform[0];
         param1.x = this._vout[0] - _loc2_.x;
         param1.y = this._vout[1] - _loc2_.y;
         param1.z = this._vout[2] - _loc2_.z;
      }
      
      public function startMouseLook() : void
      {
         this.mousePoint.x = this.eventSource.mouseX;
         this.mousePoint.y = this.eventSource.mouseY;
         this.mouseLook = true;
      }
      
      public function setObjectPosXYZ(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:Vector3D = null;
         if(this._object != null)
         {
            _loc4_ = this.objectTransform[0];
            _loc4_.x = param1;
            _loc4_.y = param2;
            _loc4_.z = param3;
            this.desiredCoords.x = param1;
            this.desiredCoords.y = param2;
            this.desiredCoords.z = param3;
            this.idleTime = 0;
         }
      }
      
      public function moveDown(param1:Boolean) : void
      {
         this._down = param1;
      }
      
      public function setDefaultBindings() : void
      {
         this.bindKey(87,ACTION_FORWARD);
         this.bindKey(83,ACTION_BACK);
         this.bindKey(65,ACTION_LEFT);
         this.bindKey(68,ACTION_RIGHT);
         this.bindKey(69,ACTION_UP);
         this.bindKey(67,ACTION_DOWN);
         this.bindKey(Keyboard.SHIFT,ACTION_ACCELERATE);
         this.bindKey(Keyboard.UP,ACTION_FORWARD);
         this.bindKey(Keyboard.DOWN,ACTION_BACK);
         this.bindKey(Keyboard.LEFT,ACTION_LEFT);
         this.bindKey(Keyboard.RIGHT,ACTION_RIGHT);
      }
      
      public function lookAt(param1:Vector3D) : void
      {
         this.lookAtXYZ(param1.x,param1.y,param1.z);
      }
      
      public function moveForward(param1:Boolean) : void
      {
         this._forward = param1;
      }
      
      public function get object() : ObjectContainer3D
      {
         return this._object;
      }
      
      public function moveRight(param1:Boolean) : void
      {
         this._right = param1;
      }
      
      public function bindKeys(param1:Array) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this.bindKey(param1[_loc2_],param1[_loc2_ + 1]);
            _loc2_ = _loc2_ + 2;
         }
      }
      
      public function setObjectPos(param1:Vector3D) : void
      {
         var _loc2_:Vector3D = null;
         if(this._object != null)
         {
            _loc2_ = this.objectTransform[0];
            _loc2_.x = param1.x;
            _loc2_.y = param1.y;
            _loc2_.z = param1.z;
            this.desiredCoords.x = param1.x;
            this.desiredCoords.y = param1.y;
            this.desiredCoords.z = param1.z;
            this.idleTime = 0;
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         this.startMouseLook();
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         this.stopMouseLook();
      }
      
      public function moveUp(param1:Boolean) : void
      {
         this._up = param1;
      }
      
      public function accelerate(param1:Boolean) : void
      {
         this._accelerate = param1;
      }
      
      public function moveBack(param1:Boolean) : void
      {
         this._back = param1;
      }
      
      public function update() : void
      {
         var _loc3_:Vector3D = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(this._object == null)
         {
            return;
         }
         var _loc1_:Number = this.time;
         this.time = getTimer();
         _loc1_ = 0.001 * (this.time - _loc1_);
         if(_loc1_ > 0.1)
         {
            _loc1_ = 0.1;
         }
         var _loc2_:Boolean = false;
         if(this.mouseLook)
         {
            _loc4_ = this.eventSource.mouseX - this.mousePoint.x;
            _loc5_ = this.eventSource.mouseY - this.mousePoint.y;
            this.mousePoint.x = this.eventSource.mouseX;
            this.mousePoint.y = this.eventSource.mouseY;
            _loc3_ = this.smoothingDelay > 0?this.desiredRotation:this.objectTransform[1];
            _loc3_.x = _loc3_.x - _loc5_ * Math.PI / 180 * this.mouseSensitivity;
            if(_loc3_.x > this.maxPitch)
            {
               _loc3_.x = this.maxPitch;
            }
            if(_loc3_.x < this.minPitch)
            {
               _loc3_.x = this.minPitch;
            }
            _loc3_.z = _loc3_.z - _loc4_ * Math.PI / 180 * this.mouseSensitivity;
            this.idleTime = 0;
            _loc2_ = true;
         }
         this.displacement.x = !!this._right?Number(1):!!this._left?Number(-1):Number(0);
         this.displacement.y = !!this._forward?Number(1):!!this._back?Number(-1):Number(0);
         this.displacement.z = !!this._up?Number(1):!!this._down?Number(-1):Number(0);
         if(this.displacement.lengthSquared > 0)
         {
            if(this._object is Camera3D)
            {
               _loc6_ = this.displacement.z;
               this.displacement.z = this.displacement.y;
               this.displacement.y = -_loc6_;
            }
            this.deltaTransformVector(this.displacement);
            if(this._accelerate)
            {
               this.displacement.scaleBy(this.speedMultiplier * this.speed * _loc1_ / this.displacement.length);
            }
            else
            {
               this.displacement.scaleBy(this.speed * _loc1_ / this.displacement.length);
            }
            if(this.smoothingDelay <= 0)
            {
               (this.objectTransform[0] as Vector3D).incrementBy(this.displacement);
            }
            else
            {
               this.desiredCoords.incrementBy(this.displacement);
            }
            this.idleTime = 0;
            _loc2_ = true;
         }
         else
         {
            this.idleTime = this.idleTime + _loc1_;
         }
         if(this.smoothingDelay > 0 && this.idleTime <= 5 * this.smoothingDelay)
         {
            if(_loc1_ > this.smoothingDelay)
            {
               (this.objectTransform[0] as Vector3D).copyFrom(this.desiredCoords);
               (this.objectTransform[1] as Vector3D).copyFrom(this.desiredRotation);
            }
            else
            {
               _loc3_ = this.objectTransform[0];
               _loc3_.x = _loc3_.x + _loc1_ / this.smoothingDelay * (this.desiredCoords.x - _loc3_.x);
               _loc3_.y = _loc3_.y + _loc1_ / this.smoothingDelay * (this.desiredCoords.y - _loc3_.y);
               _loc3_.z = _loc3_.z + _loc1_ / this.smoothingDelay * (this.desiredCoords.z - _loc3_.z);
               _loc3_ = this.objectTransform[1];
               _loc3_.x = _loc3_.x + _loc1_ / this.smoothingDelay * (this.desiredRotation.x - _loc3_.x);
               _loc3_.y = _loc3_.y + _loc1_ / this.smoothingDelay * (this.desiredRotation.y - _loc3_.y);
               _loc3_.z = _loc3_.z + _loc1_ / this.smoothingDelay * (this.desiredRotation.z - _loc3_.z);
            }
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc3_ = this.objectTransform[1];
            this._object.rotationX = _loc3_.x;
            this._object.rotationY = _loc3_.y;
            this._object.rotationZ = _loc3_.z;
            _loc3_ = this.objectTransform[0];
            this._object.x = _loc3_.x;
            this._object.y = _loc3_.y;
            this._object.z = _loc3_.z;
         }
      }
      
      public function bindKey(param1:uint, param2:String) : void
      {
         var _loc3_:Function = this.actionBindings[param2];
         if(_loc3_ != null)
         {
            this.keyBindings[param1] = _loc3_;
         }
      }
      
      public function unbindAll() : void
      {
         var _loc1_:* = null;
         for(_loc1_ in this.keyBindings)
         {
            delete this.keyBindings[_loc1_];
         }
      }
      
      public function disable() : void
      {
         this.eventSource.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
         this.eventSource.removeEventListener(KeyboardEvent.KEY_UP,this.onKey);
         this.eventSource.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.eventSource.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this.stopMouseLook();
      }
      
      public function updateObjectTransform() : void
      {
         if(this._object != null)
         {
            this.objectTransform = this._object.transform.decompose();
            this.desiredCoords.copyFrom(this.objectTransform[0]);
            this.desiredRotation.copyFrom(this.objectTransform[1]);
            this.idleTime = 0;
         }
      }
      
      public function unbindKey(param1:uint) : void
      {
         delete this.keyBindings[param1];
      }
      
      public function set object(param1:ObjectContainer3D) : void
      {
         this._object = param1;
         this.updateObjectTransform();
      }
   }
}
