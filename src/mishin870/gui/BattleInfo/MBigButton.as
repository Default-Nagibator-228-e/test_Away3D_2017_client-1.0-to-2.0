package mishin870.gui.BattleInfo {
	import controls.BigButtonState;
	import controls.Label;
    import flash.events.*;
    import flash.display.*;
    import controls.*;
    import flash.text.*;
    import assets.icons.*;
    import assets.button.*;
    import flash.filters.*;

    public class MBigButton extends MovieClip {

        public static const SHORTAGE_ENERGY:BitmapData = new icon_SHORTAGE_ENERGY(35, 35);

        protected var stateUP:BigButtonState;
        protected var stateOVER:BigButtonState;
        protected var stateDOWN:BigButtonState;
        protected var stateOFF:BigButtonState;
        protected var _label:Label;
        protected var _info:Label;
        protected var _icon:Bitmap;
        protected var _width:int = 100;
        protected var _enable:Boolean = true;

        public function MBigButton(){
            this.stateUP = new BigButtonState();
            this.stateOVER = new BigButtonState();
            this.stateDOWN = new BigButtonState();
            this.stateOFF = new BigButtonState();
            this._label = new Label();
            this._info = new Label();
            this._icon = new Bitmap();
            this.configUI();
            this.enable = true;
            tabEnabled = false;
        }
        override public function set width(_arg1:Number):void{
            this._width = int(_arg1);
            this.stateUP.width = this._width;
            this.stateOVER.width = this._width;
            this.stateOFF.width = this._width;
            this.stateDOWN.width = this._width;
            var _local2:int = (this._width - 4);
            this._label.width = _local2;
            this._info.width = _local2;
            if (this._icon.bitmapData != null){
                this._icon.x = 2;
                this._icon.y = int((25 - (this._icon.height / 2)));
                this._label.width = (_local2 - this._icon.width);
                this._label.x = ((this._icon.x + this._icon.width) + 2);
            };
        }
        public function set label(_arg1:String):void{
            this._label.text = _arg1;
        }
        public function set info(_arg1:String):void{
            this._info.htmlText = _arg1;
        }
        public function set icon(_arg1:BitmapData):void{
            if (_arg1 != null){
                this._icon.visible = true;
                this._label.width = ((this._width - 4) - this._icon.width);
            } else {
                this._label.width = (this._width - 4);
                this._icon.visible = false;
            };
            this._icon.bitmapData = _arg1;
            this.width = this._width;
        }
        private function configUI():void{
            addChild(this.stateOFF);
            addChild(this.stateDOWN);
            addChild(this.stateOVER);
            addChild(this.stateUP);
            addChild(this._label);
            addChild(this._icon);
            this._label.align = TextFormatAlign.CENTER;
            this._info.align = TextFormatAlign.CENTER;
            this._label.autoSize = TextFieldAutoSize.NONE;
            this._info.autoSize = TextFieldAutoSize.NONE;
            this._label.selectable = false;
            this._info.selectable = false;
            this._label.x = 2;
            this._info.x = 2;
            this._label.y = 15;
            this._info.y = 24;
            this._label.height = 24;
            this._info.height = 20;
            this._label.size = 14;
            this._label.mouseEnabled = false;
            this._info.mouseEnabled = false;
            this._label.filters = [new DropShadowFilter(1, 45, 0, 0.7, 1, 1, 1)];
            this._info.filters = [new DropShadowFilter(1, 45, 0, 0.7, 1, 1, 1)];
            this.stateUP.bmpLeft = new bigbutton_UP_LEFT(1, 1);
            this.stateUP.bmpCenter = new bigbutton_UP_CENTER(1, 1);
            this.stateUP.bmpRight = new bigbutton_UP_RIGHT(1, 1);
            this.stateOVER.bmpLeft = new bigbutton_OVER_LEFT(1, 1);
            this.stateOVER.bmpCenter = new bigbutton_OVER_CENTER(1, 1);
            this.stateOVER.bmpRight = new bigbutton_OVER_RIGHT(1, 1);
            this.stateDOWN.bmpLeft = new bigbutton_DOWN_LEFT(1, 1);
            this.stateDOWN.bmpCenter = new bigbutton_DOWN_CENTER(1, 1);
            this.stateDOWN.bmpRight = new bigbutton_DOWN_RIGHT(1, 1);
            this.stateOFF.bmpLeft = new bigbutton_OFF_LEFT(1, 1);
            this.stateOFF.bmpCenter = new bigbutton_OFF_CENTER(1, 1);
            this.stateOFF.bmpRight = new bigbutton_OFF_RIGHT(1, 1);
            this.width = 120;
        }
        public function set enable(_arg1:Boolean):void{
            this._enable = _arg1;
            if (this._enable){
                this.addListeners();
            } else {
                this.removeListeners();
            };
        }
        public function get enable():Boolean{
            return (this._enable);
        }
        protected function addListeners():void{
            this.setState(1);
            buttonMode = true;
            mouseEnabled = true;
            mouseChildren = true;
            addEventListener(MouseEvent.MOUSE_OVER, this.onMouseEvent);
            addEventListener(MouseEvent.MOUSE_OUT, this.onMouseEvent);
            addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseEvent);
            addEventListener(MouseEvent.MOUSE_UP, this.onMouseEvent);
        }
        protected function removeListeners():void{
            this.setState(0);
            buttonMode = false;
            mouseEnabled = false;
            mouseChildren = false;
            removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseEvent);
            removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseEvent);
            removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseEvent);
            removeEventListener(MouseEvent.MOUSE_UP, this.onMouseEvent);
        }
        protected function onMouseEvent(_arg1:MouseEvent):void{
            if (this._enable){
                switch (_arg1.type){
                    case MouseEvent.MOUSE_OVER:
                        this.setState(2);
                        this._label.y = 15;
                        this._info.y = 24;
                        break;
                    case MouseEvent.MOUSE_OUT:
                        this.setState(1);
                        this._label.y = 15;
                        this._info.y = 24;
                        break;
                    case MouseEvent.MOUSE_DOWN:
                        this.setState(3);
                        this._label.y = 16;
                        this._info.y = 25;
                        break;
                    case MouseEvent.MOUSE_UP:
                        this.setState(1);
                        this._label.y = 15;
                        this._info.y = 24;
                        break;
                };
                if (this._icon != null){
                    this._icon.y = (int((25 - (this._icon.height / 2))) + (((_arg1.type == MouseEvent.MOUSE_DOWN)) ? 1 : 0));
                };
            };
        }
        protected function setState(_arg1:int=0):void{
            switch (_arg1){
                case 0:
                    this.stateOFF.alpha = 1;
                    this.stateUP.alpha = 0;
                    this.stateOVER.alpha = 0;
                    this.stateDOWN.alpha = 0;
                    break;
                case 1:
                    this.stateOFF.alpha = 0;
                    this.stateUP.alpha = 1;
                    this.stateOVER.alpha = 0;
                    this.stateDOWN.alpha = 0;
                    break;
                case 2:
                    this.stateOFF.alpha = 0;
                    this.stateUP.alpha = 0;
                    this.stateOVER.alpha = 1;
                    this.stateDOWN.alpha = 0;
                    break;
                case 3:
                    this.stateOFF.alpha = 0;
                    this.stateUP.alpha = 0;
                    this.stateOVER.alpha = 0;
                    this.stateDOWN.alpha = 1;
                    break;
            };
        }

    }
}//package mishin870.gui.BattleInfo 
