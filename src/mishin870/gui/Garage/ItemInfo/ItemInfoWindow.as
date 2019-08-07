package mishin870.gui.Garage.ItemInfo
{
   import flash.display.Sprite;
   import controls.TankWindow;
   import controls.TankWindowInner;
   import mishin870.gui.Garage.GarageButton;
   import controls.BigButton;
   import flash.net.URLLoader;
   import mishin870.gui.StepperButton.Stepper;
   import controls.Label;
   import flash.events.MouseEvent;
   import mishin870.net.SocketClass;
   import flash.events.Event;
   import flash.net.URLRequest;
   import controls.TankWindowHeader;
   
   public class ItemInfoWindow extends Sprite
   {
       
      private var w:TankWindow;
      
      private var inner:TankWindowInner;
      
      public var ii:mishin870.gui.Garage.ItemInfo.ItemInfo;
      
      public var improveBut:GarageButton;
      
      public var setBut:BigButton;
      
      public var id:int;
      
      public var type:String;
      
      public var type2:int;
      
      private var descriptionLoader:URLLoader;
      
      private var numStep:Stepper;
      
      private var price:int;
      
      private var rank:int;
      
      public function ItemInfoWindow()
      {
         this.w = new TankWindow();
         this.inner = new TankWindowInner(-1,-1,4278985229);
         this.ii = new mishin870.gui.Garage.ItemInfo.ItemInfo();
         this.improveBut = new GarageButton();
         this.setBut = new BigButton();
         this.numStep = new Stepper();
         super();
         addChild(this.w);
         addChild(this.inner);
         addChild(this.ii);
         this.improveBut.width = 120;
         this.setBut.width = 120;
         this.improveBut.visible = false;
         this.setBut.visible = false;
         addChild(this.improveBut);
         addChild(this.setBut);
         addChild(this.numStep);
         this.numStep.addEventListener(Event.CHANGE,function(param1:Event):void
         {
            improveBut.enable = true;
            var _loc2_:int = price * numStep.value;
            if(type2 == 0)
            {
               if(_loc2_ > Main.crys)
               {
                  improveBut.setText("Купить",getRedPrice(_loc2_) + " ",getOff(_loc2_));
               }
               else
               {
                  improveBut.setText("Купить",_loc2_ + " ",getOff(_loc2_));
               }
               improveBut.enable = _loc2_ <= Main.crys;
            }
            if(type2 == 1)
            {
               improveBut.setText("Купить",getRedPrice(_loc2_) + " ",getOff(_loc2_));
               improveBut.enable = false;
            }
            if(type2 == 2 || type2 == 3)
            {
               improveBut.setText("Купить",(type2 == 3?getRedPrice(_loc2_):_loc2_) + "      " + getRedText("Ранг "),getOff(_loc2_),rank,getRankOff(price + "   Ранг "));
               improveBut.enable = false;
            }
         });
         this.numStep.wid = 75;
         this.ii.x = 12;
         this.ii.y = 12;
         this.inner.x = 12;
         this.inner.y = 12;
         addEventListener(MouseEvent.MOUSE_WHEEL,this.mw);
         this.improveBut.addEventListener(MouseEvent.MOUSE_UP,this.improveMu);
         this.setBut.addEventListener(MouseEvent.MOUSE_UP,this.setMu);
      }
      
      private function getRank(param1:int) : String
      {
         return "<img src=\'data/ranks/" + param1 + ".png\'/>";
      }
      
      private function getRedPrice(param1:int) : String
      {
         return "<font color=\'#F74C02\'>" + param1 + "</font>";
      }
      
      private function getRedText(param1:String) : String
      {
         return "<font color=\'#F74C02\'>" + param1 + "</font>";
      }
      
      private function getOff(param1:int) : int
      {
         var _loc2_:Label = new Label();
         _loc2_.text = param1.toString();
         return _loc2_.width;
      }
      
      private function getRankOff(param1:String) : int
      {
         var _loc2_:Label = new Label();
         _loc2_.text = param1;
         return _loc2_.width + 4;
      }
      
      public function setState(param1:String, param2:int, param3:int, param4:int, param5:Boolean = false, param6:int = 1) : void
      {
         this.type = param1;
         this.type2 = param3;
         this.id = param2;
         this.price = param4;
         this.rank = param6;
         this.improveBut.visible = true;
         this.setBut.visible = true;
         this.numStep.visible = false;
         this.improveBut.enable = true;
         this.setBut.enable = true;
         this.improveBut.label = "";
         this.setBut.label = "";
         if(param1 != "n")
         {
            if(param3 == -1)
            {
               this.improveBut.visible = false;
               this.setBut.visible = false;
            }
            if(param3 == 0)
            {
               this.setBut.visible = false;
               this.improveBut.setText("Купить",param4 + " ",this.getOff(param4));
            }
            if(param3 == 1)
            {
               this.setBut.visible = false;
               this.improveBut.setText("Купить",this.getRedPrice(param4) + " ",this.getOff(param4));
               this.improveBut.enable = false;
            }
            if(param3 == 2 || param3 == 3)
            {
               this.setBut.visible = false;
               this.improveBut.setText("Купить",(param3 == 3?this.getRedPrice(param4):param4) + "      " + this.getRedText("Ранг "),this.getOff(param4),param6,this.getRankOff(param4 + "   Ранг "));
               this.improveBut.enable = false;
            }
            if(param3 == 4)
            {
               this.setBut.visible = true;
               this.setBut.label = "Установить";
               this.improveBut.setText("Улучшить",param4 + " ",this.getOff(param4));
            }
            if(param3 == 5)
            {
               this.setBut.visible = true;
               this.setBut.label = "Установить";
               this.improveBut.setText("Улучшить",this.getRedPrice(param4) + " ",this.getOff(param4));
               this.improveBut.enable = false;
            }
            if(param3 == 6 || param3 == 7)
            {
               this.setBut.visible = true;
               this.setBut.label = "Установить";
               this.improveBut.setText("Улучшить",(param3 == 7?this.getRedPrice(param4):param4) + "      " + this.getRedText("Ранг "),this.getOff(param4),param6,this.getRankOff(param4 + "   Ранг "));
               this.improveBut.enable = false;
            }
            if(param3 == 8)
            {
               this.setBut.visible = true;
               this.improveBut.visible = false;
               this.setBut.label = "Установить";
            }
            this.setBut.enable = !param5;
         }
         else
         {
            this.numStep.setValues(1,1000,1);
            this.improveBut.visible = true;
            this.setBut.visible = false;
            this.numStep.visible = true;
            this.improveBut.x = this.numStep.x + this.numStep.wid + 1;
            if(param3 == 0)
            {
               this.improveBut.setText("Купить",param4 + " ",this.getOff(param4));
            }
            if(param3 == 1)
            {
               this.improveBut.setText("Купить",this.getRedPrice(param4) + " ",this.getOff(param4));
               this.improveBut.enable = false;
            }
            if(param3 == 2 || param3 == 3)
            {
               this.improveBut.setText("Купить",(param3 == 3?this.getRedPrice(param4):param4) + "      " + this.getRedText("Ранг "),this.getOff(param4),param6,this.getRankOff(param4 + "   Ранг "));
               this.improveBut.enable = false;
            }
         }
         this.res(this.w.width,this.w.height);
      }
      
      private function improveMu(param1:MouseEvent) : void
      {
         this.improveBut.enable = false;
         if(this.type == "n")
         {
            Main.instance.ftr.send("buyg;" + this.type + ";" + this.id + ";" + this.numStep.value);
         }
         else
         {
            Main.instance.ftr.send("buyg;" + this.type + ";" + this.id);
         }
      }
      
      private function setMu(param1:MouseEvent) : void
      {
         this.setBut.enable = false;
         Main.instance.ftr.send("setg;" + this.type + ";" + this.id);
      }
      
      private function setButEnab(param1:String, param2:BigButton) : void
      {
         if(param1.substr(0,1) == "0")
         {
            param2.visible = false;
            param2.enable = false;
         }
         if(param1.substr(0,1) == "1")
         {
            param2.visible = true;
            param2.enable = true;
         }
         if(param1.substr(0,1) == "2")
         {
            param2.visible = true;
            param2.enable = false;
         }
         if(param1.length > 1)
         {
            param2.label = param1.substr(1);
         }
      }
      
      public function processDescription(param1:String, param2:String, param3:String) : void
      {
         this.id = new int(param2);
         this.type = param3;
         var _loc4_:Array = param1.split("|");
         this.setButEnab(_loc4_[1],this.improveBut);
         this.setButEnab(_loc4_[2],this.setBut);
         this.descriptionLoader = new URLLoader();
         this.descriptionLoader.addEventListener(Event.COMPLETE,this.descriptionCom);
         this.descriptionLoader.load(new URLRequest("data/descriptions/" + _loc4_[0] + ".txt"));
      }
      
      private function descriptionCom(param1:Event) : void
      {
      }
      
      private function mw(param1:MouseEvent) : void
      {
         this.ii.scroll(0,-param1.delta * 2);
      }
      
      public function res(param1:Number, param2:Number) : void
      {
         this.w.width = param1;
         this.w.height = param2;
         this.ii.setRect(param1 - 24,param2 - 82);
         this.ii.wid = param1 - 24;
         this.inner.width = param1 - 24;
         this.inner.height = param2 - 80;
         this.improveBut.x = 12;
         this.improveBut.y = this.inner.y + this.inner.height + 5;
         this.setBut.x = param1 - 132;
         this.setBut.y = this.inner.y + this.inner.height + 5;
         this.numStep.y = this.improveBut.y + this.improveBut.height / 2 - this.numStep.height / 2;
         this.numStep.x = 12;
         if(this.type == "n")
         {
            this.improveBut.x = this.numStep.x + this.numStep.wid + 1;
         }
      }
   }
}
