package mishin870.gui.BattleInfo {
	import controls.TankWindowInner;
    import flash.events.*;
    import flash.display.*;
    import controls.*;
    import flash.net.*;

    public class InfoImage extends Sprite {

        private var imgLoader:Loader;
        private var inner:TankWindowInner;
        private var img:Bitmap;

        public function InfoImage(){
            this.imgLoader = new Loader();
            this.inner = new TankWindowInner();
            this.img = new Bitmap();
            super();
            addChild(this.img);
            addChild(this.inner);
        }
        public function loadImage(_arg1:String):void{
            this.imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.imgCom);
            this.imgLoader.load(new URLRequest(_arg1));
        }
        private function imgCom(_arg1:Event):void{
            this.img.bitmapData = (this.imgLoader.content as Bitmap).bitmapData;
            this.imgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.imgCom);
            dispatchEvent(new Event(Event.COMPLETE));
        }
        public function res(_arg1:Number, _arg2:Number):void{
            this.img.width = _arg1;
            this.img.height = _arg2;
            this.inner.width = _arg1;
            this.inner.height = _arg2;
        }

    }
}//package mishin870.gui.BattleInfo 
