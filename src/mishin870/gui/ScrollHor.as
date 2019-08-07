package mishin870.gui {
    import flash.display.*;
    import mishin870.gui.ScrollHorSkins.*;
	import flash.events.Event;
    import flash.events.MouseEvent;

    public class ScrollHor extends Sprite {

        private var _skin:ScrollHorSkin;
        private var _wid:int;
        private var _scrollW:Number = 0;
        private var _scrollX:int = 0;
        private var l:Bitmap;
        private var c:Bitmap;
        private var r:Bitmap;
        private var sl:Bitmap;
        private var sc:Bitmap;
        private var sr:Bitmap;
		public var min:Number = 0;
        public var max:Number = 10;
        public var val:Number = 4;
		var ms:Boolean = false;
		var mox:Number;
		var prevVal:Number;
		var callBack:Function;

        public function ScrollHor(callBack:Function){
            this.wid = 100;
            this.skin = new ScrollHorGreenSkin();
			this.callBack = callBack;
        }
        public function set scrollW(_arg1:Number):void{
            this._scrollW = _arg1;
            this.refreshSkin();
        }
        public function get scrollW():Number{
            return (this._scrollW);
        }
        public function get wid():int{
            return (this._wid);
        }
        public function set wid(_arg1:int):void{
            this._wid = _arg1;
            if (this._skin != null){
                this.refreshSkin();
            };
        }
        public function set skin(_arg1:ScrollHorSkin):void{
            this._skin = _arg1;
            this.l = new Bitmap(this._skin.l.bitmapData);
            this.c = new Bitmap(this._skin.c.bitmapData);
            this.r = new Bitmap(this._skin.l.bitmapData);
            this.r.scaleX = -1;
            this.sl = new Bitmap(this._skin.sl.bitmapData);
            this.sc = new Bitmap(this._skin.sc.bitmapData);
            this.sr = new Bitmap(this._skin.sl.bitmapData);
            this.sr.scaleX = -1;
            this.refreshSkin();
        }
        public function get skin():ScrollHorSkin{
            return (this._skin);
        }
        public function get hei():int{
            return (this.l.height);
        }
        private function removeAl():void{
            try {
                while (true) {
                    removeChildAt(0);
                };
            } catch(e:Error) {
            };
        }
        public function set scrollX(_arg1:int):void{
            this._scrollX = _arg1;
            this.refreshSkin();
        }
        public function get scrollX():int{
            return (this._scrollX);
        }
        private function refreshSkin():void{
            this.removeAl();
            this.c.width = ((this._wid - this.l.width) - this.r.width);
            this.c.x = this.l.width;
            this.r.x = (this.c.x + this.c.width);
            addChild(this.l);
            addChild(this.c);
            addChild(this.r);
            this.sl.y = 2;
            this.sl.x = (this._scrollX + 1);
            this.sc.width = (this._scrollW * (this._wid - 4));
            this.sc.y = 2;
            this.sc.x = (this._scrollX + 2);
            this.sr.y = 2;
            this.sr.x = (this.sc.x + this.sc.width);
            addChild(this.sl);
            addChild(this.sc);
            addChild(this.sr);
        }

    }
}//package mishin870.gui 
