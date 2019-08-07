package alternativa.tanks.tank.physics
{
   import alternativa.math.Vector3;
   
   public class Track
   {
       
      public var _chassis:alternativa.tanks.tank.physics.Chassis;
      
      public var _rays:Vector.<alternativa.tanks.tank.physics.SuspensionRay>;
      
      public var _numRays:int;
      
      public var _numContacts:int;
      
      public var _rayRestLength:Number;
      
      public var _rayWorkLength:Number;
      
      public function Track(param1:alternativa.tanks.tank.physics.Chassis, param2:Vector.<Vector3>, param3:int)
      {
         super();
         this._chassis = param1;
         this._rays = new Vector.<alternativa.tanks.tank.physics.SuspensionRay>(param2.length);
         var _loc4_:Vector3 = new Vector3(0,0,-1);
         var _loc5_:int = 0;
         while(_loc5_ < param2.length)
         {
            this._rays[_loc5_] = new alternativa.tanks.tank.physics.SuspensionRay(this,param2[_loc5_],_loc4_,param3);
            _loc5_++;
         }
      }
      
      public function setRayLengths(param1:Number, param2:Number) : void
      {
         this._rayRestLength = param1;
         this._rayWorkLength = param2;
      }
      
      public function set collisionGroup(param1:int) : void
      {
         var _loc2_:alternativa.tanks.tank.physics.SuspensionRay = null;
         for each(_loc2_ in this._rays)
         {
            _loc2_.collisionGroup = param1;
         }
      }
      
      public function updateControls(param1:int, param2:int) : void
      {
         var _loc3_:alternativa.tanks.tank.physics.SuspensionRay = null;
         for each(_loc3_ in this._rays)
         {
            _loc3_.updateCachedValues();
         }
      }
      
      public function addForces(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:alternativa.tanks.tank.physics.SuspensionRay = null;
         this._numContacts = 0;
         for each(_loc4_ in this._rays)
         {
            if(_loc4_.calculateIntersection())
            {
               this._numContacts++;
            }
         }
         if(this._numContacts == 0)
         {
            return;
         }
         var _loc5_:Number = 0.5 * param2 / (5 * (this._rayRestLength - this._rayWorkLength));
         var _loc6_:Number = param3;
         for each(_loc4_ in this._rays)
         {
            _loc4_.addForce(param1,_loc5_,_loc6_);
         }
      }
   }
}
