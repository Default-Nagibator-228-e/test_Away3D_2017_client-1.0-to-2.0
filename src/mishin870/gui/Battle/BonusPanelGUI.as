package mishin870.gui.Battle {
    import flash.events.*;
    import flash.display.*;
    import mishin870.gui.Battle.GlassButton.*;

    public class BonusPanelGUI extends Sprite {

        public var h:GlassButton;
        public var da:GlassButton;
        public var dd:GlassButton;
        public var ds:GlassButton;
        public var m:GlassButton;

        public function BonusPanelGUI(){
            this.h = new GlassButton();
            this.da = new GlassButton();
            this.dd = new GlassButton();
            this.ds = new GlassButton();
            this.m = new GlassButton();
            super();
            this.h.off = this.h.x;
            addChild(this.h);
            this.da.x = ((this.h.x + this.h.width) + 10);
            this.da.off = this.da.x;
            addChild(this.da);
            this.dd.x = ((this.da.x + this.da.width) + 10);
            this.dd.off = this.dd.x;
            addChild(this.dd);
            this.ds.x = ((this.dd.x + this.dd.width) + 10);
            this.ds.off = this.ds.x;
            addChild(this.ds);
            this.m.x = ((this.ds.x + this.ds.width) + 10);
            this.m.off = this.m.x;
            addChild(this.m);
            this.h.setUpText("1");
            this.da.setUpText("2");
            this.dd.setUpText("3");
            this.ds.setUpText("4");
            this.m.setUpText("5");
            this.setBonus(1, 100);
            this.setBonus(2, 100);
            this.setBonus(3, 100);
            this.setBonus(4, 100);
            this.setBonus(5, 100);
            addEventListener(Event.ADDED_TO_STAGE, this.added);
        }
        public function setBonus(_arg1:int, _arg2:int):void{
            if (_arg1 == 1){
                this.h.setSkin((((_arg2 > 0)) ? 1 : 0));
                this.h.setDownText(_arg2.toString());
            };
            if (_arg1 == 2){
                this.da.setSkin((((_arg2 > 0)) ? 2 : 0));
                this.da.setDownText(_arg2.toString());
            };
            if (_arg1 == 3){
                this.dd.setSkin((((_arg2 > 0)) ? 3 : 0));
                this.dd.setDownText(_arg2.toString());
            };
            if (_arg1 == 4){
                this.ds.setSkin((((_arg2 > 0)) ? 4 : 0));
                this.ds.setDownText(_arg2.toString());
            };
            if (_arg1 == 5){
                this.m.setSkin((((_arg2 > 0)) ? 5 : 0));
                this.m.setDownText(_arg2.toString());
            };
        }
        public function setInactive(_arg1:int, _arg2:int):void{
            if (_arg1 == 1){
                this.h.setInactive(_arg2, this);
            };
            if (_arg1 == 2){
                this.da.setInactive(_arg2, this);
            };
            if (_arg1 == 3){
                this.dd.setInactive(_arg2, this);
            };
            if (_arg1 == 4){
                this.ds.setInactive(_arg2, this);
            };
            if (_arg1 == 5){
                this.m.setInactive(_arg2, this);
            };
        }
        public function active():void{
            if (!this.h.getEnabled()){
                this.h.active();
            };
            if (!this.da.getEnabled()){
                this.da.active();
            };
            if (!this.dd.getEnabled()){
                this.dd.active();
            };
            if (!this.ds.getEnabled()){
                this.ds.active();
            };
            if (!this.m.getEnabled()){
                this.m.active();
            };
        }
        public function getEnab(_arg1:int):Boolean{
            if (_arg1 == 1){
                return (this.h.getEnabled());
            };
            if (_arg1 == 2){
                return (this.da.getEnabled());
            };
            if (_arg1 == 3){
                return (this.dd.getEnabled());
            };
            if (_arg1 == 4){
                return (this.ds.getEnabled());
            };
            if (_arg1 == 5){
                return (this.m.getEnabled());
            };
            return (true);
        }
        private function added(_arg1:Event):void{
            stage.addEventListener(Event.RESIZE, this.res);
            this.res(null);
        }
        private function res(_arg1:Event):void{
            if (stage == null){
                Main.instance.stage.removeEventListener(Event.RESIZE, this.res);
                return;
            };
            this.y = ((stage.stageHeight - 10) - this.h.height);
        }

    }
}//package mishin870.gui.Battle 
