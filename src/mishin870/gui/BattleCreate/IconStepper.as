package mishin870.gui.BattleCreate {
	import controls.Label;
    import flash.display.*;
    import controls.*;
    import mishin870.gui.StepperButton.*;

    public class IconStepper extends Stepper {

        public static const SCORE:int = 0;
        public static const TANK:int = 1;
        public static const TIMER:int = 2;
        [Embed(source="IconStepper/scoreClass.png")] private var scoreClass:Class;
        [Embed(source="IconStepper/tankClass.png")] private var tankClass:Class;
        [Embed(source="IconStepper/timerClass.png")] private var timerClass:Class;

        private var _icon:int;
        private var _label:Label;
        private var overlay:Sprite;

        public function IconStepper(){
            this._label = new Label();
            this.overlay = new Sprite();
            super();
            addChild(this._label);
            this.icon = SCORE;
            this.redrawOverlay();
            this.overlay.visible = false;
        }
        private function redrawOverlay():void{
            this.overlay.graphics.clear();
            this.overlay.graphics.beginFill(0, 0.4);
            this.overlay.graphics.drawRect(0, 0, (width - 20), (height + 15));
            this.overlay.graphics.endFill();
        }
        public function set enable(_arg1:Boolean):void{
            this.overlay.visible = !(_arg1);
        }
        public function get enable():Boolean{
            return (!(this.overlay.visible));
        }
        public function set label(_arg1:String):void{
            this._label.text = _arg1;
            this._label.y = -(this._label.height);
        }
        public function get label():String{
            return (this._label.text);
        }
        public function set icon(_arg1:int):void{
            var _local2:Bitmap;
            this._icon = _arg1;
            try {
                removeChildAt(3);
            } catch(e:Error) {
            };
            try {
                removeChildAt(4);
            } catch(e:Error) {
            };
            if (_arg1 == SCORE){
                _local2 = new scoreClass();
                _local2.x = -(_local2.width);
            };
            if (_arg1 == TANK){
                _local2 = new tankClass();
                _local2.x = (-(_local2.width) - 5);
            };
            if (_arg1 == TIMER){
                _local2 = new timerClass();
                _local2.x = (-(_local2.width) - 5);
            };
            _local2.y = (15 - (_local2.height / 2));
            try {
                addChildAt(_local2, 3);
            } catch(e:Error) {
            };
            addChildAt(this.overlay, 4);
            this.overlay.y = -15;
            this.overlay.x = _local2.x;
            this.redrawOverlay();
        }
        public function get icon():int{
            return (this._icon);
        }

    }
}//package mishin870.gui.BattleCreate 
