package loaderw
{
   import flash.display.Sprite;
   import flash.display.*;

   public class LoaderLamp extends Sprite
   {
      {
      private static const offClass:Class = LoaderLamp_offClass;
      private static const onClass:Class = LoaderLamp_onClass;
      private var off:Bitmap;
      private var on:Bitmap;
      }
      public function LoaderLamp() {
         this.off=new offClass();
         this.on=new onClass();
         super();
         this.setState(false);
         return;
      }
      private function removeAl() : void {
         try
            {
               while(true)
                  {
                     removeChildAt(0);
                  }
            }
         catch(e:Error)
            {
            }
         return;
      }
      public function setState(param1:Boolean) : void {
         this.removeAl();
         if(param1)
            {
               addChild(this.on);
            }
         else
            {
               addChild(this.off);
            }
         return;
      }
   }
}
