package gui
{
   import controls.TankWindow;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.display.Stage;
   import controls.DefaultButton;
   import flash.events.MouseEvent;
   
   public class Nicks extends TankWindow
   {
       
      private var p:Sprite;
      
      public function Nicks(param1:Stage)
      {
         var _stage:Stage = param1;
         super(120,82);
         _stage.addEventListener(Event.RESIZE,this.draw);
         this.p = new Sprite();
         this.p.graphics.beginFill(0,0.5);
         this.p.graphics.drawRect(0,0,4000,4000);
         this.p.addChild(this);
         var mb:DefaultButton = new DefaultButton();
         mb.width = 100;
         mb.x = 10;
         mb.y = 10;
         mb.label = "Mishin870";
         addChild(mb);
         mb.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            Main.instance.login.loginI.value = "Mishin870";
            _stage.removeEventListener(Event.RESIZE,draw);
            _stage.removeChild(p);
            Main.instance.login.removeNicks();
         });
         var nb:DefaultButton = new DefaultButton();
         nb.width = 100;
         nb.x = 10;
         nb.y = 40;
         nb.label = "Noob";
         addChild(nb);
         nb.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            Main.instance.login.loginI.value = "Noob";
            _stage.removeEventListener(Event.RESIZE,draw);
            _stage.removeChild(p);
            Main.instance.login.removeNicks();
         });
         _stage.addChild(this.p);
         this.draw(null,_stage);
      }
      
      public function draw(param1:Event = null, param2:Stage = null) : void
      {
         try
         {
            this.x = param2.stageWidth / 2 - this.width / 2;
            this.y = param2.stageHeight / 2 - this.height / 2;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
   }
}
