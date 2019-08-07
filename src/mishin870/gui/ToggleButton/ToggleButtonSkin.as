package mishin870.gui.ToggleButton {
    import flash.display.*;

    public class ToggleButtonSkin extends Sprite {

        public static const SKIN_NORM:int = 0;
        public static const SKIN_HOVER:int = 1;
        public static const SKIN_DOWN:int = 2;
        [Embed(source="ToggleButtonSkin/cd.png")] private var cdClass:Class;
        [Embed(source="ToggleButtonSkin/ch.png")] private var chClass:Class;
        [Embed(source="ToggleButtonSkin/cn.png")] private var cnClass:Class;
        [Embed(source="ToggleButtonSkin/ld.png")] private var ldClass:Class;
        [Embed(source="ToggleButtonSkin/lh.png")] private var lhClass:Class;
        [Embed(source="ToggleButtonSkin/ln.png")] private var lnClass:Class;
        [Embed(source="ToggleButtonSkin/rd.png")] private var rdClass:Class;
        [Embed(source="ToggleButtonSkin/rh.png")] private var rhClass:Class;
        [Embed(source="ToggleButtonSkin/rn.png")] private var rnClass:Class;

        private var cd:Bitmap = new cdClass();
        private var ch:Bitmap = new chClass();
        private var cn:Bitmap = new cnClass();
        private var ld:Bitmap = new ldClass();
        private var lh:Bitmap = new lhClass();
        private var ln:Bitmap = new lnClass();
        private var rd:Bitmap = new rdClass();
        private var rh:Bitmap = new rhClass();
        private var rn:Bitmap = new rnClass();
        private var _wid:int;
        private var _skin:int = 0;

        public function ToggleButtonSkin(){
            super();
            this.wid = 100;
        }
        public function set wid(_arg1:int):void{
            this._wid = _arg1;
            this.res(this._wid);
        }
        public function get wid():int{
            return (this._wid);
        }
        public function set skin(_arg1:int):void{
            this._skin = _arg1;
            this.res(this._wid);
        }
        public function get skin():int{
            return (this._skin);
        }
        private function removeAl():void{
            try {
                while (true) {
                    removeChildAt(0);
                };
            } catch(E:Error) {
            };
        }
        private function res(_arg1:int):void{
            this.removeAl();
            if (this._skin == SKIN_NORM){
                addChild(this.ln);
                addChild(this.rn);
                addChild(this.cn);
                this.cn.x = this.ln.width;
                this.cn.width = ((_arg1 - this.ln.width) - this.rn.width);
                this.rn.x = (this.cn.x + this.cn.width);
            };
            if (this._skin == SKIN_HOVER){
                addChild(this.lh);
                addChild(this.rh);
                addChild(this.ch);
                this.ch.x = this.lh.width;
                this.ch.width = ((_arg1 - this.lh.width) - this.rh.width);
                this.rh.x = (this.ch.x + this.ch.width);
            };
            if (this._skin == SKIN_DOWN){
                addChild(this.ld);
                addChild(this.rd);
                addChild(this.cd);
                this.cd.x = this.ld.width;
                this.cd.width = ((_arg1 - this.ld.width) - this.rd.width);
                this.rd.x = (this.cd.x + this.cd.width);
            };
        }

    }
}//package mishin870.gui.ToggleButton 
