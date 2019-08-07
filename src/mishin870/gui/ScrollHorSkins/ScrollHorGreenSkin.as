package mishin870.gui.ScrollHorSkins {

    public class ScrollHorGreenSkin extends ScrollHorSkin {

        [Embed(source="ScrollHorGreenSkin/cc.png")] private var cc:Class;
        [Embed(source="ScrollHorGreenSkin/scc.png")] private var scc:Class;
        [Embed(source="ScrollHorGreenSkin/slc.png")] private var slc:Class;
        [Embed(source="ScrollHorGreenSkin/lc.png")] private var lc:Class;

        public function ScrollHorGreenSkin(){
            this.c = new cc();
            this.l = new lc();
            this.sc = new scc();
            this.sl = new slc();
        }
    }
}//package mishin870.gui.ScrollHorSkins 
