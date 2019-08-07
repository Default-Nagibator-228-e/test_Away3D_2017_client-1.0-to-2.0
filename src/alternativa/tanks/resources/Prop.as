package alternativa.tanks.resources
{
   import flash.events.EventDispatcher;
   import alternativa.engine3d.core.Object3D;
   
   public class Prop extends EventDispatcher
   {
       
      public var type:String;
      
      public function Prop(param1:String = "")
      {
         super();
         this.type = param1;
      }
      
      public function getProp(param1:String) : Object3D
      {
         return null;
      }
   }
}
