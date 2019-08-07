package mishin870.gui.Chat {
    import flash.events.*;
    import flash.display.Sprite;
    import controls.Label;
    import flash.text.*;
    import flash.filters.*;
	import flash.display.DisplayObject

    public class ChatItem extends Sprite {

        private var tftext:Label;
        private var tfname:Label;
        private var tfname2:Label;
        public var id:String;
        public var type:Number;
        public var msg:String;
        public var n:String;

        public function ChatItem(_arg1:Number, _arg2:String, _arg3:Number, _arg4:String, _arg5:DisplayObject=null, _arg6:String="", _arg7:DisplayObject=null, _arg8:String=""){
            var max_width:* = _arg1;
            var id:* = _arg2;
            var type:* = _arg3;
            var msg:* = _arg4;
            var rank:* = _arg5;
            var name_player:String = _arg6;
            var rank2:* = _arg7;
            var name_player2:String = _arg8;
            this.tftext = new Label();
            this.tfname = new Label();
            this.tfname2 = new Label();
            super();
            this.id = id;
            this.type = type;
            this.msg = msg;
            this.n = name_player;
            if (type == 0){
                this.tftext.textColor = 0xFFFFFF;
                this.tfname.textColor = 0xF600;
                this.tftext.autoSize = TextFieldAutoSize.CENTER;
                this.tftext.wordWrap = true;
                this.tfname.autoSize = TextFieldAutoSize.LEFT;
                this.tfname.text = (name_player + ":");
                addChild(rank);
                this.tfname.filters = [new GlowFilter(0, 0.8, 4, 4, 5)];
                this.tftext.filters = [new GlowFilter(0, 0.8, 4, 4, 5)];
                rank.filters = [new GlowFilter(0, 0.8, 4, 4, 5)];
                this.tfname.x = rank.width;
                this.tfname.y = -2;
                addChild(this.tfname);
                this.tftext.x = (this.tfname.x + this.tfname.width);
                this.tftext.y = -2;
                this.tftext.width = (max_width - this.tftext.x);
                addChild(this.tftext);
                this.tftext.selectable = false;
                this.tfname.selectable = false;
                this.tftext.htmlText = msg;
                rank.y = ((this.tfname.y + (this.tfname.height / 2)) - (rank.height / 2));
            };
            if (type == 1){
                this.tfname.textColor = 8321918;
                this.tfname.filters = [new GlowFilter(0, 0.8, 4, 4, 3)];
                this.tfname.autoSize = TextFieldAutoSize.LEFT;
                this.tfname.wordWrap = true;
                this.tfname.htmlText = msg;
                this.tfname.width = max_width;
                this.tfname.selectable = false;
                addChild(this.tfname);
                this.tfname.y = -2;
            };
            if (type == 2){
                this.tftext.textColor = 0xFFFFFF;
                this.tfname.textColor = 0xF600;
                this.tfname2.textColor = 0xF600;
                this.tftext.autoSize = TextFieldAutoSize.CENTER;
                this.tftext.wordWrap = true;
                this.tfname.autoSize = TextFieldAutoSize.LEFT;
                this.tfname2.autoSize = TextFieldAutoSize.LEFT;
                this.tftext.htmlText = msg;
                this.tfname.text = (name_player + " → ");
                this.tfname2.text = (name_player2 + ":");
                addChild(rank);
                addChild(rank2);
                this.tfname.filters = [new GlowFilter(0, 0.8, 4, 4, 3)];
                this.tfname2.filters = [new GlowFilter(0, 0.8, 4, 4, 3)];
                this.tftext.filters = [new GlowFilter(0, 0.8, 4, 4, 3)];
                this.tfname.x = (rank.width - 1);
                this.tfname.y = -2;
                rank2.x = (this.tfname.x + this.tfname.width);
                this.tfname2.x = ((rank2.x + rank2.width) - 1);
                this.tfname2.y = -2;
                addChild(this.tfname);
                addChild(this.tfname2);
                this.tftext.x = (this.tfname2.x + this.tfname2.width);
                this.tftext.y = -2;
                this.tftext.width = (max_width - this.tftext.x);
                addChild(this.tftext);
                this.tftext.selectable = false;
                this.tfname.selectable = false;
                this.tfname2.selectable = false;
            };
            if (type == 3){
                this.tftext.textColor = 0xFAFAFA;
                this.tfname.textColor = 0xF600;
                this.tftext.autoSize = TextFieldAutoSize.LEFT;
                this.tfname.autoSize = TextFieldAutoSize.LEFT;
                this.tfname.text = name_player;
                this.tftext.text = msg;
                addChild(rank);
                this.tfname.filters = [new GlowFilter(0, 0.5, 4, 4, 3)];
                this.tftext.filters = [new GlowFilter(0, 0.5, 4, 4, 3)];
                rank.filters = [new GlowFilter(0, 0.8, 4, 4, 3)];
                this.tfname.y = -2;
                addChild(this.tfname);
                this.tftext.x = -(this.tftext.width);
                this.tfname.x = ((this.tftext.x - this.tfname.width) - 3);
                rank.x = (this.tfname.x - rank.width);
                this.tftext.y = -2;
                addChild(this.tftext);
                this.tftext.selectable = false;
                this.tfname.selectable = false;
                rank.y = ((this.tfname.y + (this.tfname.height / 2)) - (rank.height / 2));
            };
            if (type == 4){
                this.tftext.textColor = 0xFAFAFA;
                this.tfname.textColor = 0xF600;
                this.tfname2.textColor = 0xF600;
                this.tftext.autoSize = TextFieldAutoSize.LEFT;
                this.tfname.autoSize = TextFieldAutoSize.LEFT;
                this.tfname2.autoSize = TextFieldAutoSize.LEFT;
                this.tfname.text = name_player;
                this.tfname2.text = name_player2;
                this.tftext.text = msg;
                addChild(rank);
                addChild(rank2);
                this.tfname.filters = [new GlowFilter(0, 0.5, 4, 4, 3)];
                this.tfname2.filters = [new GlowFilter(0, 0.5, 4, 4, 3)];
                this.tftext.filters = [new GlowFilter(0, 0.5, 4, 4, 3)];
                rank.filters = [new GlowFilter(0, 0.8, 4, 4, 3)];
                rank2.filters = [new GlowFilter(0, 0.8, 4, 4, 3)];
                this.tfname.y = -2;
                this.tfname2.y = -2;
                addChild(this.tfname);
                addChild(this.tfname2);
                this.tfname2.x = -(this.tfname2.width);
                rank2.x = (this.tfname2.x - rank2.width);
                this.tftext.x = ((rank2.x - this.tftext.width) - 3);
                this.tfname.x = ((this.tftext.x - this.tfname.width) - 3);
                rank.x = (this.tfname.x - rank.width);
                this.tftext.y = -2;
                addChild(this.tftext);
                this.tftext.selectable = false;
                this.tfname.selectable = false;
                this.tfname2.selectable = false;
                rank.y = ((this.tfname.y + (this.tfname.height / 2)) - (rank.height / 2));
                rank2.y = ((this.tfname.y + (this.tfname.height / 2)) - (rank.height / 2));
            };
            if (((!((type == 3))) && (!((type == 4))))){
                this.tftext.addEventListener(TextEvent.LINK, function (_arg1:TextEvent):void{
                    var _local2:int = parseInt(_arg1.text.substr(1));
                    if (isNaN(_local2)){
                        return;
                    };
                    Main.instance.lobby.battles.battleItems.sel(_local2);
                    Main.instance.selectBattle(Main.instance.lobby.battles.battleItems.getBattle(_local2));
                });
            };
        }
        public function refresh(_arg1:Number):void{
            if (this.type == 1){
                this.tfname.htmlText = this.msg;
                this.tfname.width = _arg1;
            };
            if (this.type == 0){
                this.tftext.htmlText = this.msg;
                this.tftext.width = (_arg1 - this.tftext.x);
            };
            if (this.type == 2){
                this.tftext.htmlText = this.msg;
                this.tftext.width = (_arg1 - this.tftext.x);
            };
        }

    }
}//package mishin870.gui.Chat 
