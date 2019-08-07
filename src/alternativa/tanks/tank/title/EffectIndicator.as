package alternativa.tanks.tank.title
{
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import flash.geom.Rectangle;
   import flash.geom.Matrix;
   import flash.geom.ColorTransform;
   import flash.utils.getTimer;
   
   public class EffectIndicator
   {
      
      [Embed (source="assets/icon_health.png")] private static var iconHealthCls:Class;
		private static var iconHealth:BitmapData = new iconHealthCls().bitmapData;
		[Embed (source="assets/icon_armor.png")] private static var iconArmorCls:Class;
		private static var iconArmor:BitmapData = new iconArmorCls().bitmapData;
		[Embed (source="assets/icon_power.png")] private static var iconPowerCls:Class;
		private static var iconPower:BitmapData = new iconPowerCls().bitmapData;
		[Embed (source="assets/icon_nitro.png")] private static var iconNitroCls:Class;
		private static var iconNitro:BitmapData = new iconNitroCls().bitmapData;
      
      private static var icons:Dictionary = new Dictionary();
      
      private static var rect:Rectangle = new Rectangle(0,0,iconArmor.width,iconArmor.height);
      
      private static var matrix:Matrix = new Matrix();
      
      private static const STATUS_HIDDEN:int = 0;
      
      private static const STATUS_PREPARED:int = 1;
      
      private static const STATUS_VISIBLE:int = 2;
      
      {
         icons[0] = iconHealth;
         icons[1] = iconArmor;
         icons[2] = iconPower;
         icons[3] = iconNitro;
      }
      
      private var _effectId:int;
      
      private var icon:BitmapData;
      
      private var warningTime:int;
      
      private var colorTransform:ColorTransform;
      
      private var endTime:int;
      
      private var alpha:Number = 1;
      
      private var needRedraw:Boolean;
      
      private var x:int;
      
      private var y:int;
      
      private var userTitle:alternativa.tanks.tank.title.UserTitle;
      
      private var visibilityStatus:int = 0;
      
      private var playingWarning:Boolean;
      
      private var blinker:alternativa.tanks.tank.title.Blinker;
      
      public function EffectIndicator(param1:int, param2:int, param3:alternativa.tanks.tank.title.UserTitle)
      {
         this.colorTransform = new ColorTransform();
         this.blinker = new alternativa.tanks.tank.title.Blinker(300,10,20,0.2,1,10);
         super();
         this._effectId = param1;
         this.icon = icons[param1];
         this.warningTime = param2;
         this.userTitle = param3;
      }
      
      public function get effectId() : int
      {
         return this._effectId;
      }
      
      public function isHidden() : Boolean
      {
         return this.visibilityStatus == STATUS_HIDDEN;
      }
      
      public function show(param1:int) : void
      {
         if(this.visibilityStatus != STATUS_VISIBLE || this.alpha != 1)
         {
            this.needRedraw = true;
         }
         this.endTime = getTimer() + param1;
         if(this.visibilityStatus == STATUS_HIDDEN)
         {
            this.visibilityStatus = STATUS_PREPARED;
         }
         this.playingWarning = false;
         this.colorTransform.alphaMultiplier = 1;
         this.alpha = 1;
      }
      
      public function hide() : void
      {
         if(this.visibilityStatus == STATUS_HIDDEN)
         {
            return;
         }
         this.visibilityStatus = STATUS_HIDDEN;
         this.colorTransform.alphaMultiplier = 1;
      }
      
      public function clear(param1:BitmapData) : void
      {
         if(this.visibilityStatus != STATUS_VISIBLE)
         {
            return;
         }
         rect.x = this.x;
         rect.y = this.y;
         param1.fillRect(rect,0);
      }
      
      public function setPosition(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
         this.needRedraw = true;
      }
      
      public function forceRedraw() : void
      {
         this.needRedraw = true;
      }
      
      public function update(param1:int, param2:int, param3:BitmapData) : void
      {
         if(this.visibilityStatus == STATUS_HIDDEN)
         {
            return;
         }
         var _loc4_:int = this.endTime - param1;
         if(this.needRedraw)
         {
            this.draw(param3);
            this.needRedraw = false;
         }
         if(_loc4_ < this.warningTime)
         {
            if(_loc4_ < 0)
            {
               this.userTitle.hideIndicator(this._effectId);
               return;
            }
            this.updateWarningAnimation(param1,param2,param3);
         }
         if(this.visibilityStatus == STATUS_PREPARED)
         {
            this.visibilityStatus = STATUS_VISIBLE;
         }
      }
      
      private function updateWarningAnimation(param1:int, param2:int, param3:BitmapData) : void
      {
         var _loc4_:Number = NaN;
         if(this.playingWarning)
         {
            _loc4_ = this.blinker.updateValue(param1,param2);
            if(_loc4_ != this.alpha)
            {
               this.alpha = _loc4_;
               this.colorTransform.alphaMultiplier = this.alpha;
               this.draw(param3);
            }
         }
         else
         {
            this.blinker.init(param1);
            this.playingWarning = true;
         }
      }
      
      private function draw(param1:BitmapData) : void
      {
         this.clear(param1);
         matrix.tx = this.x;
         matrix.ty = this.y;
         param1.draw(this.icon,matrix,this.colorTransform,null,null,true);
      }
   }
}
