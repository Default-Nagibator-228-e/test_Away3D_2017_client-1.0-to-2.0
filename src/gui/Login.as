package gui
{
   import controls.ColorButton;
   import controls.Label;
   import controls.TankCheckBox;
   import controls.TankInput;
   import controls.TankWindow;
   import controls.TankWindowHeader;
   import flash.display.*;
   import mishin870.net.SocketClass;
   import flash.events.*;
   import flash.ui.*;
   import gui.Alert;
   import controls.*;
   import flash.net.*;

   public class Login extends Sprite
   {
      {
      private var win:TankWindow;
	  private var ldr:Loader;
      private var saveCh:TankCheckBox;
      public var loginI:TankInput;
      private var passI:TankInput;
      private var enterBut:ColorButton;
      private var forgL:Label;
      private var newBut:ColorButton;
      private var al:Alert;
      private var so:SharedObject;
      private var n:Nicks;
	  private var _stage:Stage;
      }
      public function Login(param1:Stage) {
         var stage:Stage;
         stage = param1;
         this.so=SharedObject.getLocal("login");
         super();
         stage.addChild(this);
         this.win=new TankWindow();
         this.win.width=425;
         this.win.height=225;
         addChild(this.win);
         this.loginI=new TankInput();
         this.passI=new TankInput();
         this.enterBut=new ColorButton();
         this.forgL=new Label();
         this.newBut=new ColorButton();
         this.saveCh=new TankCheckBox();
         this.loginI.width=292;
         this.loginI.label="Позывной:";
         this.loginI.restrict=".0-9a-zA-z_\\-";
         this.loginI.maxChars=20;
         this.loginI.addEventListener(MouseEvent.ROLL_OVER,function(param1:Event):void
            {
               Mouse.cursor=MouseCursor.IBEAM;
               return;
            }
         );
         this.loginI.addEventListener(MouseEvent.ROLL_OUT,function(param1:Event):void
            {
               Mouse.cursor=MouseCursor.ARROW;
               return;
            }
         );
         this.passI.hidden=true;
         this.passI.width=292;
         this.passI.label="Пароль:";
         this.passI.addEventListener(MouseEvent.ROLL_OVER,function(param1:Event):void
            {
               Mouse.cursor=MouseCursor.IBEAM;
               return;
            }
         );
         this.passI.addEventListener(MouseEvent.ROLL_OUT,function(param1:Event):void
            {
               Mouse.cursor=MouseCursor.ARROW;
               return;
            }
         );
         this.saveCh.checked=false;
         this.saveCh.label="Запомнить";
         this.enterBut.label="Играть";
         this.enterBut.setStyle("def");
         this.enterBut.addEventListener(MouseEvent.ROLL_OVER,function(param1:Event):void
            {
               Mouse.cursor=MouseCursor.BUTTON;
               return;
            }
         );
         this.enterBut.addEventListener(MouseEvent.ROLL_OUT,function(param1:Event):void
            {
               Mouse.cursor=MouseCursor.ARROW;
               return;
            }
         );
         this.forgL.y=123;
         this.forgL.htmlText="<u>Забыли позывной или пароль?</u>";
         this.forgL.textColor=5898034;
         this.forgL.addEventListener(MouseEvent.ROLL_OVER,function(param1:Event):void
            {
               Mouse.cursor=MouseCursor.BUTTON;
               return;
            }
         );
         this.forgL.addEventListener(MouseEvent.ROLL_OUT,function(param1:Event):void
            {
               Mouse.cursor=MouseCursor.ARROW;
               return;
            }
         );
         this.forgL.addEventListener(MouseEvent.CLICK,function(param1:Event):void
            {
               return;
            }
         );
         this.forgL.x=227;
         this.newBut.label="Регистрация";
         this.newBut.setStyle("def");
         this.newBut.addEventListener(MouseEvent.ROLL_OVER, function(param1:Event):void
            {
               Mouse.cursor=MouseCursor.BUTTON;
               return;
            }
         );
         this.newBut.addEventListener(MouseEvent.ROLL_OUT,function(param1:Event):void
            {
               Mouse.cursor=MouseCursor.ARROW;
               return;
            }
         );
         stage.addChild(this.loginI);
         stage.addChild(this.passI);
         stage.addChild(this.enterBut);
         addChild(this.forgL);
         stage.addChild(this.newBut);
         stage.addChild(this.saveCh);
         if(this.so.data["login"]!=null)
            {
               this.loginI.value=this.so.data["login"];
               this.passI.value=this.so.data["pass"];
               this.saveCh.checked=this.so.data["check"]=="1";
            }
         Main.instance.ftr.addListener(this.getResponse);
         this.loginI.addEventListener(KeyboardEvent.KEY_DOWN,this.kd);
         this.passI.addEventListener(KeyboardEvent.KEY_DOWN,this.kd);
         this.enterBut.addEventListener(MouseEvent.CLICK, this.enterC);
		 this.newBut.addEventListener(MouseEvent.CLICK,this.enterR);
         return;
      }
      public function removeNicks() : void {
         this.n=null;
         return;
      }
      public function update() : void {
         var _loc1_:int = int(this.x);
         var _loc2_:int = int(this.y);
         this.loginI.x=_loc1_+108;
         this.loginI.y=_loc2_+30;
         this.passI.x=_loc1_+108;
         this.passI.y=_loc2_+68;
         this.saveCh.x=_loc1_+108;
         this.saveCh.y=_loc2_+116;
         this.enterBut.x=_loc1_+108;
         this.enterBut.y=_loc2_+170;
         this.newBut.x=_loc1_+305;
         this.newBut.y=_loc2_+170;
         return;
      }
      public function removeFromScreen() : void {
		 Main.instance.ftr.removeListener(this.getResponse);
         this.loginI.removeEventListener(KeyboardEvent.KEY_DOWN,this.kd);
         this.passI.removeEventListener(KeyboardEvent.KEY_DOWN,this.kd);
         this.enterBut.removeEventListener(MouseEvent.CLICK,this.enterC);
         stage.removeChild(this.loginI);
         stage.removeChild(this.passI);
         stage.removeChild(this.enterBut);
         stage.removeChild(this.newBut);
         stage.removeChild(this.saveCh);
         stage.removeChild(this);
         return;
      }
      private function kd(param1:KeyboardEvent) : void {
         if(param1.keyCode==Keyboard.ENTER||param1.keyCode==Keyboard.NUMPAD_ENTER)
            {
               if(this.al!=null)
                  {
                     try
                        {
                           this.al.remowe();
                        }
                     catch(e:Error)
                        {
                        }
                     this.al=null;
                  }
               else
                  {
                     if(!this.enterBut.enable)
                        {
                           return;
                        }
                     this.enter();
                  }
            }
         return;
      }
      private function enterC(param1:MouseEvent) : void {
         this.enter();
         return;
      }
	  private function enterR(param1:MouseEvent) : void {
         Main.instance.startRegistration();
         return;
      }
      private function getResponse(param1:String) : void {
         this.enterBut.enable=true;
         var _loc2_:Array = param1.split(";");
         if(_loc2_[0]=="error")
            {
               this.al=new Alert(stage);
               this.al.add=_loc2_[1];
            }
         if(_loc2_[0]=="lobby")
            {
               Main.instance.startLobby(_loc2_);
            }
         return;
      }
      private function enter() : void {
         if(this.saveCh.checked)
            {
               this.so.data["login"]=this.loginI.value;
               this.so.data["pass"]=this.passI.value;
               this.so.data["check"]="1";
            }
         else
            {
               this.so.data["login"]="";
               this.so.data["pass"]="";
               this.so.data["check"]="0";
            }
         this.enterBut.enable=false;
         Main.instance.ftr.send("login;"+this.loginI.value+";"+this.passI.value);
         return;
      }
   }
}
