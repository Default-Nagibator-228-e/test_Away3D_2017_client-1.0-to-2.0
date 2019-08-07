package mishin870.gui.Garage
{
   import flash.display.Sprite;
   import controls.TankWindow;
   import controls.TankWindowInner;
   
   public class MyTank extends Sprite
   {
       
      private var tv:mishin870.gui.Garage.TankViewer;
      
      private var w:TankWindow;
      
      public var inner:TankWindowInner;
      
      public function MyTank()
      {
         this.inner = new TankWindowInner(-1,-1,16777215);
         super();
         this.tv = new mishin870.gui.Garage.TankViewer(this);
         this.w = new TankWindow();
         addChild(this.w);
         addChild(this.tv);
         addChild(this.inner);
      }
      
      public function destroy() : void
      {
         this.tv.destroy();
      }
      
      public function restore() : void
      {
         this.tv.restore();
      }
      
      public function setTank(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:XML = Main.instance.xml;
         this.setTank2(_loc4_.hulls[0].hull[param1].@path,_loc4_.turrets[0].turret[param2].@path,_loc4_.colormaps[0].colormap[param3].@path + "image.jpg");
      }
      
      public function setTank2(param1:String, param2:String, param3:String) : void
      {
         this.tv.loadTank(param1,param2,param3);
      }
      
      public function res(param1:Number, param2:Number) : void
      {
         this.w.width = param1;
         this.w.height = param2;
         this.tv.x = 12;
         this.tv.y = 12;
         this.tv.res(param1 - 24,param2 - 24);
         this.inner.width = param1 - 24;
         this.inner.height = param2 - 24;
         this.inner.x = 12;
         this.inner.y = 12;
      }
   }
}
