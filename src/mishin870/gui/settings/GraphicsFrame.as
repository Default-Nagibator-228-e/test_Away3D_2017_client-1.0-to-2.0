package mishin870.gui.settings {
    import controls.*;
	import controls.TankCheckBox;
	import controls.TankWindowInner;

    public class GraphicsFrame extends TankWindowInner {

        private var fpsCh:TankCheckBox;
        private var chatCh:TankCheckBox;
        private var mipCh:TankCheckBox;
        private var adaptCh:TankCheckBox;
        private var skyCh:TankCheckBox;

        public function GraphicsFrame(){
            this.fpsCh = new TankCheckBox();
            this.chatCh = new TankCheckBox();
            this.mipCh = new TankCheckBox();
            this.adaptCh = new TankCheckBox();
            this.skyCh = new TankCheckBox();
            super(Settings.FRAME_WIDTH, 120);
            this.fpsCh.label = "Показывать FPS";
            this.fpsCh.x = 8;
            this.fpsCh.y = 8;
            this.fpsCh.checked = true;
            addChild(this.fpsCh);
            this.chatCh.label = "Показывать боевой чат";
            this.chatCh.x = 8;
            this.chatCh.y = (18 + this.fpsCh.height);
            this.chatCh.checked = true;
            addChild(this.chatCh);
            this.mipCh.label = "Мип-маппинг (лучше качество картинки, больше потребление памяти)";
            this.mipCh.x = 8;
            this.mipCh.y = ((this.chatCh.y + this.chatCh.height) + 10);
            this.mipCh.checked = false;
            addChild(this.mipCh);
            this.adaptCh.label = "Адаптивный FPS";
            this.adaptCh.y = 8;
            this.adaptCh.x = ((this.fpsCh.x + this.fpsCh.height) + 100);
            this.adaptCh.checked = false;
            addChild(this.adaptCh);
            this.skyCh.label = "Показывать небо";
            this.skyCh.y = 8;
            this.skyCh.x = ((this.adaptCh.x + this.adaptCh.height) + 100);
            this.skyCh.checked = true;
            addChild(this.skyCh);
        }
    }
}//package mishin870.gui.settings 
