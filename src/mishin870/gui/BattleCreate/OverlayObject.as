package mishin870.gui.BattleCreate {
    import flash.display.*;

    public class OverlayObject extends Sprite {

        public function OverlayObject(_arg1:DisplayObject){
            addChild(_arg1);
            var _local2:Sprite = new Sprite();
            _local2.graphics.beginFill(0, 0.4);
            _local2.graphics.drawRect(0, 0, _arg1.width, _arg1.height);
            _local2.graphics.endFill();
            addChild(_local2);
        }
    }
}//package mishin870.gui.BattleCreate 
