package mishin870.gui.BattleCreate {
	import controls.ColorButton;
	import controls.TankCheckBox;
	import controls.TankInput;
	import controls.TankWindow;
	import controls.TankWindowHeader;
    import flash.events.*;
    import flash.display.*;
    import controls.*;
    import mishin870.net.*;
    import mishin870.gui.ComboBox.*;
    import mishin870.gui.ToggleButton.*;

    public class BattleCreateWindow extends Sprite {

        private var win:TankWindow;
        private var nameI:TankInput;
        private var mapCb:MComboBox;
        private var preview:PreviewBattle;
        private var dmBut:ToggleButton;
        private var tdmBut:ToggleButton;
        private var playersStep:IconStepper;
        private var timeStep:IconStepper;
        private var scoreStep:IconStepper;
        private var bbpCh:OverlayObject;
        private var closeCh:OverlayObject;
        private var autoCh:OverlayObject;
        private var selfCh:OverlayObject;
        private var createBut:ColorButton;

        public function BattleCreateWindow(){
            var x:* = null;
            var temp:* = null;
            this.win = new TankWindow();
            this.nameI = new TankInput();
            this.mapCb = new MComboBox();
            this.preview = new PreviewBattle();
            this.dmBut = new ToggleButton();
            this.tdmBut = new ToggleButton();
            this.playersStep = new IconStepper();
            this.timeStep = new IconStepper();
            this.scoreStep = new IconStepper();
            this.createBut = new ColorButton();
            super();
            addChild(this.win);
            this.nameI.label = "Имя:";
            this.nameI.textField.text = "Новая карта";
            this.nameI.addEventListener(Event.CHANGE, function (_arg1:Event):void{
                checkSteppers(null);
            });
            this.nameI.y = 10;
            this.mapCb.y = 45;
            addChild(this.nameI);
            this.mapCb.label = "Карта:";
            for each (x in Main.instance.xml.maps[0].map) {
                this.mapCb.addItem(x.@name);
            };
            this.mapCb.text = Main.instance.xml.maps[0].map[0].@name;
            this.res(100, 200);
            this.loadPreview(("data/maps/" + Main.instance.xml.maps[0].map[0].@preview));
            this.preview.x = 10;
            this.preview.y = 85;
            addChild(this.preview);
            addChild(this.dmBut);
            addChild(this.tdmBut);
            addChild(this.createBut);
            addChild(this.playersStep);
            addChild(this.timeStep);
            addChild(this.scoreStep);
            temp = new TankCheckBox();
            temp.checked = false;
            temp.label = "Без припасов";
            this.bbpCh = new OverlayObject(temp);
            addChild(this.bbpCh);
            temp = new TankCheckBox();
            temp.checked = false;
            temp.label = "Закрытая битва";
            this.closeCh = new OverlayObject(temp);
            addChild(this.closeCh);
            temp = new TankCheckBox();
            temp.checked = false;
            temp.label = "Автобаланс";
            this.autoCh = new OverlayObject(temp);
            addChild(this.autoCh);
            temp = new TankCheckBox();
            temp.checked = false;
            temp.label = "Огонь по своим";
            this.selfCh = new OverlayObject(temp);
            addChild(this.selfCh);
            this.autoCh.visible = false;
            this.selfCh.visible = false;
            addChild(this.mapCb);
            this.dmBut.setLabels("Каждый", "за себя");
            this.tdmBut.setLabels("Команда", "на команду");
            this.dmBut.enable = false;
            this.dmBut.addEventListener(MouseEvent.MOUSE_UP, function (_arg1:MouseEvent):void{
                autoCh.visible = false;
                selfCh.visible = false;
                dmBut.enable = false;
                tdmBut.enable = true;
            });
            this.tdmBut.addEventListener(MouseEvent.MOUSE_UP, function (_arg1:MouseEvent):void{
                autoCh.visible = true;
                selfCh.visible = true;
                tdmBut.enable = false;
                dmBut.enable = true;
            });
            this.createBut.setStyle(ColorButton.RED);
            this.createBut.label = "Создать";
            this.createBut.addEventListener(MouseEvent.CLICK, function (_arg1:MouseEvent):void{
                if ((((((timeStep.value <= 0)) && ((scoreStep.value <= 0)))) || ((rep(nameI.textField.text, " ", "").length == 0)))){
                    return;
                };
				Main.instance.lobby.battles.visible = true;
                visible = false;
                Main.instance.ftr.send((((((((((((((("cb;" + ((dmBut.enable) ? "1" : "0")) + ";") + playersStep.value) + ";") + scoreStep.value) + ";") + timeStep.value) + ";") + nameI.textField.text) + ";") + mapCb.text) + ";") + "http://oldtank.hol.es/data/maps/") + Main.instance.xml.maps[0].map[mapCb.selItem].@xml));
            });
            this.playersStep.icon = IconStepper.TANK;
            this.playersStep.label = "Мах игроков";
            this.playersStep.setValues(2, 10, 2);
            this.playersStep.wid = 75;
            this.playersStep.x = 45;
            this.timeStep.icon = IconStepper.TIMER;
            this.timeStep.label = "Время";
            this.timeStep.setValues(0, 999, 15);
            this.timeStep.wid = 75;
            this.scoreStep.icon = IconStepper.SCORE;
            this.scoreStep.label = "Уничтожений";
            this.scoreStep.setValues(0, 999, 15);
            this.scoreStep.wid = 75;
            this.playersStep.addEventListener(Event.CHANGE, this.checkSteppers);
            this.timeStep.addEventListener(Event.CHANGE, this.checkSteppers);
            this.scoreStep.addEventListener(Event.CHANGE, this.checkSteppers);
        }
        private function rep(_arg1:String, _arg2:String, _arg3:String):String{
            var _local4:String = _arg1;
            while (_local4.search(_arg2) != -1) {
                _local4 = _local4.replace(_arg2, _arg3);
            };
            return (_local4);
        }
        private function checkSteppers(_arg1:Event):void{
            var _local2:int = this.scoreStep.value;
            var _local3:int = this.timeStep.value;
            this.createBut.enable = !((((((_local3 <= 0)) && ((_local2 <= 0)))) || ((this.rep(this.nameI.textField.text, " ", "").length == 0))));
        }
        public function loadPreview(_arg1:String):void{
            this.preview.loadImage(_arg1);
        }
        public function res(_arg1:Number, _arg2:Number):void{
            var _local3:int;
            this.win.width = _arg1;
            this.win.height = (_arg2 - 4);
            this.nameI.x = 55;
            this.nameI.width = ((_arg1 - this.nameI.x) - 10);
            this.mapCb.x = 55;
            this.mapCb.wid = ((_arg1 - this.mapCb.x) - 10);
            this.preview.res((_arg1 - 20), int(((_arg2 / 2) - this.preview.y)));
            this.dmBut.wid = (int(((_arg1 - 20) / 2)) - 2);
            this.tdmBut.wid = int(((_arg1 - 20) / 2));
            this.dmBut.x = 10;
            this.tdmBut.x = int((((_arg1 - 20) / 2) + 12));
            this.dmBut.y = int(((this.preview.y + this.preview.height) + 5));
            this.tdmBut.y = int(((this.preview.y + this.preview.height) + 5));
            this.timeStep.y = ((this.dmBut.y + this.dmBut.height) + 30);
            this.timeStep.x = int(((_arg1 / 2) - 25));
            this.playersStep.y = this.timeStep.y;
            this.scoreStep.y = this.timeStep.y;
            this.scoreStep.x = int(((_arg1 - 75) - 30));
            this.createBut.x = ((_arg1 - this.createBut.width) - 10);
            this.createBut.y = ((_arg2 - this.createBut.height) - 17);
            try {
                this.bbpCh.x = 65;
                this.autoCh.x = 65;
                this.selfCh.x = ((_arg1 - this.selfCh.width) - 65);
                _local3 = int((_arg2 - this.timeStep.y));
                this.bbpCh.y = (int(((_local3 / 2) + this.timeStep.y)) - 25);
                this.autoCh.y = (this.bbpCh.y - 40);
                this.selfCh.y = this.autoCh.y;
                this.closeCh.x = 15;
                this.closeCh.y = ((_arg2 - this.closeCh.height) - 17);
            } catch(e:Error) {
            };
        }

    }
}//package mishin870.gui.BattleCreate 
