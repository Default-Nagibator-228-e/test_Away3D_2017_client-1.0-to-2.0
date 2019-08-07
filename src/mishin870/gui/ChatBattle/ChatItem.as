package mishin870.gui.ChatBattle {
	import controls.Label;
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;
    import controls.*;
    import flash.text.*;
    import flash.filters.*;

    public class ChatItem extends Sprite {

        private static const TIME_TO_HIDE:int = 30000;

        private var tftext:Label;
        private var tfname:Label;
        private var tfname2:Label;
        public var id:String;
        public var type:Number;
        public var msg:String;
        private var timeHide:int;
        private var prevTime:int;
        private var hidingTime:int = 1000;
        private var isShow:Boolean = true;
        public var deleted:Boolean = false;
        private var isShow2:Boolean = false;

        public function ChatItem(_arg1:Number, _arg2:String, _arg3:Number, _arg4:String, _arg5:DisplayObject=null, _arg6:String="", _arg7:DisplayObject=null, _arg8:String=""){
            this.tftext = new Label();
            this.tfname = new Label();
            this.tfname2 = new Label();
            super();
            this.id = _arg2;
            this.type = _arg3;
            this.msg = _arg4;
            this.timeHide = TIME_TO_HIDE;
            if (_arg3 == 0){
                this.tftext.textColor = 0xFAFAFA;
                this.tfname.textColor = 0xF600;
                this.tftext.autoSize = TextFieldAutoSize.CENTER;
                this.tftext.wordWrap = true;
                this.tfname.autoSize = TextFieldAutoSize.LEFT;
                this.tfname.text = (_arg6 + ":");
                addChild(_arg5);
                this.tfname.filters = [new GlowFilter(0, 0.5, 4, 4, 3)];
                this.tftext.filters = [new GlowFilter(0, 0.5, 4, 4, 3)];
                _arg5.filters = [new GlowFilter(0, 0.8, 4, 4, 3)];
                this.tfname.x = _arg5.width;
                this.tfname.y = -2;
                addChild(this.tfname);
                this.tftext.x = ((this.tfname.x + this.tfname.width) + 3);
                this.tftext.y = -2;
                this.tftext.width = (_arg1 - this.tftext.x);
                addChild(this.tftext);
                this.tftext.selectable = false;
                this.tfname.selectable = false;
                this.tftext.htmlText = _arg4;
                _arg5.y = ((this.tfname.y + (this.tfname.height / 2)) - (_arg5.height / 2));
            };
            if (_arg3 == 1){
                this.tfname.textColor = 8321918;
                this.tfname.filters = [new GlowFilter(0, 0.8, 4, 4, 5)];
                _arg5.filters = [new GlowFilter(0, 0.8, 4, 4, 5)];
                this.tfname.autoSize = TextFieldAutoSize.LEFT;
                this.tfname.wordWrap = true;
                this.tfname.htmlText = _arg4;
                this.tfname.width = _arg1;
                this.tfname.selectable = false;
                addChild(this.tfname);
                this.tfname.y = -2;
            };
            if (_arg3 == 2){
                this.tftext.textColor = 0xFFFFFF;
                this.tfname.textColor = 16448070;
                this.tftext.autoSize = TextFieldAutoSize.CENTER;
                this.tftext.wordWrap = true;
                this.tfname.autoSize = TextFieldAutoSize.LEFT;
                this.tfname.text = (_arg6 + ":");
                this.tfname.filters = [new GlowFilter(0, 0.8, 4, 4, 5)];
                this.tftext.filters = [new GlowFilter(0, 0.8, 4, 4, 5)];
                this.tfname.y = -2;
                addChild(this.tfname);
                this.tftext.x = ((this.tfname.x + this.tfname.width) + 3);
                this.tftext.y = -2;
                this.tftext.width = (_arg1 - this.tftext.x);
                addChild(this.tftext);
                this.tftext.selectable = false;
                this.tfname.selectable = false;
                this.tftext.htmlText = _arg4;
            };
            if (_arg3 == 3){
                this.tftext.textColor = 0xFAFAFA;
                this.tfname.textColor = 0xF600;
                this.tftext.autoSize = TextFieldAutoSize.LEFT;
                this.tftext.wordWrap = true;
                this.tfname.autoSize = TextFieldAutoSize.LEFT;
                this.tfname.text = _arg6;
                this.tftext.text = _arg4;
                addChild(_arg5);
                this.tfname.filters = [new GlowFilter(0, 0.5, 4, 4, 3)];
                this.tftext.filters = [new GlowFilter(0, 0.5, 4, 4, 3)];
                _arg5.filters = [new GlowFilter(0, 0.8, 4, 4, 3)];
                this.tfname.y = -2;
                addChild(this.tfname);
                this.tftext.x = (_arg1 - this.tftext.width);
                this.tfname.x = ((this.tftext.x - this.tfname.width) - 3);
                _arg5.x = (this.tfname.x - _arg5.width);
                this.tftext.y = -2;
                addChild(this.tftext);
                this.tftext.selectable = false;
                this.tfname.selectable = false;
                _arg5.y = ((this.tfname.y + (this.tfname.height / 2)) - (_arg5.height / 2));
            };
            this.prevTime = getTimer();
            addEventListener(Event.ENTER_FRAME, this.ef);
        }
        private function ef(_arg1:Event):void{
            var _local4:Number;
            var _local2:int = getTimer();
            var _local3:int = (_local2 - this.prevTime);
            this.prevTime = _local2;
            if (this.isShow){
                this.timeHide = (this.timeHide - _local3);
                if (this.timeHide <= 0){
                    this.isShow = false;
                };
            } else {
                if (this.hidingTime > 0){
                    this.hidingTime = (this.hidingTime - _local3);
                    _local4 = (this.hidingTime / 1000);
                    if (!this.isShow2){
                        this.alpha = _local4;
                    };
                } else {
                    this.deleted = true;
                    if (!this.isShow2){
                        this.alpha = 0;
                    };
                    removeEventListener(Event.ENTER_FRAME, this.ef);
                };
            };
        }
        public function hide():void{
            this.deleted = true;
            alpha = 0;
            removeEventListener(Event.ENTER_FRAME, this.ef);
        }
        public function show2():void{
            this.isShow2 = true;
            alpha = 1;
        }
        public function hide2():void{
            this.isShow2 = false;
            if (this.deleted){
                alpha = 0;
            };
        }
        public function refresh(_arg1:Number):void{
            if (this.type == 1){
                this.tfname.text = this.msg;
                this.tfname.width = _arg1;
            };
            if (this.type == 0){
                this.tftext.text = this.msg;
                this.tftext.width = (_arg1 - this.tftext.x);
            };
            if (this.type == 2){
                this.tftext.text = this.msg;
                this.tftext.width = (_arg1 - this.tftext.x);
            };
        }

    }
}//package mishin870.gui.ChatBattle 
