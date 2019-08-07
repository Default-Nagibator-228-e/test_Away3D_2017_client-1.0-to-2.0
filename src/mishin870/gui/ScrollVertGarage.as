package mishin870.gui {
    import flash.display.*;
    import mishin870.gui.ScrollVertSkins.*;

    public class ScrollVertGarage extends Sprite {

        private var _skin:ScrollVertSkin;
        private var _hei:int;
        private var _scrollH:Number = 0;
        private var _scrollY:int = 0;
        private var u:Bitmap;
        private var c:Bitmap;
        private var d:Bitmap;
        private var su:Bitmap;
        private var sc:Bitmap;
        private var sd:Bitmap;

        public function ScrollVertGarage(){
            this.hei = 100;
            this.skin = new ScrollVertGreenSkin();
        }
        public function set scrollH(_arg1:Number):void{
            this._scrollH = _arg1;
            this.refreshSkin();
        }
        public function get scrollH():Number{
            return (this._scrollH);
        }
        public function get hei():int{
            return (this._hei);
        }
        public function set hei(_arg1:int):void{
            this._hei = _arg1;
            if (this._skin != null){
                this.refreshSkin();
            };
        }
        public function set skin(_arg1:ScrollVertSkin):void{
            this._skin = _arg1;
            this.u = new Bitmap(this._skin.u.bitmapData);
            this.c = new Bitmap(this._skin.c.bitmapData);
            this.d = new Bitmap(this._skin.u.bitmapData);
            this.d.scaleY = -1;
            this.su = new Bitmap(this._skin.su.bitmapData);
            this.sc = new Bitmap(this._skin.sc.bitmapData);
            this.sd = new Bitmap(this._skin.su.bitmapData);
            this.sd.scaleY = -1;
            this.refreshSkin();
        }
        public function get skin():ScrollVertSkin{
            return (this._skin);
        }
        public function get wid():int{
            return (this.u.width);
        }
        private function removeAl():void{
            try {
                while (true) {
                    removeChildAt(0);
                };
            } catch(e:Error) {
            };
        }
        public function set scrollY(_arg1:int):void{
            this._scrollY = _arg1;
            this.refreshSkin();
        }
        public function get scrollY():int{
            return (this._scrollY);
        }
        private function refreshSkin():void{
            this.removeAl();
            this.c.height = ((this._hei - this.u.height) - this.d.height);
            this.c.y = this.u.height;
            this.d.y = (this.c.y + this.c.height);
            addChild(this.u);
            addChild(this.c);
            addChild(this.d);
            this.su.x = 2;
            this.su.y = (this._scrollY + 1);
            this.sc.height = (this._scrollH * (this._hei - 4));
            this.sc.x = 2;
            this.sc.y = (this._scrollY + 2);
            this.sd.x = 2;
            this.sd.y = (this.sc.y + this.sc.height);
            addChild(this.su);
            addChild(this.sc);
            addChild(this.sd);
        }

    }
}//package mishin870.gui 
