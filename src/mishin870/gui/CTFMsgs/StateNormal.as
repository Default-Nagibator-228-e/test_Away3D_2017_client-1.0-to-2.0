package mishin870.gui.CTFMsgs {

    public class StateNormal implements IMessageState {

        private var msg:Message;
        private var time:int;
        private var currTime:int;

        public function StateNormal(_arg1:Message, _arg2:int){
            this.msg = _arg1;
            this.time = _arg2;
            this.currTime = _arg2;
        }
        public function init():void{
            this.currTime = this.time;
        }
        public function update(_arg1:int):Boolean{
            this.currTime = (this.currTime - _arg1);
            return ((this.currTime > 0));
        }

    }
}//package mishin870.gui.CTFMsgs 
