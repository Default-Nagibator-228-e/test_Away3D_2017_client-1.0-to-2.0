package mishin870.gui.CTFMsgs {
    import flash.display.*;
    import __AS3__.vec.*;
    import flash.filters.*;

    public class Msgs extends Sprite {

        private var maxMessages:int;
        private var fontSize:int;
        private var verticalInterval:int;
        private var numMessages:int = 0;
        private var messages:Vector.<Message>;
        private var numPooledMessages:int = 0;
        private var messagePool:Vector.<Message>;

        public function Msgs(_arg1:int, _arg2:int, _arg3:int){
            this.maxMessages = _arg1;
            this.fontSize = _arg2;
            this.verticalInterval = _arg3;
            this.messagePool = new Vector.<Message>();
            this.messages = new Vector.<Message>(3);
            filters = [new GlowFilter(0, 1, 6, 6)];
        }
        public function addMessage(_arg1:uint, _arg2:String):void{
            if (this.numMessages >= this.maxMessages){
                this.removeMessage(0);
            };
            var _local3:Message = this.createMessage();
            this.messages[this.numMessages] = _local3;
            addChild(_local3.label);
            _local3.label.color = _arg1;
            _local3.label.text = _arg2;
            _local3.label.x = (-0.5 * _local3.label.width);
            _local3.label.y = (this.verticalInterval * this.numMessages);
            this.numMessages++;
        }
        public function update(_arg1:uint):void{
            var _local2:Message;
            var _local3:int;
            while (_local3 < this.numMessages) {
                _local2 = this.messages[_local3];
                if (_local2.isDead){
                    this.removeMessage(_local3);
                    _local3--;
                } else {
                    _local2.update(_arg1);
                };
                _local3++;
            };
        }
        private function removeMessage(_arg1:int):void{
            var _local4:Message;
            var _local2:Message = this.messages[_arg1];
            this.destroyMessage(_local2);
            var _local3:int = (_arg1 + 1);
            while (_local3 < this.numMessages) {
                _local4 = this.messages[_local3];
                this.messages[(_local3 - 1)] = this.messages[_local3];
                _local2 = _local4;
                _local2.label.y = (_local2.label.y - this.verticalInterval);
                _local3++;
            };
            this.numMessages--;
        }
        private function destroyMessage(_arg1:Message):void{
            removeChild(_arg1.label);
            this.numPooledMessages++;
            this.messagePool.push(_arg1);
        }
        private function createMessage():Message{
            var _local1:Message;
            if (this.numPooledMessages == 0){
                _local1 = new Message(this.fontSize);
            } else {
                this.numPooledMessages--;
                _local1 = this.messagePool.splice(this.numPooledMessages, 1)[0];
            };
            _local1.init();
            return (_local1);
        }

    }
}//package mishin870.gui.CTFMsgs 
