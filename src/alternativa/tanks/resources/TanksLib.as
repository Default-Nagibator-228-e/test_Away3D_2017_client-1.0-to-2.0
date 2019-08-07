package alternativa.tanks.resources
{
   import alternativa.tanks.tank.TankTurret;
   import alternativa.tanks.tank.TankHull;
   import flash.display.BitmapData;
   
   public class TanksLib
   {
      
      public var turrets:Vector.<TankTurret>;
      
      public var hulls:Vector.<TankHull>;
      
      public var colormaps:Vector.<BitmapData>;
       
      public function TanksLib()
      {
         super();
		 this.turrets = new Vector.<TankTurret>();
		 this.hulls = new Vector.<TankHull>();
		 this.colormaps = new Vector.<BitmapData>();
      }
   }
}
