package alternativa.tanks.tank.weapon.sfx
{
   import alternativa.tanks.IGraphicEffect;
   import alternativa.tanks.tank.weapon.Weapon;
   import away3d.cameras.Camera3D;
   import away3d.containers.ObjectContainer3D;
   import away3d.entities.Mesh;
   import away3d.entities.Sprite3D;
   import away3d.materials.TextureMaterial;
   import away3d.primitives.PlaneGeometry;
   import flash.geom.Point;
   import alternativa.math.Vector3;
   import alternativa.tanks.Game;
   import flash.geom.Vector3D;
   
   public class RailGunShotEffect implements IGraphicEffect
   {
       
      private var sprite1:Sprite3D;
      
      private var sprite2:Sprite3D;
      
      private var sprite3:Sprite3D;
      
      private var weapon:Weapon;
      
      private var killed:Boolean = false;
	  
	  private var killed1:Boolean = false;
      
      private var time:Number = 0;
      
      private var timePart2:Number;
      
      private var timePart3:Number;
      
      private var allTime:Number;
	  
	  private var li1:Mesh = new Mesh(new PlaneGeometry(1, 1));
	  
	  private var li3:Mesh = new Mesh(new PlaneGeometry(1, 1));
      
      public function RailGunShotEffect(param1:Weapon, param2:TextureMaterial, param3:TextureMaterial, param4:TextureMaterial, param5:Number, param6:Number, param7:Number)
      {
         super();
         this.weapon = param1;
         this.timePart2 = param5;
         this.timePart3 = param6;
         this.allTime = param7;
         var _loc8_:Point = this.getWH(param2);
         this.sprite1 = new Sprite3D(param2,_loc8_.x,_loc8_.y);
         _loc8_ = this.getWH(param3);
         this.sprite2 = new Sprite3D(param3,_loc8_.x,_loc8_.y);
         _loc8_ = this.getWH(param4);
         this.sprite3 = new Sprite3D(param4,_loc8_.x,_loc8_.y);
         this.sprite2.visible = false;
         this.sprite3.visible = false;
      }
      
      private function setScale(param1:Sprite3D, param2:Number) : void
      {
         param1.scaleX = param1.scaleY = param1.scaleZ = param2;
      }
      
      private function getWH(param1:TextureMaterial) : Point
      {
         return new Point(param1.texture.width,param1.texture.height);
      }
	  
	  private function rotat(param1:Sprite3D,param2:int) : void
      {
         param1.rotationX += param2;
		 param1.rotationY += param2;
		 param1.rotationZ += param2;
      }
      
      public function play(param1:int, param2:Number, param3:Camera3D) : Boolean
      {
         this.time = this.time + param1;
		 var lk:Vector3D = new Vector3D();
		 var fu:Vector3D = weapon.tank.carBody.rotation.add(new Vector3D(0, weapon.tank.turretDirection));
		 li1.position = weapon.tank.carBody.position.add(new Vector3D(0, weapon.tank.turret.position.y + weapon.tank.turret.maxY*.75));
		 li1.rotationX = fu.x;
		 li1.rotationY = weapon.tank.carBody.rotationY;
		 li1.moveForward(weapon.tank.turret.z);
		 li1.rotationZ = fu.z;
		 li1.rotationY = fu.y;
		 li1.moveForward(weapon.tank.turret.maxZ);
		 lk = li1.position.clone();
		 li1 = li3;
		 sprite1.position = lk;
		 sprite2.position = lk;
		 sprite3.position = lk;
		 rotat(sprite1, param1 / 1000);
		 rotat(sprite2, param1 / 1000);
		 rotat(sprite3, param1 / 1000);
         if(this.time >= this.timePart2)
         {
            this.sprite2.visible = true;
         }
         if(this.time >= this.timePart3)
         {
            this.sprite3.visible = true;
         }
         if(this.time >= this.allTime)
         {
            this.kill();
         }
         return !this.killed;
      }
      
      public function destroy() : void
      {
		  if (!killed1)
		  {
			killed1 = true;
			if (this.sprite1 != null)
			{
				Main.instance.game.container.removeChild(this.sprite1);
			}
			if (this.sprite2 != null)
			{
				Main.instance.game.container.removeChild(this.sprite2);
			}
			if (this.sprite3 != null)
			{
				Main.instance.game.container.removeChild(this.sprite3);
			}
		  }
      }
      
      public function addToContainer(param1:ObjectContainer3D, param2:Game) : void
      {
         Main.instance.game.container.addChild(this.sprite1);
         Main.instance.game.container.addChild(this.sprite2);
         Main.instance.game.container.addChild(this.sprite3);
      }
      
      public function kill() : void
      {
         this.killed = true;
      }
   }
}
