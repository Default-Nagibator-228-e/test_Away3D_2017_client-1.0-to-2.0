package mishin870.gui {
    import flash.events.*;
    import flash.display.*;

    public class UpPanelButtonClose extends Sprite {
        [Embed(source="UpPanelButton/closen.png")] private static const nClass:Class;
        [Embed(source="UpPanelButton/closed.png")] private static const dClass:Class;
        private var n:Bitmap = new nClass();
        private var d:Bitmap = new dClass();
        private var skin:Boolean = false;

        public function UpPanelButtonClose() {
            setSkin(false);
            addEventListener(MouseEvent.MOUSE_UP, mu);
            addEventListener(MouseEvent.MOUSE_DOWN, md);
            addEventListener(MouseEvent.MOUSE_OUT, mu);
        }

        private function mu(event:MouseEvent):void {
            setSkin(false);
        }

		private function md(event:MouseEvent):void {
			setSkin(true);
        }

        private function setSkin(down:Boolean):void {
            skin = down;
            removeAl();
            if (skin) {
                addChild(d);
            } else {
                addChild(n);
            }
        }

        private function removeAl():void {
			try {
				while (true) {
					removeChildAt(0);
				}
			} catch (e:Error){}
		}
	}
}