package mishin870.gui.CTFMsgs {
	import controls.Label;
    import flash.display.*;
    import __AS3__.vec.*;
    import controls.*;
    import flash.filters.*;

    public class Message {

        private static const FLASH_TIME:int = 100;
        private static const FADE_TIME:int = 300;
        private static const LIFE_TIME1:int = 1500;
        private static const LIFE_TIME2:int = 10000;
        private static const ALPHA:Number = 0.6;

        public var label:Label;
        public var isDead:Boolean;
        private var states:Vector.<IMessageState>;
        private var currentStateIndex:int;

        public function Message(_arg1:int){
            this.label = new Label();
            this.states = new Vector.<IMessageState>();
            this.states.push(new StateAlpha(this, FLASH_TIME, 0, 1));
            this.states.push(new StateNormal(this, LIFE_TIME1));
            this.states.push(new StateAlpha(this, FADE_TIME, 1, ALPHA));
            this.states.push(new StateNormal(this, LIFE_TIME2));
            this.states.push(new StateAlpha(this, FADE_TIME, ALPHA, 0));
            this.label.size = _arg1;
            this.label.bold = true;
        }
        public function init():void{
            this.isDead = false;
            this.currentStateIndex = 0;
            this.states[0].init();
        }
        public function update(_arg1:int):void{
            if (this.isDead){
                return;
            };
            var _local2:IMessageState = this.states[this.currentStateIndex];
            if (!_local2.update(_arg1)){
                this.currentStateIndex++;
                if (this.currentStateIndex >= this.states.length){
                    this.isDead = true;
                } else {
                    this.states[this.currentStateIndex].init();
                };
            };
        }

    }
}//package mishin870.gui.CTFMsgs 
