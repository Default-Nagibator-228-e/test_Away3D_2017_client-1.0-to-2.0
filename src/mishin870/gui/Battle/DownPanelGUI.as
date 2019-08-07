package mishin870.gui.Battle {
	import controls.Label;
    import flash.display.*;
    import controls.*;
    import flash.text.*;

    public class DownPanelGUI extends Sprite {

        [Embed(source="DownPanelGUI/moneyClass.png")] private var moneyClass:Class;
        [Embed(source="DownPanelGUI/crysClass.png")] private var crysClass:Class;
        [Embed(source="DownPanelGUI/scoreClass.png")] private var scoreClass:Class;
        [Embed(source="DownPanelGUI/timerClass.png")] private var timerClass:Class;

        private var score:Bitmap = new scoreClass();
        private var scoreL:Label = new Label();
        private var timer:Bitmap = new timerClass();
        private var timeL:Label = new Label();
        private var crys:Bitmap = new crysClass();
        private var money:Bitmap = new moneyClass();
        private var moneyL:Label = new Label();
        public var off:int;
        private var gl:Glass = new Glass();
        public var type:int;
        private var mon:int;
        public var bt:BattleTimer;
        private var gls:Glass = new Glass();
        private var score2:Bitmap;
        private var score2L:Label = new Label();

        public function DownPanelGUI(){
            this.scoreL.text = "10";
            this.timeL.text = "15 : 00";
            var _local1:StyleSheet = new StyleSheet();
            var _local2:Object = new Object();
            _local2.fontSize = 19;
            _local2.fontName = "MyriadPro";
            _local1.setStyle(".item", _local2);
            this.score2L.styleSheet = _local1;
            this.gl.setWid(300);
            addChild(this.gl);
            this.gls.setWid(100);
            addChild(this.gls);
            addChild(this.score2);
            addChild(this.score2L);
            this.money.y = 12;
            this.money.x = 13;
            addChild(this.money);
            this.moneyL.y = 10;
            this.moneyL.x = 35;
            addChild(this.moneyL);
            this.crys.y = 14;
            addChild(this.crys);
            this.type = 0;
            this.setMoney(0);
            this.setMode(0);
            this.setMoney(0);
			this.bt = new BattleTimer(this);
            this.setScore2Label("0");
            this.off = 410;
        }
        public function setMode(_arg1:int):void{
            this.removeCh(this.score);
            this.removeCh(this.timer);
            this.removeCh(this.scoreL);
            this.removeCh(this.timeL);
            this.type = _arg1;
            if (_arg1 == 1){
                addChild(this.score);
                addChild(this.scoreL);
            };
            if (_arg1 == 2){
                addChild(this.timer);
                addChild(this.timeL);
            };
            if (_arg1 == 3){
                addChild(this.score);
                addChild(this.timer);
                addChild(this.scoreL);
                addChild(this.timeL);
            };
            this.setMoney(this.mon);
        }
        public function setScoreLabel(_arg1:String):void{
            this.scoreL.text = _arg1;
            this.setMoney(this.mon);
        }
        public function setTimeLabel(_arg1:String):void{
            this.timeL.text = _arg1;
            this.setMoney(this.mon);
        }
        public function setScore2Label(_arg1:String):void{
            this.score2L.htmlText = (("<p class='item'>" + _arg1) + "</p>");
            this.setMoney(this.mon);
        }
        private function removeCh(_arg1:DisplayObject):void{
            if (_arg1 == null){
                return;
            };
            if (contains(_arg1)){
                removeChild(_arg1);
            };
        }
        public function setMoney(_arg1:int):void{
            this.mon = _arg1;
            this.moneyL.htmlText = ("Фонд битвы: " + _arg1);
            this.crys.x = ((this.moneyL.x + this.moneyL.width) + 2);
            if (this.type == 0){
                this.gl.setWid((this.crys.x + 20));
            };
            if (this.type == 1){
                this.score.y = 7;
                this.score.x = (this.crys.x + 13);
                this.scoreL.x = (this.score.x + 19);
                this.scoreL.y = 10;
                this.gl.setWid(((this.scoreL.x + this.scoreL.width) + 10));
            };
            if (this.type == 2){
                this.timer.y = 12;
                this.timer.x = (this.crys.x + 20);
                this.timeL.x = (this.timer.x + 18);
                this.timeL.y = 10;
                this.gl.setWid(((this.timeL.x + this.timeL.width) + 10));
            };
            if (this.type == 3){
                this.score.y = 7;
                this.score.x = (this.crys.x + 13);
                this.scoreL.x = (this.score.x + 19);
                this.scoreL.y = 10;
                this.timer.y = 12;
                this.timer.x = ((this.scoreL.x + this.scoreL.width) + 10);
                this.timeL.x = (this.timer.x + 18);
                this.timeL.y = 10;
                this.gl.setWid(((this.timeL.x + this.timeL.width) + 10));
            };
            try {
                this.gls.x = ((this.gl.x + this.gl.width) + 10);
                this.score2.y = 6;
                this.score2.x = (this.gls.x + 6);
                this.score2L.x = (this.score2.x + 22);
                this.score2L.y = 4;
                this.gls.setWid((((this.score2L.x - this.gls.x) + this.score2L.width) + 8));
                this.off = ((this.gl.width + this.gls.width) + 20);
                this.x = (stage.stageWidth - this.off);
            } catch(e:Error) {
            };
        }

    }
}//package mishin870.gui.Battle 
