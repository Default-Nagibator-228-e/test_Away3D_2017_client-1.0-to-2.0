package alternativa.tanks.bonus
{
   import flash.display.Sprite;
   import alternativa.physics.PhysicsScene;
   import alternativa.engine3d.core.Object3DContainer;
   import alternativa.math.Vector3;
   import alternativa.tanks.physics.TanksCollisionDetector;
   import flash.utils.getTimer;
   import flash.events.Event;
   import alternativa.physics.constraints.Constraint;
   import alternativa.tanks.Game;
   import alternativa.tanks.tank.Tank;
   import mishin870.net.SocketClass;
   import alternativa.physics.collision.primitives.CollisionBox;
   import flash.geom.ColorTransform;
   import flash.display.BitmapData;
   import alternativa.tanks.resources.ImageLib;
   import alternativa.engine3d.objects.Mesh;
   import alternativa.engine3d.materials.TextureMaterial;
   
   public class Bonus
   {
      
      private static const upSpeed:Number = 300;
      
      private static const angleSpeed:Number = 2;
      
      private static const REMOVAL_TIME:int = 2000;
      
      public static const STATE_FALLING:int = 0;
      
      public static const STATE_DROPPED:int = 1;
      
      public static const STATE_NONPARACHUTE:int = 2;
      
      public static const STATE_TAKEN:int = 3;
       
      private var timeToLive:int = 2000;
      
      public var bb:alternativa.tanks.bonus.BonusBody;
      
      public var pb:alternativa.tanks.bonus.ParaBody;
      
      private var _state:int = 0;
      
      private var prevTime:Number;
      
      private var spr:Sprite;
      
      private var w:PhysicsScene;
      
      private var constraints:Vector.<alternativa.tanks.bonus.MaxDistanceConstraint>;
      
      private var testTime:Number = 200;
      
      public var type:Number;
      
      public var id:int;
      
      public function Bonus(param1:Number, param2:int)
      {
         var _loc3_:BitmapData = null;
         this.spr = new Sprite();
         this.constraints = new Vector.<alternativa.tanks.bonus.MaxDistanceConstraint>();
         super();
         this.id = param2;
         this.type = param1;
         if(param1 == 1)
         {
            _loc3_ = ImageLib.getImage("box_med");
         }
         if(param1 == 2)
         {
            _loc3_ = ImageLib.getImage("box_armr");
         }
         if(param1 == 3)
         {
            _loc3_ = ImageLib.getImage("box_shot");
         }
         if(param1 == 4)
         {
            _loc3_ = ImageLib.getImage("box_nos");
         }
         if(param1 == 5)
         {
            _loc3_ = ImageLib.getImage("box_crys");
         }
         if(param1 == 6)
         {
            _loc3_ = ImageLib.getImage("box_gold");
         }
         this.bb = new alternativa.tanks.bonus.BonusBody(_loc3_,BonusResources.box.clone() as Mesh,this);
         var _loc4_:Mesh = BonusResources.parachute.clone() as Mesh;
         var _loc5_:Mesh = BonusResources.parachutei.clone() as Mesh;
         _loc4_.setMaterialToAllFaces(new TextureMaterial(ImageLib.getImage("para").clone()));
         _loc5_.setMaterialToAllFaces(new TextureMaterial(ImageLib.getImage("parai").clone()));
         this.pb = new alternativa.tanks.bonus.ParaBody(_loc4_,_loc5_);
      }
      
      private function getRandomPos(param1:Number, param2:Number) : Number
      {
         return Math.round(Math.random() * (param2 - param1)) + param1;
      }

      public function addToWorld(param1:PhysicsScene, param2:Object3DContainer, param3:Vector3) : void
      {
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:alternativa.tanks.bonus.MaxDistanceConstraint = null;
         this.w = param1;
         var _loc4_:TanksCollisionDetector = TanksCollisionDetector(param1.collisionDetector);
         var _loc5_:Vector3 = param3;
		 var _loc6_:Vector3 = new Vector3(_loc5_.x,_loc5_.y,_loc5_.z + 50);
         this.bb.addToContainer(param2);
         this.bb.state.pos = _loc5_;
         param1.addBody(this.bb);
         _loc4_.addBody(this.bb);
		 this.pb.addToContainer(param2);
         this.pb.state.pos = _loc6_;
         param1.addBody(this.pb);
         var _loc8_:Number = 2 * Math.PI / 4;
         var _loc9_:int = 0;
         while(_loc9_ < 4)
         {
            _loc10_ = _loc9_ * _loc8_;
            _loc11_ = 180 * Math.cos(_loc10_);
            _loc12_ = 180 * Math.sin(_loc10_);
            _loc13_ = new alternativa.tanks.bonus.MaxDistanceConstraint(this.pb,this.bb,new Vector3(_loc11_,_loc12_,0),new Vector3(0,0,50),400);
            param1.addConstraint(_loc13_);
            this.constraints.push(_loc13_);
            _loc9_++;
         }
         this.bb.alpha = 1;
		 this.pb.alpha = 1;
         this.prevTime = getTimer();
         this.spr.addEventListener(Event.ENTER_FRAME,this.ef);
      }
      
      public function removeFromWorld() : void
      {
         var _loc1_:Constraint = null;
         this.bb.removeFromContainer();
         this.w.removeBody(this.bb);
         if(this.pb != null)
         {
            this.pb.removeFromContainer();
            this.w.removeBody(this.pb);
         }
         TanksCollisionDetector(this.w.collisionDetector).removeBody(this.bb);
         for each(_loc1_ in this.constraints)
         {
            this.w.removeConstraint(_loc1_);
         }
         this.bb = null;
         this.pb = null;
         this.constraints = null;
         this.spr.removeEventListener(Event.ENTER_FRAME,this.ef);
         this.spr = null;
      }
      
      public function update(param1:Number) : void
      {
         this.bb.updateSkin(param1);
         if(this._state != STATE_NONPARACHUTE)
         {
            if(this.pb != null)
            {
               this.pb.updateSkin(param1);
            }
         }
      }
      
      private function testTankCollision() : void
      {
         var _loc1_:Tank = Game.getInstance().tanks[0];
         if(Boolean(_loc1_.exp) || !_loc1_.vis)
         {
            return;
         }
         if(TanksCollisionDetector(this.bb.world.collisionDetector).testContactsTankBonus(this.bb.collisionPrimitives,_loc1_.chassis.collisionPrimitives))
         {
            SocketClass.send("takeb;" + this.id);
            this.state = STATE_TAKEN;
            (this.bb.collisionPrimitives.head.primitive as CollisionBox).hs = new Vector3();
         }
      }
      
      public function take() : void
      {
         this.state = STATE_TAKEN;
         (this.bb.collisionPrimitives.head.primitive as CollisionBox).hs = new Vector3();
      }
      
      private function ef(param1:Event) : void
      {
         var now:Number = NaN;
         var delta:Number = NaN;
         var off:Number = NaN;
         var e:Event = param1;
         try
         {
            now = getTimer();
            delta = now - this.prevTime;
            this.prevTime = now;
            if(this._state != STATE_TAKEN)
            {
               this.testTime = this.testTime - delta;
               if(this.testTime <= 0)
               {
                  this.testTime = 200;
                  this.testTankCollision();
               }
            }
            if(this._state == STATE_DROPPED || this._state == STATE_TAKEN)
            {
               if(this.pb != null)
               {
                  this.pb.alpha = this.pb.alpha - delta / 2000;
                  if(this.pb.alpha <= 0)
                  {
                     this.removeParachute();
                  }
               }
            }
            if(this._state == STATE_TAKEN)
            {
               this.timeToLive = this.timeToLive - delta;
               this.bb.addForce(new Vector3(0,0,Game.getInstance().world._gravity.vLength() / this.bb.invMass));
               this.bb.state.velocity.vReset(0,0,upSpeed * this.timeToLive / REMOVAL_TIME + upSpeed * 0.1);
               this.bb.state.rotation.vReset(0,0,angleSpeed * this.timeToLive / REMOVAL_TIME + angleSpeed * 0.1);
               off = 200 - this.timeToLive / 10;
               this.bb.colorTransform = new ColorTransform(1,1,1,1,off,off,off);
               this.bb.alpha = this.timeToLive / REMOVAL_TIME;
               if(this.timeToLive <= 0)
               {
                  Game.getInstance().removeBonus(this);
               }
            }
            return;
         }
         catch(err:Error)
         {
            (e.target as Sprite).removeEventListener(Event.ENTER_FRAME,ef);
            return;
         }
      }
      
      private function removeParachute() : void
      {
         var _loc1_:alternativa.tanks.bonus.MaxDistanceConstraint = null;
         if(this._state != STATE_TAKEN)
         {
            this._state = STATE_NONPARACHUTE;
         }
         for each(_loc1_ in this.constraints)
         {
            this.w.removeConstraint(_loc1_);
         }
         this.constraints = null;
         this.w.removeBody(this.pb);
         this.pb.removeFromContainer();
         this.pb = null;
      }
      
      public function set state(param1:int) : void
      {
         this._state = param1;
      }
      
      public function get state() : int
      {
         return this._state;
      }
   }
}
