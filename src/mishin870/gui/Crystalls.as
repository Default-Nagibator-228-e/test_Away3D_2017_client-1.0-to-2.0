package mishin870.gui {
    import controls.*;
    import flash.display.*;
    import flash.events.*;

    public class Crystalls extends Sprite {
        [Embed(source="Crystalls/c.png")] private static const cClass:Class;
        [Embed(source="Crystalls/l.png")] private static const lClass:Class;
        [Embed(source="Crystalls/r.png")] private static const rClass:Class;
        [Embed(source="Crystalls/buyn.png")] private static const buyClass:Class;
        [Embed(source="Crystalls/buyd.png")] private static const buydClass:Class;
        private var c:Bitmap;
        private var l:Bitmap;
        private var r:Bitmap;
        private var buy:Bitmap;
        private var buyd:Bitmap;
        public var wid:Number;
        private var buy_state:Boolean = false;
        private var label:Label;

        public function Crystalls() {
            this.c = new cClass();
            this.l = new lClass();
            this.r = new rClass();
            this.buy = new buyClass();
            this.buyd = new buydClass();
            this.label = new Label();
            this.label.align = "right";
            this.label.textColor = 4279500544;
            this.label.x = 50;
            this.label.y = 4;
            addChild(this.l);
            addChild(this.c);
            addChild(this.r);
            addChild(this.buy);
            addChild(this.buyd);
            addChild(this.label);
            this.buy.y = 5;
            this.buyd.y = 5;
            this.wid = 84;
            this.setSkinBuy(false);
            addEventListener(MouseEvent.MOUSE_UP, this.mu);
            addEventListener(MouseEvent.MOUSE_OUT, this.mu);
            addEventListener(MouseEvent.MOUSE_DOWN, this.md);
        }

        public function setLabel(param1:String):void {
            this.label.text = param1;
            this.label.x = 60 - this.label.width;
        }

        private function mu(event:MouseEvent):void {
            if (event.localX >= this.wid - 34) {
                this.setSkinBuy(false);
            }
        }

		private function md(event:MouseEvent):void {
            if (event.localX >= this.wid - 34) {
                this.setSkinBuy(true);
            }
        }

		private function setSkinBuy(param1:Boolean):void {
            this.buy_state = param1;
            if (param1) {
                this.buy.visible = false;
                this.buyd.visible = true;
            } else {
                this.buyd.visible = false;
                this.buy.visible = true;
            }
        }

        public function update():void {
            this.r.x = this.wid - 48;
            this.c.width = this.wid - 46;
            this.c.x = 7;
            this.buy.x = this.wid - 28;
            this.buyd.x = this.wid - 28;
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