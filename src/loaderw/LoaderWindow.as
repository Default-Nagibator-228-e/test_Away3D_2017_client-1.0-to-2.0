package loaderw
{
   import flash.display.Sprite;
   import flash.display.Bitmap;
   import controls.Label;
   
   public class LoaderWindow extends Sprite
   {
      
      private static const loaderHeaderClass:Class = LoaderWindow_loaderHeaderClass;
      
      private static const loaderWindowClass:Class = LoaderWindow_loaderWindowClass;
       
      private var loaderWindow:Bitmap;
      
      private var loaderProgress:loaderw.LoaderProgress;
      
      private var loaderHeader:Bitmap;
      
      private var cap:Label;
      
      public function LoaderWindow()
      {
         this.loaderWindow = new loaderWindowClass();
         this.loaderProgress = new loaderw.LoaderProgress();
         this.loaderHeader = new loaderHeaderClass();
         this.cap = new Label();
         super();
         addChild(this.loaderWindow);
         addChild(this.loaderProgress);
         addChild(this.loaderHeader);
         addChild(this.cap);
         this.loaderHeader.y = 12;
         this.loaderHeader.x = this.loaderWindow.width / 2 - this.loaderHeader.width / 2;
         this.loaderProgress.x = 16;
         this.loaderProgress.y = 49;
      }
      
      public function setCaption(param1:String) : void
      {
         this.cap.text = param1;
         this.cap.y = 31;
         this.cap.x = this.loaderWindow.width / 2 - this.cap.width / 2;
      }
      
      public function setProgress(param1:int) : void
      {
         this.loaderProgress.setProgress(param1);
      }
   }
}
