package mishin870.gui.Battles {
    import flash.events.*;
    import flash.display.*;
    import mishin870.gui.*;

    public class Battles extends Sprite {

        public var battlesW:BattlesWindow;
        public var battleItems:BattleItems;
        public var scr:ScrollVert;

        public function Battles(){
            this.battlesW = new BattlesWindow();
            this.scr = new ScrollVert();
            super();
            this.battleItems = new BattleItems(this.scr);
            addChild(this.battlesW);
            addChild(this.battleItems);
            addChild(this.scr);
            this.battleItems.y = 15;
            addEventListener(MouseEvent.MOUSE_WHEEL, this.mw);
        }
        private function mw(_arg1:MouseEvent):void{
            this.battleItems.scroll(0, (-(_arg1.delta) * 2));
            this.battleItems.refreshScr();
        }
        public function addBattle(_arg1:String, _arg2:String, _arg3:String, _arg4:int, _arg5:int, _arg6:int, _arg7:int, _arg8:int, _arg9:int, _arg10:int, _arg11:int):void{
            this.battleItems.addBattle(((this.battlesW.width*0.90) - this.battleItems.off), _arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7, _arg8, _arg9, _arg10, _arg11);
        }
        public function res(_arg1:Number, _arg2:Number):void{
            this.battlesW.res(_arg1, (_arg2 - 50));
            this.battleItems.setRect(_arg1, (_arg2 - 120));
            this.battleItems.res((this.battlesW.width - 30));
            this.scr.x = ((_arg1 - this.scr.wid) - 15);
            this.scr.y = 15;
            this.scr.hei = (_arg2 - 120);
            this.battleItems.refrAWH((this.battlesW.width - 30));
            this.battleItems.scroll(0, 0);
        }

    }
}//package mishin870.gui.Battles 
