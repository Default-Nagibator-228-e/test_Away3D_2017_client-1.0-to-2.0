package alternativa.tanks.config
{
   import flash.events.EventDispatcher;
   import flash.events.Event;
   
   public class SimpleLoader extends EventDispatcher
   {
       
      public function SimpleLoader()
      {
         super();
      }
      
      public function load() : void
      {
      }
      
      public function completeLoading() : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
