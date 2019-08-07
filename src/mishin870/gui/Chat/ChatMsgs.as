package mishin870.gui.Chat {
    import mishin870.gui.*;
    import __AS3__.vec.*;
    import mishin870.gui.rang.*;

    public class ChatMsgs extends ScrollingSprite {

        public var MAX_MSGS:int = 50;
        public var wid:Number;
        public var msgs:Vector.<ChatItem>;
        private var scr:ScrollVert;
        private var inl:Boolean = false;

        public function ChatMsgs(_arg1:ScrollVert){
            this.msgs = new Vector.<ChatItem>();
            super();
            this.scr = _arg1;
            if (_arg1 != null){
                this.inl = true;
            };
            if (this.inl){
                this.refrAWH();
            };
        }
        public function refreshScr():void{
            var _local1:Number;
            if (this.msgs.length > 0){
                _local1 = (this.msgs.length * this.msgs[0].height);
            } else {
                _local1 = 1;
            };
            this.scr.scrollY = ((scrollRect.height / _local1) * py);
        }
        public function refrAWH():void{
            var _local1:Number;
            if (this.msgs.length > 0){
                _local1 = (this.msgs.length * this.msgs[0].height);
            } else {
                _local1 = 1;
            };
            setAWH(scrollRect.width, _local1);
            this.scr.visible = (_local1 >= scrollRect.height);
            this.scr.scrollH = (scrollRect.height / _local1);
            this.scr.scrollY = ((scrollRect.height / _local1) * py);
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
            if (this.inl){
                this.refrAWH();
            };
        }
        public function clear():void{
            try {
                while (true) {
                    removeChildAt(0);
                };
            } catch(e:Error) {
            };
            this.msgs = new Vector.<ChatItem>();
            if (this.inl){
                this.refrAWH();
            };
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
            if (this.inl){
                this.refrAWH();
            };
        }
        public function addMessage(_arg1:Number, _arg2:int, _arg3:String, _arg4:int=0, _arg5:String="", _arg6:int=0, _arg7:String=""):void{
            var _local8:ChatItem = new ChatItem(_arg1, "0", _arg2, _arg3, new RangSmall((_arg4 + 1)), _arg5, new RangSmall((_arg6 + 1)), _arg7);
            _local8.x = 15;
            if ((this.msgs.length + 1) >= this.MAX_MSGS){
                this.up();
            };
            if (this.msgs.length == 0){
                _local8.y = 0;
            } else {
                _local8.y = (this.msgs[(this.msgs.length - 1)].y + this.msgs[(this.msgs.length - 1)].height);
            };
            addChild(_local8);
            this.msgs.push(_local8);
            if (this.inl){
                this.refrAWH();
            };
        }
        public function res(_arg1:Number):void{
            var _local2:ChatItem;
            var _local3:int;
            for each (_local2 in this.msgs) {
                _local2.refresh(_arg1);
            };
            _local3 = 0;
            while (_local3 < this.msgs.length) {
                if (_local3 == 0){
                    this.msgs[_local3].y = 0;
                } else {
                    this.msgs[_local3].y = (this.msgs[(_local3 - 1)].y + this.msgs[(_local3 - 1)].height);
                };
                _local3++;
            };
        }

    }
}//package mishin870.gui.Chat 
