package mishin870.gui.Battle.DMTab {
	import controls.Label;
    import flash.display.*;
    import __AS3__.vec.*;
    import controls.*;
    import assets.cellrenderer.battlelist.*;

    public class TABBattleInfoItemsDM extends Sprite {

        private static const UPPANEL_FONT_COLOR:uint = 1008393;

        private var itemw:int;
        private var itemh:int;
        private var off:int;
        private var items:Vector.<TABBattleInfoItemDM>;
        private var upPanel:CellRenderer_selectedUpSkin;
        private var upPanelName:Label;
        private var upPanelKills:Label;
        private var upPanelDestructs:Label;
        private var upPanelUP:Label;
        private var upPanelRewards:Label;

        public function TABBattleInfoItemsDM(_arg1:int, _arg2:int, _arg3:int){
            this.items = new Vector.<TABBattleInfoItemDM>();
            this.upPanel = new CellRenderer_selectedUpSkin();
            super();
            this.itemw = _arg1;
            this.itemh = _arg2;
            this.off = _arg3;
            this.resizeOverlay((_arg1 + (_arg3 * 2)), (_arg2 + (_arg3 * 2)));
            this.upPanel.x = _arg3;
            this.upPanel.y = _arg3;
            this.upPanel.width = _arg1;
            addChild(this.upPanel);
            this.upPanelName = new Label();
            this.upPanelKills = new Label();
            this.upPanelDestructs = new Label();
            this.upPanelUP = new Label();
            this.upPanelRewards = new Label();
            this.setupUpPanelLabel(this.upPanelName, "Позывной");
            this.setupUpPanelLabel(this.upPanelKills, "Уничтожено");
            this.setupUpPanelLabel(this.upPanelDestructs, "Подбит");
            this.setupUpPanelLabel(this.upPanelUP, "У/П");
            this.setupUpPanelLabel(this.upPanelRewards, "Приз");
            this.upPanelRewards.visible = false;
            this.upPanelName.x = 12;
            this.upPanelKills.x = 162;
            this.upPanelDestructs.x = 262;
            this.upPanelUP.x = ((_arg1 - this.upPanelUP.width) - 20);
        }
        public function clearScores():void{
            var _local1:TABBattleInfoItemDM;
            for each (_local1 in this.items) {
                _local1.kills = 0;
                _local1.destructs = 0;
                _local1.calculateUp();
            };
        }
        public function select(_arg1:int):void{
            var _local2:int;
            while (_local2 < this.items.length) {
                this.items[_local2].setState((_local2 == _arg1));
                _local2++;
            };
        }
        public function getByName(_arg1:String):TABBattleInfoItemDM{
            var _local2:TABBattleInfoItemDM;
            for each (_local2 in this.items) {
                if (_local2.pname == _arg1){
                    return (_local2);
                };
            };
            return (null);
        }
        public function getByNum(_arg1:int):TABBattleInfoItemDM{
            if ((((_arg1 >= 0)) && ((_arg1 < this.items.length)))){
                return (this.items[_arg1]);
            };
            return (null);
        }
        public function showRewards():void{
            var _local1:TABBattleInfoItemDM;
            this.upPanelName.x = 12;
            this.upPanelKills.x = (142 - this.upPanelRewards.width);
            this.upPanelDestructs.x = (242 - this.upPanelRewards.width);
            this.upPanelUP.x = (((this.itemw - this.upPanelUP.width) - 40) - this.upPanelRewards.width);
            this.upPanelRewards.x = ((this.itemw - this.upPanelRewards.width) - 20);
            this.upPanelRewards.visible = true;
            for each (_local1 in this.items) {
                _local1.showReward(((this.upPanelKills.x + this.upPanelKills.width) - 5), ((this.upPanelDestructs.x + this.upPanelDestructs.width) - 5), (this.upPanelUP.x + (this.upPanelUP.width / 2)), (this.upPanelRewards.x + this.upPanelRewards.width));
            };
        }
        public function hideRewards():void{
            var _local1:TABBattleInfoItemDM;
            this.upPanelName.x = 12;
            this.upPanelKills.x = 162;
            this.upPanelDestructs.x = 262;
            this.upPanelUP.x = ((this.itemw - this.upPanelUP.width) - 20);
            this.upPanelRewards.visible = false;
            for each (_local1 in this.items) {
                _local1.hideReward(((this.upPanelKills.x + this.upPanelKills.width) - 5), ((this.upPanelDestructs.x + this.upPanelDestructs.width) - 5), (this.upPanelUP.x + (this.upPanelUP.width / 2)));
            };
        }
        public function addItem(_arg1:int, _arg2:int, _arg3:String):void{
            var _local4:TABBattleInfoItemDM = new TABBattleInfoItemDM(_arg1, this.itemw, _arg2, _arg3, ((this.upPanelKills.x + this.upPanelKills.width) - 5), ((this.upPanelDestructs.x + this.upPanelDestructs.width) - 5), (this.upPanelUP.x + (this.upPanelUP.width / 2)));
            if (this.items.length <= 0){
                _local4.y = (this.itemh + this.off);
            } else {
                _local4.y = (this.items[(this.items.length - 1)].y + this.itemh);
            };
            addChild(_local4);
            this.items.push(_local4);
            _local4.x = this.off;
            this.resizeOverlay((this.itemw + (this.off * 2)), (((this.itemh * (this.items.length + 1)) + (this.off * 2)) - 2));
        }
        public function getById(_arg1:int):TABBattleInfoItemDM{
            var _local2:TABBattleInfoItemDM;
            for each (_local2 in this.items) {
                if (_local2.id == _arg1){
                    return (_local2);
                };
            };
            return (null);
        }
        public function getNumById(_arg1:int):int{
            var _local2:int;
            while (_local2 < this.items.length) {
                if (this.items[_local2].id == _arg1){
                    return (_local2);
                };
                _local2++;
            };
            return (-1);
        }
        public function removeById(_arg1:int):void{
            var _local2:int = this.getNumById(_arg1);
            if (_local2 == -1){
                return;
            };
            this.removeItem(_local2);
        }
        public function removeByName(_arg1:String):void{
            var _local2:int;
            while (_local2 < this.items.length) {
                if (this.items[_local2].pname == _arg1){
                    this.removeItem(_local2);
                };
                _local2++;
            };
        }
        public function removeItem(_arg1:int):void{
            if ((((_arg1 < 0)) || ((_arg1 >= this.items.length)))){
                return;
            };
            var _local2:TABBattleInfoItemDM = this.items[_arg1];
            this.items.splice(_arg1, 1);
            removeChild(_local2);
            _local2 = null;
            var _local3:int;
            while (_local3 < this.items.length) {
                _local2 = this.items[_local3];
                if (_local3 == 0){
                    _local2.y = (this.itemh + this.off);
                } else {
                    _local2.y = (this.items[(_local3 - 1)].y + this.itemh);
                };
                _local3++;
            };
            this.resizeOverlay((this.itemw + (this.off * 2)), (((this.itemh * (this.items.length + 1)) + (this.off * 2)) - 2));
        }
        private function setupUpPanelLabel(_arg1:Label, _arg2:String):void{
            _arg1.textColor = UPPANEL_FONT_COLOR;
            _arg1.text = _arg2;
            _arg1.y = ((this.upPanel.height / 2) - (_arg1.height / 2));
            this.upPanel.addChild(_arg1);
        }
        private function clearFor(_arg1:TABBattleInfoItemDM):void{
            graphics.drawRoundRect(_arg1.x, _arg1.y, _arg1.width, (_arg1.height - 2), 5);
        }
        private function resizeOverlay(_arg1:int, _arg2:int):void{
            var _local3:TABBattleInfoItemDM;
            graphics.clear();
            graphics.beginFill(0, 0.5);
            graphics.drawRoundRect(0, 0, _arg1, _arg2, 15);
            for each (_local3 in this.items) {
                this.clearFor(_local3);
            };
            graphics.endFill();
        }

    }
}//package mishin870.gui.Battle.DMTab 
