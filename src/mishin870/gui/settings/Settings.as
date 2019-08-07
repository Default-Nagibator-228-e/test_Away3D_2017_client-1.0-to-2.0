package mishin870.gui.settings {
	import controls.DefaultButton;
	import controls.Label;
	import controls.TankCheckBox;
	import controls.TankWindow;
	import controls.TankWindowHeader;
    import flash.events.*;
    import controls.*;
    import flash.text.*;

    public class Settings extends TankWindow {

        private static const LABEL_TEXT_FORMAT:TextFormat = new TextFormat("MyriadPro", 13);
        public static const FRAME_WIDTH:int = 435;

        private var sf:SoundFrame;
        private var gl:Label;
        private var gf:GraphicsFrame;
        private var al:Label;
        private var af:AccountFrame;
        private var cl:Label;
        private var cf:ControlFrame;
        private var newsCh:TankCheckBox;
        private var saveBut:DefaultButton;
        private var cancelBut:DefaultButton;

        public function Settings(){
            this.sf = new SoundFrame();
            this.gl = new Label();
            this.gf = new GraphicsFrame();
            this.al = new Label();
            this.af = new AccountFrame();
            this.cl = new Label();
            this.cf = new ControlFrame();
            this.newsCh = new TankCheckBox();
            this.saveBut = new DefaultButton();
            this.cancelBut = new DefaultButton();
            super(457, 470);
            headerLang = "ru";
            header = TankWindowHeader.SETTINGS;
            this.sf.x = 11;
            this.sf.y = 11;
            addChild(this.sf);
            this.gl.textColor = 0;
            this.gl.defaultTextFormat = LABEL_TEXT_FORMAT;
            this.gl.text = "Отображение";
            this.gl.x = this.sf.x;
            this.gl.y = ((this.sf.y + this.sf.height) + 16);
            addChild(this.gl);
            this.gf.x = 11;
            this.gf.y = ((this.sf.y + this.sf.height) + 32);
            addChild(this.gf);
            this.al.textColor = 0;
            this.al.defaultTextFormat = LABEL_TEXT_FORMAT;
            this.al.text = "Аккаунт";
            this.al.x = this.gf.x;
            this.al.y = ((this.gf.y + this.gf.height) + 16);
            addChild(this.al);
            this.af.x = 11;
            this.af.y = ((this.gf.y + this.gf.height) + 32);
            addChild(this.af);
            this.cl.textColor = 0;
            this.cl.defaultTextFormat = LABEL_TEXT_FORMAT;
            this.cl.text = "Управление";
            this.cl.x = this.af.x;
            this.cl.y = ((this.af.y + this.af.height) + 16);
            addChild(this.cl);
            this.cf.x = 11;
            this.cf.y = ((this.af.y + this.af.height) + 32);
            addChild(this.cf);
            this.newsCh.label = "Получать новости";
            this.newsCh.x = 19;
            this.newsCh.y = ((this.cf.y + this.cf.height) + 10);
            addChild(this.newsCh);
            this.cancelBut.label = "Отмена";
            this.cancelBut.y = this.newsCh.y;
            this.cancelBut.x = ((this.cf.x + this.cf.width) - this.cancelBut.width);
            addChild(this.cancelBut);
            this.saveBut.label = "Сохранить";
            this.saveBut.y = this.newsCh.y;
            this.saveBut.x = ((this.cancelBut.x - this.saveBut.width) - 10);
            addChild(this.saveBut);
            this.cancelBut.addEventListener(MouseEvent.MOUSE_UP, this.close);
            this.saveBut.addEventListener(MouseEvent.MOUSE_UP, this.close);
        }
        private function close(_arg1:MouseEvent):void{
            dispatchEvent(new Event(Event.CLOSE));
        }

    }
}//package mishin870.gui.settings 
