package mishin870.gui.menuWindow 
{
	import controls.DefaultButton;
	import controls.TankWindow;
	import controls.TankWindowHeader;
	import controls.TankWindowInner;
    import flash.events.*;
    import flash.display.*;
    import controls.*;

    public class menu extends Sprite {
        private var win:TankWindow;
        private var createBut:DefaultButton;

        public function menu(){
            this.win = new TankWindow();
            super();
            addChild(this.win);
            this.res(100, 200);
        }
        public function res(_arg1:Number, _arg2:Number):void{
            this.win.width = _arg1;
            this.win.height = (_arg2 - 4);
        }

    }
}