package mishin870.gui {
    import controls.*;
    import flash.display.*;

    public class RankProgress extends Sprite {
        [Embed(source="RankProgress/c.png")] private var cClass:Class;
        [Embed(source="RankProgress/c2.png")] private var c2Class:Class;
        [Embed(source="RankProgress/l.png")] private var lClass:Class;
        [Embed(source="RankProgress/r.png")] private var rClass:Class;
        [Embed(source="RankProgress/l2.png")] private var l2Class:Class;
        [Embed(source="RankProgress/r2.png")] private var r2Class:Class;
        private var c:Bitmap = new cClass();
        private var c2:Bitmap = new c2Class();
        private var l:Bitmap = new lClass();
        private var r:Bitmap = new rClass();
        private var l2:Bitmap = new l2Class();
        private var r2:Bitmap = new r2Class();
        public var wid:Number;
        public var min:Number;
        public var max:Number;
        public var val:Number;
        private var label:Label = new Label();
		
        public function RankProgress() {
            label.textColor = 4279500544;
            label.x = 7;
            label.y = 4;
            addChild(l);
            addChild(l2);
            addChild(c);
            addChild(c2);
            addChild(r);
            addChild(r2);
            addChild(label);
            l2.visible = false;
            r2.visible = false;
            this.wid = 43;
            this.updateProgress(0, 100, 50);
        }
		
        public function setLabel(caption:String):void {
            label.text = caption;
        }
		
        public function updateProgress(min:Number, max:Number, val:Number):void {
            this.min = min;
            this.max = max;
            this.val = val;
            this.update();
        }
		
        private function setLeftRightVisible(param1:Boolean, param2:Boolean):void {
            if (param1)
            {
                l2.visible = true;
                l.visible = false;
            }
            else
            {
                l.visible = true;
                l2.visible = false;
            }
            if (param2)
            {
                r2.visible = true;
                r.visible = false;
            }
            else
            {
                r.visible = true;
                r2.visible = false;
            }
        }
		
        public function update():void {
            r.x = this.wid - 7;
            r2.x = this.wid - 7;
            var _loc_1:* = this.max - this.min;
            var _loc_2:* = this.val - this.min;
            if (_loc_2 <= 0)
            {
                c.width = this.wid - 14;
                c.x = 7;
                c2.visible = false;
                c.visible = true;
                setLeftRightVisible(false, false);
                return;
            }
            if (_loc_2 >= _loc_1)
            {
                c2.width = this.wid - 14;
                c2.x = 7;
                c.visible = false;
                c2.visible = true;
                setLeftRightVisible(true, true);
                return;
            }
            var _loc_3:* = Math.round(_loc_2 / (_loc_1 / (this.wid - 14)));
            c2.width = _loc_3;
            c.width = this.wid - (14 + _loc_3);
            c.x = _loc_3 + 7;
            c2.x = 7;
            c.visible = true;
            c2.visible = true;
            setLeftRightVisible(true, false);
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