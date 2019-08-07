package mishin870.gui.Battle.DMTab {
	import controls.Label;
    import flash.display.*;
    import controls.*;
    import flash.text.*;
    import assets.cellrenderer.battlelist.*;
    import mishin870.gui.rang.*;

    public class TABBattleInfoItemDM extends Sprite {

        private var itemw:int;
        private var rank:RangSmall;
        private var nameL:Label;
        private var killsL:Label;
        private var destructsL:Label;
        private var rewardL:Label;
        private var upL:Label;
        public var id:int;

        public function TABBattleInfoItemDM(_arg1:int, _arg2:int, _arg3:int, _arg4:String, _arg5:int, _arg6:int, _arg7:int){
            this.id = _arg1;
            this.itemw = _arg2;
            this.rank = new RangSmall(_arg3);
            this.nameL = new Label();
            this.nameL.text = _arg4;
            this.killsL = new Label();
            this.killsL.autoSize = TextFieldAutoSize.RIGHT;
            this.killsL.x = _arg5;
            this.destructsL = new Label();
            this.destructsL.autoSize = TextFieldAutoSize.RIGHT;
            this.destructsL.x = _arg6;
            this.upL = new Label();
            this.upL.autoSize = TextFieldAutoSize.CENTER;
            this.upL.x = _arg7;
            this.rewardL = new Label();
            this.rewardL.autoSize = TextFieldAutoSize.RIGHT;
            this.rewardL.visible = false;
            this.setState(false);
            this.kills = 0;
            this.destructs = 0;
            this.up = "—";
        }
        public function calculateUp():void{
            var _local1:Number;
            var _local2:int;
            if ((((this.kills == 0)) || ((this.destructs == 0)))){
                this.up = "—";
                return;
            };
            _local1 = (this.kills / this.destructs);
            _local2 = int(_local1);
            this.up = _local1.toString().substr(0, (_local2.toString().length + 2));
        }
        public function set kills(_arg1:int):void{
            this.killsL.text = _arg1.toString();
            this.killsL.y = ((height / 2) - (this.killsL.height / 2));
        }
        public function get kills():int{
            return (int(this.killsL.text));
        }
        public function set destructs(_arg1:int):void{
            this.destructsL.text = _arg1.toString();
            this.destructsL.y = ((height / 2) - (this.destructsL.height / 2));
        }
        public function get destructs():int{
            return (int(this.destructsL.text));
        }
        public function set up(_arg1:String):void{
            this.upL.text = _arg1;
            this.upL.y = ((height / 2) - (this.upL.height / 2));
        }
        public function get up():String{
            return (this.upL.text);
        }
        public function set pname(_arg1:String):void{
            this.nameL.text = _arg1;
            this.nameL.y = ((height / 2) - (this.nameL.height / 2));
        }
        public function get pname():String{
            return (this.nameL.text);
        }
        public function set rang(_arg1:int):void{
            this.rank.setRank(_arg1);
        }
        public function set reward(_arg1:int):void{
            this.rewardL.text = _arg1.toString();
            this.rewardL.y = ((height / 2) - (this.rewardL.height / 2));
        }
        public function get reward():int{
            return (int(this.rewardL.text));
        }
        public function showReward(_arg1:int, _arg2:int, _arg3:int, _arg4:int):void{
            this.killsL.x = _arg1;
            this.destructsL.x = _arg2;
            this.upL.x = _arg3;
            this.rewardL.x = _arg4;
            this.rewardL.visible = true;
        }
        public function hideReward(_arg1:int, _arg2:int, _arg3:int):void{
            this.killsL.x = _arg1;
            this.destructsL.x = _arg2;
            this.upL.x = _arg3;
            this.rewardL.visible = false;
        }
        public function setState(_arg1:Boolean):void{
            var _local3:DisplayObject;
            var _local4:Sprite;
            try {
                while (true) {
                    removeChildAt(0);
                };
            } catch(e:Error) {
            };
            var _local2:Sprite = new Sprite();
            if (_arg1){
                _local3 = new CellRenderer_upSkin();
                _local3.width = this.itemw;
                _local2.addChild(_local3);
                _local4 = new Sprite();
                _local4.graphics.lineStyle(2, 0xFF00);
                _local4.graphics.beginFill(0, 0);
                _local4.graphics.drawRoundRect(2, 2, (_local2.width - 4), (_local2.height - 4), 5);
                _local4.graphics.endFill();
                _local2.addChild(_local4);
                _local2.graphics.beginFill(0xFF00, 0.5);
                _local2.graphics.drawRoundRect(0, 0, _local2.width, _local2.height, 5);
                _local2.graphics.endFill();
                _local2.alpha = 0.5;
                addChild(_local2);
            } else {
                _local3 = new CellRenderer_upSkin();
                _local3.width = this.itemw;
                _local2.addChild(_local3);
                _local2.alpha = 0.5;
                addChild(_local2);
            };
            this.rank.y = ((_local2.height / 2) - (this.rank.height / 2));
            this.nameL.y = ((_local2.height / 2) - (this.nameL.height / 2));
            this.rank.x = 4;
            this.nameL.x = (this.rank.x + this.rank.width);
            addChild(this.rank);
            addChild(this.nameL);
            addChild(this.killsL);
            addChild(this.destructsL);
            addChild(this.upL);
            addChild(this.rewardL);
        }

    }
}//package mishin870.gui.Battle.DMTab 
