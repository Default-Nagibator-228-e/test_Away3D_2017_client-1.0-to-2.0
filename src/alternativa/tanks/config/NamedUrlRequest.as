package alternativa.tanks.config
{
   import flash.net.URLRequest;
   
   public class NamedUrlRequest
   {
       
      public var name:String;
      
      public var req:URLRequest;
      
      public function NamedUrlRequest(param1:String, param2:String)
      {
         super();
         this.req = new URLRequest(param2);
         this.name = param1;
      }
   }
}
