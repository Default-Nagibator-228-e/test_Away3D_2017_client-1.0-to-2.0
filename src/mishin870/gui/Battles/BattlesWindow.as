package mishin870.gui.Battles {
	import controls.DefaultButton;
	import controls.TankWindow;
	import controls.TankWindowHeader;
	import controls.TankWindowInner;
    import flash.events.*;
    import flash.display.*;
    import controls.*;

    public class BattlesWindow extends Sprite {

        private var win:TankWindow;
        private var wini:TankWindowInner;
        private var createBut:DefaultButton;

        public function BattlesWindow(){
            this.win = new TankWindow();
            this.wini = new TankWindowInner(-1, -1, 4278985229);
            this.createBut = new DefaultButton();
            super();
            addChild(this.win);
            addChild(this.wini);
            addChild(this.createBut);
            this.createBut.label = "Создать";
            this.createBut.addEventListener(MouseEvent.CLICK, function (_arg1:MouseEvent):void{
                Main.instance.lobby.battleInfo.visible = false;
                Main.instance.lobby.battles.visible = false;
                Main.instance.lobby.bcw.visible = true;
                Main.sbid = -1;
            });
            this.res(100, 200);
        }
        public function res(_arg1:Number, _arg2:Number):void{
            this.win.width = _arg1;
            this.win.height = (_arg2 - 4);
            this.wini.x = 10;
            this.wini.y = 10;
            this.wini.width = (_arg1 - 20);
            this.wini.height = (_arg2 - 60);
            this.createBut.x = ((_arg1 - this.createBut.width) - 10);
            this.createBut.y = (_arg2 - 45);
        }

    }
}//package mishin870.gui.Battles 
