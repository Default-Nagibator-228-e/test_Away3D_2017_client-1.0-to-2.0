package mishin870.gui.Garage.Items
{
   import mishin870.gui.ScrollingSpriteGarage;
   import mishin870.gui.ScrollVertGarage;
   import mishin870.net.SocketClass;
   import flash.events.Event;
   
   public class GarageItems extends ScrollingSpriteGarage
   {
       
      public var items:Vector.<Item>;
      
      private var scr:ScrollVertGarage;
      
      public function GarageItems(param1:ScrollVertGarage)
      {
         this.items = new Vector.<Item>();
         super();
         this.scr = param1;
      }
      
      public function refreshScr() : void
      {
         var _loc1_:Number = NaN;
         if(this.items.length > 0)
         {
            _loc1_ = this.items.length * 140;
         }
         else
         {
            _loc1_ = 1;
         }
         this.scr.scrollY = scrollRect.height / _loc1_ * px;
      }
      
      public function addItem(param1:Boolean, param2:int, param3:String, param4:String, param5:Boolean, param6:String, param7:Number, param8:int, param9:int = -1) : void
      {
         var _loc10_:Item = new Item(param2);
         _loc10_.load(param1,param3,param4,param5,param6,param7,this.mu,param8,param9);
         if(this.items.length <= 0)
         {
            _loc10_.x = 0;
         }
         else
         {
            _loc10_.y = this.items[this.items.length - 1].y + 140;
         }
         addChild(_loc10_);
         this.items.push(_loc10_);
         this.refrAWH();
      }
      
      public function clear() : void
      {
         var _loc1_:Item = null;
         for each(_loc1_ in this.items)
         {
            removeChild(_loc1_);
         }
         this.items = new Vector.<Item>();
         this.refrAWH();
      }
      
      public function unSel() : void
      {
         var _loc1_:Item = null;
         for each(_loc1_ in this.items)
         {
            _loc1_.gi.set_sel(false);
         }
      }
      
      private function mu(param1:Item) : void
      {
         var _loc2_:Item = null;
         for each(_loc2_ in this.items)
         {
            if(_loc2_ == param1)
            {
               try
               {
                  _loc2_.gi.set_sel(true);
                  Main.instance.ftr.send("gi;" + _loc2_.id + ";" + _loc2_.type);
               }
               catch(e:Error)
               {
                  continue;
               }
            }
            else
            {
               try
               {
                  _loc2_.gi.set_sel(false);
               }
               catch(e:Error)
               {
                  continue;
               }
            }
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function sort() : void
      {
         var _loc3_:Item = null;
         var _loc4_:int = 0;
         var _loc1_:Vector.<Item> = new Vector.<Item>();
         var _loc2_:Vector.<Item> = new Vector.<Item>();
         for each(_loc3_ in this.items)
         {
            if(_loc3_.active)
            {
               _loc1_.push(_loc3_);
            }
            else
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc1_[_loc4_].y = _loc4_ * 133;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc2_[_loc4_].y = (_loc4_ + _loc1_.length) * 140;
            _loc4_++;
         }
      }
      
      public function refrAWH() : void
      {
         var _loc1_:Number = NaN;
         if(this.items.length > 0)
         {
            _loc1_ = this.items.length * 140;
         }
         else
         {
            _loc1_ = 1;
         }
         setAWH(_loc1_,scrollRect.height);
         this.scr.visible = _loc1_ >= scrollRect.height;
         if(scrollRect.height <= this.scr.y + 1 - y)
         {
            this.scr.visible = false;
         }
         this.scr.scrollH = scrollRect.height / _loc1_;
         this.scr.scrollY = scrollRect.height / _loc1_;
      }
   }
}
