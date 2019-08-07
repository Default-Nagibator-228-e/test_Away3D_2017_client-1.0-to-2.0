package mishin870.gui.BattleInfo {
	import controls.TankWindowInner;
    import flash.events.*;
    import flash.display.*;
    import controls.*;

    public class BattleInfoPlayersWindow extends Sprite {

        public var bip:BattleInfoPlayers;
        private var inner:TankWindowInner;

        public function BattleInfoPlayersWindow(_arg1:int, _arg2:int){
            this.bip = new BattleInfoPlayers(_arg1, _arg2);
            this.bip.y = 3;
            if (_arg1 == 0){
                this.inner = new TankWindowInner(-1, -1, 4278985229);
            };
            if (_arg1 == 1){
                this.inner = new TankWindowInner(-1, -1, 0xFF621700);
            };
            if (_arg1 == 2){
                this.inner = new TankWindowInner(-1, -1, 0xFF002C59);
            };
            addChild(this.inner);
            addChild(this.bip);
            addEventListener(MouseEvent.MOUSE_WHEEL, this.mw);
        }
        private function mw(_arg1:MouseEvent):void{
            this.bip.scroll(0, (-(_arg1.delta) * 2));
        }
        public function res(_arg1:int, _arg2:int):void{
            this.bip.y = 3;
            this.bip.setRect(_arg1, (_arg2 - 5));
            this.bip.res(_arg1);
            this.bip.scroll(0, 0);
            this.inner.width = _arg1;
            this.inner.height = _arg2;
        }

    }
}//package mishin870.gui.BattleInfo 
