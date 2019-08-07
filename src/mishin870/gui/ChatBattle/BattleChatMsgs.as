package mishin870.gui.ChatBattle {
    import mishin870.gui.*;
    import __AS3__.vec.*;
    import mishin870.gui.rang.*;

    public class BattleChatMsgs extends ScrollingSpriteGarage {

        private var hei:int = 100;
        public var MAX_MSGS:int = 30;
        public var wid:Number;
        public var msgs:Vector.<ChatItem>;

        public function BattleChatMsgs(){
            this.msgs = new Vector.<ChatItem>();
            super();
        }
        private function up():void{
            var _local1:ChatItem = this.msgs[0];
            removeChild(_local1);
            this.msgs.splice(0, 1);
            _local1 = null;
        }
        public function clear():void{
            var _local2:ChatItem;
            var _local1:int = (this.msgs.length - 1);
            while (_local1 >= 0) {
                _local2 = this.msgs[_local1];
                removeChild(_local2);
                this.msgs.splice(_local1, 1);
                _local2 = null;
                _local1--;
            };
        }
        private function getVisibleMsgsNum():int{
            var _local1:int;
            var _local2:int;
            while (_local2 < this.msgs.length) {
                if (!this.msgs[_local2].deleted){
                    _local1++;
                };
                _local2++;
            };
            return (_local1);
        }
        public function addMessage(_arg1:Number, _arg2:int, _arg3:String, _arg4:int=0, _arg5:String="", _arg6:int=0, _arg7:String=""):void{
            var _local9:int;
            var _local8:ChatItem = new ChatItem(_arg1, "0", _arg2, _arg3, new RangSmall((_arg4 + 1)), _arg5, new RangSmall((_arg6 + 1)), _arg7);
            if ((this.msgs.length + 1) >= this.MAX_MSGS){
                this.up();
            };
            if (this.msgs.length == 0){
                _local8.y = (this.hei - _local8.height);
            } else {
                _local9 = 0;
                while (_local9 < this.msgs.length) {
                    this.msgs[_local9].y = (this.msgs[_local9].y - _local8.height);
                    _local9++;
                };
                _local8.y = (this.hei - _local8.height);
            };
            addChild(_local8);
            this.msgs.push(_local8);
            this.checkVis();
        }
        public function showHideAll(_arg1:Boolean):void{
            var _local2:ChatItem;
            if (_arg1){
                for each (_local2 in this.msgs) {
                    _local2.show2();
                };
            } else {
                for each (_local2 in this.msgs) {
                    _local2.hide2();
                };
            };
        }
        private function checkVis():void{
            var _local2:int;
            var _local3:int;
            var _local1:int = this.getVisibleMsgsNum();
            if (_local1 > 6){
                _local2 = 0;
                _local3 = (this.msgs.length - 1);
                while (_local3 >= 0) {
                    if (_local2 >= 6){
                        this.msgs[_local3].hide();
                    };
                    _local2++;
                    _local3--;
                };
            };
        }
        public function res(_arg1:Number):void{
            var _local2:ChatItem;
            var _local3:int;
            for each (_local2 in this.msgs) {
                _local2.refresh(_arg1);
            };
            _local3 = (this.msgs.length - 1);
            while (_local3 >= 0) {
                if (_local3 == (this.msgs.length - 1)){
                    this.msgs[_local3].y = (this.hei - this.msgs[_local3].height);
                } else {
                    this.msgs[_local3].y = (this.msgs[(_local3 + 1)].y - this.msgs[(_local3 + 1)].height);
                };
                _local3--;
            };
        }
        public function setHeight(_arg1:int):void{
            this.hei = _arg1;
            this.res(this.wid);
        }

    }
}//package mishin870.gui.ChatBattle 
