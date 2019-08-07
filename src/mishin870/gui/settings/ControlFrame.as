package mishin870.gui.settings {
    import controls.*;
	import controls.TankCheckBox;
	import controls.TankWindowInner;

    public class ControlFrame extends TankWindowInner {

        private var inversCh:TankCheckBox;
        private var alterCh:TankCheckBox;

        public function ControlFrame(){
            this.inversCh = new TankCheckBox();
            this.alterCh = new TankCheckBox();
            super(Settings.FRAME_WIDTH, 81);
            this.inversCh.label = "Инверсное управление при движении назад";
            this.inversCh.x = 8;
            this.inversCh.y = 8;
            this.inversCh.checked = false;
            addChild(this.inversCh);
            this.alterCh.label = "Альтернативное поведение камеры";
            this.alterCh.x = 8;
            this.alterCh.y = ((this.inversCh.y + this.inversCh.height) + 10);
            this.alterCh.checked = false;
            addChild(this.alterCh);
        }
    }
}//package mishin870.gui.settings 
