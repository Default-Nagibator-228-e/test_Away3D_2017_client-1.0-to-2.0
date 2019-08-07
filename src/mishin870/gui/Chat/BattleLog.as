package mishin870.gui.Chat {
    import flash.display.*;
    import __AS3__.vec.*;
    import mishin870.gui.rang.*;

    public class BattleLog extends Sprite {

        public var MAX_MSGS:int = 10;
        public var msgs:Vector.<ChatItem>;

        public function BattleLog(){
            this.msgs = new Vector.<ChatItem>();
            super();
        }
        private function up():void{
            var _local2:ChatItem;
            var _local1:ChatItem = this.msgs[0];
            removeChild(_local1);
            for each (_local2 in this.msgs) {
                _local2.y = (_local2.y - _local1.height);
            };
            this.msgs.splice(0, 1);
            _local1 = null;
        }
        public function clear():void{
            try {
                while (true) {
                    removeChildAt(0);
                };
            } catch(e:Error) {
            };
            this.msgs = new Vector.<ChatItem>();
        }
        public function clearu(_arg1:String):void{
            var _local3:ChatItem;
            var _local4:int;
            var _local2:int;
            while (_local2 < this.msgs.length) {
                _local3 = this.msgs[_local2];
                if (_local3.n == _arg1){
                    removeChild(_local3);
                    _local4 = (_local2 + 1);
                    while (_local4 < this.msgs.length) {
                        this.msgs[_local4].y = (this.msgs[_local4].y - _local3.height);
                        _local4++;
                    };
                    this.msgs.splice(_local2, 1);
                    _local3 = null;
                    _local2--;
                };
                _local2++;
            };
        }
        public function addMessage(_arg1:int, _arg2:String, _arg3:int=0, _arg4:String="", _arg5:int=0, _arg6:String=""):void{
            var _local7:ChatItem = new ChatItem(0, "0", _arg1, _arg2, new RangSmall((_arg3 + 1)), _arg4, new RangSmall((_arg5 + 1)), _arg6);
            _local7.x = 15;
            if ((this.msgs.length + 1) >= this.MAX_MSGS){
                this.up();
            };
            if (this.msgs.length == 0){
                _local7.y = 0;
            } else {
                _local7.y = (this.msgs[(this.msgs.length - 1)].y + this.msgs[(this.msgs.length - 1)].height);
            };
            addChild(_local7);
            this.msgs.push(_local7);
        }

    }
}//package mishin870.gui.Chat 
