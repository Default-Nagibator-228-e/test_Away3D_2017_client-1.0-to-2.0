package mishin870.gui.Garage {
    import flash.events.*;
    import flash.display.*;
    import flash.net.*;

    public class TankSkin {

        private var part:TankPart;
        private var loader:Loader;
        private var colormap:BitmapData;
        private var turretUrl:String;
        private var hullUrl:String;
        private var colormapUrl:String;

        public function loadTank(_arg1:String, _arg2:String, _arg3:String):void{
            if (((!((this.part == null))) || (!((this.loader == null))))){
                return;
            };
            this.turretUrl = _arg2;
            this.hullUrl = _arg1;
            this.colormapUrl = _arg3;
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.colormapCom);
            this.loader.load(new URLRequest(_arg3));
        }
        private function colormapCom(_arg1:Event):void{
            var _local2:Bitmap = (this.loader.content as Bitmap);
            this.colormap = _local2.bitmapData;
            this.loader = null;
            this.part = new TankPart(this.turretUrl);
            this.part.addEventListener(Event.COMPLETE, this.turretCom);
            this.part.load();
        }
        private function updatePartTexture(_arg1:TankPart, _arg3:BitmapData):void{
            var _local4:Shape = new Shape();
            _local4.graphics.beginBitmapFill(_arg3);
            _local4.graphics.drawRect(0, 0, _arg1.lightmap.width, _arg1.lightmap.height);
            var _local5:BitmapData = new BitmapData(_arg1.lightmap.width, _arg1.lightmap.height, false, 0);
            _local5.draw(_local4);
            _local5.draw(_arg1.lightmap, null, null, BlendMode.HARDLIGHT);
            _local5.draw(_arg1.details);
            _arg2.setMaterialToAllFaces(new TextureMaterial(_local5));
        }
        private function turretCom(_arg1:Event):void{
            this.turret = this.part.model;
            this.updatePartTexture(this.part, this.turret, this.colormap);
            this.part.removeEventListener(Event.COMPLETE, this.turretCom);
            this.part = new TankPart(this.hullUrl);
            this.part.addEventListener(Event.COMPLETE, this.hullCom);
            this.part.load();
        }
        private function hullCom(_arg1:Event):void{
            this.hull = this.part.model;
            this.updatePartTexture(this.part, this.hull, this.colormap);
            this.part.removeEventListener(Event.COMPLETE, this.hullCom);
            try {
                while (true) {
                    removeChildAt(0);
                };
            } catch(e:Error) {
            };
            addChild(this.hull);
            addChild(this.turret);
            this.hull.calculateBounds();
            this.turret.calculateBounds();
            this.hull.sorting = Sorting.DYNAMIC_BSP;
            this.turret.sorting = Sorting.DYNAMIC_BSP;
            this.hull.x = 0;
            this.hull.y = 0;
            this.hull.z = 0;
            this.turret.x = this.part.turretPos.x;
            this.turret.y = this.part.turretPos.y;
            this.turret.z = this.part.turretPos.z;
            this.part = null;
            dispatchEvent(new Event(Event.COMPLETE));
        }

    }
}//package mishin870.gui.Garage 
