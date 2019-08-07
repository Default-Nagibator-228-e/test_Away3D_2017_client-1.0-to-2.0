package alternativa.tanks.resources
{
   import flash.display.BitmapData;
   
   public class ImageLib
   {
      
      private static var objects:Object = new Object();
       
      public function ImageLib()
      {
         super();
      }
      
      public static function addImage(param1:String, param2:BitmapData) : void
      {
         objects[param1] = param2;
      }
      
      public static function getImage(param1:String) : BitmapData
      {
         return objects[param1];
      }
   }
}
