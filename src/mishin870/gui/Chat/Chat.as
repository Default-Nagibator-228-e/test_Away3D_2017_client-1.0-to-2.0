package mishin870.gui.Chat {
    import flash.events.*;
    import flash.display.*;
    import mishin870.gui.*;

    public class Chat extends Sprite {

        public var chatW:ChatWindow;
        public var chatMsgs:ChatMsgs;
        public var scr:ScrollVert;

        public function Chat(){
            this.chatW = new ChatWindow();
            this.scr = new ScrollVert();
            super();
            this.chatMsgs = new ChatMsgs(this.scr);
            this.scr.visible = false;
            addChild(this.chatW);
            addChild(this.chatMsgs);
            addChild(this.scr);
            this.chatMsgs.y = 15;
            addEventListener(MouseEvent.MOUSE_WHEEL, this.mw);
        }
        public function clear():void{
            this.chatMsgs.clear();
        }
        public function clearu(_arg1:String):void{
            this.chatMsgs.clearu(_arg1);
        }
        private function mw(_arg1:MouseEvent):void{
            this.chatMsgs.scroll(0, (-(_arg1.delta) * 2));
            this.chatMsgs.refreshScr();
        }
        public function addMessage(_arg1:int, _arg2:String, _arg3:int=0, _arg4:String="", _arg5:int=0, _arg6:String=""):void{
            this.chatMsgs.addMessage((this.chatW.width - 30), _arg1, _arg2, _arg3, _arg4, _arg5, _arg6);
        }
        public function res(_arg1:Number, _arg2:Number):void{
            this.chatW.res(_arg1, _arg2);
            this.chatMsgs.setRect(_arg1, (_arg2 - 120));
            this.chatMsgs.res((this.chatW.width - 30));
            this.scr.x = ((_arg1 - this.scr.wid) - 15);
            this.scr.y = 15;
            this.scr.hei = (_arg2 - 120);
            this.chatMsgs.refrAWH();
            this.chatMsgs.scroll(0, 0);
        }

    }
}//package mishin870.gui.Chat 
