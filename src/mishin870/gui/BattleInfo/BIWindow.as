package mishin870.gui.BattleInfo {
	import controls.TankWindow;
	import controls.TankWindowHeader;
	import controls.TankWindowInner;
    import flash.display.*;
    import controls.*;

    public class BIWindow extends Sprite {

        private var win:TankWindow;
        private var wini:TankWindowInner;

        public function BIWindow(){
            this.win = new TankWindow();
            this.wini = new TankWindowInner(-1, -1, 4278985229);
            super();
            addChild(this.win);
            this.res(100, 200);
        }
        public function res(_arg1:Number, _arg2:Number):void{
            this.win.width = _arg1;
            this.win.height = (_arg2 - 4);
            this.wini.x = 10;
            this.wini.y = 10;
            this.wini.width = (_arg1 - 20);
            this.wini.height = (_arg2 - 60);
        }

    }
}//package mishin870.gui.BattleInfo 
