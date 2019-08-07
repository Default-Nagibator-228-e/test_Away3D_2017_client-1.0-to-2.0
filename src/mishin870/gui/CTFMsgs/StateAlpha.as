package mishin870.gui.CTFMsgs {

    public class StateAlpha implements IMessageState {

        private var msg:Message;
        private var time:int;
        private var beginAlpha:Number;
        private var endAlpha:Number;
        private var step:Number;
        private var currAlpha:Number;
        private var currTime:int;

        public function StateAlpha(_arg1:Message, _arg2:int, _arg3:Number, _arg4:Number){
            this.msg = _arg1;
            this.time = _arg2;
            this.currTime = _arg2;
            this.beginAlpha = _arg3;
            this.endAlpha = _arg4;
        }
        public function init():void{
            this.msg.label.alpha = this.beginAlpha;
            this.currAlpha = this.beginAlpha;
            this.currTime = this.time;
            this.step = ((this.endAlpha - this.beginAlpha) / this.time);
        }
        public function update(_arg1:int):Boolean{
            this.currAlpha = (this.currAlpha + (this.step * _arg1));
            this.msg.label.alpha = this.currAlpha;
            this.currTime = (this.currTime - _arg1);
            return ((this.currTime > 0));
        }

    }
}//package mishin870.gui.CTFMsgs 
