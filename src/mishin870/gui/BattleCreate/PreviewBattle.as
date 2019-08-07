package mishin870.gui.BattleCreate {
	import controls.TankWindowInner;
    import flash.events.*;
    import flash.display.*;
    import controls.*;
    import flash.net.*;

    public class PreviewBattle extends Sprite {

        private var img:Bitmap;
        private var inner:TankWindowInner;
        private var isLoading:Boolean = false;
        private var wid:int;
        private var hei:int;

        public function PreviewBattle(){
            this.img = new Bitmap(new BitmapData(1, 1));
            this.inner = new TankWindowInner();
            super();
            addChild(this.img);
            addChild(this.inner);
        }
        public function loadImage(_arg1:String):void{
            var loader:* = null;
            var url:* = "http://f90573wp.beget.tech/" + _arg1;
            if (this.isLoading){
                return;
            };
            this.isLoading = true;
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (_arg1:Event):void{
                isLoading = false;
                img.bitmapData = (loader.content as Bitmap).bitmapData;
                res(wid, hei);
            });
            loader.load(new URLRequest(url));
        }
        public function res(_arg1:int, _arg2:int):void{
            this.wid = _arg1;
            this.hei = _arg2;
            this.img.width = _arg1;
            this.img.height = _arg2;
            this.inner.width = _arg1;
            this.inner.height = _arg2;
        }

    }
}//package mishin870.gui.BattleCreate 
