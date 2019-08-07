package alternativa.tanks.tank.controllers
{
   import alternativa.tanks.tank.Tank;
   //import alternativa.physics.collision.ICollisionDetector;
   import alternativa.math.Vector3;
   import alternativa.tanks.Game;
   import alternativa.math.Matrix4;
   import flash.geom.Vector3D;
   
   public class FollowCameraController extends CameraControllerBase
   {
      
      private static const HEIGHT_CHANGE_STEP:Number = 50;
      
      private static const MIN_HEIGHT:Number = 150;
      
      private static const MAX_HEIGHT:Number = 3100;
      
      private static const MIN_DISTANCE:Number = 50;
      
      private static const OFFSET:Number = 10;
       
      public var tank:Tank;
      
      private var extraPitch:Number = 0.17453292519943295;
      
      //private var collisionDetector:ICollisionDetector;
      
      private var cameraCollisionGroup:int;
      
      private var _cameraHeight:Number = 0;
      
      private var cameraDistance:Number = 0;
      
      private var locked:Boolean;
      
      private var maxPositionError:Number = 10;
      
      private var pivotPosition:Vector3;
      
      private var targetDirection:Vector3;
      
      private var cameraPosition:Vector3;
      
      private var maxAngleError:Number = 0.017453292519943295;
      
      private var linSpeed:Number = 0;
      
      private var pitchSpeed:Number = 0;
      
      private var yawSpeed:Number = 0;
      
      private var camSpeedThreshold:Number = 10;
      
      private var rayOrigin:Vector3;
      
      private var vector:Vector3;
      
     // private var rayHit:RayIntersection;
      
      private var gameEngine:Game;
      
      private var matrix:Matrix4;
      
      public function FollowCameraController(param1:int, param2:Tank = null)
      {
         this.pivotPosition = new Vector3();
         this.targetDirection = new Vector3();
         this.cameraPosition = new Vector3();
         this.rayOrigin = new Vector3();
         this.vector = new Vector3();
         this.matrix = new Matrix4();
         super();
         this.cameraCollisionGroup = param1;
         this.tank = param2;
         //this.cameraHeight = 600;
      }
      
      public function initByPivot(param1:Vector3, param2:Vector3) : void
      {
         //this.pivotPosition.vCopy(param1);
         //this.targetDirection.vCopy(param2);
         //this.getCameraPosition(param1,param2,this.collisionDetector,this.cameraPosition);
         //var _loc3_:Number = this.getPitchAngle();
         //var _loc4_:Number = Math.atan2(-param2.x,param2.y);
         //setPosition(this.cameraPosition);
         //setRotation(new Vector3(_loc3_ - 0.5 * Math.PI,0,_loc4_));
         //updateCameraTransform();
      }
      
      public function onUpdate(param1:Number) : void
      {
		  
      }
      
      private function updatePivotAndDirection() : void
      {
         //var _loc1_:Vector3 = new Vector3().copyFromVector3D(this.tank.turret.localToGlobal(new Vector3D(0,-200,150)));
         //this.tank.weapon.calcTurretParams(0);
         //this.matrix.setRotationMatrix(0,0,this.tank.turretDirection + this.tank.rotationZ);
         //this.pivotPosition.vReset(_loc1_.x,_loc1_.y,_loc1_.z);
        // this.targetDirection.vReset(this.matrix.b,this.matrix.f,0).normalize();
      }
   }
}
