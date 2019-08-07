package mishin870.gui.ComboBox.list {
	import controls.Label;
    import flash.events.*;
    import flash.display.*;
    import controls.*;

    public class MComboBoxListItem extends Sprite {

        public var label:Label;
        private var callBack:Function;
        private var back:Sprite;
        private var s:Sprite;

        public function MComboBoxListItem(_arg1:String, _arg2:Function){
            this.label = new Label();
            super();
            this.callBack = _arg2;
            this.back = new Sprite();
            this.back.graphics.beginFill(0x797979);
            this.back.graphics.drawRoundRect(0, 0, 100, 18, 10, 10);
            this.back.graphics.endFill();
            addChild(this.back);
            this.back.alpha = 0;
            this.s = new Sprite();
            this.s.graphics.beginFill(0xFFFFFF);
            this.s.graphics.drawRect(0, 0, 100, 20);
            this.s.graphics.endFill();
            this.s.alpha = 0;
            addChild(this.s);
            this.label.x = 10;
            this.label.text = _arg1;
            addChild(this.label);
            addEventListener(MouseEvent.CLICK, this.click);
            addEventListener(MouseEvent.ROLL_OUT, this.mout);
            addEventListener(MouseEvent.ROLL_OVER, this.min);
        }
        private function mout(_arg1:MouseEvent):void{
            this.back.alpha = 0;
        }
        private function min(_arg1:MouseEvent):void{
            this.back.alpha = 1;
        }
        public function res(_arg1:int):void{
            this.back.graphics.clear();
            this.back.graphics.beginFill(0x797979);
            this.back.graphics.drawRoundRect(0, 0, _arg1, 18, 5, 5);
            this.back.graphics.endFill();
            this.s.graphics.clear();
            this.s.graphics.beginFill(0xFFFFFF);
            this.s.graphics.drawRect(0, 0, _arg1, 20);
            this.s.graphics.endFill();
        }
        private function click(_arg1:MouseEvent):void{
            this.callBack.call(null, this);
        }

    }
}//package mishin870.gui.ComboBox.list 
