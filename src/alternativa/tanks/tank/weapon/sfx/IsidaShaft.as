package alternativa.tanks.tank.weapon.sfx
{
   import alternativa.tanks.IGraphicEffect;
   import flash.geom.Vector3D;
   import alternativa.math.Vector3;
   import alternativa.engine3d.materials.Material;
   import alternativa.engine3d.core.Camera3D;
   import alternativa.tanks.Game;
   import flash.geom.Matrix3D;
   import alternativa.engine3d.core.Object3DContainer;
   
   public class IsidaShaft implements IGraphicEffect
   {
       
      private var shaftPlane:AnimPlane;
      
      private var isidaEnd:alternativa.tanks.tank.weapon.sfx.IsidaEnd;
      
      private const endPosOffset:Number = 100;
      
      private var targetAxisZ:Vector3D;
      
      private var beamAxisZ:Vector3D;
      
      private var axis2:Vector3D;
      
      private var vin:Vector.<Number>;
      
      private var vout:Vector.<Number>;
      
      private var dir:Vector3D;
      
      private var startPos:Vector3;
      
      private var len:Number;
      
      private var ea:Vector3D;
      
      public function IsidaShaft(param1:Vector.<Material>, param2:Vector.<Material>, param3:Number, param4:Vector3, param5:Vector3D)
      {
         this.shaftPlane = new AnimPlane();
         this.targetAxisZ = new Vector3D();
         this.beamAxisZ = new Vector3D();
         this.axis2 = new Vector3D();
         this.vin = Vector.<Number>([0,0,1]);
         this.vout = Vector.<Number>([0,0,1]);
         this.ea = new Vector3D();
         super();
         this.isidaEnd = new alternativa.tanks.tank.weapon.sfx.IsidaEnd(param2);
         this.updatePosDir(param4,new Vector3(),param5,1);
         this.setMaterials(param1,param2,param3);
         this.updateRotation(Game.getInstance().camera);
      }
      
      public function setMaterials(param1:Vector.<Material>, param2:Vector.<Material>, param3:Number) : void
      {
         if(this.shaftPlane.materials == param1)
         {
            return;
         }
         this.shaftPlane.setMaterials(param1,param3);
         this.isidaEnd.setMaterials(param2);
      }
      
      public function play(param1:int, param2:Number, param3:Camera3D) : Boolean
      {
         this.shaftPlane.play(param1);
         this.updateRotation(param3);
         return true;
      }
      
      public function updatePosDir(param1:Vector3, param2:Vector3, param3:Vector3D, param4:Number) : void
      {
         this.len = param4;
         this.startPos = param1.vClone();
         this.dir = param3.clone();
         this.updateEndPos(param2);
         this.shaftPlane.x = param1.x;
         this.shaftPlane.y = param1.y;
         this.shaftPlane.z = param1.z;
         this.updateRotation(Game.getInstance().camera);
      }
      
      private function updateEndPos(param1:Vector3) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Vector3 = null;
         var _loc2_:Vector3 = new Vector3(this.dir.x,this.dir.y,this.dir.z);
         _loc3_ = _loc2_.vLength() - this.endPosOffset;
         _loc2_.vNormalize();
         _loc4_ = new Vector3();
         _loc4_.x = param1.x + _loc3_ * _loc2_.x;
         _loc4_.y = param1.y + _loc3_ * _loc2_.y;
         _loc4_.z = param1.z + _loc3_ * _loc2_.z + 25;
         this.isidaEnd.updatePos(_loc4_);
      }
      
      private function updateRotation(param1:Camera3D) : void
      {
         var _loc2_:Matrix3D = null;
         var _loc3_:Vector3D = null;
         var _loc4_:Number = NaN;
         _loc2_ = new Matrix3D();
         if(this.dir.y < -0.99999 || this.dir.y > 0.99999)
         {
            _loc3_ = new Vector3D(0,0,1);
            _loc3_.w = this.dir.y < 0?Number(180):Number(0);
         }
         else
         {
            _loc3_ = new Vector3D(this.dir.z,0,-this.dir.x);
            _loc3_.normalize();
            _loc3_.w = Math.acos(this.dir.y) * 180 / Math.PI;
         }
         _loc2_.appendRotation(_loc3_.w,_loc3_);
         this.targetAxisZ.x = param1.x - this.startPos.x;
         this.targetAxisZ.y = param1.y - this.startPos.y;
         this.targetAxisZ.z = param1.z - this.startPos.z;
         _loc4_ = this.targetAxisZ.x * this.dir.x + this.targetAxisZ.y * this.dir.y + this.targetAxisZ.z * this.dir.z;
         this.targetAxisZ.x = this.targetAxisZ.x - _loc4_ * this.dir.x;
         this.targetAxisZ.y = this.targetAxisZ.y - _loc4_ * this.dir.y;
         this.targetAxisZ.z = this.targetAxisZ.z - _loc4_ * this.dir.z;
         this.targetAxisZ.normalize();
         _loc2_.transformVectors(this.vin,this.vout);
         this.beamAxisZ.x = this.vout[0];
         this.beamAxisZ.y = this.vout[1];
         this.beamAxisZ.z = this.vout[2];
         _loc4_ = this.beamAxisZ.x * this.targetAxisZ.x + this.beamAxisZ.y * this.targetAxisZ.y + this.beamAxisZ.z * this.targetAxisZ.z;
         this.axis2.x = this.beamAxisZ.y * this.targetAxisZ.z - this.beamAxisZ.z * this.targetAxisZ.y;
         this.axis2.y = this.beamAxisZ.z * this.targetAxisZ.x - this.beamAxisZ.x * this.targetAxisZ.z;
         this.axis2.z = this.beamAxisZ.x * this.targetAxisZ.y - this.beamAxisZ.y * this.targetAxisZ.x;
         this.axis2.normalize();
         this.axis2.w = Math.acos(_loc4_) * 180 / Math.PI;
         _loc2_.appendRotation(this.axis2.w,this.axis2);
         this.ea = _loc2_.decompose()[1];
         this.shaftPlane.rotationX = this.ea.x;
         this.shaftPlane.rotationY = this.ea.y;
         this.shaftPlane.rotationZ = this.ea.z;
         this.shaftPlane.setScale(this.shaftPlane.materialWid,this.len,1);
      }
      
      public function destroy() : void
      {
         if(this.shaftPlane.parent != null)
         {
            this.shaftPlane.parent.removeChild(this.shaftPlane);
         }
         this.isidaEnd.kill();
      }
      
      public function kill() : void
      {
      }
      
      public function setVisible(param1:Boolean) : void
      {
         this.shaftPlane.visible = param1;
         this.isidaEnd.setVisible(param1);
      }
      
      public function addToContainer(param1:Object3DContainer, param2:Game) : void
      {
         param1.addChild(this.shaftPlane);
         param2.addGraphicsEffect(this.isidaEnd);
      }
   }
}

