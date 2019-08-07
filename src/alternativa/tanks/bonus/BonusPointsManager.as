package alternativa.tanks.bonus
{
   import alternativa.math.Vector3;
   
   public class BonusPointsManager
   {
       
      public var bonusPoints:Vector.<alternativa.tanks.bonus.BonusPoint>;
      
      public function BonusPointsManager()
      {
         this.bonusPoints = new Vector.<alternativa.tanks.bonus.BonusPoint>();
         super();
      }
      
      public function initBonusPoints(param1:XML) : void
      {
         var _loc2_:XML = null;
         for each(_loc2_ in param1.child("bonus-regions").elements("bonus-region"))
         {
            this.addBonusPoint(_loc2_.elements("bonus-type"),this.readVector3(_loc2_.child("min")),this.readVector3(_loc2_.child("max")),this.readVector3(_loc2_.child("rotation")));
         }
      }
      
      private function readVector3(param1:XMLList) : Vector3
      {
         return new Vector3(0,0,0);
      }
      
      public function getBonusPoint(param1:int) : alternativa.tanks.bonus.BonusPoint
      {
         var _loc3_:alternativa.tanks.bonus.BonusPoint = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Vector.<alternativa.tanks.bonus.BonusPoint> = new Vector.<alternativa.tanks.bonus.BonusPoint>();
         for each(_loc3_ in this.bonusPoints)
         {
            for each(_loc5_ in _loc3_.types)
            {
               if(_loc5_ == param1)
               {
                  _loc2_.push(_loc3_);
                  break;
               }
            }
         }
         _loc4_ = Math.round(Math.random() * (_loc2_.length - 1));
         return _loc2_[_loc4_];
      }
      
      private function addBonusPoint(param1:XMLList, param2:Vector3, param3:Vector3, param4:Vector3) : void
      {
         var _loc6_:XML = null;
         var _loc5_:alternativa.tanks.bonus.BonusPoint = new alternativa.tanks.bonus.BonusPoint();
         _loc5_.posMax = param3;
         _loc5_.posMin = param2;
         _loc5_.rot = param4;
         for each(_loc6_ in param1)
         {
            if(_loc6_ == "medkit")
            {
               _loc5_.types.push(BonusType.BOX_MED);
            }
            if(_loc6_ == "armorup")
            {
               _loc5_.types.push(BonusType.BOX_ARMR);
            }
            if(_loc6_ == "damageup")
            {
               _loc5_.types.push(BonusType.BOX_SHOT);
            }
            if(_loc6_ == "nitro")
            {
               _loc5_.types.push(BonusType.BOX_NOS);
            }
            if(_loc6_ == "crystal")
            {
               _loc5_.types.push(BonusType.BOX_CRYS);
            }
            if(_loc6_ == "crystal_100")
            {
               _loc5_.types.push(BonusType.BOX_GOLD);
            }
         }
         this.bonusPoints.push(_loc5_);
      }
   }
}
