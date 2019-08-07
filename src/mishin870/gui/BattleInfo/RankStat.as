package mishin870.gui.BattleInfo {
    import flash.display.*;
    import mishin870.gui.rang.*;

    public class RankStat extends Sprite {

        public function setRanks(_arg1:int, _arg2:int):void{
            var _local8:RangSmall;
            try {
                while (true) {
                    removeChildAt(0);
                };
            } catch(e:Error) {
            };
            var _local3:int;
            var _local4:int;
            var _local5:RangSmall;
            var _local6:int;
            var _local7:int = _arg2;
            while (_local7 >= _arg1) {
                if (_local4 >= 16){
                    _local4 = 0;
                    _local3 = (_local3 - (_local6 + 2));
                    _local5 = null;
                };
                _local8 = new RangSmall(_local7);
                if (_local5 == null){
                    _local8.x = -(_local8.width);
                    _local8.y = (-(_local8.height) + _local3);
                    _local5 = _local8;
                } else {
                    _local8.y = (-(_local8.height) + _local3);
                    _local8.x = ((_local5.x - _local8.width) - 2);
                    _local5 = _local8;
                };
                if (_local8.height > _local6){
                    _local6 = _local8.height;
                };
                _local4++;
                addChild(_local8);
                _local7--;
            };
        }

    }
}//package mishin870.gui.BattleInfo 
