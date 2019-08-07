package mishin870.gui.Garage
{
   import flash.display.Sprite;
   import mishin870.gui.Garage.ItemInfo.ItemInfoWindow;
   import mishin870.gui.Garage.Items.GarageItemsWindow;
   import mishin870.gui.Garage.GarageSelectSH;
   import flash.events.Event;
   
   public class Garage extends Sprite
   {
       
      public var mt:mishin870.gui.Garage.MyTank;
      
      public var iiw:ItemInfoWindow;
      
      public var shop:GarageItemsWindow;
      
      public var myItems:GarageItemsWindow;
	  
      public var selectSH:GarageSelectSH;
      
      private var arr:Array;
      
      public function Garage()
      {
         this.mt = new mishin870.gui.Garage.MyTank();
         this.iiw = new ItemInfoWindow();
         this.shop = new GarageItemsWindow(true);
         this.myItems = new GarageItemsWindow(false);
         this.selectSH = new GarageSelectSH();
         super();
         addChild(this.mt);
         addChild(this.iiw);
         addChild(this.shop);
         addChild(this.selectSH);
         addChild(this.myItems);
         this.shop.items.addEventListener(Event.CHANGE,this.shopCh);
         this.myItems.items.addEventListener(Event.CHANGE,this.myItemsCh);
      }
      
      private function shopCh(param1:Event) : void
      {
         this.myItems.items.unSel();
      }
      
      private function myItemsCh(param1:Event) : void
      {
         this.shop.items.unSel();
      }
      
      public function res(param1:Number, param2:Number) : void
      {
         this.mt.res(param1 - 240,param2*0.39777777777777777777777777777778);
         this.iiw.res(param1 - 240,param2*0.39777777777777777777777777777778);
		 this.iiw.y = (param2 * 0.59555555555555555555555555555556)/1.5;
		 
         this.myItems.y = this.mt.y+60;
		 this.myItems.x = param1 - 240;
         this.myItems.res(240, param2-60);
		 
		 this.shop.y = this.myItems.y;
         this.shop.x = this.myItems.x;
         this.shop.res(240, param2-60);
		 
		 this.selectSH.x = this.myItems.x;
      }
      
      public function processInfo(param1:Array) : void
      {
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         param1.shift();
         var _loc2_:String = param1.shift();
         var _loc3_:int = int(param1.shift());
         var _loc4_:int = int(param1.shift());
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = false;
         if(_loc4_ != 8)
         {
            _loc5_ = int(param1.shift());
         }
         if(_loc4_ == 2 || _loc4_ == 3 || _loc4_ == 6 || _loc4_ == 7)
         {
            _loc6_ = int(param1.shift());
         }
         if(_loc4_ > 3)
         {
            _loc7_ = param1.shift() == "1";
         }
         if(_loc2_ == "h")
         {
            _loc8_ = Main.instance.xml.descriptions[0].hulls[0].description[_loc3_].@name;
            _loc9_ = Main.instance.xml.descriptions[0].hulls[0].description[_loc3_].@text.split(";");
            _loc10_ = _loc9_[0];
            _loc11_ = _loc9_[1];
            this.iiw.ii.setDescription("<p class=\'o\'>    " + _loc8_ + "</p>\n<img src=\'" + _loc10_ + "\'/>",_loc11_);
            this.iiw.setState(_loc2_,_loc3_,_loc4_,_loc5_,_loc7_,_loc6_);
         }
         if(_loc2_ == "t")
         {
            _loc8_ = Main.instance.xml.descriptions[0].turrets[0].description[_loc3_].@name;
            _loc9_ = Main.instance.xml.descriptions[0].turrets[0].description[_loc3_].@text.split(";");
            _loc10_ = _loc9_[0];
            _loc11_ = _loc9_[1];
            this.iiw.ii.setDescription("<p class=\'o\'>    " + _loc8_ + "</p>\n<img src=\'" + _loc10_ + "\'/>",_loc11_);
            this.iiw.setState(_loc2_,_loc3_,_loc4_,_loc5_,_loc7_,_loc6_);
         }
         if(_loc2_ == "c")
         {
            _loc8_ = Main.instance.xml.descriptions[0].colormaps[0].description[_loc3_].@name;
            _loc9_ = Main.instance.xml.descriptions[0].colormaps[0].description[_loc3_].@text.split(";");
            _loc10_ = _loc9_[0];
            _loc11_ = _loc9_[1];
            this.iiw.ii.setDescription("<p class=\'o\'>    " + _loc8_ + "</p>\n<img src=\'" + _loc10_ + "\'/>",_loc11_);
            this.iiw.setState(_loc2_,_loc3_,_loc4_,_loc5_,_loc7_,_loc6_);
         }
         if(_loc2_ == "n")
         {
            _loc8_ = Main.instance.xml.descriptions[0].numerics[0].description[_loc3_].@name;
            _loc9_ = Main.instance.xml.descriptions[0].numerics[0].description[_loc3_].@text.split(";");
            _loc10_ = _loc9_[0];
            _loc11_ = _loc9_[1];
            this.iiw.ii.setDescription("<p class=\'o\'>    " + _loc8_ + "</p>\n<img src=\'" + _loc10_ + "\'/>",_loc11_);
            this.iiw.setState(_loc2_,_loc3_,_loc4_,_loc5_,_loc7_,_loc6_);
         }
      }
      
      public function processGarage(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:String = null;
         var _loc11_:* = false;
         var _loc12_:int = 0;
         var _loc13_:* = false;
         var _loc14_:int = 0;
         this.myItems.items.clear();
         this.shop.items.clear();
         this.iiw.setState("",-1,-1,-1);
         this.iiw.ii.setDescription("","");
         param1.shift();
         this.arr = param1.slice();
         var _loc2_:int = int(param1.shift());
         var _loc3_:int = int(param1.shift());
         var _loc4_:int = int(param1.shift());
         var _loc5_:int = int(param1.shift());
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc7_ = int(param1[0]);
            _loc8_ = int(Main.instance.xml.numerics[0].numeric[_loc6_].@price);
            if(_loc7_ > 0)
            {
               _loc9_ = Main.instance.xml.numerics[0].numeric[_loc6_].@url;
               _loc10_ = Main.instance.xml.numerics[0].numeric[_loc6_].@name;
               this.myItems.items.addItem(true,_loc6_,"numeric",_loc9_,true,_loc10_,_loc8_,-1,_loc7_);
            }
            else
            {
               _loc9_ = Main.instance.xml.numerics[0].numeric[_loc6_].@url;
               _loc10_ = Main.instance.xml.numerics[0].numeric[_loc6_].@name;
               _loc11_ = param1[1] == "1";
               this.shop.items.addItem(true,_loc6_,"numeric",_loc9_,_loc11_,_loc10_,_loc8_,-1);
            }
            param1.shift();
            param1.shift();
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc12_ = int(param1[3]);
            _loc13_ = param1[4] == "1";
            if(param1[0] == "1")
            {
               _loc9_ = Main.instance.xml.turrets[0].turret[_loc6_ * 4 + int(param1[1])].@path + "preview.png";
               _loc10_ = Main.instance.xml.turrets[0].turret[_loc6_ * 4 + int(param1[1])].@name;
               this.myItems.items.addItem(true,_loc6_,"turret",_loc9_,true,_loc10_,-1,_loc12_);
            }
            else
            {
               _loc9_ = Main.instance.xml.turrets[0].turret[_loc6_ * 4].@path + "preview.png";
               _loc10_ = Main.instance.xml.turrets[0].turret[_loc6_ * 4].@name;
               _loc11_ = param1[2] == "1";
               _loc8_ = int(Main.instance.xml.turrets[0].turret[_loc6_ * 4].@price);
               this.shop.items.addItem(true,_loc6_,"turret",_loc9_,_loc11_,_loc10_,_loc8_,_loc12_);
            }
            param1.shift();
            param1.shift();
            param1.shift();
            param1.shift();
            param1.shift();
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc12_ = int(param1[3]);
            _loc13_ = param1[4] == "1";
            if(param1[0] == "1")
            {
               _loc9_ = Main.instance.xml.hulls[0].hull[_loc6_ * 4 + int(param1[1])].@path + "preview.png";
               _loc10_ = Main.instance.xml.hulls[0].hull[_loc6_ * 4 + int(param1[1])].@name;
               this.myItems.items.addItem(true,_loc6_,"hull",_loc9_,true,_loc10_,-1,_loc12_);
            }
            else
            {
               _loc9_ = Main.instance.xml.hulls[0].hull[_loc6_ * 4].@path + "preview.png";
               _loc10_ = Main.instance.xml.hulls[0].hull[_loc6_ * 4].@name;
               _loc11_ = param1[2] == "1";
               _loc8_ = int(Main.instance.xml.hulls[0].hull[_loc6_ * 4].@price);
               this.shop.items.addItem(true,_loc6_,"hull",_loc9_,_loc11_,_loc10_,_loc8_,_loc12_);
            }
            param1.shift();
            param1.shift();
            param1.shift();
            param1.shift();
            param1.shift();
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc14_ = int(param1[0]);
            if(_loc14_ != -1)
            {
               _loc13_ = param1[3] == "1";
               if(param1[0] == "1")
               {
                  _loc9_ = Main.instance.xml.colormaps[0].colormap[_loc6_].@path + "preview.png";
                  _loc10_ = Main.instance.xml.colormaps[0].colormap[_loc6_].@name;
                  this.myItems.items.addItem(true,_loc6_,"colormap",_loc9_,true,_loc10_,-1,-1);
               }
               else
               {
                  _loc9_ = Main.instance.xml.colormaps[0].colormap[_loc6_].@path + "preview.png";
                  _loc10_ = Main.instance.xml.colormaps[0].colormap[_loc6_].@name;
                  _loc11_ = param1[2] == "1";
                  _loc8_ = int(Main.instance.xml.colormaps[0].colormap[_loc6_].@price);
                  this.shop.items.addItem(true,_loc6_,"colormap",_loc9_,_loc11_,_loc10_,_loc8_,-1);
               }
               param1.shift();
               param1.shift();
               param1.shift();
               param1.shift();
            }
            else
            {
               param1.shift();
               param1.shift();
            }
            _loc6_++;
         }
         this.shop.sort();
      }
   }
}
