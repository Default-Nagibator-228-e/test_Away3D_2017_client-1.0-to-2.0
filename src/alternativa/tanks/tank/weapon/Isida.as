package alternativa.tanks.tank.weapon
{
   import flash.display.Sprite;
   import alternativa.math.Vector3;
   import alternativa.tanks.tank.Tank;
   import alternativa.engine3d.materials.Material;
   import alternativa.tanks.tank.weapon.sfx.IsidaStart;
   import alternativa.tanks.tank.weapon.sfx.IsidaShaft;
   import alternativa.tanks.resources.ImageLib;
   import alternativa.tanks.Game;
   import flash.geom.Vector3D;
   import flash.events.Event;
   import alternativa.tanks.tank.weapon.ts.IsidaTargetSystem;
   import alternativa.tanks.tank.weapon.ts.IsidaHitInfo;
   import flash.utils.getTimer;
   
   public class Isida extends Weapon
   {
      
      public static const STATE_IDLE:int = 0;
      
      public static const STATE_HEAL:int = 1;
      
      public static const STATE_DAMAGE:int = 2;
       
      private var _stat:int = 0;
      
      public var delay:Number = 40;
      
      public var delay2:Number = 100;
      
      public var temptime:uint = 0;
      
      public var ballon:Number = 100;
      
      public var maxBallon:Number = 100;
      
      protected var active:Boolean;
      
      private var time_next:Number = 100;
      
      private var time:Number;
      
      private var tempSprite:Sprite;
      
      private var damage:Number = 0;
      
      private var dir:Vector3;
      
      private var endPos:Vector3;
      
      public var isDamage:Boolean = true;
      
      public var range1:Number;
      
      public var range2:Number;
      
      private var target:Tank;
      
      private var idleSparkMaterials:Vector.<Material>;
      
      private var damageStartMaterials:Vector.<Material>;
      
      private var healStartMaterials:Vector.<Material>;
      
      private var damageEndMaterials:Vector.<Material>;
      
      private var healEndMaterials:Vector.<Material>;
      
      private var damageShaftMaterials:Vector.<Material>;
      
      private var healShaftMaterials:Vector.<Material>;
      
      private var isidaStart:IsidaStart;
      
      private var isidaShaft:IsidaShaft;
      
      public function Isida()
      {
         this.tempSprite = new Sprite();
         super();
      }
      
      override public function destroy() : void
      {
         this.tempSprite = null;
         this.isidaShaft.destroy();
         this.isidaStart.destroy();
         this.healShaftMaterials = null;
         this.damageShaftMaterials = null;
         this.healEndMaterials = null;
         this.damageEndMaterials = null;
         this.healStartMaterials = null;
         this.damageStartMaterials = null;
         this.idleSparkMaterials = null;
         this.endPos = null;
         this.dir = null;
      }
      
      public function get stat() : int
      {
         return this._stat;
      }
      
      public function set stat(param1:int) : void
      {
         this._stat = param1;
      }
      
      override public function loadProfile(param1:XML) : void
      {
         this.idleSparkMaterials = getAnimBitmaps(ImageLib.getImage(param1.child("idleSpark").@id));
         this.damageStartMaterials = getAnimBitmaps(ImageLib.getImage(param1.child("damageStart").@id));
         this.healStartMaterials = getAnimBitmaps(ImageLib.getImage(param1.child("healStart").@id));
         this.damageEndMaterials = getAnimBitmaps(ImageLib.getImage(param1.child("damageEnd").@id));
         this.healEndMaterials = getAnimBitmaps(ImageLib.getImage(param1.child("healEnd").@id));
         this.damageShaftMaterials = getAnimBitmapsByWH(param1.child("damageShaft").@w,param1.child("damageShaft").@h,ImageLib.getImage(param1.child("damageShaft").@id));
         this.healShaftMaterials = getAnimBitmapsByWH(param1.child("healShaft").@w,param1.child("healShaft").@h,ImageLib.getImage(param1.child("healShaft").@id));
         this.delay = param1.child("delay").@val;
         this.delay2 = param1.child("delay2").@val;
         turretSpeed = param1.child("turretSpeed").@val;
         this.damage = param1.child("damage").@val;
         this.range1 = param1.child("range1").@val;
         this.range2 = param1.child("range2").@val;
      }
      
      override public function tankComplete() : void
      {
         this.isidaStart = new IsidaStart(this,this.idleSparkMaterials);
         this.isidaStart.setVisible(false);
         Game.getInstance().addGraphicsEffect(this.isidaStart);
         calcTurretParams(0);
         this.isidaShaft = new IsidaShaft(this.damageShaftMaterials,this.damageEndMaterials,50,barrelOrigin,new Vector3D(gunDir.x,gunDir.y,gunDir.z));
         this.isidaShaft.setVisible(false);
         Game.getInstance().addGraphicsEffect(this.isidaShaft);
      }
      
      private function updateIsidaShaft() : void
      {
         this.isidaShaft.setVisible(true);
         var _loc1_:Vector3D = this.target.turret.localToGlobal(new Vector3D());
         var _loc2_:Vector3 = new Vector3().copyFromVector3D(_loc1_);
         var _loc3_:Vector3D = tank.muzzlePoint.localToGlobal(new Vector3D());
         var _loc4_:Vector3 = new Vector3().copyFromVector3D(_loc3_);
         var _loc5_:Vector3 = new Vector3();
         _loc5_ = _loc5_.vDiff(_loc2_,_loc4_);
         var _loc6_:Number = _loc5_.vLength();
         _loc5_.vScale(1 / _loc6_);
         this.isidaShaft.updatePosDir(_loc4_,_loc2_,new Vector3D(_loc5_.x,_loc5_.y,_loc5_.z),_loc6_);
      }
      
      private function eft(param1:Event) : void
      {
         var _loc3_:IsidaTargetSystem = null;
         var _loc4_:IsidaHitInfo = null;
         var _loc5_:Vector3D = null;
         var _loc6_:Vector3D = null;
         var _loc2_:Number = getTimer() - this.time;
         this.time = getTimer();
         this.time_next = this.time_next - _loc2_;
         if(this._stat == STATE_DAMAGE)
         {
            this.isidaShaft.setMaterials(this.damageShaftMaterials,this.damageEndMaterials,50);
            this.updateIsidaShaft();
         }
         if(this._stat == STATE_HEAL)
         {
            this.isidaShaft.setMaterials(this.healShaftMaterials,this.healEndMaterials,50);
            this.updateIsidaShaft();
         }
         if(this.time_next <= 0)
         {
            this.time_next = 100;
            if(this._stat == STATE_IDLE)
            {
               _loc3_ = new IsidaTargetSystem();
               calcTurretParams(0);
               _loc4_ = new IsidaHitInfo();
               if(_loc3_.getTarget(tank,Game.getInstance().tanks,barrelOrigin,gunDir,_loc4_,this.range1))
               {
                  if(this.isDamage)
                  {
                     this.target = _loc4_.target;
                     this.isidaStart.setMaterials(this.damageStartMaterials);
                     this.stat = STATE_DAMAGE;
                  }
                  else
                  {
                     this.target = _loc4_.target;
                     this.isidaStart.setMaterials(this.healStartMaterials);
                     this.stat = STATE_HEAL;
                  }
               }
               else
               {
                  this.stat = STATE_IDLE;
                  this.isidaStart.setMaterials(this.idleSparkMaterials);
                  this.isidaShaft.setVisible(false);
               }
            }
            else if(this.target != null)
            {
               _loc5_ = this.target.turret.localToGlobal(new Vector3D());
               _loc6_ = tank.muzzlePoint.globalToLocal(_loc5_);
               if(_loc6_.y < 0 || _loc6_.y > this.range2 || _loc6_.x < -400 || _loc6_.x > 400 || _loc6_.z < -400 || _loc6_.z > 400)
               {
                  this.stat = STATE_IDLE;
                  this.isidaStart.setMaterials(this.idleSparkMaterials);
                  this.isidaShaft.setVisible(false);
               }
            }
            else
            {
               this.stat = STATE_IDLE;
               this.isidaStart.setMaterials(this.idleSparkMaterials);
               this.isidaShaft.setVisible(false);
            }
         }
      }
      
      override public function start(param1:int = 0) : void
      {
         if(this.active)
         {
            return;
         }
         this.time = getTimer();
         this.active = true;
         this.isidaStart.setVisible(true);
         this.isidaShaft.setVisible(false);
         this.eft(null);
         this.tempSprite.addEventListener(Event.ENTER_FRAME,this.eft);
      }
      
      override public function stop() : void
      {
         if(!this.active)
         {
            return;
         }
         this.stat = STATE_IDLE;
         this.isidaStart.setVisible(false);
         this.isidaShaft.setVisible(false);
         this.active = false;
         this.tempSprite.removeEventListener(Event.ENTER_FRAME,this.eft);
      }
      
      override public function getStatus() : Number
      {
         return Math.round(this.ballon / this.maxBallon * 100);
      }
      
      override public function update(param1:uint, param2:uint) : void
      {
      }
   }
}
