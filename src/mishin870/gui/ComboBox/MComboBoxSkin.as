package mishin870.gui.ComboBox {
	import controls.Label;
    import flash.display.*;
    import flash.geom.*;
    import controls.*;

    public class MComboBoxSkin extends Sprite {

        public static const SKIN_NORMAL:int = 0;
        public static const SKIN_HOVER:int = 1;
        public static const SKIN_DOWN:int = 2;
        [Embed(source="MComboBoxSkin/cClass.png")] private var cClass:Class;
        [Embed(source="MComboBoxSkin/cdClass.png")] private var cdClass:Class;
        [Embed(source="MComboBoxSkin/chClass.png")] private var chClass:Class;
        [Embed(source="MComboBoxSkin/lClass.png")] private var lClass:Class;
        [Embed(source="MComboBoxSkin/ldClass.png")] private var ldClass:Class;
        [Embed(source="MComboBoxSkin/lhClass.png")] private var lhClass:Class;
        [Embed(source="MComboBoxSkin/rClass.png")] private var rClass:Class;
        [Embed(source="MComboBoxSkin/rdClass.png")] private var rdClass:Class;
        [Embed(source="MComboBoxSkin/rhClass.png")] private var rhClass:Class;

        private var c:Bitmap = new cClass();
        private var cd:Bitmap = new cdClass();
        private var ch:Bitmap = new chClass();
        private var l:Bitmap = new lClass();
        private var ld:Bitmap = new ldClass();
        private var lh:Bitmap = new lhClass();
        private var r:Bitmap = new rClass();
        private var rd:Bitmap = new rdClass();
        private var rh:Bitmap = new rhClass();
        private var _skin:int = 0;
        private var _wid:int;
        private var _text:Label = new Label();

        public function MComboBoxSkin(){
            super();
            this._text.x = 6;
            this._text.y = 6;
            this.wid = 100;
        }
        public function set skin(_arg1:int):void{
            this._skin = _arg1;
            this.wid = this._wid;
        }
        public function get skin():int{
            return (this._skin);
        }
        private function removeAl():void{
            try {
                while (true) {
                    removeChildAt(0);
                };
            } catch(e:Error) {
            };
        }
        public function set wid(_arg1:int):void{
            this._wid = _arg1;
            this.removeAl();
            this._text.scrollRect = new Rectangle(0, 0, (this._wid - 40), 30);
            if (this._skin == SKIN_NORMAL){
                addChild(this.c);
                addChild(this.l);
                addChild(this.r);
                this.c.width = (this._wid - 40);
                this.c.x = 7;
                this.r.x = (this._wid - 33);
                this._text.y = 6;
            };
            if (this._skin == SKIN_HOVER){
                addChild(this.ch);
                addChild(this.lh);
                addChild(this.rh);
                this.ch.width = (this._wid - 40);
                this.ch.x = 7;
                this.rh.x = (this._wid - 33);
                this._text.y = 6;
            };
            if (this._skin == SKIN_DOWN){
                addChild(this.cd);
                addChild(this.ld);
                addChild(this.rd);
                this.cd.width = (this._wid - 40);
                this.cd.x = 7;
                this.rd.x = (this._wid - 33);
                this._text.y = 7;
            };
            addChild(this._text);
        }
        public function set text(_arg1:String):void{
            this._text.text = _arg1;
        }
        public function get text():String{
            return (this._text.text);
        }
        public function get wid():int{
            return (this._wid);
        }

    }
}//package mishin870.gui.ComboBox 
