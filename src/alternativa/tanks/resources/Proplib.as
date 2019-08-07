package alternativa.tanks.resources
{
   public class Proplib
   {
       
      public var groups:Object;
      
      public function Proplib()
      {
         this.groups = new Object();
         super();
      }
      
      public function addPropGroup(param1:String, param2:PropGroup) : void
      {
         this.groups[param1] = param2;
      }
   }
}
