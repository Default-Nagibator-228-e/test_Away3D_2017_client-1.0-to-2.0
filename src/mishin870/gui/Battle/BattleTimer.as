package mishin870.gui.Battle {
    import flash.events.*;
    import flash.utils.*;

    public class BattleTimer {

        private var dpg:DownPanelGUI;
        private var time:int = 900;
        private var tempTime:int = 1000;
        private var prevTime:int;

        public function BattleTimer(_arg1:DownPanelGUI){
            this.dpg = _arg1;
        }
        public function start():void{
            this.prevTime = getTimer();
            this.dpg.addEventListener(Event.ENTER_FRAME, this.ef);
        }
        public function stop():void{
            this.dpg.removeEventListener(Event.ENTER_FRAME, this.ef);
        }
        private function ef(_arg1:Event):void{
            var _local2:int = getTimer();
            var _local3:int = (_local2 - this.prevTime);
            this.prevTime = _local2;
            this.tempTime = (this.tempTime - _local3);
            if (this.tempTime <= 0){
                this.tempTime = 1000;
                this.time--;
                if (this.time < 0){
                    this.time = 0;
                };
                this.dpg.setTimeLabel(this.getLabel(this.time));
            };
        }
        public function setTime(_arg1:int):void{
            this.time = _arg1;
        }
        private function getLabel(_arg1:int):String{
            var _local2:int = (_arg1 / 60);
            var _local3:int = (_arg1 % 60);
            var _local4:String = (((_local3 < 10)) ? ("0" + _local3) : ("" + _local3));
            return (((_local2 + " : ") + _local4));
        }

    }
}//package mishin870.gui.Battle 
