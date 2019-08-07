package mishin870.gui.BattleInfo {
	import controls.TankWindowInner;
    import mishin870.gui.*;
    import __AS3__.vec.*;
    import controls.*;
    import mishin870.gui.rang.*;

    public class BattleInfoPlayers extends ScrollingSpriteGarage {

        public var items:Vector.<BattleInfoPlayersItem>;
        public var MAX_PLAYERS:int;
        public var CURRENT_PLAYERS:int;
        public var team:int;
        private var inner:TankWindowInner;

        public function BattleInfoPlayers(_arg1:int, _arg2:int){
            var _local4:BattleInfoPlayersItem;
            this.items = new Vector.<BattleInfoPlayersItem>();
            super();
            this.MAX_PLAYERS = _arg2;
            this.team = _arg1;
            var _local3:int;
            while (_local3 < _arg2) {
                _local4 = new BattleInfoPlayersItem(1, _arg1);
                if (_local3 != 0){
                    _local4.y = (this.items[(this.items.length - 1)].y + 20);
                } else {
                    _local4.y = 3;
                };
                _local4.x = 3;
                addChild(_local4);
                this.items.push(_local4);
                _local3++;
            };
            this.res(100);
        }
        public function refrAWH():void{
            var _local1:Number;
            if (this.items.length > 0){
                _local1 = (this.items.length * 20);
            } else {
                _local1 = 1;
            };
            setAWH(scrollRect.width, _local1);
        }
        public function setPlayers(_arg1:Vector.<String>, _arg2:Vector.<int>):void{
            var _local3:BattleInfoPlayersItem;
            var _local4:int;
            this.CURRENT_PLAYERS = 0;
            for each (_local3 in this.items) {
                removeChild(_local3);
                _local3 = null;
            };
            this.items = new Vector.<BattleInfoPlayersItem>();
            _local4 = 0;
            while (_local4 < this.MAX_PLAYERS) {
                if (_arg1.length > _local4){
                    _local3 = new BattleInfoPlayersItem(0, this.team, _arg1[_local4], new RangSmall((_arg2[_local4] + 1)));
                    this.CURRENT_PLAYERS++;
                } else {
                    _local3 = new BattleInfoPlayersItem(1, this.team);
                };
                _local3.y = (_local4 * 20);
                _local3.x = 3;
                this.items.push(_local3);
                addChild(_local3);
                _local4++;
            };
            this.refrAWH();
        }
        public function res(_arg1:Number):void{
            var _local2:BattleInfoPlayersItem;
            for each (_local2 in this.items) {
                _local2.setMaxWidth((_arg1 - 7));
            };
            this.refrAWH();
        }

    }
}//package mishin870.gui.BattleInfo 
