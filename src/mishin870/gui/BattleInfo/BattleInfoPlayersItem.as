package mishin870.gui.BattleInfo {
	import controls.Label;
    import flash.display.*;
    import controls.*;
    import flash.text.*;
    import assets.cellrenderer.battlelist.*;

    public class BattleInfoPlayersItem extends Sprite {

        private static const OFFSET:int = 15;

        private var backSkin:DisplayObject;
        private var tfname:Label;
        public var type:Number;
        private var rank:DisplayObject;

        public function BattleInfoPlayersItem(_arg1:int, _arg2:int, _arg3:String="", _arg4:DisplayObject=null){
            this.tfname = new Label();
            super();
            if (_arg2 == 1){
                this.backSkin = new CellRed();
            };
            if (_arg2 == 2){
                this.backSkin = new CellBlue();
            };
            if (_arg2 == 0){
                this.backSkin = new CellNormalUp();
            };
            addChild(this.backSkin);
            this.type = _arg1;
            if (_arg1 == 0){
                this.tfname.textColor = 0xFFFFFF;
                this.tfname.autoSize = TextFieldAutoSize.LEFT;
                this.tfname.text = _arg3;
                this.rank = _arg4;
                addChild(_arg4);
                this.tfname.x = OFFSET;
                _arg4.x = (this.tfname.x - _arg4.width);
                addChild(this.tfname);
                this.tfname.selectable = false;
                _arg4.y = ((this.tfname.height / 2) - (_arg4.height / 2));
            };
            if (_arg1 == 1){
                this.tfname.textColor = 0x858585;
                this.tfname.autoSize = TextFieldAutoSize.LEFT;
                this.tfname.text = "Пусто";
                this.tfname.selectable = false;
                addChild(this.tfname);
                this.tfname.x = OFFSET;
            };
        }
        public function setMaxWidth(_arg1:Number):void{
            this.backSkin.width = _arg1;
        }
        public function setType(_arg1:int, _arg2:String="", _arg3:DisplayObject=null):void{
            try {
                while (true) {
                    removeChildAt(0);
                };
            } catch(e:Error) {
            };
            addChild(this.backSkin);
            this.type = _arg1;
            if (_arg1 == 0){
                this.tfname.textColor = 0xFFFFFF;
                this.tfname.autoSize = TextFieldAutoSize.LEFT;
                this.tfname.text = _arg2;
                addChild(_arg3);
                addChild(this.tfname);
                this.tfname.x = OFFSET;
                _arg3.x = (this.tfname.x - _arg3.width);
                this.tfname.selectable = false;
                _arg3.y = ((this.tfname.height / 2) - (_arg3.height / 2));
            };
            if (_arg1 == 1){
                this.tfname.textColor = 0x858585;
                this.tfname.autoSize = TextFieldAutoSize.LEFT;
                this.tfname.text = "Пусто";
                this.tfname.selectable = false;
                addChild(this.tfname);
                this.tfname.x = OFFSET;
            };
        }

    }
}//package mishin870.gui.BattleInfo 
