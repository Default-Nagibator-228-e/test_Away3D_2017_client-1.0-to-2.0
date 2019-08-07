package mishin870.gui
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

   public class Fame extends Sprite
   {
      {
      private var win:TankWindow;
	  private var ldr:Loader;
      private var al:Alert;
	  private var so:SharedObject;
	  private var _stage:Stage;
      }
      public function Fame(param1:Stage) {
         var stage:Stage;
         stage = param1;
		 this.so=SharedObject.getLocal("fame");
         super();
         stage.addChild(this);
         this.win=new TankWindow();
         this.win.width=425;
         this.win.headerLang="ru";
         this.win.header=TankWindowHeader.HALL_OF_FAME;
         this.win.height=225;
         addChild(this.win);
         SocketClass.addListener(this.getResponse);
         return;
      }
      private function getResponse(param1:String) : void {
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
   }
}
