package mishin870.gui.Garage.Items
{
   import flash.display.Sprite;
   import controls.TankWindow;
   import controls.TankWindowInner;
   import mishin870.gui.ScrollVertGarage;
   import flash.events.MouseEvent;
   import controls.TankWindowHeader;
   
   public class GarageItemsWindow extends Sprite
   {
      
      private static const offsetX:Number = 0;
      
      private static const offsetY:Number = 0;
       
      private var w:TankWindow;
      
      private var inner:TankWindowInner;
      
      public var items:GarageItems;
      
      private var scr:ScrollVertGarage;
      
      public function GarageItemsWindow(param1:Boolean = false)
	  {
         this.w = new TankWindow();
         this.inner = new TankWindowInner(-1,-1,4278985229);
         this.scr = new ScrollVertGarage();
         super();
         addChild(this.w);
         addChild(this.inner);
         this.items = new GarageItems(this.scr);
         addChild(this.items);
         addChild(this.scr);
         addEventListener(MouseEvent.MOUSE_WHEEL,this.mw);
      }
      
      public function sort() : void
      {
         this.items.sort();
      }
      
      public function mw(param1:MouseEvent) : void
      {
         this.items.scroll( -param1.delta*20, 0);
         this.items.refreshScr();
      }
      
      public function res(param1:Number, param2:Number) : void
      {
         this.w.x = offsetX;
         this.w.y = offsetY;
         this.w.width = param1;
         this.w.height = param2;
         this.inner.x = offsetX + 10;
         this.inner.y = offsetY + 10;
         this.inner.width = param1 - offsetX - 20;
         this.inner.height = param2 - offsetY - 20;
         this.items.x = offsetX + 15;
         this.items.y = offsetY + 15;
         this.scr.x = this.w.x + this.w.width - 20;
         this.scr.y = this.items.y;
         this.items.setRect(param1 - 30,param2 - 30);
         this.scr.hei = param2 - 30;
         this.items.refrAWH();
         this.items.scroll(0,0);
      }
   }
}
