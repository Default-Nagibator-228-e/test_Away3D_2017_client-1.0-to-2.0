package alternativa.tanks.tank
{
   //import alternativa.physics.collision.types.RayIntersection;
   import alternativa.math.Vector3;
   import alternativa.math.Matrix3;
   import alternativa.tanks.sfx.AnimatedPlaneEffect;
   import alternativa.tanks.sfx.TextureAnimation;
   import away3d.entities.Mesh;
   import away3d.materials.TextureMaterial;
   import away3d.utils.Cast;
   import flash.display.BitmapData;
   import alternativa.tanks.Game;
   import alternativa.tanks.resources.ImageLib;
   import alternativa.tanks.sfx.StaticObject3DPositionProvider;
   import alternativa.tanks.sfx.AnimatedSpriteEffect;
   import flash.geom.Rectangle;
   import flash.geom.Point;
   import alternativa.tanks.sfx.MovingObject3DPositionProvider;
   
   public class TankExplosionFactory
   {
      
      private static const EXPLOSION_SIZE:Number = 800;
      
      private static const SMOKE_SIZE:Number = 400;
      
      private static const SHOCKWAVE_SIZE:Number = 1000;
      
      private static const BASE_DIAGONAL:Number = 600;
      
      private static const MIN_SMOKE_SPEED:Number = 800;
      
      private static const SMOKE_SPEED_DELTA:Number = 200;
      
      private static const SMOKE_ACCELERATION:Number = -2000;
      
      private static const EXPLOSION_FIRE_OFFSET_TO_CAMERA:int = 200;
       
      //private var rayHit:RayIntersection;
      
      private var position:Vector3;
      
      private var eulerAngles:Vector3;
      
      private var velocity:Vector3;
      
      private var matrix:Matrix3;
      
      private var shockWaveScaleSpeed:Number = 1;
      
      public function TankExplosionFactory()
      {
         super();
         //this.rayHit = new RayIntersection();
         this.position = new Vector3();
         this.eulerAngles = new Vector3();
         this.velocity = new Vector3();
         this.matrix = new Matrix3();
      }
      
      private static function getEffectScale(param1:Tank) : Number
      {
         var _loc2_:Mesh = param1.hull;
         var _loc3_:Number = _loc2_.bounds.max.x - _loc2_.bounds.min.x;
         var _loc4_:Number = _loc2_.bounds.max.y - _loc2_.bounds.min.y;
         var _loc5_:Number = _loc2_.bounds.max.z - _loc2_.bounds.min.z;
         return Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_ + _loc5_ * _loc5_) / BASE_DIAGONAL;
      }
      
      public function createEffect(param1:Tank) : void
      {
         var _loc2_:Number = getEffectScale(param1);
         this.createExplosionShockWave(param1,_loc2_);
         this.createExplosionFire(_loc2_);
         this.createExplosionSmoke(_loc2_);
      }
      
      private function createExplosionShockWave(param1:Tank, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Vector3 = null;
         var _loc8_:AnimatedPlaneEffect = null;
         var _loc9_:TextureAnimation = null;
         var _loc12_:BitmapData = null;
         var _loc6_:* = NaN;
         var _loc7_:* = null;
         var _loc10_:Vector3 = new Vector3(0, 0, -1);
		 this.position = new Vector3(param1.carBody.x,param1.carBody.y,param1.carBody.z);
         //this.position.vCopy(param1.chassis.state.pos);//
         //if(Game.getInstance().world.collisionDetector.intersectRayWithStatic(this.position,_loc10_,255,500,null,this.rayHit))
         //{
            //this.rayHit.pos.z = this.rayHit.pos.z + 10;
            _loc3_ = SHOCKWAVE_SIZE;
            _loc4_ = 200;
            //if(this.rayHit.t > _loc4_)
            //{
               //_loc3_ = _loc3_ * ((500 - this.rayHit.t) / (500 - _loc4_));
            //}
           // _loc5_ = this.rayHit.normal;
            //_loc6_ = Math.acos(_loc5_.z);
           // _loc7_ = new Vector3(-_loc5_.y,_loc5_.x,0);
            //_loc7_.normalize();
            //this.matrix.fromAxisAngle(_loc7_,_loc6_);
            //this.matrix.getEulerAngles(this.eulerAngles);
            _loc8_ = new AnimatedPlaneEffect();
            _loc12_ = ImageLib.getImage("tank_explosion_shockwave");
            _loc9_ = new TextureAnimation(this.getAnimBitmapsByWH(2048, 128, _loc12_), 25);
			var ho:Vector3 = new Vector3(param1.carBody.position.x,param1.carBody.position.y,param1.carBody.position.z);
            _loc8_.init(param2 * _loc3_,ho,new Vector3,_loc9_.fps,_loc9_,this.shockWaveScaleSpeed);
            Game.getInstance().addGraphicsEffect(_loc8_);
         //}
      }
      
      private function createExplosionFire(param1:Number) : void
      {
         this.position.z = this.position.z + 50;
         var _loc2_:StaticObject3DPositionProvider = new StaticObject3DPositionProvider();
         _loc2_.init(this.position,EXPLOSION_FIRE_OFFSET_TO_CAMERA);
         var _loc3_:AnimatedSpriteEffect = new AnimatedSpriteEffect();
         var _loc4_:Number = EXPLOSION_SIZE * param1;
         var _loc5_:BitmapData = ImageLib.getImage("tank_explosion_explosion");
         var _loc6_:TextureAnimation = new TextureAnimation(this.getAnimBitmapsByWH(2048,128,_loc5_),25);
         _loc3_.init(_loc4_,_loc4_,_loc6_,Math.random() * 2 * Math.PI,_loc6_.fps,_loc2_);
         Game.getInstance().addGraphicsEffect(_loc3_);
      }
      
      public function getAnimBitmapsByWH(param1:Number, param2:Number, param3:BitmapData) : Vector.<TextureMaterial>
      {
         var _loc9_:BitmapData = null;
         var _loc4_:Vector.<TextureMaterial> = new Vector.<TextureMaterial>();
         var _loc5_:Rectangle = new Rectangle(0,0,param1,param2);
         var _loc6_:Point = new Point();
         var _loc7_:int = param3.width / param1;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc9_ = new BitmapData(param1, param2, true, 0xffffff);
            _loc5_.x = param1 * _loc8_;
            _loc9_.copyPixels(param3, _loc5_, _loc6_);
			var par:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(_loc9_));
			par.alphaBlending = true;
            _loc4_.push(par);
            _loc8_++;
         }
         return _loc4_;
      }
      
      private function createExplosionSmoke(param1:Number) : void
      {
         var _loc3_:MovingObject3DPositionProvider = null;
         var _loc4_:AnimatedSpriteEffect = null;
         var _loc6_:TextureAnimation = null;
         var _loc8_:BitmapData = null;
         var _loc2_:* = NaN;
         var _loc5_:* = NaN;
         var _loc7_:* = 0;
         while(_loc7_ < 3)
         {
            _loc2_ = MIN_SMOKE_SPEED + Math.random() * SMOKE_SPEED_DELTA;
            this.velocity.x = _loc2_ * (1 - 2 * Math.random());
            this.velocity.y = _loc2_ * (1 - 2 * Math.random());
            this.velocity.z = _loc2_ * 0.5 * (1 + Math.random());
            _loc3_ = new MovingObject3DPositionProvider();
            _loc3_.init(this.position,this.velocity,SMOKE_ACCELERATION);
            _loc4_ = new AnimatedSpriteEffect();
            _loc5_ = SMOKE_SIZE * param1;
            _loc8_ = ImageLib.getImage("tank_explosion_smoke");
            _loc6_ = new TextureAnimation(this.getAnimBitmapsByWH(2048,128,_loc8_),25);
            _loc4_.init(_loc5_,_loc5_,_loc6_,Math.random() * 2 * Math.PI,_loc6_.fps,_loc3_);
            Game.getInstance().addGraphicsEffect(_loc4_);
            _loc7_++;
         }
      }
   }
}
