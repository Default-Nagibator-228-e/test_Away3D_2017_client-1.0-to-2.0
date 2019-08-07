package mishin870.gui.Battle {
    import flash.display.*;

    public class Glass extends Sprite {

        [Embed(source="Glass/lClass.png")] private var lClass:Class;
        [Embed(source="Glass/rClass.png")] private var rClass:Class;
        [Embed(source="Glass/cClass.png")] private var cClass:Class;

        private var l:Bitmap = new lClass();
        private var r:Bitmap = new rClass();
        private var c:Bitmap = new cClass();
        private var wid:int;

        public function Glass(){
            addChild(this.l);
            addChild(this.r);
            addChild(this.c);
            this.c.x = 5;
            this.setWid(100);
        }
        public function setWid(_arg1:int):void{
            this.wid = _arg1;
            this.r.x = (this.wid - 5);
            this.c.width = (this.wid - 10);
        }

    }
}//package mishin870.gui.Battle 
