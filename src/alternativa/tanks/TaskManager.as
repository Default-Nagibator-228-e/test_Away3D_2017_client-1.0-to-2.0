package alternativa.tanks
{
   import alternativa.tanks.tasks.TaskManagerTask;
   
   public class TaskManager
   {
       
      private var tasks:Vector.<TaskManagerTask>;
      
      public function TaskManager()
      {
         this.tasks = new Vector.<TaskManagerTask>();
         super();
      }
      
      public function addTask(param1:TaskManagerTask) : void
      {
         this.tasks.push(param1);
      }
      
      public function removeTask(param1:int) : void
      {
         this.tasks.splice(param1,1);
      }
      
      public function get numTasks() : int
      {
         return this.tasks.length;
      }
      
      public function update(param1:Game) : void
      {
         var _loc2_:TaskManagerTask = null;
         for each(_loc2_ in this.tasks)
         {
            _loc2_.start(param1);
            _loc2_ = null;
         }
         this.tasks = new Vector.<TaskManagerTask>();
      }
   }
}
