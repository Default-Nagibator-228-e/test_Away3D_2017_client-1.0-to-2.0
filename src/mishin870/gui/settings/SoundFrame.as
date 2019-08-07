package mishin870.gui.settings {
	import controls.Label;
	import controls.TankCheckBox;
	import controls.TankWindowInner;
    import flash.display.*;
    import controls.*;

    public class SoundFrame extends TankWindowInner {

        [Embed(source="SoundFrame/ss.png")] private var ssClass:Class
        private var ss:Bitmap = new ssClass();
        private var ssL:Label = new Label();
        private var bc:TankCheckBox = new TankCheckBox();

        public function SoundFrame(){
            super(Settings.FRAME_WIDTH, 46);
            this.ssL.text = "Громкость:";
            this.ssL.x = 30;
            this.ssL.y = 14;
            addChild(this.ssL);
            this.ss.x = 97;
            this.ss.y = 8;
            addChild(this.ss);
            this.bc.y = this.ss.y;
            this.bc.x = ((this.ss.x + this.ss.width) + 8);
            this.bc.label = "Фоновый звук";
            addChild(this.bc);
        }
    }
}