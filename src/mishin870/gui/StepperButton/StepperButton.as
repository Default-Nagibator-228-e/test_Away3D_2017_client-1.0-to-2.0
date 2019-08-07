package mishin870.gui.StepperButton {
    import flash.events.*;
    import flash.display.*;

    public class StepperButton extends Sprite {

        [Embed(source="StepperButton/norm.png")] private var normClass:Class;
        [Embed(source="StepperButton/up.png")] private var upClass:Class;
        [Embed(source="StepperButton/down.png")] private var downClass:Class;

        private var norm:Bitmap = new normClass();
        private var up:Bitmap = new upClass();
        private var down:Bitmap = new downClass();
        private var isUp:Boolean;
        private var callBack:Function;

        public function StepperButton(_arg1:Function){
            super();
            this.callBack = _arg1;
            this.setSkin(0);
            addEventListener(MouseEvent.MOUSE_UP, this.mu);
            addEventListener(MouseEvent.MOUSE_DOWN, this.md);
        }
        private function mu(_arg1:MouseEvent):void{
            this.callBack.call(null, ((this.isUp) ? 1 : -1));
            this.setSkin(0);
        }
        private function md(_arg1:MouseEvent):void{
            var _local2:int = _arg1.localY;
            this.isUp = (_local2 <= (this.norm.height / 2));
            this.setSkin(((this.isUp) ? 1 : 2));
        }
        private function removeAl():void{
            try {
                while (true) {
                    removeChildAt(0);
                };
            } catch(e:Error) {
            };
        }
        public function setSkin(_arg1:int):void{
            this.removeAl();
            if (_arg1 == 0){
                addChild(this.norm);
            };
            if (_arg1 == 1){
                addChild(this.up);
            };
            if (_arg1 == 2){
                addChild(this.down);
            };
        }

    }
}//package mishin870.gui.StepperButton 
