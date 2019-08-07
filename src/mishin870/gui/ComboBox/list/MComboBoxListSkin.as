package mishin870.gui.ComboBox.list {
    import flash.events.*;
    import flash.display.*;

    public class MComboBoxListSkin extends Sprite {

        [Embed(source="MComboBoxListSkin/cClass.png")] private var cClass:Class;
        [Embed(source="MComboBoxListSkin/dcClass.png")] private var dcClass:Class;
        [Embed(source="MComboBoxListSkin/dlClass.png")] private var dlClass:Class;
        [Embed(source="MComboBoxListSkin/drClass.png")] private var drClass:Class;
        [Embed(source="MComboBoxListSkin/lClass.png")] private var lClass:Class;
        [Embed(source="MComboBoxListSkin/rClass.png")] private var rClass:Class;
        [Embed(source="MComboBoxListSkin/ulClass.png")] private var ulClass:Class;
        [Embed(source="MComboBoxListSkin/urClass.png")] private var urClass:Class;

        private var c:Bitmap = new cClass();
        private var dc:Bitmap = new dcClass();
        private var dl:Bitmap = new dlClass();
        private var dr:Bitmap = new drClass();
        private var l:Bitmap = new lClass();
        private var r:Bitmap = new rClass();
        private var ul:Bitmap = new ulClass();
        private var ur:Bitmap = new urClass();
        public var items:MComboBoxListItems = new MComboBoxListItems();

        public function MComboBoxListSkin(){
            super();
            addChild(this.c);
            addChild(this.dc);
            addChild(this.dl);
            addChild(this.dr);
            addChild(this.l);
            addChild(this.r);
            addChild(this.ul);
            addChild(this.ur);
            addChild(this.items);
            addEventListener(MouseEvent.MOUSE_WHEEL, this.mw);
            this.res(100, 200);
        }
        private function mw(_arg1:MouseEvent):void{
            this.items.scroll(0, (-(_arg1.delta) * 2));
        }
        public function addItem(_arg1:String):void{
            this.items.addItem(_arg1);
        }
        public function res(_arg1:int, _arg2:int):void{
            this.l.y = 2;
            this.l.height = (_arg2 - 5);
            this.dl.y = (_arg2 - 3);
            this.dc.y = (_arg2 - 3);
            this.dc.x = 3;
            this.dc.width = (_arg1 - 6);
            this.dr.x = (_arg1 - 3);
            this.dr.y = (_arg2 - 3);
            this.r.x = (_arg1 - 5);
            this.r.y = 2;
            this.r.height = (_arg2 - 5);
            this.c.x = 5;
            this.c.y = 2;
            this.c.width = (_arg1 - 10);
            this.c.height = (_arg2 - 5);
            this.ul.x = (_arg1 - 2);
            this.items.x = 5;
            this.items.y = 2;
            this.items.res((_arg1 - 10), (_arg2 - 4));
        }

    }
}//package mishin870.gui.ComboBox.list 
