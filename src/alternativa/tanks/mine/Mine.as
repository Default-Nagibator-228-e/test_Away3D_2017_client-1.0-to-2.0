package alternativa.tanks.mine
{
   import alternativa.engine3d.objects.Mesh;
   import alternativa.tanks.tank.Tank;
   import alternativa.physics.Body;
   import alternativa.tanks.Game;
   import alternativa.tanks.physics.TanksCollisionDetector;
   import alternativa.tanks.tank.BattleTeamType;
   import alternativa.math.Vector3;
   import flash.geom.Vector3D;
   import mishin870.net.SocketClass;
   import alternativa.engine3d.loaders.Parser3DS;
   import alternativa.engine3d.core.Object3D;
   import alternativa.engine3d.materials.TextureMaterial;
   import alternativa.math.Matrix3;
   import alternativa.physics.collision.primitives.CollisionBox;
   
   public class Mine
   {
      
      private static const modelClass:Class = Mine_modelClass;
      
      private static const blueClass:Class = Mine_blueClass;
      
      private static const greenClass:Class = Mine_greenClass;
      
      private static const redClass:Class = Mine_redClass;
      
      private static const yellowClass:Class = Mine_yellowClass;
      
      private static var model:Mesh;
       
      private var m:Mesh;
      
      private var tank:Tank;
      
      private var mBody:Body;
      
      public var id:int;
      
      private var destroyed:Boolean = false;
      
      public function Mine(param1:int, param2:Tank, param3:Vector3, param4:Vector3)
      {
         var _loc5_:Parser3DS = null;
         var _loc6_:Object3D = null;
         var _loc7_:Mesh = null;
         super();
         this.id = param1;
         this.tank = param2;
         if(model == null)
         {
            _loc5_ = new Parser3DS();
            _loc5_.parse(new modelClass());
            for each(_loc6_ in _loc5_.objects)
            {
               _loc7_ = _loc6_ as Mesh;
               if(_loc7_ != null)
               {
                  if(_loc7_.name == "mine")
                  {
                     model = _loc7_;
                  }
                  if(_loc7_.name == "flare")
                  {
                     _loc7_.setMaterialToAllFaces(null);
                  }
               }
            }
            model.setMaterialToAllFaces(null);
            model.calculateFacesNormals();
            model.calculateBounds();
         }
         this.m = model.clone() as Mesh;
         if(param2.TEAM == BattleTeamType.BLUE)
         {
            this.m.setMaterialToAllFaces(new TextureMaterial(new blueClass().bitmapData));
         }
         if(param2.TEAM == BattleTeamType.RED)
         {
            this.m.setMaterialToAllFaces(new TextureMaterial(new redClass().bitmapData));
         }
         if(param2.TEAM == BattleTeamType.GREEN)
         {
            if(param2.tankId == -1)
            {
               this.m.setMaterialToAllFaces(new TextureMaterial(new yellowClass().bitmapData));
            }
            else
            {
               this.m.setMaterialToAllFaces(new TextureMaterial(new greenClass().bitmapData));
            }
         }
         Game.getInstance().map.addChild(this.m);
         this.m.x = param3.x;
         this.m.y = param3.y;
         this.m.z = param3.z;
         this.m.rotationX = param4.x;
         this.m.rotationY = param4.y;
         this.m.rotationZ = param4.z;
         this.mBody = new Body(20,Matrix3.IDENTITY);
         this.mBody.addCollisionPrimitive(new CollisionBox(new Vector3(75,75,75),1));
         this.mBody.movable = false;
         this.mBody.frozen = true;
         this.mBody.state.pos.x = this.m.x;
         this.mBody.state.pos.y = this.m.y;
         this.mBody.state.pos.z = this.m.z;
         Game.getInstance().world.addBody(this.mBody);
      }
      
      public function destroy() : void
      {
         if(this.destroyed)
         {
            return;
         }
         Game.getInstance().world.removeBody(this.mBody);
         Game.getInstance().map.removeChild(this.m);
         this.mBody = null;
         this.m = null;
         this.destroyed = true;
      }
      
      private function testCollision(param1:Tank) : Boolean
      {
         var _loc2_:TanksCollisionDetector = null;
         try
         {
            if(this.tank.tankId == param1.tankId)
            {
               return false;
            }
            if(this.tank.TEAM == param1.TEAM)
            {
               if(this.tank.TEAM != BattleTeamType.GREEN && param1.TEAM != BattleTeamType.GREEN)
               {
                  return false;
               }
            }
            _loc2_ = TanksCollisionDetector(Game.getInstance().world.collisionDetector);
            return _loc2_.testContacts2(this.mBody.collisionPrimitives,param1.chassis.collisionPrimitives);
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public function update(param1:Tank) : void
      {
         if(this.destroyed)
         {
            return;
         }
         if(this.testCollision(param1))
         {
            param1.chassis.addWorldForceAtLocalPoint(new Vector3().copyFromVector3D(param1.globalToLocal(new Vector3D(this.m.x,this.m.y,this.m.z))),new Vector3(0,0,5000000));
            this.destroy();
            SocketClass.send("mined;" + this.id);
         }
      }
   }
}
