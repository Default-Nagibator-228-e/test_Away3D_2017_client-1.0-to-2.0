package mishin870.gui
{
   import flash.display.Sprite;
   import flash.display.Bitmap;
   import controls.TankWindow;
   import flash.display.Stage;
   import controls.ColorButton;
   import controls.Label;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.display.Loader;
   import flash.net.URLRequest;
   
   public class EB1 extends Sprite
   {
      private var fon:Class;
      
      private var bg:Bitmap;
      
      private var c:Array;
	  
	  private var w:TankWindow;
      
      private var p:Sprite;
      
      private var _stage:Stage;
      
      private var b:ColorButton;
      
      private var l:Label;
      
      public function EB1(param1:Stage)
      {
         this.fon = EB;
		 this.w = new TankWindow(180,120);
         this.p = new Sprite();
         this.b = new ColorButton();
         this.l = new Label();
         super();
		 this._stage = param1;
         this._stage.addEventListener(Event.RESIZE,this.draw);
         this.p.graphics.beginFill(0,0.5);
         this.p.graphics.drawRect(0,0,4000,4000);
         this.b.y = 340;
         this.b.label = "Закрыть";
         this.b.setStyle("def");
         this.b.addEventListener(MouseEvent.CLICK,this.remowe);
         this.l.y = 160;
         this.l.defaultTextFormat = new TextFormat("MyriadPro",13);
         this.p.addChild(this.w);
         this.w.addChild(this.b);
         this.w.addChild(this.l);
		 this.add = "";
		 addChild(this.bg = new this.fon());
         this.bg.x = 190;
         this.bg.y = 120;
      }
	        
      private function draw(param1:Event = null) : void
      {
         this.w.width = 56 * 8;
         this.w.width = this.w.width < 150?Number(150):Number(this.w.width);
		 this.w.height = 47 * 8;
         this.w.height = this.w.height < 150?Number(150):Number(this.w.height);
         this.l.x = int((this.w.width - this.l.width) / 2);
         this.b.x = int((this.w.width - this.b.width) / 2);
         this.w.x = int((this._stage.stageWidth - this.w.width) / 2);
         this.w.y = int((this._stage.stageHeight - this.w.height) / 2);
      }
      
      public function set add(param1:String) : void
      {
         this.l.htmlText = param1;
         this.draw();
         this._stage.addChild(this.p);
      }
      
      public function remowe(param1:MouseEvent = null) : void
      {
         this._stage.removeChild(this.p);
		 removeChild(this.bg);
      }
   }
}
