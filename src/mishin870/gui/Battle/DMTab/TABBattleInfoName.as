package mishin870.gui.Battle.DMTab {
	import controls.Label;
    import flash.display.*;
    import controls.*;
    import flash.text.*;

    public class TABBattleInfoName extends Sprite {

        private var _label:Label;

        public function TABBattleInfoName(_arg1:int, _arg2:int){
            this._label = new Label();
            super();
            graphics.beginFill(0, 0.5);
            graphics.drawRoundRect(0, 0, _arg1, _arg2, 15);
            graphics.endFill();
            var _local3:TextFormat = new TextFormat("MyriadPro", 18);
            this._label.defaultTextFormat = _local3;
            addChild(this._label);
        }
        public function set label(_arg1:String):void{
            this._label.text = _arg1;
            this.refreshLabel();
        }
        public function get label():String{
            return (this._label.text);
        }
        private function refreshLabel():void{
            this._label.x = ((width / 2) - (this._label.width / 2));
            this._label.y = ((height / 2) - (this._label.height / 2));
        }

    }
}//package mishin870.gui.Battle.DMTab 
