package mishin870.gui.Battles {
	import controls.Label;
    import flash.display.*;
    import controls.*;
	import mishin870.gui.BattleInfo.BattleInfo;

    public class BattlePlayersInfo extends Sprite {

        [Embed(source = "PlayersInfo/gFree.png")] private static const gFree:Class;
	[Embed(source = "PlayersInfo/gFull.png")] private static const gFull:Class;
	[Embed(source = "PlayersInfo/bFree.png")] private static const bFree:Class;
	[Embed(source = "PlayersInfo/bFull.png")] private static const bFull:Class;
	[Embed(source = "PlayersInfo/rFree.png")] private static const rFree:Class;
	[Embed(source = "PlayersInfo/rFull.png")] private static const rFull:Class;
	private var gfr:Bitmap = new gFree();
	private var gfu:Bitmap = new gFull();
	private var rfr:Bitmap = new rFree();
	private var rfu:Bitmap = new rFull();
	private var bfr:Bitmap = new bFree();
	private var bfu:Bitmap = new bFull();
        public var type:Number = 0;
        public var g:Number = 0;
        public var r:Number = 0;
        public var b:Number = 0;
        public var gMax:Number = 1;
        public var rMax:Number = 1;
        public var bMax:Number = 1;
        private var lnum1:Label = new Label();
        private var lnum2:Label = new Label();

        public function BattlePlayersInfo(){
            super();
            this.lnum1.textColor = 0xFFFFFF;
            this.lnum2.textColor = 0xFFFFFF;
            this.lnum1.selectable = false;
            this.lnum2.selectable = false;
        }
        private function removeAl():void{
            try {
                while (true) {
                    removeChildAt(0);
                };
            } catch(e:Error) {
            };
        }
        public function update(_var:BattleInfo):void{
            this.removeAl();
            if (this.type == 0){
                if (this.g >= this.gMax){
                    addChild(this.gfu);
                    this.lnum1.textColor = 0x6C6C6C;
					_var.play1.enable = false;
                } else {
                    addChild(this.gfr);
                    this.lnum1.textColor = 0xFFFFFF;
                };
                addChild(this.lnum1);
                this.lnum1.text = this.g.toString();
                this.lnum1.y = ((this.gfr.height / 2) - (this.lnum1.height / 2));
                this.lnum1.x = ((this.gfr.width / 2) - (this.lnum1.width / 2));
            };
            if (this.type == 1){
                if (this.r >= this.rMax){
                    addChild(this.rfu);
                    this.lnum1.textColor = 0x6C6C6C;
					_var.play1.enable = false;
                } else {
                    addChild(this.rfr);
                    this.lnum1.textColor = 0xFFFFFF;
                };
                if (this.b >= this.bMax){
                    addChild(this.bfu);
                    this.bfu.x = (this.bfu.width + 1);
                    this.lnum2.textColor = 0x6C6C6C;
					_var.play2.enable = false;
                } else {
                    addChild(this.bfr);
                    this.bfr.x = (this.bfr.width + 1);
                    this.lnum2.textColor = 0xFFFFFF;
                };
                addChild(this.lnum1);
                addChild(this.lnum2);
                this.lnum1.text = this.r.toString();
                this.lnum2.text = this.b.toString();
                this.lnum1.y = ((this.rfr.height / 2) - (this.lnum1.height / 2));
                this.lnum1.x = ((this.rfr.width / 2) - (this.lnum1.width / 2));
                this.lnum2.y = ((this.rfr.height / 2) - (this.lnum2.height / 2));
                this.lnum2.x = (((this.rfr.width / 2) - (this.lnum2.width / 2)) + this.rfr.width);
            };
        }

    }
}//package mishin870.gui.Battles 
