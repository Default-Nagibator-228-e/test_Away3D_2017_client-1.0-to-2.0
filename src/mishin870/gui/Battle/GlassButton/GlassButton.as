package mishin870.gui.Battle.GlassButton {
	import controls.Label;
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;
    import controls.*;
    import flash.text.*;

    public class GlassButton extends Sprite {

        [Embed(source="GlassButton/defClass.png")] private var defClass:Class;
        [Embed(source="GlassButton/hClass.png")] private var hClass:Class;
        [Embed(source="GlassButton/mClass.png")] private var mClass:Class;
        [Embed(source="GlassButton/daClass.png")] private var daClass:Class;
        [Embed(source="GlassButton/ddClass.png")] private var ddClass:Class;
        [Embed(source="GlassButton/dsClass.png")] private var dsClass:Class;
        [Embed(source="GlassButton/hiClass.png")] private var hiClass:Class;
        [Embed(source="GlassButton/miClass.png")] private var miClass:Class;
        [Embed(source="GlassButton/daiClass.png")] private var daiClass:Class;
        [Embed(source="GlassButton/ddiClass.png")] private var ddiClass:Class;
        [Embed(source="GlassButton/dsiClass.png")] private var dsiClass:Class;

        private var def:Bitmap = new defClass();
        private var h:Bitmap = new hClass();
        private var m:Bitmap = new mClass();
        private var da:Bitmap = new daClass();
        private var dd:Bitmap = new ddClass();
        private var ds:Bitmap = new dsClass();
        private var hi:Bitmap = new hiClass();
        private var mi:Bitmap = new miClass();
        private var dai:Bitmap = new daiClass();
        private var ddi:Bitmap = new ddiClass();
        private var dsi:Bitmap = new dsiClass();
        private var upl:Label = new Label();
        private var downl:Label = new Label();
        private var skin:int;
        private var clock:Clock;
        private var tmr:Timer;
        private var enab:Boolean = true;
        public var off:int = 0;

        public function GlassButton(){
            super();
            this.setSkin(0);
            addChild(this.upl);
            this.upl.x = 2;
            this.upl.y = -1;
            this.upl.selectable = false;
            this.downl.x = 32;
            this.downl.y = 20;
            this.downl.autoSize = TextFieldAutoSize.RIGHT;
            addChild(this.downl);
            this.downl.selectable = false;
            var _local1:StyleSheet = new StyleSheet();
            var _local2:Object = new Object();
            _local2.fontSize = 12;
            _local2.fontName = "MyriadPro";
            _local1.setStyle(".item", _local2);
            this.upl.styleSheet = _local1;
            var _local3:StyleSheet = new StyleSheet();
            var _local4:Object = new Object();
            _local4.fontSize = 12;
            _local4.fontName = "MyriadPro";
            _local4.bold = false;
            _local3.setStyle(".item", _local4);
            this.downl.styleSheet = _local3;
        }
        public function getEnabled():Boolean{
            if (int(this.downl.text) <= 0){
                return (false);
            };
            return (this.enab);
        }
        public function setUpText(_arg1:String):void{
            this.upl.htmlText = (("<p class='item'>" + _arg1) + "</p>");
        }
        public function setDownText(_arg1:String):void{
            this.downl.htmlText = (("<p class='item'>" + _arg1) + "</p>");
        }
        private function removeAl():void{
            try {
                while (true) {
                    removeChildAt(0);
                };
            } catch(e:Error) {
            };
        }
        public function setInactive(_arg1:int, _arg2:Sprite):void{
            this.enab = false;
            this.clock = new Clock(38, 10);
            this.clock.addToContainer(_arg2, (x + 2), (y + 2));
            this.clock.unknown(0);
            this.setSkin(this.skin);
            this.tmr = new Timer(100, _arg1);
            this.tmr.addEventListener(TimerEvent.TIMER, this.timerTim);
            this.tmr.addEventListener(TimerEvent.TIMER_COMPLETE, this.timerCom);
            this.tmr.start();
        }
        public function active():void{
            if (!this.enab){
                this.enab = true;
                this.setSkin(this.skin);
                this.tmr.removeEventListener(TimerEvent.TIMER, this.timerTim);
                this.tmr.removeEventListener(TimerEvent.TIMER_COMPLETE, this.timerCom);
                this.tmr = null;
                this.clock = null;
            };
        }
        private function timerTim(_arg1:TimerEvent):void{
            this.clock.off = this.off;
            this.clock.unknown((this.tmr.currentCount / this.tmr.repeatCount));
            this.setSkin(this.skin);
        }
        private function timerCom(_arg1:TimerEvent):void{
            this.enab = true;
            this.setSkin(this.skin);
            this.tmr.removeEventListener(TimerEvent.TIMER, this.timerTim);
            this.tmr.removeEventListener(TimerEvent.TIMER_COMPLETE, this.timerCom);
            this.tmr = null;
            this.clock = null;
        }
        public function setSkin(_arg1:int):void{
            this.skin = _arg1;
            this.removeAl();
            if (_arg1 == 0){
                addChild(this.def);
            };
            if (_arg1 == 1){
                addChild(this.h);
            };
            if (_arg1 == 2){
                addChild(this.da);
            };
            if (_arg1 == 3){
                addChild(this.dd);
            };
            if (_arg1 == 4){
                addChild(this.ds);
            };
            if (_arg1 == 5){
                addChild(this.m);
            };
            if (_arg1 != 0){
                addChild(this.upl);
            };
            if (((!(this.enab)) && ((_arg1 > 0)))){
                addChild(this.clock);
            };
            if (_arg1 != 0){
                addChild(this.downl);
            };
        }

    }
}//package mishin870.gui.Battle.GlassButton 
