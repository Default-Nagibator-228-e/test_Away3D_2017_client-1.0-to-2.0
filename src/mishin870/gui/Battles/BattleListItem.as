package mishin870.gui.Battles {
	import controls.Label;
    import flash.events.*;
    import flash.display.*;
    import controls.*;
    import flash.text.*;
    import assets.cellrenderer.battlelist.*;
	import mishin870.gui.BattleInfo.BattleInfo;

    public class BattleListItem extends Sprite {

        private var us:CellRenderer_upSkin;
        private var ds:CellRenderer_downSkin;
        private var sds:CellRenderer_selectedDownSkin;
        private var sus:CellRenderer_selectedUpSkin;
        private var dds:CellRenderer_disabledDownSkin;
        private var dus:CellRenderer_disabledUpSkin;
        private var dsds:CellRenderer_disabledSelectedDownSkin;
        private var dsus:CellRenderer_disabledSelectedUpSkin;
        public var enab:Boolean = true;
        public var sel:Boolean = false;
        private var callBack:Function;
        public var lname:Label;
        private var lmap:Label;
        private var bpi:BattlePlayersInfo;
		private static var bi:BattleInfo;
        public var id:int;
        public var mapXml:String;
        public var MAX_PLAYERS:int;
        public var type:int;
        public var minRank:int;
        public var maxRank:int;
        public var dest:int;
		public var time:int;

        public function BattleListItem(_arg1:int, _arg2:Number, _arg3:String, _arg4:String, _arg5:String, _arg6:int, _arg7:int, _arg8:int, _arg9:Function, _arg10:int, _arg11:int){
            this.us = new CellRenderer_upSkin();
            this.ds = new CellRenderer_downSkin();
            this.sds = new CellRenderer_selectedDownSkin();
            this.sus = new CellRenderer_selectedUpSkin();
            this.dds = new CellRenderer_disabledDownSkin();
            this.dus = new CellRenderer_disabledUpSkin();
            this.dsds = new CellRenderer_disabledSelectedDownSkin();
            this.dsus = new CellRenderer_disabledSelectedUpSkin();
            this.lname = new Label();
            this.lmap = new Label();
            this.bpi = new BattlePlayersInfo();
            super();
            this.dest = _arg10;
			this.time = _arg11;
            this.callBack = _arg9;
            this.minRank = _arg7;
            this.maxRank = _arg8;
            this.mapXml = _arg5;
            this.MAX_PLAYERS = _arg6;
            this.id = _arg1;
            this.lname.selectable = false;
            this.lmap.selectable = false;
			
			

			
            this.us.width = _arg2;
            addChild(this.us);
            this.ds.width = _arg2;
            this.sds.width = _arg2;
            this.sus.width = _arg2;
            this.dsds.width = _arg2;
            this.dsus.width = _arg2;
            this.dds.width = _arg2;
            this.dus.width = _arg2;
            this.lname.autoSize = TextFieldAutoSize.LEFT;
            this.lname.text = _arg3;
            this.lname.x = 16;
            this.lname.y = 0;
            this.lname.width = 100;
            this.lname.size = 30;
            this.lmap.autoSize = TextFieldAutoSize.RIGHT;
            this.lmap.text = _arg4;
            this.lmap.x = ((_arg2 - this.lmap.width) - 5);
            this.lmap.y = 0;
            addChild(this.lname);
            addChild(this.lmap);
            this.bpi.x = (_arg2 * 0.5);
            this.bpi.y = 2;
            addChild(this.bpi);
            addEventListener(MouseEvent.MOUSE_UP, this.mu);
            addEventListener(MouseEvent.MOUSE_DOWN, this.md);
        }
        public function resize(_arg1:Number):void{
            this.us.width = _arg1;
            this.lmap.x = ((_arg1 - this.lmap.width) - 5);
            this.bpi.x = (_arg1 * 0.5);
            this.ds.width = _arg1;
            this.sds.width = _arg1;
            this.sus.width = _arg1;
            this.dsds.width = _arg1;
            this.dsus.width = _arg1;
            this.dds.width = _arg1;
            this.dus.width = _arg1;
			
			this.us.height = 100;
			this.ds.height = 100;
			this.sds.height = 100;
			this.sus.height = 100;
			this.dds.height = 100;
			this.dus.height = 100;
			this.dsds.height = 100;
			this.dsus.height = 100;
			
			
        }
        public function setState(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number=0, _arg5:Number=1):void{
            this.bpi.type = _arg1;
            if (_arg1 == 0){
                this.bpi.g = _arg2;
                this.bpi.gMax = _arg3;
            } else {
                this.bpi.r = _arg2;
                this.bpi.rMax = _arg3;
                this.bpi.b = _arg4;
                this.bpi.bMax = _arg5;
            };
            this.bpi.update(bi);
        }
		public function setbi(_arg1:BattleInfo):void{
            bi = _arg1;
        }
        private function removeAl():void{
            this.removeC(this.us);
            this.removeC(this.ds);
            this.removeC(this.sds);
            this.removeC(this.sus);
            this.removeC(this.dds);
            this.removeC(this.dus);
            this.removeC(this.dsds);
            this.removeC(this.dsus);
        }
        private function removeC(_arg1:DisplayObject):void{
            try {
                removeChild(_arg1);
            } catch(e:Error) {
            };
        }
        private function mu(_arg1:MouseEvent):void{
            this.callBack.call(null, this);
            this.removeAl();
            if (this.enab){
                if (this.sel){
                    addChildAt(this.sus, 0);
                } else {
                    addChildAt(this.us, 0);
                };
            } else {
                if (this.sel){
                    addChildAt(this.dsus, 0);
                } else {
                    addChildAt(this.dus, 0);
                };
            };
            this.update_label();
        }
        public function mu2():void{
            this.removeAl();
            if (this.enab){
                if (this.sel){
                    addChildAt(this.sus, 0);
                } else {
                    addChildAt(this.us, 0);
                };
            } else {
                if (this.sel){
                    addChildAt(this.dsus, 0);
                } else {
                    addChildAt(this.dus, 0);
                };
            };
            this.update_label();
        }
        public function update_label():void{
            if (this.enab){
                if (this.sel){
                    this.lname.textColor = 860942;
                    this.lmap.textColor = 860942;
                } else {
                    this.lname.textColor = 5898033;
                    this.lmap.textColor = 5898033;
                };
            } else {
                if (this.sel){
                    this.lname.textColor = 0x636363;
                    this.lmap.textColor = 0x636363;
                } else {
                    this.lname.textColor = 0xB1B1B1;
                    this.lmap.textColor = 0xB1B1B1;
                };
            };
        }
        private function md(_arg1:MouseEvent):void{
            this.removeAl();
            if (this.enab){
                if (this.sel){
                    addChildAt(this.sds, 0);
                } else {
                    addChildAt(this.ds, 0);
                };
            } else {
                if (this.sel){
                    addChildAt(this.dsds, 0);
                } else {
                    addChildAt(this.dds, 0);
                };
            };
            this.update_label();
        }

    }
}//package mishin870.gui.Battles 
