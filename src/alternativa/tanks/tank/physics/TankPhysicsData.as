package alternativa.tanks.tank.physics
{
   public class TankPhysicsData
   {
      
      public static var fields:Array = ["mass","springDamping","power","maxForwardSpeed","maxBackwardSpeed","maxTurnSpeed","drivingForceOffsetZ","smallVelocity","rayRestLengthCoeff","dynamicFriction","brakeFriction","sideFriction","spotTurnPowerCoeff","spotTurnDynamicFriction","spotTurnSideFriction","moveTurnPowerCoeffInner","moveTurnPowerCoeffOuter","moveTurnDynamicFrictionInner","moveTurnDynamicFrictionOuter","moveTurnSideFriction","moveTurnSpeedCoeffInner","moveTurnSpeedCoeffOuter","tankOffsetZ"];
      
      public static var fieldsRu:Array = ["Macca","Демпфирование","Двигатель","ПередняяСкорость","ЗадняяСкорость","PазворотНаМесте","СмещениеТочкиZ","МалаяСилаТрения","ОтношениеЧастей","СилаТрения№1","СилаТрения№2","СилаТрения№3","СилаТяги№1","СилаТяги№2","ТрениеПриПовороте","СилаВнутреннейГусеницы","СилаВнешнейГусеницы","ДинамикаВнутреннейГусеницы","ДинамикаВнешнейГусеницы","ТрениеПриПоворотеВдвижении","ОграничениеВнутреннейГусеницы","ОграничениеВнешнейГусеницы","СмещениеТанкаZ"];
       
      public var mass:Number = 1000;
      
      public var power:Number = 1000000;
      
      public var maxForwardSpeed:Number = 600;
      
      public var maxBackwardSpeed:Number = 600;
      
      public var maxTurnSpeed:Number = 2;
      
      public var springDamping:Number = 1000;
      
      public var drivingForceOffsetZ:Number = 0;
      
      public var smallVelocity:Number = 100;
      
      public var rayRestLengthCoeff:Number = 1.5;
      
      public var dynamicFriction:Number = 0.1;
      
      public var brakeFriction:Number = 2;
      
      public var sideFriction:Number = 3;
      
      public var spotTurnPowerCoeff:Number = 1;
      
      public var spotTurnDynamicFriction:Number = 0.1;
      
      public var spotTurnSideFriction:Number = 2;
      
      public var moveTurnPowerCoeffOuter:Number = 3;
      
      public var moveTurnPowerCoeffInner:Number = 0;
      
      public var moveTurnDynamicFrictionInner:Number = 0.2;
      
      public var moveTurnDynamicFrictionOuter:Number = 0.1;
      
      public var moveTurnSideFriction:Number = 2;
      
      public var moveTurnSpeedCoeffInner:Number = 0.3;
      
      public var moveTurnSpeedCoeffOuter:Number = 0.3;
      
      public var tankOffsetZ:Number = 0;
      
      public function TankPhysicsData()
      {
         super();
      }
      
      public function copy(param1:TankPhysicsData) : void
      {
         this.mass = param1.mass;
         this.power = param1.power;
         this.maxForwardSpeed = param1.maxForwardSpeed;
         this.maxBackwardSpeed = param1.maxBackwardSpeed;
         this.maxTurnSpeed = param1.maxTurnSpeed;
         this.springDamping = param1.springDamping;
         this.drivingForceOffsetZ = param1.drivingForceOffsetZ;
         this.smallVelocity = param1.smallVelocity;
         this.rayRestLengthCoeff = param1.rayRestLengthCoeff;
         this.dynamicFriction = param1.dynamicFriction;
         this.brakeFriction = param1.brakeFriction;
         this.sideFriction = param1.sideFriction;
         this.spotTurnPowerCoeff = param1.spotTurnPowerCoeff;
         this.spotTurnDynamicFriction = param1.spotTurnDynamicFriction;
         this.spotTurnSideFriction = param1.spotTurnSideFriction;
         this.moveTurnPowerCoeffOuter = param1.moveTurnPowerCoeffOuter;
         this.moveTurnPowerCoeffInner = param1.moveTurnPowerCoeffInner;
         this.moveTurnDynamicFrictionInner = param1.moveTurnDynamicFrictionInner;
         this.moveTurnDynamicFrictionOuter = param1.moveTurnDynamicFrictionOuter;
         this.moveTurnSideFriction = param1.moveTurnSideFriction;
         this.moveTurnSpeedCoeffInner = param1.moveTurnSpeedCoeffInner;
         this.moveTurnSpeedCoeffOuter = param1.moveTurnSpeedCoeffOuter;
         this.tankOffsetZ = param1.tankOffsetZ;
      }
      
      public function getXml() : XML
      {
         var _loc2_:String = null;
         var _loc1_:XML = <profile></profile>;
         for each(_loc2_ in fields)
         {
            _loc1_.appendChild(XML("<" + _loc2_ + ">" + this[_loc2_] + "</" + _loc2_ + ">"));
         }
         return _loc1_;
      }
      
      public function loadFromXml(param1:XML) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < fieldsRu.length)
         {
            if(param1.elements(fieldsRu[_loc2_])[0] != null)
            {
               this[fields[_loc2_]] = Number(param1.elements(fieldsRu[_loc2_])[0]);
            }
            _loc2_++;
         }
      }
      
      public function clone() : TankPhysicsData
      {
         var _loc1_:TankPhysicsData = new TankPhysicsData();
         _loc1_.copy(this);
         return _loc1_;
      }
   }
}
