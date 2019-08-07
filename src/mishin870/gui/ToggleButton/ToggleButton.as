package mishin870.gui.ToggleButton {
	import controls.Label;
    import flash.events.*;
    import flash.display.*;
    import controls.*;
    import flash.text.*;
    import flash.filters.*;

    public class ToggleButton extends Sprite {

        private static const UP_OFF:int = 2;
        private static const DOWN_OFF:int = 3;

        private var _label1:Label;
        private var _label2:Label;
        private var skin:ToggleButtonSkin;
        private var _enable:Boolean = true;
        private var off:int = 2;

        public function ToggleButton(){
            this._label1 = new Label();
            this._label2 = new Label();
            this.skin = new ToggleButtonSkin();
            super();
            addChild(this.skin);
            var _local1:TextFormat = new TextFormat();
            _local1.font = this._label1.defaultTextFormat.font;
            _local1.size = (this._label1.defaultTextFormat.size + 2);
            this._label1.defaultTextFormat = _local1;
            this._label2.defaultTextFormat = _local1;
            var _local2:Array = [new GlowFilter(0, 0.8, 2, 2, 2)];
            addChild(this._label1);
            addChild(this._label2);
            this._label1.filters = _local2;
            this._label2.filters = _local2;
            addEventListener(MouseEvent.ROLL_OVER, this.skinH);
            addEventListener(MouseEvent.ROLL_OUT, this.skinN);
            addEventListener(MouseEvent.MOUSE_MOVE, this.skinH);
            addEventListener(MouseEvent.MOUSE_DOWN, this.skinD);
        }
        public function set enable(_arg1:Boolean):void{
            this._enable = _arg1;
            if (this._enable){
                this.skinN();
            } else {
                this.skinD();
            };
        }
        public function get enable():Boolean{
            return (this._enable);
        }
        private function skinN(_arg1:MouseEvent=null):void{
            if (!this._enable){
                return;
            };
            this.off = UP_OFF;
            this.skin.skin = ToggleButtonSkin.SKIN_NORM;
            this.refreshLabel();
        }
        private function skinH(_arg1:MouseEvent=null):void{
            if (!this._enable){
                return;
            };
            this.off = UP_OFF;
            this.skin.skin = ToggleButtonSkin.SKIN_HOVER;
            this.refreshLabel();
        }
        private function skinD(_arg1:MouseEvent=null):void{
            this.off = DOWN_OFF;
            this.skin.skin = ToggleButtonSkin.SKIN_DOWN;
            this.refreshLabel();
        }
        public function set wid(_arg1:int):void{
            this.skin.wid = _arg1;
            this.refreshLabel();
        }
        public function get wid():int{
            return (this.skin.wid);
        }
        public function setLabels(_arg1:String, _arg2:String):void{
            this._label1.text = _arg1;
            this._label2.text = _arg2;
            this.refreshLabel();
        }
        private function refreshLabel():void{
            this._label1.x = ((this.skin.wid / 2) - (this._label1.width / 2));
            this._label2.x = ((this.skin.wid / 2) - (this._label2.width / 2));
            this._label1.y = (((height / 2) - this._label1.height) + this.off);
            this._label2.y = (((height / 2) - 4) + this.off);
        }

    }
}//package mishin870.gui.ToggleButton 
