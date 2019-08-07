package mishin870.gui.Garage.Items
{
   import flash.display.Sprite;
   import assets.icons.GarageItemBackground;
   import flash.display.Bitmap;
   import controls.Label;
   import mishin870.gui.Garage.m2.MIndicator2;
   import flash.events.MouseEvent;
   import flash.display.BitmapData;
   import flash.display.PixelSnapping;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class GarageItem extends Sprite
   {
      
      [Embed(source="GarageItem/crystall.png")] private var crystall:Class;
      
      private static const ACTIVE_COLOR:int = 65280;
       
      public var back:GarageItemBackground = new GarageItemBackground(3);
      
      public var crys:Bitmap = new crystall();
      
      public var active:Boolean = true;
      
      public var sel:Boolean = false;
      
      public var equ:Boolean = false;
      
      private var type:Number = 1;
      
      public var itemImg:Bitmap;
      
      public var iname:String;
      
      public var tfcrys:Label = new Label();
      
      public var tfname:Label = new Label();
      
      public var item:mishin870.gui.Garage.Items.Item;
      
      private var mi:MIndicator2;
      
      public var tfnum:Label = new Label();
      
      public function GarageItem(param1:mishin870.gui.Garage.Items.Item, param2:BitmapData, param3:Number, param4:String, param5:Boolean, param6:int, param7:int)
      {
         super();
         this.iname = param4;
         this.item = param1;
         addChild(this.back);
         if(param5)
         {
            this.back.gotoAndStop(3);
         }
         else
         {
            this.back.gotoAndStop(1);
         }
         this.active = param5;
         this.itemImg = new Bitmap(param2,PixelSnapping.NEVER,true);
         this.itemImg.x = this.back.width / 2 - this.itemImg.width / 2;
         this.itemImg.y = this.back.height / 2 - this.itemImg.height / 2;
         addChild(this.itemImg);
         if(param5)
         {
            this.tfname.autoSize = TextFieldAutoSize.LEFT;
            this.tfname.text = param4;
            this.tfname.background = false;
            this.tfname.textColor = ACTIVE_COLOR;
            this.tfname.x = 5;
            this.tfname.y = 3;
            this.tfname.selectable = false;
            addChild(this.tfname);
         }
         else
         {
            this.tfname.autoSize = TextFieldAutoSize.LEFT;
            this.tfname.text = param4;
            this.tfname.background = false;
            this.tfname.textColor = 12632230;
            this.tfname.x = 5;
            this.tfname.y = 3;
            this.tfname.selectable = false;
            addChild(this.tfname);
         }
         if(param3 > -1)
         {
            this.crys.x = this.width - (5 + this.crys.width);
            this.crys.y = 7;
            addChild(this.crys);
            if(param5)
            {
               this.tfcrys.autoSize = TextFieldAutoSize.LEFT;
               this.tfcrys.text = "" + param3;
               this.tfcrys.background = false;
               this.tfcrys.textColor = ACTIVE_COLOR;
               this.tfcrys.x = this.crys.x - (this.tfcrys.width + 2);
               this.tfcrys.y = 3;
               this.tfcrys.selectable = false;
               addChild(this.tfcrys);
            }
            else
            {
               this.tfcrys.autoSize = TextFieldAutoSize.LEFT;
               this.tfcrys.text = "" + param3;
               this.tfcrys.background = false;
               this.tfcrys.textColor = 12632256;
               this.tfcrys.x = this.crys.x - (this.tfcrys.width + 2);
               this.tfcrys.y = 3;
               this.tfcrys.selectable = false;
               addChild(this.tfcrys);
            }
         }
         addEventListener(MouseEvent.MOUSE_UP,this.mu);
         if(param6 >= 0)
         {
            this.mi = new MIndicator2(param6);
            this.mi.y = 7;
            this.mi.x = 160;
            addChild(this.mi);
         }
         if(param7 != -1)
         {
            this.tfnum.textColor = ACTIVE_COLOR;
            this.tfnum.defaultTextFormat = new TextFormat("MyriadPro",18);
            this.tfnum.text = "x" + param7;
            this.tfnum.x = this.back.width - this.tfnum.width - 10;
            this.tfnum.y = this.back.height - this.tfnum.height - 10;
            addChild(this.tfnum);
         }
      }
      
      private function mu(param1:MouseEvent) : void
      {
         this.item.mu();
      }
      
      public function set_sel(param1:Boolean) : void
      {
         this.sel = param1;
         if(this.active)
         {
            if(this.equ)
            {
               if(this.type == 0)
               {
                  if(param1)
                  {
                     this.back.gotoAndStop(10);
                  }
                  else
                  {
                     this.back.gotoAndStop(9);
                  }
               }
               if(this.type == 1)
               {
                  if(param1)
                  {
                     this.back.gotoAndStop(6);
                  }
                  else
                  {
                     this.back.gotoAndStop(5);
                  }
               }
               if(this.type == 2)
               {
                  if(param1)
                  {
                     this.back.gotoAndStop(18);
                  }
                  else
                  {
                     this.back.gotoAndStop(17);
                  }
               }
            }
            else if(param1)
            {
               this.back.gotoAndStop(4);
            }
            else
            {
               this.back.gotoAndStop(3);
            }
         }
         else if(param1)
         {
            this.back.gotoAndStop(2);
         }
         else
         {
            this.back.gotoAndStop(1);
         }
      }
      
      public function set_equ(param1:Boolean) : void
      {
         this.equ = param1;
         this.set_sel(this.sel);
      }
      
      public function set_type(param1:Number) : void
      {
         this.type = param1;
      }
   }
}
