package mishin870.gui.BattleInfo {
	import controls.DefaultButton;
	import controls.Label;
	import controls.TankInput;
    import flash.events.*;
    import flash.display.*;
    import controls.*;
    import flash.text.*;
    import mishin870.net.*;
    import assets.icons.*;
    import mishin870.gui.Battle.Glass.*;
    import flash.filters.*;
    import flash.ui.*;
    import flash.system.*;

    public class BattleInfo extends Sprite {
	

        private var copyI:TankInput;
        private var copyBut:DefaultButton;
        private var rs:RankStat;
        public var lname:Label;
        public var biW:BIWindow;
        public var infoImg:InfoImage;
        private var wid:Number = 1;
        private var hei:Number = 1;
        public var bipw1:BattleInfoPlayersWindow;
        public var bipw2:BattleInfoPlayersWindow;
        public var play1:MBigButton;
        public var play2:MBigButton;
        public var type:int = 0;
        public var firstLoad:Boolean = false;
        public var id:int;
        private var scoreIco:GUIIco;
        private var scoreLabel:Label;
		private var timeIco:GUIIco;
        private var timeLabel:Label;
        private var paraIco:GUIIco;

        public function BattleInfo(){
            this.copyI = new TankInput();
            this.copyBut = new DefaultButton();
            this.rs = new RankStat();
            this.lname = new Label();
            this.biW = new BIWindow();
            this.infoImg = new InfoImage();
            this.play1 = new MBigButton();
            this.play2 = new MBigButton();
            this.scoreIco = new GUIIco(GUIIco.SCORE);
            this.scoreLabel = new Label();
			this.timeIco = new GUIIco(GUIIco.TIMER);
            this.timeLabel = new Label();
            this.paraIco = new GUIIco(GUIIco.PARA);
            super();
            addChild(this.biW);
            addChild(this.infoImg);
            this.infoImg.addChild(this.scoreIco);
            this.infoImg.addChild(this.scoreLabel);
			this.infoImg.addChild(this.timeIco);
            this.infoImg.addChild(this.timeLabel);
            this.infoImg.addChild(this.paraIco);
            this.infoImg.addChild(this.lname);
            this.infoImg.addChild(this.rs);
            this.copyI.textField.type = TextFieldType.DYNAMIC;
            this.copyI.addEventListener(MouseEvent.ROLL_OVER, function (_arg1:MouseEvent):void{
                Mouse.cursor = MouseCursor.IBEAM;
            });
            this.copyI.addEventListener(MouseEvent.ROLL_OUT, function (_arg1:MouseEvent):void{
                Mouse.cursor = MouseCursor.ARROW;
            });
            this.copyBut.label = "Скопировать ссылку";
            addChild(this.copyI);
            addChild(this.copyBut);
            this.copyBut.addEventListener(MouseEvent.CLICK, function (_arg1:MouseEvent):void{
                System.setClipboard(copyI.textField.text);
            });
            addChild(this.play1);
            addChild(this.play2);
            this.play1.addEventListener(MouseEvent.MOUSE_UP, this.play1Mu);
            this.play2.addEventListener(MouseEvent.MOUSE_UP, this.play2Mu);
            this.infoImg.x = 12;
            this.infoImg.y = 12;
            this.scoreLabel.filters = [new GlowFilter(0, 0.8, 4, 4, 4)];
            this.scoreLabel.defaultTextFormat = new TextFormat("MyriadPro", 16);
			this.timeLabel.filters = [new GlowFilter(0, 0.8, 4, 4, 4)];
            this.timeLabel.defaultTextFormat = new TextFormat("MyriadPro", 16);
            this.lname.filters = [new GlowFilter(0, 0.8, 4, 4, 4)];
            this.lname.defaultTextFormat = new TextFormat("MyriadPro", 19);
            this.lname.x = 10;
            this.lname.y = 10;
            this.infoImg.addEventListener(Event.COMPLETE, this.infoImgCom);
            this.scoreIco.x = 10;
            this.scoreIco.filters = [new GlowFilter(0, 0.8, 2, 2, 2)];
			this.timeIco.x = 10;
            this.timeIco.filters = [new GlowFilter(0, 0.8, 2, 2, 2)];
            this.paraIco.filters = [new GlowFilter(0, 0.8, 4, 4, 4)];
        }
        public function setName(_arg1:String):void{
            this.lname.text = _arg1;
            this.refreshIcons();
        }
        public function setRanks(_arg1:int, _arg2:int):void{
            this.rs.setRanks(_arg1, _arg2);
        }
        public function setScore(_arg1:int):void{
            this.scoreLabel.text = _arg1.toString();
            this.refreshIcons();
        }
		public function setTime(_arg1:int):void{
            this.timeLabel.text = _arg1.toString();
            this.refreshIcons();
        }
        private function refreshIcons():void{
            this.scoreIco.y = ((this.lname.y + this.lname.height) + 2);
			this.timeIco.x = ((this.paraIco.x + this.paraIco.width) + 25);
			this.timeIco.y = (((this.paraIco.y + (this.paraIco.height / 2)) - (this.timeIco.height / 2)) + 1);
            this.scoreLabel.x = ((this.scoreIco.x + this.scoreIco.width) - 5);
            this.scoreLabel.y = (((this.scoreIco.y + (this.scoreIco.height / 2)) - (this.scoreLabel.height / 2)) + 1);
			this.timeLabel.x = ((this.timeIco.x + this.timeIco.width) + 5);
            this.timeLabel.y = (((this.timeIco.y + (this.timeIco.height / 2)) - (this.timeLabel.height / 2)) + 1);
            this.paraIco.x = ((this.scoreLabel.x + this.scoreLabel.width) + 25);
            this.paraIco.y = (((this.scoreIco.y + (this.scoreIco.height / 2)) - (this.paraIco.height / 2)) + 1);
        }
        private function play1Mu(_arg1:MouseEvent):void{
            this.play1.enable = false;
            this.play2.enable = false;
            Main.instance.ftr.send((("enb;" + this.id) + ";0"));
        }
		private function spectatorMu(_arg1:MouseEvent):void{
            Main.instance.ftr.send((("enb2;" + this.id) + ";3"));
        }
        private function play2Mu(_arg1:MouseEvent):void{
            this.play1.enable = false;
            this.play2.enable = false;
            Main.instance.ftr.send((("enb;" + this.id) + ";1"));
        }
        public function setType(_arg1:int, _arg2:int):void{
            this.type = _arg1;
            try {
                removeChild(this.play1);
            } catch(e:Error) {
            };
            try {
                removeChild(this.play2);
            } catch(e:Error) {
            };
            this.removeBIPW();
            if (_arg1 == 0){
                this.bipw1 = new BattleInfoPlayersWindow(0, _arg2);
                addChild(this.bipw1);
                addChild(this.play1);
                this.play1.icon = new play_icons_ALL();
                this.play1.label = "Играть";
            } else {
                this.bipw1 = new BattleInfoPlayersWindow(1, _arg2);
                this.bipw2 = new BattleInfoPlayersWindow(2, _arg2);
                addChild(this.bipw1);
                addChild(this.bipw2);
                addChild(this.play1);
                addChild(this.play2);
                this.play1.icon = new play_icons_RED();
                this.play1.label = "Играть";
                this.play2.icon = new play_icons_BLUE();
                this.play2.label = "Играть";
            };
        }
        public function removeBIPW():void{
            try {
                removeChild(this.bipw1);
            } catch(e:Error) {
            };
            try {
                removeChild(this.bipw2);
            } catch(e:Error) {
            };
        }
        private function infoImgCom(_arg1:Event):void{
            this.infoImg.res((this.wid - 24), (this.hei / 3));
        }
        public function setCopyText(_arg1:String):void{
            this.copyI.textField.text = _arg1;
        }
        public function res(_arg1:Number, _arg2:Number):void{
            this.biW.res(_arg1, (_arg2 - 50));
            this.infoImg.res((_arg1 - 24), (_arg2 / 3));
            this.rs.x = (this.infoImg.width - 10);
            this.rs.y = (this.infoImg.height - 10);
            this.copyI.y = (this.infoImg.height + 15);
            this.copyI.x = 12;
            this.copyI.width = ((_arg1 / 2.5) * 1.5);
            this.copyBut.width = ((_arg1 - this.copyI.width) - 18);
            this.copyBut.y = (this.infoImg.height + 14);
            this.copyBut.x = (this.copyI.width + 5);
            if (this.type == 0){
                try {
                    this.bipw1.y = (this.copyI.y + 33);
                    this.bipw1.x = 12;
                    this.bipw1.res((_arg1 - 24), ((_arg2 - this.bipw1.y) - 120));
                    this.play1.y = (_arg2 - 115);
                    this.play1.x = (_arg1 - 132);
                } catch(e:Error) {
                };
            } else {
                try {
                    this.bipw1.y = (this.copyI.y + 33);
                    this.bipw1.x = 12;
                    this.bipw1.res(((_arg1 / 2) - 14), ((_arg2 - this.bipw1.y) - 120));
                    this.play1.y = (_arg2 - 115);
                    this.play1.x = 12;
                } catch(e:Error) {
                };
                try {
                    this.bipw2.y = (this.copyI.y + 33);
                    this.bipw2.res(((_arg1 / 2) - 14), ((_arg2 - this.bipw2.y) - 120));
                    this.bipw2.x = ((_arg1 - this.bipw2.width) - 12);
                    this.play2.y = (_arg2 - 115);
                    this.play2.x = (_arg1 - 132);
                } catch(e:Error) {
                };
            };
            this.wid = _arg1;
            this.hei = _arg2;
        }

    }
}//package mishin870.gui.BattleInfo 
