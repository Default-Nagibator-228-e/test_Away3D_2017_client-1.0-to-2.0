package alternativa.tanks.tank
{
   import alternativa.math.Vector3;
   
   public class SpawnPointsManager
   {
       
      public var greenPoints:Vector.<alternativa.tanks.tank.SpawnPoint>;
      
      public var redPoints:Vector.<alternativa.tanks.tank.SpawnPoint>;
      
      public var bluePoints:Vector.<alternativa.tanks.tank.SpawnPoint>;
      
      public function SpawnPointsManager()
      {
         this.greenPoints = new Vector.<alternativa.tanks.tank.SpawnPoint>();
         this.redPoints = new Vector.<alternativa.tanks.tank.SpawnPoint>();
         this.bluePoints = new Vector.<alternativa.tanks.tank.SpawnPoint>();
         super();
      }
      
      public function initSpawnPoints(param1:XML) : void
      {
         var _loc2_:XML = null;
         for each(_loc2_ in param1.child("spawn-points").elements("spawn-point"))
         {
            this.addSpawnPoint(_loc2_.@type,this.readVector3(_loc2_.child("position"),0,0,100),this.readVector3(_loc2_.child("rotation")));
         }
      }
      
      private function readVector3(param1:XMLList, param2:int = 0, param3:int = 0, param4:int = 0) : Vector3
      {
         var _loc5_:Number = param1.child("x") != null?Number(param1.child("x")):Number(0);
         var _loc6_:Number = param1.child("y") != null?Number(param1.child("y")):Number(0);
         var _loc7_:Number = param1.child("z") != null?Number(param1.child("z")):Number(0);
         _loc5_ = _loc5_ + param2;
         _loc6_ = _loc6_ + param3;
         _loc7_ = _loc7_ + param4;
         return new Vector3(_loc5_,_loc6_,_loc7_);
      }
      
      public function getSpawn(param1:BattleTeamType) : alternativa.tanks.tank.SpawnPoint
      {
         var _loc2_:Vector.<alternativa.tanks.tank.SpawnPoint> = null;
         if(param1 == BattleTeamType.NONE || param1 == BattleTeamType.GREEN)
         {
            _loc2_ = this.greenPoints;
         }
         if(param1 == BattleTeamType.RED)
         {
            _loc2_ = this.redPoints;
         }
         if(param1 == BattleTeamType.BLUE)
         {
            _loc2_ = this.bluePoints;
         }
         var _loc3_:int = Math.round(Math.random() * (_loc2_.length - 1));
         return _loc2_[_loc3_];
      }
      
      private function addSpawnPoint(param1:String, param2:Vector3, param3:Vector3) : void
      {
         if(param1 == "dm")
         {
            this.greenPoints.push(new alternativa.tanks.tank.SpawnPoint(BattleTeamType.NONE,param2,param3));
            return;
         }
         if(param1 == "red")
         {
            this.redPoints.push(new alternativa.tanks.tank.SpawnPoint(BattleTeamType.RED,param2,param3));
            return;
         }
         if(param1 == "blue")
         {
            this.bluePoints.push(new alternativa.tanks.tank.SpawnPoint(BattleTeamType.BLUE,param2,param3));
            return;
         }
      }
   }
}
