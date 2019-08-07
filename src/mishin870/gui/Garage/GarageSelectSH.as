package mishin870.gui.Garage
{
	import controls.DefaultButton;
	import controls.TankWindow;
	import controls.TankWindowHeader;
	import controls.TankWindowInner;
    import flash.events.*;
    import flash.display.*;
    import controls.*;

    public class GarageSelectSH extends Sprite {
        private var win:TankWindow;
        private var BmyItems:DefaultButton;
        private var Bshop:DefaultButton;
		

        public function GarageSelectSH(){
            this.win = new TankWindow();
            super();
            addChild(this.win);
			
			this.BmyItems = new DefaultButton();
			this.Bshop = new DefaultButton();
			
			this.BmyItems.width = 100;
			this.BmyItems.x = 15;
			this.BmyItems.y = 15;
			this.Bshop.width = 100;
			this.Bshop.x = 125;
			this.Bshop.y = 15;
			this.BmyItems.label = "Мой склад";
			this.Bshop.label = "Магазин";
			
			this.BmyItems.addEventListener(MouseEvent.MOUSE_UP, selectS);
			this.Bshop.addEventListener(MouseEvent.MOUSE_UP, selectH);
			
			addChild(this.BmyItems);
			addChild(this.Bshop);
			
            this.res(240, 70);
        }
		public function selectS(param1:Boolean){
			Main.instance.lobby.garage.shop.visible = false;
			Main.instance.lobby.garage.myItems.visible = true;
		}
		public function selectH(param1:Boolean){
			Main.instance.lobby.garage.shop.visible = true;
			Main.instance.lobby.garage.myItems.visible = false;
		}
        public function res(_arg1:Number, _arg2:Number):void{
            this.win.width = _arg1;
            this.win.height = (_arg2 - 4);
        }
		
    }
}