package mishin870.gui {
    import flash.display.*;
    import flash.geom.*;

    public class ScrollingSprite extends Sprite {

        public var px:Number = 0;
        public var py:Number = 0;
        public var aW:Number;
        public var aH:Number;

        public function ScrollingSprite(){
            this.setRect(1, 1);
            this.setAWH(1, 1);
        }
        public function setAWH(_arg1:Number, _arg2:Number):void{
            this.aW = _arg1;
            this.aH = _arg2;
        }
        public function setRect(_arg1:Number, _arg2:Number):void{
            scrollRect = new Rectangle(this.px, this.py, _arg1, _arg2);
        }
        public function scroll(_arg1:Number, _arg2:Number):void{
            this.px = (this.px + _arg1);
            this.py = (this.py + _arg2);
            if ((this.px + scrollRect.width) > this.aW){
                this.px = (this.aW - scrollRect.width);
            };
            if ((this.py + scrollRect.height) > this.aH){
                this.py = (this.aH - scrollRect.height);
            };
            if (this.py < 0){
                this.py = 0;
            };
            if (this.px < 0){
                this.px = 0;
            };
            scrollRect = new Rectangle(this.px, this.py, scrollRect.width, scrollRect.height);
        }

    }
}//package mishin870.gui 