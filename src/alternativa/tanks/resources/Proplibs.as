package alternativa.tanks.resources
{
   public class Proplibs
   {
      
      public static var libs:Object = new Object();
       
      public function Proplibs()
      {
         super();
      }
      
      public static function addPropLib(param1:String, param2:Proplib) : void
      {
         libs[param1] = param2;
      }
   }
}
