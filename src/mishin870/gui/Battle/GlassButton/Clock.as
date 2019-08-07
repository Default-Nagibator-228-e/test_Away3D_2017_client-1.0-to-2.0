package mishin870.gui.Battle.GlassButton {
    import flash.display.*;
    import flash.geom.*;
    import __AS3__.vec.*;

    public class Clock extends Sprite {

        private static const d:Number = 0.785398;
        private static const a:Number = 2.35619;
        private static const u:Number = 3.92699;
        private static const v:Number = 5.49779;

        private static var p:Vector.<Point>;

        private var n:Number;
        private var shape:Shape;
        public var off:int = 0;

        public function Clock(_arg1:int, _arg2:int){
            if (p == null){
                createPoints();
            };
            this.n = _arg1;
            graphics.beginFill(0, 0.7);
            graphics.drawRoundRect(0, 0, this.n, this.n, _arg2);
            graphics.endFill();
            var _local3:Shape = new Shape();
            this.shape = new Shape();
        }
        private static function createPoints():void{
            p = new Vector.<Point>(6);
            p[0] = new Point(1, 0);
            p[1] = new Point(1, 1);
            p[2] = new Point(0, 1);
            p[3] = new Point(0, 0);
            p[4] = new Point(0.5, 0);
            p[5] = new Point(0.5, 0.5);
        }

        public function addToContainer(_arg1:Sprite, _arg2:int, _arg3:int):void{
            _arg1.addChild(this.shape);
            this.shape.x = _arg2;
            this.shape.y = _arg3;
        }
        public function unknown(_arg1:Number):void{
            var _local2:Number = 0;
            var _local3:Number = 0;
            var _local4:Number = 0;
            var _local5:Number = ((2 * Math.PI) * _arg1);
            if (_local5 < d){
                _local4 = 0;
                _local2 = ((0.5 * this.n) * (1 + Math.tan(_local5)));
                _local3 = 0;
            } else {
                if (_local5 < a){
                    _local4 = 1;
                    _local2 = this.n;
                    _local3 = ((0.5 * this.n) * (1 - (1 / Math.tan(_local5))));
                } else {
                    if (_local5 < u){
                        _local4 = 2;
                        _local2 = ((0.5 * this.n) * (1 - Math.tan(_local5)));
                        _local3 = this.n;
                    } else {
                        if (_local5 < v){
                            _local4 = 3;
                            _local2 = 0;
                            _local3 = ((0.5 * this.n) * (1 + (1 / Math.tan(_local5))));
                        } else {
                            _local4 = 4;
                            _local2 = ((0.5 * this.n) * (1 + Math.tan(_local5)));
                            _local3 = 0;
                        };
                    };
                };
            };
            var _local6:Graphics = this.shape.graphics;
            _local6.clear();
            var _local7:Point = p[5];
            _local6.beginFill(0xFF0000);
            _local6.moveTo(_local2, _local3);
            while (_local4 < 6) {
                _local7 = p[_local4];
                _local6.lineTo((this.n * _local7.x), (this.n * _local7.y));
                _local4++;
            };
            _local6.lineTo(_local2, _local3);
            _local6.endFill();
            mask = this.shape;
        }

    }
}//package mishin870.gui.Battle.GlassButton 
