package mishin870.gui.Battle.Glass {
    import flash.display.*;

    public class GUIIco extends Sprite {

        [Embed(source="GUIIco/balanceClass.png")] private var balanceClass:Class;
        [Embed(source="GUIIco/moneyClass.png")] private var moneyClass:Class;
        [Embed(source="GUIIco/paraClass.png")] private var paraClass:Class;
        [Embed(source="GUIIco/scoreClass.png")] private var scoreClass:Class;
        [Embed(source="GUIIco/timerClass.png")] private var timerClass:Class;
        public static const BALANCE:int = 0;
        public static const MONEY:int = 1;
        public static const PARA:int = 2;
        public static const SCORE:int = 3;
        public static const TIMER:int = 4;

        public function GUIIco(_arg1:int=0){
            this.addIcon(_arg1);
        }
        public function setIcon(_arg1:int):void{
            try {
                while (true) {
                    removeChildAt(0);
                };
            } catch(e:Error) {
            };
            this.addIcon(_arg1);
        }
        private function addIcon(_arg1:int):void{
            if (_arg1 == BALANCE){
                addChild(new balanceClass());
            };
            if (_arg1 == MONEY){
                addChild(new moneyClass());
            };
            if (_arg1 == PARA){
                addChild(new paraClass());
            };
            if (_arg1 == SCORE){
                addChild(new scoreClass());
            };
            if (_arg1 == TIMER){
                addChild(new timerClass());
            };
        }

    }
}//package mishin870.gui.Battle.Glass 
