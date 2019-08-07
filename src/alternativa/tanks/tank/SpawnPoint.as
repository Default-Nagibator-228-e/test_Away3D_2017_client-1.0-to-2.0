package alternativa.tanks.tank
{
   import alternativa.math.Vector3;
   
   public class SpawnPoint
   {
       
      public var teamType:alternativa.tanks.tank.BattleTeamType;
      
      public var pos:Vector3;
      
      public var rot:Vector3;
      
      public function SpawnPoint(param1:alternativa.tanks.tank.BattleTeamType, param2:Vector3, param3:Vector3)
      {
         super();
         this.teamType = param1;
         this.pos = param2;
         this.rot = param3;
      }
   }
}
