package mishin870.gui.Garage.Items
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class Item extends Sprite
   {
       
      private var il:ImageLoader;
      
      public var gi:GarageItem;
      
      private var pr:Number;
      
      private var iname:String;
      
      public var active:Boolean;
      
      private var sendBack:Boolean;
      
      public var callBack:Function;
      
      public var id:int;
      
      public var type:String;
      
      public var m:int;
      
      public var num:int;
      
      public function Item(param1:int)
      {
         super();
         this.id = param1;
      }
      
      public function load(param1:Boolean, param2:String, param3:String, param4:Boolean, param5:String, param6:Number, param7:Function, param8:int, param9:int) : void
      {
         this.sendBack = param1;
         this.callBack = param7;
         this.pr = param6;
         this.iname = param5;
         this.active = param4;
         this.type = param2;
         this.m = param8;
         this.num = param9;
         this.load_item(param3);
      }
      
      public function image_loaded(param1:Event) : void
      {
         if(this.gi != null)
         {
            if(!this.contains(this.gi))
            {
               removeChild(this.gi);
            }
         }
         this.gi = new GarageItem(this,this.il.img,this.pr,this.iname,this.active,this.m,this.num);
         this.gi.set_type(0);
         addChild(this.gi);
      }
      
      public function setType(param1:int) : void
      {
         this.gi.set_type(param1);
      }
      
      public function mu() : void
      {
         this.callBack.call(null,this);
      }
      
      public function load_item(param1:String) : void
      {
         this.il = new ImageLoader(param1);
         this.il.addEventListener(Event.COMPLETE,this.image_loaded);
         this.il.load();
      }
   }
}
