package mishin870.gui.settings {
    import controls.*;
	import controls.DefaultButton;
	import controls.TankWindowInner;

    public class AccountFrame extends TankWindowInner {

        private var chBut:DefaultButton;

        public function AccountFrame(){
            this.chBut = new DefaultButton();
            super(Settings.FRAME_WIDTH, 65);
            this.chBut.label = "Изменить пароль и e-mail";
            this.chBut.width = 210;
            this.chBut.y = int(((height / 2) - (this.chBut.height / 2)));
            this.chBut.x = int(((width / 2) - (this.chBut.width / 2)));
            addChild(this.chBut);
        }
    }
}//package mishin870.gui.settings 
