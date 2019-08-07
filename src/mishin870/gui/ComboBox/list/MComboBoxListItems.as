package mishin870.gui.ComboBox.list {
    import flash.events.*;
    import mishin870.gui.*;
    import __AS3__.vec.*;

    public class MComboBoxListItems extends ScrollingSpriteGarage {

        private var items:Vector.<MComboBoxListItem>;
        public var selItem:String;
        public var sel:int;

        public function MComboBoxListItems(){
            this.items = new Vector.<MComboBoxListItem>();
            super();
        }
        private function clickItem(_arg1:MComboBoxListItem):void{
            var _local3:MComboBoxListItem;
            var _local2:int;
            while (_local2 < this.items.length) {
                _local3 = this.items[_local2];
                if (_local3 == _arg1){
                    this.selItem = _arg1.label.text;
                    this.sel = _local2;
                    dispatchEvent(new Event(Event.CHANGE));
                };
                _local2++;
            };
        }
        public function addItem(_arg1:String):void{
            var _local2:MComboBoxListItem = new MComboBoxListItem(_arg1, this.clickItem);
            addChild(_local2);
            if (this.items.length == 0){
                _local2.y = 5;
            } else {
                _local2.y = (this.items[(this.items.length - 1)].y + this.items[(this.items.length - 1)].height);
            };
            this.items.push(_local2);
            setAWH(scrollRect.width, ((this.items.length * _local2.height) + 10));
        }
        public function res(_arg1:int, _arg2:int):void{
            var _local3:MComboBoxListItem;
            setRect(_arg1, _arg2);
            for each (_local3 in this.items) {
                _local3.res((_arg1 - 5));
            };
        }

    }
}//package mishin870.gui.ComboBox.list 
