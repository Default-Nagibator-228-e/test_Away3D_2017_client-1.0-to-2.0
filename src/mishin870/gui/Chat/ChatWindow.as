package mishin870.gui.Chat {
	
    import flash.events.*;
    import flash.display.*;
    import controls.*;
    import flash.ui.*;

    public class ChatWindow extends Sprite {

        private var win:TankWindow;
        private var wini:TankWindowInner;
        private var input:TankInput;
        private var sendBut:DefaultButton;

        public function ChatWindow(){
			super();
            this.win = new TankWindow();
            this.wini = new TankWindowInner(-1, -1, 4278985229);
            this.input = new TankInput();
            this.sendBut = new DefaultButton();
            addChild(this.win);
            addChild(this.wini);
            this.input.maxChars = 0xFF;
            this.input.addEventListener(MouseEvent.ROLL_OUT, function (_arg1:MouseEvent):void{
                Mouse.cursor = MouseCursor.ARROW;
            });
            this.input.addEventListener(MouseEvent.ROLL_OVER, function (_arg1:MouseEvent):void{
                Mouse.cursor = MouseCursor.IBEAM;
            });
            addChild(this.input);
            this.sendBut.label = "Сказать";
            this.sendBut.width = 100;
            addChild(this.sendBut);
            this.res(100, 200);
            this.input.addEventListener(KeyboardEvent.KEY_UP, this.ku);
            this.sendBut.addEventListener(MouseEvent.MOUSE_UP, this.mu);
        }
        private function checkInput():void{
            var _local1:String = this.input.textField.text;
            if (_local1 != ""){
                while (_local1.search(":") > 0) {
                    _local1 = _local1.replace(":", "");
                };
                while (_local1.search(";") > 0) {
                    _local1 = _local1.replace(";", "");
                };
                Main.instance.sendChat(_local1);
                this.input.textField.text = "";
            };
        }
        private function ku(_arg1:KeyboardEvent):void{
            if (_arg1.keyCode == Keyboard.ENTER){
                this.checkInput();
            };
        }
        private function mu(_arg1:MouseEvent):void{
            this.checkInput();
        }
        public function res(_arg1:Number, param2:Number):void{
            this.win.width = _arg1;
            this.win.height = param2;
            this.wini.x = 8;
            this.wini.y = 8;
            this.wini.width = (_arg1 - 20);
            this.wini.height = param2 * 0.87777777777777777777777777777778;
            this.input.x = 8;
            this.input.y = param2 * 0.95617977528089887640449438202247;
            this.input.width = (this.wini.width - 105);
            this.sendBut.y = this.input.y;
            this.sendBut.x = ((this.input.x + this.input.width) - 5);
        }

    }
}//package mishin870.gui.Chat 
