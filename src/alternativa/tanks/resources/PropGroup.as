package alternativa.tanks.resources
{
   public class PropGroup
   {
       
      public var props:Object;
      
      public function PropGroup()
      {
         this.props = new Object();
         super();
      }
      
      public function addProp(param1:String, param2:Prop) : void
      {
         this.props[param1] = param2;
      }
   }
}
