package mishin870.gui.StepperButton
{
   import flash.display.Sprite;
   import flash.events.Event;
   import controls.TankInput;

   public class Stepper extends Sprite {
	   
      public function Stepper() {
         this.i=new TankInput();
         super();
         this.s=new StepperButton(this.ch);
         addChild(this.i);
         this.i.addEventListener(Event.CHANGE,this.change);
         addChild(this.s);
         this.wid=100;
         return;
      }
      private var min:int;
      private var max:int;
      private var val:int;
      private var i:TankInput;
      private var s:StepperButton;
      private var _wid:int;
      private function change(param1:Event) : void {
         this.val=int(this.i.textField.text);
         this.ch(0);
         return;
      }
      public function get value() : int {
         return this.val;
      }
      public function set wid(param1:int) : void {
         this._wid=param1;
         this.res(this._wid);
         return;
      }
      public function get wid() : int {
         return this._wid;
      }
      private function res(param1:int) : void {
         this.i.width=param1-this.s.width-1;
         this.s.x=param1-this.s.width;
         return;
      }
      private function ch(param1:int) : void {
         this.val=this.val+param1;
         if(this.val<this.min)
            {
               this.val=this.min;
            }
         if(this.val>this.max)
            {
               this.val=this.max;
            }
         if(this.val!=0)
            {
               this.i.textField.text=this.val.toString();
            }
         else
            {
               this.i.textField.text="—";
            }
         dispatchEvent(new Event(Event.CHANGE));
         return;
      }
      public function setValues(param1:int, param2:int, param3:int) : void {
         this.min=param1;
         this.max=param2;
         this.val=param3;
         this.ch(0);
         return;
      }
   }
}