package mishin870.gui {
	import controls.Label;
    import flash.events.*;
    import flash.display.*;
    import controls.*;

    public class UpPanelButton extends Sprite {

        [Embed(source="UpPanelButton/cn.png")] private static const cnClass:Class;
        [Embed(source="UpPanelButton/cd.png")] private static const cdClass:Class;
        [Embed(source="UpPanelButton/coff.png")] private static const coffClass:Class;
        [Embed(source="UpPanelButton/ln.png")] private static const lnClass:Class;
        [Embed(source="UpPanelButton/ld.png")] private static const ldClass:Class;
        [Embed(source="UpPanelButton/loff.png")] private static const loffClass:Class;
        [Embed(source="UpPanelButton/rn.png")] private static const rnClass:Class;
        [Embed(source="UpPanelButton/rd.png")] private static const rdClass:Class;
        [Embed(source="UpPanelButton/roff.png")] private static const roffClass:Class;
        private var cn:Bitmap;
        private var cd:Bitmap;
        private var coff:Bitmap;
        private var ln:Bitmap;
        private var ld:Bitmap;
        private var loff:Bitmap;
        private var rn:Bitmap;
        private var rd:Bitmap;
        private var roff:Bitmap;
        private var skin:Boolean = false;
        private var enabled:Boolean = true;
        public var wid:Number = 28;
        public var hei:Number;
        private var label:Label;
        private var icon:Bitmap = null;

        public function UpPanelButton() {
            this.cn = new cnClass();
            this.cd = new cdClass();
            this.coff = new coffClass();
            this.ln = new lnClass();
            this.ld = new ldClass();
            this.loff = new loffClass();
            this.rn = new rnClass();
            this.rd = new rdClass();
            this.roff = new roffClass();
            this.label = new Label();
            this.setSkin(false);
            this.addEventListener(MouseEvent.MOUSE_UP, this.mu);
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.md);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.mu);
        }

        public function setEnabled(param1:Boolean):void {
            if (param1 == enabled) return;
            this.enabled = param1;
            this.setSkin(this.skin);
        }

        public function setIcon(param1:Bitmap):void {
            this.icon = new Bitmap(param1.bitmapData);
            this.setSkin(this.skin);
        }

        private function mu(event:MouseEvent):void {
            if (this.enabled) {
                this.setSkin(false);
            }
        }

		private function md(event:MouseEvent):void {
            if (this.enabled) {
                this.setSkin(true);
            }
        }

        public function setLabel(param1:String):void {
            this.label.text = param1;
			this.label.size = 20;
            this.setSkin(this.skin);
        }

        private function setSkin(param1:Boolean):void {
            var _loc_3:* = NaN;
            this.skin = param1;
            this.removeAl();
            if (this.enabled) {
                if (param1) {
                    addChild(this.ld);
                    addChild(this.cd);
                    addChild(this.rd);
                    this.cd.x = 4;
                    this.cd.width = this.wid;
                    this.rd.x = this.wid + 4;
					this.ld.height = this.hei;
					this.cd.height = this.hei;
					this.rd.height = this.hei;
                }else{
                    addChild(this.ln);
                    addChild(this.cn);
                    addChild(this.rn);
                    this.cn.x = 4;
                    this.cn.width = this.wid;
                    this.rn.x = this.wid + 4;
					this.cn.height = this.hei;
					this.ln.height = this.hei;
					this.rn.height = this.hei;
                }
            } else {
                addChild(this.loff);
                addChild(this.coff);
                addChild(this.roff);
                this.coff.x = 4;
                this.coff.width = this.wid;
                this.roff.x = this.wid + 4;
                this.loff.y = -1;
                this.roff.y = -1;
                this.coff.y = -1;
				this.coff.height = this.hei;
				this.roff.height = this.hei;
				this.loff.height = this.hei;
            }
            var _loc_2:* = this.wid + 10;
            if (this.icon != null) {
                if (this.label.text != "") {
                    _loc_3 = this.label.width + this.icon.width + 8;
                    this.icon.x = _loc_2 / 2 - _loc_3 / 2;
                    this.icon.y = this.hei*0.45 - this.icon.height / 2;
                    this.label.x = this.icon.x + this.icon.width + 5;
                    this.label.y = this.hei*0.45 - this.label.height / 2;
                } else {
                    this.icon.x = _loc_2 / 2 - this.icon.width / 2;
                    this.icon.y = this.hei*0.45 - this.icon.height / 2;
                }
                if (param1) {
                    this.icon.y++;
                    this.label.y++;
                }
                addChild(this.icon);
            } else {
                this.label.x = _loc_2 / 2 - this.label.width / 2;
                this.label.y = this.hei*0.45 - this.label.height / 2;
                if (param1) {
                    this.label.y++;
                }
            }
            addChild(this.label);
        }

        public function setWidth(wid:Number):void {
            this.wid = wid;
            this.setSkin(this.skin);
        }
		public function setHeight(hei:Number):void {
            this.hei = hei;
            this.setSkin(this.skin);
        }
		
		private function removeAl():void {
			try {
				while (true) {
					removeChildAt(0);
				}
			} catch (e:Error){}
        }
		
    }
}