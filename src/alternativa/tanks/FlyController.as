package alternativa.tanks
{
	import away3d.cameras.Camera3D;
	import away3d.containers.View3D;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	public class FlyController 
	{
		
		private var stuga:Stage;
		private var camera:Camera3D;
		private var _move:Boolean = false;
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastMouseX:Number;
		private var _lastMouseY:Number;
		private var move:int = 50;
		
		public function FlyController(cam:View3D) 
		{
			stuga = cam.stage;
			camera = cam.camera;
			Main.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			Main.instance.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.instance.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			Main.instance.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		public function update():void
		{
			if (_move) {
				camera.rotationY = 0.3 * (Main.instance.stage.mouseX - _lastMouseX) + _lastPanAngle;
				camera.rotationX = 0.3 * (Main.instance.stage.mouseY - _lastMouseY) + _lastTiltAngle;
			}
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			_lastPanAngle = camera.rotationY;
			_lastTiltAngle = camera.rotationX;
			_lastMouseX = Main.instance.stage.mouseX;
			_lastMouseY = Main.instance.stage.mouseY;
			_move = true;
			Main.instance.stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			_move = false;
			Main.instance.stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function onStageMouseLeave(event:Event):void
		{
			_move = false;
			Main.instance.stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function keyDownHandler(event : KeyboardEvent) : void {
			switch(event.keyCode) {
				case Keyboard.UP:
					camera.moveForward(move);
					break;
				case Keyboard.DOWN:
					camera.moveBackward(move);
					break;
				case Keyboard.LEFT:
					camera.moveLeft(move);
					break;
				case Keyboard.RIGHT:
					camera.moveRight(move);
					break;
				case Keyboard.U:
					camera.moveForward(move);
					break;
				case Keyboard.J:
					camera.moveBackward(move);
					break;
				case Keyboard.H:
					camera.moveLeft(move);
					break;
				case Keyboard.K:
					camera.moveRight(move);
					break;
				case Keyboard.Q:
					camera.moveUp(move);
					break;
				case Keyboard.SHIFT:
					move = 200;
					break;
				case Keyboard.E:
					camera.moveDown(move);
			}
		}
		
		private function keyUpHandler(event : KeyboardEvent) : void {
			switch(event.keyCode) {
				case Keyboard.SHIFT:
					move = 50;
			}
		}
		
	}

}