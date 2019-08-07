package mishin870.gui.Garage
{
   import alternativa.engine3d.core.Object3D;
   import flash.utils.Timer;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import flash.events.TimerEvent;
   
   public class GarageObjectController
   {
      
      private static const SP:Number = -0.3;
      
      private static const speedDown:Number = 0.1;
       
      private var obj:Object3D;
      
      private var imd:Boolean = false;
      
      private var prevX:Number;
      
      private var movePrevX:Number;
      
      private var prePrevX:Number;
      
      private var speed:Number = -0.3;
      
      private var tim:Timer;
      
      private var EventSource:DisplayObject;
      
      private var isPause:Boolean = false;
      
      private var pauseTim:Timer;
      
      public function GarageObjectController(param1:DisplayObject)
      {
         super();
         this.tim = new Timer(50);
         this.obj = param2;
         Main.instance.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.mm);
         Main.instance.stage.addEventListener(MouseEvent.MOUSE_UP,this.mu);
         this.tim.addEventListener(TimerEvent.TIMER,this.onTimer);
         this.tim.start();
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.md);
         param1.addEventListener(Event.ENTER_FRAME,this.ef);
         this.EventSource = param1;
      }
      
      public function destroy() : void
      {
         Main.instance.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mm);
         Main.instance.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mu);
         this.EventSource.removeEventListener(MouseEvent.MOUSE_DOWN,this.md);
         this.EventSource.removeEventListener(Event.ENTER_FRAME,this.ef);
      }
      
      private function md(param1:MouseEvent) : void
      {
         this.prevX = Main.instance.stage.mouseX;
         this.movePrevX = Main.instance.stage.mouseX;
         this.prePrevX = this.prevX;
         this.imd = true;
      }
      
      private function onTimer(param1:Event) : void
      {
         if(this.imd)
         {
            this.prePrevX = this.prevX;
            this.prevX = Main.instance.stage.mouseX;
         }
      }
      
      private function mm(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         if(this.imd)
         {
            _loc2_ = Main.instance.stage.mouseX - this.movePrevX;
            this.movePrevX = Main.instance.stage.mouseX;
            if(this.module(_loc2_) > 0)
            {
               this.rotate(_loc2_ / 100);
            }
         }
      }
      
      private function mu(param1:MouseEvent) : void
      {
         if(this.imd)
         {
            this.speed = (Main.instance.stage.mouseX - this.prePrevX) / 5;
            this.imd = false;
            this.isPause = true;
            this.pauseTim = new Timer(15000,1);
            this.pauseTim.addEventListener(TimerEvent.TIMER_COMPLETE,this.pauseCom);
            this.pauseTim.start();
         }
      }
      
      private function pauseCom(param1:TimerEvent) : void
      {
         this.isPause = false;
         try
         {
            this.pauseTim.removeEventListener(TimerEvent.TIMER_COMPLETE,this.pauseCom);
            this.pauseTim.stop();
         }
         catch(e:Error)
         {
         }
         this.pauseTim = null;
      }
      
      private function module(param1:Number) : Number
      {
         return param1 < 0?Number(-param1):Number(param1);
      }
      
      private function diff(param1:Number, param2:Number) : Number
      {
         return param1 > param2?Number(param1 - param2):Number(param2 - param1);
      }
      
      private function rotate(param1:Number) : void
      {
         this.obj.rotationZ = this.obj.rotationZ + param1;
      }
      
      private function ef(param1:Event) : void
      {
         if(!this.imd)
         {
            if(this.speed < speedDown)
            {
               this.speed = this.speed + this.module(this.speed) / 30;
            }
            if(this.speed > speedDown)
            {
               this.speed = this.speed - this.module(this.speed) / 30;
            }
            if(this.isPause)
            {
               if(this.diff(this.speed,0) <= 0.5)
               {
                  this.speed = 0;
               }
            }
            else if(this.diff(this.speed,SP) <= 0.5)
            {
               this.speed = SP;
            }
            this.rotate(this.speed / 100);
         }
      }
   }
}
