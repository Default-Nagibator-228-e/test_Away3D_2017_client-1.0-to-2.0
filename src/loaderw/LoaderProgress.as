package loaderw
{
   import flash.display.Sprite;
   import flash.display.Bitmap;
   
   public class LoaderProgress extends Sprite
   {
      
      private static const loaderProgressClass:Class = LoaderProgress_loaderProgressClass;
       
      private var loaderProgress:Bitmap;
      
      private var lamps:Vector.<loaderw.LoaderLamp>;
      
      public function LoaderProgress()
      {
         this.loaderProgress = new loaderProgressClass();
         this.lamps = new Vector.<loaderw.LoaderLamp>(20);
         super();
         addChild(this.loaderProgress);
         var _loc1_:int = 0;
         while(_loc1_ < this.lamps.length)
         {
            this.lamps[_loc1_] = new loaderw.LoaderLamp();
            if(_loc1_ != 0)
            {
               this.lamps[_loc1_].x = this.lamps[_loc1_ - 1].x + this.lamps[_loc1_ - 1].width - 2;
               this.lamps[_loc1_].y = 3;
            }
            else
            {
               this.lamps[_loc1_].x = 3;
               this.lamps[_loc1_].y = 3;
            }
            addChild(this.lamps[_loc1_]);
            _loc1_++;
         }
      }
      
      public function setProgress(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.lamps.length)
         {
            this.lamps[_loc2_].setState(param1 > _loc2_);
            _loc2_++;
         }
      }
   }
}
