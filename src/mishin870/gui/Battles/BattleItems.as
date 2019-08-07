package mishin870.gui.Battles {
    import mishin870.gui.*;
    import __AS3__.vec.*;

    public class BattleItems extends ScrollingSprite {
        public var wid:Number;
        public var battles:Vector.<BattleListItem>;
        private var scr:ScrollVert;
        public var off:int = 0;

        public function BattleItems(_arg1:ScrollVert){
            this.battles = new Vector.<BattleListItem>();
            super();
            this.scr = _arg1;
            this.refrAWH(100);
        }
        public function refreshScr():void{
            var _local1:Number;
            if (this.battles.length > 0){
                _local1 = (this.battles.length * this.battles[0].height);
            } else {
                _local1 = 1;
            };
            this.scr.scrollY = ((scrollRect.height / _local1) * py);
        }
        public function refrAWH(_arg1:Number):void{
            var _local2:Number;
            if (this.battles.length > 0){
                _local2 = (this.battles.length * this.battles[0].height);
            } else {
                _local2 = 1;
            };
            setAWH(scrollRect.width, _local2);
            if (this.scr.visible != (_local2 >= scrollRect.height)){
                this.scr.visible = (_local2 >= scrollRect.height);
                if (this.scr.visible){
                    this.off = (this.scr.wid + 3);
                } else {
                    this.off = 0;
                };
            };
            this.res((_arg1 - this.off));
            this.scr.scrollH = (scrollRect.height / _local2);
            this.scr.scrollY = ((scrollRect.height / _local2) * py);
        }
        public function clear():void{
            var _local1:BattleListItem;
            for each (_local1 in this.battles) {
                removeChild(_local1);
            };
            this.battles = new Vector.<BattleListItem>();
            this.refrAWH(this.wid);
        }
        public function addBattle(_arg1:Number, _arg2:String, _arg3:String, _arg4:String, _arg5:int, _arg6:int, _arg7:int, _arg8:int, _arg9:int, _arg10:int, _arg11:int, _arg12:int):void{
            var _local12:int;
            var _local13:int;
            while (_local13 < this.battles.length) {
                if (this.battles[_local13].sel){
                    _local12 = _local13;
                };
                _local13++;
            };
            var _local14:BattleListItem = new BattleListItem(_arg10, _arg1, _arg2, _arg3, _arg4, _arg7, _arg8, _arg9, this.bliClick, _arg6, _arg12);
            _local14.x = 15;
            if (_arg5 == 0){
                _local14.setState(_arg5, 0, _local14.MAX_PLAYERS);
            } else {
                _local14.setState(_arg5, 0, _local14.MAX_PLAYERS, 0, _local14.MAX_PLAYERS);
            };
            _local14.type = _arg5;
            if (this.battles.length <= 0){
                _local14.y = 0;
            } else {
                _local14.y = (this.battles[(this.battles.length - 1)].y + this.battles[(this.battles.length - 1)].height);
            };
            addChild(_local14);
            this.battles.push(_local14);
            this.select(_local12);
            this.sort(_arg11);
            this.refrAWH(_arg1);
        }
        private function getBattles(_arg1:int, _arg2:Boolean):Vector.<BattleListItem>{
            var _local4:BattleListItem;
            var _local5:Boolean;
            var _local3:Vector.<BattleListItem> = new Vector.<BattleListItem>();
            for each (_local4 in this.battles) {
                _local5 = (((_arg1 >= _local4.minRank)) && ((_arg1 <= _local4.maxRank)));
                if (_local5 == _arg2){
                    _local3.push(_local4);
                };
            };
            return (_local3);
        }
        public function sort(_arg1:int):void{
            var _local2:Vector.<BattleListItem> = this.getBattles(_arg1, true);
            var _local3:Vector.<BattleListItem> = this.getBattles(_arg1, false);
            var _local4:int;
            while (_local4 < _local2.length) {
                _local2[_local4].enab = true;
                _local2[_local4].mu2();
                if (_local4 == 0){
                    _local2[_local4].y = 0;
                } else {
                    _local2[_local4].y = (_local2[(_local4 - 1)].y + _local2[(_local4 - 1)].height);
                };
                _local4++;
            };
            _local4 = 0;
            while (_local4 < _local3.length) {
                _local3[_local4].enab = false;
                _local3[_local4].mu2();
                if (_local4 == 0){
                    if (_local2.length <= 0){
                        _local3[_local4].y = 0;
                    } else {
                        _local3[_local4].y = (_local2[(_local2.length - 1)].y + _local2[(_local2.length - 1)].height);
                    };
                } else {
                    _local3[_local4].y = (_local3[(_local4 - 1)].y + _local3[(_local4 - 1)].height);
                };
                _local4++;
            };
            this.refrAWH(this.wid);
        }
        public function getBattle(_arg1:int):BattleListItem{
            var _local2:BattleListItem;
            for each (_local2 in this.battles) {
                if (_local2.id == _arg1){
                    return (_local2);
                };
            };
            return (null);
        }
        public function setPlayers(_arg1:int, _arg2:int, _arg3:int):void{
            var _local4:BattleListItem = this.getBattle(_arg1);
            if (_local4 == null){
                return;
            };
            if (_local4.type == 0){
                _local4.setState(_local4.type, _arg2, _local4.MAX_PLAYERS);
            } else {
                _local4.setState(_local4.type, _arg2, _local4.MAX_PLAYERS, _arg3, _local4.MAX_PLAYERS);
            };
        }
        public function res(_arg1:Number):void{
            var _local2:BattleListItem;
            for each (_local2 in this.battles) {
                _local2.resize(_arg1);
            };
        }
        private function select(_arg1:int):void{
            var _local2:int;
            while (_local2 < this.battles.length) {
                this.battles[_local2].sel = (_local2 == _arg1);
                this.battles[_local2].mu2();
                _local2++;
            };
        }
        public function sel(_arg1:int):void{
            if (this.getBattle(_arg1) == null){
                return;
            };
            var _local2:int;
            while (_local2 < this.battles.length) {
                this.battles[_local2].sel = (_local2 == _arg1);
                this.battles[_local2].mu2();
                _local2++;
            };
        }
        public function bliClick(_arg1:BattleListItem):void{
            var _local2:BattleListItem;
            for each (_local2 in this.battles) {
                if (_local2 == _arg1){
                    _local2.sel = true;
                    Main.instance.selectBattle(_local2);
                } else {
                    _local2.sel = false;
                    _local2.mu2();
                };
            };
        }

    }
}//package mishin870.gui.Battles 
