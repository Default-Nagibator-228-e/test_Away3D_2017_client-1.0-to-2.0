package gui 
{
	import controls.*;
	import fl.controls.listClasses.ImageCell;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.events.TextEvent;
	import mishin870.net.SocketClass;
	
	/**
	 * @author LockOn
	 */
	public class Registration extends Sprite
	{
		
		private var _stage:Stage;
		private var b:TankWindow = new TankWindow(380, 288);
		private var c:TankWindow = new TankWindow(360, 65);
		private var f:Label = new Label();
		private var g:Label = new Label();
		private var h:TankInput = new TankInput();
		private var i:TankInput = new TankInput();
		private var j:TankInput = new TankInput();
		private var k:TankCheckBox = new TankCheckBox();
		private var l:ColorButton = new ColorButton();
		private var m:Label = new Label();
		public var check:Boolean = true;
		private var al:Alert;
		
		public function Registration(a:Stage):void
		{
			_stage = a;
			_stage.addEventListener(Event.RESIZE, draw);
			h.y = 60;
			h.x = 75;
			h.width = 280;
			h.label = "Имя:";
			h.restrict = ".0-9a-zA-z_\\-";
			h.addEventListener(MouseEvent.ROLL_OVER, function(e:Event):void {
				Mouse.cursor = MouseCursor.IBEAM;
			});
			h.addEventListener(MouseEvent.ROLL_OUT, function(e:Event):void {
				Mouse.cursor = MouseCursor.ARROW;
			});
			
			i.y = h.y + 40;
			i.x = h.x;
			i.width = 280;
			i.label = "Пароль:";
			i.hidden = true;
			i.addEventListener(MouseEvent.ROLL_OVER, function(e:Event):void {
				Mouse.cursor = MouseCursor.IBEAM;
			});
			i.addEventListener(MouseEvent.ROLL_OUT, function(e:Event):void {
				Mouse.cursor = MouseCursor.ARROW;
			});
			j.y = i.y + 40;
			j.x = h.x;
			j.width = 280;
			j.label = "Повтор:";
			j.hidden = true;
			j.addEventListener(MouseEvent.ROLL_OVER, function(e:Event):void {
				Mouse.cursor = MouseCursor.IBEAM;
			});
			j.addEventListener(MouseEvent.ROLL_OUT, function(e:Event):void {
				Mouse.cursor = MouseCursor.ARROW;
			});
			
			f.y = 24;
			f.x = 24;
			
			k.x = h.x;
			k.y = j.y + 50;
			k.label = "Запомнить";
			k.addEventListener(MouseEvent.ROLL_OVER, function(e:Event):void {
				Mouse.cursor = MouseCursor.BUTTON;
			});
			k.addEventListener(MouseEvent.ROLL_OUT, function(e:Event):void {
				Mouse.cursor = MouseCursor.ARROW;
			});
			
			l.label = "Продолжить";
			l.enable = true;
			l.x = 259;
			l.y = k.y;
			l.setStyle("def");
			l.addEventListener(MouseEvent.ROLL_OVER, function(e:Event):void {
				Mouse.cursor = MouseCursor.BUTTON;
			});
			l.addEventListener(MouseEvent.ROLL_OUT, function(e:Event):void {
				Mouse.cursor = MouseCursor.ARROW;
			});
			l.addEventListener(MouseEvent.CLICK, function(a:Event):void {
			Main.instance.ftr.send("reg;" + h.value + ";" + i.value + ";");
				
			});
			g.y = f.y;
			g.x = 157;
			
			m.y = k.y + 45;
			m.x = f.x;
			m.htmlText = "Нажимая на кнопку \"" + l.label + "\", вы подтверждаете ваше\nсогласие с <a href=\'event:0\'><font color=\'#59ff32\'><u>Правилами</u></font></a> и <a href=\'event:1\'><font color=\'#59ff32\'><u>Условиями</u></font></a>.";
			m.addEventListener(TextEvent.LINK, function(e:TextEvent):void {
				if(e.text == "0") addChild(new Condition(_stage, 0));
				else if(e.text == "1") addChild(new Condition(_stage, 1));
			});

			
			Main.instance.ftr.addListener(this.getResponse);
			addChild(b);
			b.addChild(f);
			b.addChild(g);
			b.addChild(h);
			b.addChild(i);
			b.addChild(j);
			b.addChild(k);
			b.addChild(l);
			b.addChild(m);
			
			draw();
		}
		
		private function draw(e:Event = null):void {
			b.x = int((_stage.stageWidth - b.width) / 2);
			b.y = int((_stage.stageHeight - b.height) / 2);
		}
		
	   public function removeFromScreen() : void {
		 Main.instance.ftr.removeListener(this.getResponse);
         stage.removeChild(this.h);
         stage.removeChild(this.i);
         stage.removeChild(this.l);
         stage.removeChild(this.j);
         stage.removeChild(this.k);
         stage.removeChild(this);
         return;
       }
		
		 private function getResponse(param1:String) : void {
         var _loc2_:Array = param1.split(";");
         if(_loc2_[0]=="error")
            {
               this.al=new Alert(stage);
               this.al.add=_loc2_[1];
            }
		 if(_loc2_[0]=="error1")
           {
               this.al=new Alert(stage);
               this.al.add=_loc2_[1];
           }
         if(_loc2_[0]=="lobby")
            {
               Main.instance.startLobbyinR(_loc2_);
            }
         return;
      }
		
	}

}