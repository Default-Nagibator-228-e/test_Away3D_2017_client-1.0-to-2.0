package mishin870.gui.Battle.DMTab {
    import flash.display.*;
    import alternativa.tanks.*;

    public class TABBattleInfoDM extends Sprite {

        private static const ITEMW:int = 384;
        private static const ITEMH:int = 20;
        private static const OFF:int = 7;
        private static const OFFSET_NAME_ITEMS:int = 5;

        private var bName:TABBattleInfoName;
        private var bItems:TABBattleInfoItemsDM;

        public function TABBattleInfoDM(){
            this.bName = new TABBattleInfoName((ITEMW + (OFF * 2)), 30);
            addChild(this.bName);
            this.bItems = new TABBattleInfoItemsDM(ITEMW, ITEMH, OFF);
            this.bItems.y = (this.bName.height + OFFSET_NAME_ITEMS);
            addChild(this.bItems);
        }
        public function addItem(_arg1:int, _arg2:int, _arg3:String):void{
            this.bItems.addItem(_arg1, _arg2, _arg3);
            Game.getInstance().res(null);
        }
        public function set label(_arg1:String):void{
            this.bName.label = _arg1;
        }
        public function get label():String{
            return (this.bName.label);
        }
        public function select(_arg1:int):void{
            this.bItems.select(_arg1);
        }
        public function getByName(_arg1:String):TABBattleInfoItemDM{
            return (this.bItems.getByName(_arg1));
        }
        public function getByNum(_arg1:int):TABBattleInfoItemDM{
            return (this.bItems.getByNum(_arg1));
        }
        public function removeItem(_arg1:int):void{
            this.bItems.removeItem(_arg1);
        }
        public function getById(_arg1:int):TABBattleInfoItemDM{
            return (this.bItems.getById(_arg1));
        }
        public function removeById(_arg1:int):void{
            this.bItems.removeById(_arg1);
        }
        public function removeByName(_arg1:String):void{
            this.bItems.removeByName(_arg1);
        }
        public function getNumById(_arg1:int):int{
            return (this.bItems.getNumById(_arg1));
        }
        public function showRewards():void{
            this.bItems.showRewards();
        }
        public function hideRewards():void{
            this.bItems.hideRewards();
        }
        public function clearScores():void{
            this.bItems.clearScores();
        }

    }
}//package mishin870.gui.Battle.DMTab 