import alternativa.engine3d.core.Object3DContainer;
import alternativa.engine3d.materials.Material;
import alternativa.engine3d.primitives.Plane;
import alternativa.engine3d.materials.TextureMaterial;

class AnimPlane extends Object3DContainer
{
    
   private var MAX_NEXT_TIME:Number;
   
   private var numFrames:int;
   
   private var currFrame:int;
   
   private var nextTime:Number;
   
   public var materials:Vector.<Material>;
   
   public var materialWid:Number;
   
   private var plane:Plane;
   
   function AnimPlane()
   {
      super();
      this.plane = new Plane(1,1,1,1,true);
      addChild(this.plane);
   }
   
   public function setMaterials(param1:Vector.<Material>, param2:Number) : void
   {
      this.materialWid = (param1[0] as TextureMaterial).texture.width;
      this.materials = param1;
      this.numFrames = param1.length;
      this.currFrame = 0;
      this.MAX_NEXT_TIME = param2;
      this.nextTime = param2;
      this.updateFrame();
   }
   
   private function updateFrame() : void
   {
      this.plane.setMaterialToAllFaces(this.materials[this.currFrame]);
   }
   
   private function nextFrame() : void
   {
      this.currFrame++;
      if(this.currFrame >= this.numFrames)
      {
         this.currFrame = 0;
      }
      this.updateFrame();
   }
   
   public function setScale(param1:Number, param2:Number, param3:Number) : void
   {
      this.plane.scaleX = param1;
      this.plane.scaleY = param2;
      this.plane.scaleZ = param3;
      this.plane.y = param2 / 2;
   }
   
   public function play(param1:int) : void
   {
      this.nextTime = this.nextTime - param1;
      if(this.nextTime <= 0)
      {
         this.nextTime = this.MAX_NEXT_TIME;
         this.nextFrame();
      }
   }
}
