package mishin870.gui.ComboBox {
	import controls.Label;
    import flash.events.*;
    import flash.display.*;
    import controls.*;
    import mishin870.gui.ComboBox.list.*;
    import flash.text.*;
    import flash.ui.*;

    public class MComboBox extends Sprite {

        private var skin:MComboBoxSkin;
        private var list:MComboBoxListSkin;
        private var _label:Label;
        public var selItem:int = 0;

        public function MComboBox(){
            this.skin = new MComboBoxSkin();
            this.list = new MComboBoxListSkin();
            this._label = new Label();
            super();
            addChild(this.skin);
            this._label.autoSize = TextFieldAutoSize.RIGHT;
            this._label.x = -10;
            this._label.y = 6;
            addChild(this._label);
            this.list.y = 28;
            this.list.visible = false;
            addChild(this.list);
            this.skin.addEventListener(MouseEvent.ROLL_OVER, this.skinOver);
            this.skin.addEventListener(MouseEvent.ROLL_OUT, this.skinOut);
            this.skin.addEventListener(MouseEvent.MOUSE_UP, this.skinN);
            this.skin.addEventListener(MouseEvent.MOUSE_DOWN, this.skinD);
            this.skin.addEventListener(MouseEvent.MOUSE_MOVE, this.skinH);
            this.skin.addEventListener(MouseEvent.CLICK, this.ShowHideList);
            this.list.items.addEventListener(Event.CHANGE, this.listCh);
        }
        private function listCh(_arg1:Event):void{
            this.text = this.list.items.selItem;
            this.selItem = this.list.items.sel;
            this.list.visible = false;
            Main.instance.loadBattleCreateImage(this.selItem);
        }
        public function addItem(_arg1:String):void{
            this.list.addItem(_arg1);
        }
        private function ShowHideList(_arg1:MouseEvent):void{
            this.list.visible = !(this.list.visible);
        }
        private function skinOver(_arg1:MouseEvent):void{
            Mouse.cursor = MouseCursor.BUTTON;
            this.skinH(null);
        }
        private function skinOut(_arg1:MouseEvent):void{
            Mouse.cursor = MouseCursor.ARROW;
            this.skinN(null);
        }
        public function set wid(_arg1:int):void{
            this.skin.wid = _arg1;
            this.list.res(_arg1, 200);
        }
        public function get wid():int{
            return (this.skin.wid);
        }
        public function set hei(_arg1:int):void{
            this.list.res(this.skin.wid, _arg1);
        }
        private function skinH(_arg1:MouseEvent):void{
            this.skin.skin = MComboBoxSkin.SKIN_HOVER;
        }
        private function skinN(_arg1:MouseEvent):void{
            this.skin.skin = MComboBoxSkin.SKIN_NORMAL;
        }
        private function skinD(_arg1:MouseEvent):void{
            this.skin.skin = MComboBoxSkin.SKIN_DOWN;
        }
        public function set text(_arg1:String):void{
            this.skin.text = _arg1;
        }
        public function get text():String{
            return (this.skin.text);
        }
        public function set label(_arg1:String):void{
            this._label.text = _arg1;
        }
        public function get label():String{
            return (this._label.text);
        }

    }
}//package mishin870.gui.ComboBox 
