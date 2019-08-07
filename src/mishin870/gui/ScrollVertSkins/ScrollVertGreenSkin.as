package mishin870.gui.ScrollVertSkins {

    public class ScrollVertGreenSkin extends ScrollVertSkin {

        [Embed(source="ScrollVertGreenSkin/cc.png")] private var cc:Class;
        [Embed(source="ScrollVertGreenSkin/scc.png")] private var scc:Class;
        [Embed(source="ScrollVertGreenSkin/suc.png")] private var suc:Class;
        [Embed(source="ScrollVertGreenSkin/uc.png")] private var uc:Class;

        public function ScrollVertGreenSkin(){
            this.c = new cc();
            this.u = new uc();
            this.sc = new scc();
            this.su = new suc();
        }
    }
}
