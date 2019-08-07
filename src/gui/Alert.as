package gui
{
   import flash.display.Sprite;
   import controls.TankWindow;
   import flash.display.Stage;
   import controls.ColorButton;
   import controls.Label;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   
   public class Alert extends Sprite
   {
       
      private var w:TankWindow;
      
      private var p:Sprite;
      
      private var _stage:Stage;
      
      private var b:ColorButton;
      
      private var l:Label;
      
      public function Alert(param1:Stage = null)
      {
         this.w = new TankWindow(180,120);
         this.p = new Sprite();
         this.b = new ColorButton();
         this.l = new Label();
         super();
         this._stage = Main.instance.stage;
         this._stage.addEventListener(Event.RESIZE,this.draw);
         this.p.graphics.beginFill(0,0.5);
         this.p.graphics.drawRect(0,0,4000,4000);
         this.b.y = 70;
         this.b.label = "OK";
         this.b.setStyle("def");
         this.b.addEventListener(MouseEvent.CLICK,this.remowe);
         this.l.y = 30;
         this.l.defaultTextFormat = new TextFormat("MyriadPro",13);
         this.p.addChild(this.w);
         this.w.addChild(this.b);
         this.w.addChild(this.l);
      }
      
      private function draw(param1:Event = null) : void
      {
         this.w.width = this.l.text.length * 8;
         this.w.width = this.w.width < 150?Number(150):Number(this.w.width);
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
      }
   }
}
