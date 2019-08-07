package alternativa.tanks.tank.title
{
   import away3d.containers.ObjectContainer3D;
   import away3d.entities.Sprite3D;
   import away3d.materials.TextureMaterial;
   import away3d.utils.Cast;
   import flash.display.StageQuality;
   import flash.geom.Matrix;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.display.BitmapData;
   import flash.text.TextField;
   import alternativa.tanks.tank.BattleTeamType;
   import mishin870.gui.rang.RangSmall;
   import flash.geom.Vector3D;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class UserTitle
   {
      
      private static const matrix:Matrix = new Matrix();
      
      private static const EFFECT_WARNING_TIME:int = 3000;
      
      private static const RANK_ICON_SIZE:int = 13;
      
      private static const LABEL_HEIGHT:int = 13;
      
      private static const RANK_ICON_OFFSET_Y:int = 0;
      
      private static const EFFECTS_ICON_SIZE:int = 16;
      
      private static const LABEL_SPACING:int = 0;
      
      private static const HEALTH_BAR_SPACING_Y:int = 2;
      
      private static const WEAPON_BAR_SPACING_Y:int = -1;
      
      private static const EFFECTS_SPACING_Y:int = 4;
      
      private static const EFFECTS_SPACING_X:int = 4;
      
      private static const BAR_WIDTH:int = 100;
      
      private static const BAR_HEIGHT:int = 8;
      
      private static const TEXTURE_MARGIN:int = 3;
      
      private static const TEXTURE_MARGIN_2:int = 2 * TEXTURE_MARGIN;
      
      private static var filter:GlowFilter = new GlowFilter(0,0.8,4,4,3);
      
      public static const BIT_LABEL:int = 1;
      
      public static const BIT_HEALTH:int = 2;
      
      public static const BIT_WEAPON:int = 4;
      
      public static const BIT_EFFECTS:int = 8;
      
      private static const TRANSITION_PERIOD:int = 300;
       
      public var MAX_HEALTH:int = 30;
      
      private var configFlags:int;
      
      private var dirtyFlags:int;
      
      public var sprite:Sprite3D;
      
      private var textureRect:Rectangle;
      
      public var rankIcon:BitmapData;
      
      private var label:TextField;
      
      private var healthBar:ProgressBar;
      
      private var weaponBar:ProgressBar;
      
      private var effectIndicators:Vector.<EffectIndicator>;
      
      private var numVisibleIndicators:int;
      
      private var effectIndicatorsY:int;
      
      private var rankId:int = 1;
      
      private var labelText:String;
      
      private var health:int;
      
      private var weaponStatus:int;
      
      private var indicatorsNumberChanged:Boolean;
      
      private var teamType:BattleTeamType = BattleTeamType.NONE;
      
      private var skin:ProgressBarSkin = ProgressBarSkin.HEALTHBAR_DM;
      
      private var hidden:Boolean;
      
      private var transitionTime:int;
      
      public var textu:BitmapData = new BitmapData(256,256,true,0);
      
      private var textuAlpha:Number = 1;
      
      public function UserTitle()
      {
         super();
         this.sprite = new Sprite3D(new TextureMaterial(Cast.bitmapTexture(this.textu)),100,100);
         //this.sprite.perspectiveScale = false;
         //var _loc1_:RangSmall = new RangSmall(this.rankId);
         var _loc2_:BitmapData = new BitmapData(256, 256, true, 16777215);
         _loc2_.draw(new RangSmall(this.rankId), null, null, null, null, true);
         this.rankIcon = _loc2_;
      }
      
      public function hide() : void
      {
         if(this.hidden)
         {
            return;
         }
         this.hidden = true;
         this.initTransition();
      }
      
      public function show() : void
      {
         if(!this.hidden)
         {
            return;
         }
         this.hidden = false;
         this.initTransition();
      }
      
      public function setConfiguration(param1:int) : void
      {
         if(this.configFlags == param1)
         {
            return;
         }
         this.configFlags = param1;
         this.updateConfiguration();
      }
      
      public function setTeamType(param1:BattleTeamType) : void
      {
         var _loc2_:int = 0;
         if(this.teamType == param1)
         {
            return;
         }
         this.teamType = param1;
         this.skin = ProgressBarSkin.HEALTHBAR_DM;
         switch(param1)
         {
            case BattleTeamType.RED:
               this.skin = ProgressBarSkin.HEALTHBAR_RED;
               break;
            case BattleTeamType.BLUE:
               this.skin = ProgressBarSkin.HEALTHBAR_BLUE;
               break;
            case BattleTeamType.GREEN:
               this.skin = ProgressBarSkin.HEALTHBAR_DM;
         }
         for each(_loc2_ in [BIT_LABEL,BIT_HEALTH,BIT_WEAPON])
         {
            if(this.hasOption(_loc2_))
            {
               this.markDirty(_loc2_);
            }
         }
      }
      
      public function setRank(param1:int) : void
      {
         if(this.rankId == param1)
         {
            return;
         }
         this.rankId = param1;
         var _loc2_:RangSmall = new RangSmall(param1);
         var _loc3_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,16777215);
         _loc3_.draw(_loc2_);
         this.rankIcon = _loc3_;
         if(this.hasOption(BIT_LABEL))
         {
            this.markDirty(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
         }
      }
      
      public function setLabelText(param1:String) : void
      {
         if(this.labelText == param1)
         {
            return;
         }
         this.labelText = param1;
         if(this.hasOption(BIT_LABEL))
         {
            this.updateConfiguration();
            this.markDirty(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
         }
      }
      
      public function setHealth(param1:int) : void
      {
         if(this.health == param1)
         {
            return;
         }
         this.health = param1;
         if(this.hasOption(BIT_HEALTH))
         {
            this.markDirty(BIT_HEALTH);
         }
      }
      
      public function setWeaponStatus(param1:int) : void
      {
         if(this.weaponStatus == param1)
         {
            return;
         }
         this.weaponStatus = param1;
         if(this.hasOption(BIT_WEAPON))
         {
            this.markDirty(BIT_WEAPON);
         }
      }
      
      public function showIndicator(param1:int, param2:int) : void
      {
         if(!this.hasOption(BIT_EFFECTS))
         {
            return;
         }
         var _loc3_:EffectIndicator = this.getEffectIndicatorById(param1);
         if(_loc3_ != null)
         {
            if(_loc3_.isHidden())
            {
               this.changeVisibleIndicatorsNumber(1);
            }
            _loc3_.show(param2);
         }
      }
      
      public function hideIndicator(param1:int) : void
      {
         if(!this.hasOption(BIT_EFFECTS))
         {
            return;
         }
         var _loc2_:EffectIndicator = this.getEffectIndicatorById(param1);
         if(_loc2_ != null)
         {
            if(!_loc2_.isHidden())
            {
               _loc2_.clear(this.textu);
               this.changeVisibleIndicatorsNumber(-1);
            }
            _loc2_.hide();
         }
      }
      
      public function update(param1:int, param2:int) : void
      {
         var _loc3_:EffectIndicator = null;
         this.processTransition(param1);
         if(this.dirtyFlags != 0)
         {
            if(this.isDirtyAndHasOption(BIT_LABEL))
            {
               this.updateLabel();
            }
            if(this.isDirtyAndHasOption(BIT_HEALTH))
            {
               this.healthBar.setSkin(this.skin);
               this.healthBar.progress = this.health;
               this.healthBar.draw(this.textu);
            }
            if(this.isDirtyAndHasOption(BIT_WEAPON))
            {
               this.weaponBar.progress = this.weaponStatus;
               this.weaponBar.draw(this.textu);
            }
            if(this.isDirtyAndHasOption(BIT_EFFECTS))
            {
               for each(_loc3_ in this.effectIndicators)
               {
                  _loc3_.forceRedraw();
               }
            }
            this.dirtyFlags = 0;
         }
         if(this.hasOption(BIT_EFFECTS))
         {
            this.updateEffectIndicators(param1,param2);
         }
         this.sprite.width = this.textu.width;
         this.sprite.height = this.textu.height;
         (this.sprite.material as TextureMaterial).texture = Cast.bitmapTexture(this.textu);
		 (this.sprite.material as TextureMaterial).alphaBlending = true;
      }
      
      private function isDirtyAndHasOption(param1:int) : Boolean
      {
         return (this.dirtyFlags & param1) != 0 && (this.configFlags & param1) != 0;
      }
      
      private function updateEffectIndicators(param1:int, param2:int) : void
      {
         var _loc3_:EffectIndicator = null;
         var _loc4_:int = 0;
         var _loc6_:* = 0;
         var _loc5_:int = this.effectIndicators.length;
         if(this.indicatorsNumberChanged)
         {
            this.indicatorsNumberChanged = false;
            _loc6_ = this.textureRect.width + TEXTURE_MARGIN_2 - this.numVisibleIndicators * EFFECTS_ICON_SIZE - (this.numVisibleIndicators - 1) * EFFECTS_SPACING_X >> 1;
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc3_ = this.effectIndicators[_loc4_];
               _loc3_.clear(this.textu);
               if(!_loc3_.isHidden())
               {
                  _loc3_.setPosition(_loc6_,this.effectIndicatorsY);
                  _loc6_ = int(_loc6_ + (EFFECTS_ICON_SIZE + EFFECTS_SPACING_X));
               }
               _loc4_++;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = this.effectIndicators[_loc4_];
            _loc3_.update(param1,param2,this.textu);
            _loc4_++;
         }
      }
      
      private function changeVisibleIndicatorsNumber(param1:int) : void
      {
         this.numVisibleIndicators = this.numVisibleIndicators + param1;
         this.indicatorsNumberChanged = true;
      }
      
      private function updateConfiguration() : void
      {
         if(this.configFlags == 0)
         {
            return;
         }
         this.setupTexture();
         this.setupComponents();
      }
      
      private function setupTexture() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.hasOption(BIT_LABEL))
         {
            if(this.label == null)
            {
               this.createLabelComponents();
            }
            this.label.text = this.labelText == null?"":this.labelText;
            _loc1_ = RANK_ICON_SIZE + LABEL_SPACING + this.label.textWidth;
            _loc2_ = LABEL_HEIGHT;
         }
         if(this.hasOption(BIT_HEALTH))
         {
            if(_loc1_ < BAR_WIDTH)
            {
               _loc1_ = BAR_WIDTH;
            }
            if(_loc2_ > 0)
            {
               _loc2_ = _loc2_ + HEALTH_BAR_SPACING_Y;
            }
            _loc2_ = _loc2_ + BAR_HEIGHT;
            if(this.hasOption(BIT_WEAPON))
            {
               _loc2_ = _loc2_ + (WEAPON_BAR_SPACING_Y + BAR_HEIGHT);
            }
         }
         if(this.hasOption(BIT_EFFECTS))
         {
            _loc3_ = 3 * EFFECTS_ICON_SIZE + 2 * EFFECTS_SPACING_X;
            if(_loc1_ < _loc3_)
            {
               _loc1_ = _loc3_;
            }
            if(_loc2_ > 0)
            {
               _loc2_ = _loc2_ + EFFECTS_SPACING_Y;
            }
            _loc2_ = _loc2_ + EFFECTS_ICON_SIZE;
         }
         _loc1_ = _loc1_ + 2 * TEXTURE_MARGIN;
         _loc2_ = _loc2_ + 2 * TEXTURE_MARGIN;
         if(this.textu == null || this.textu.width != _loc1_ || this.textu.height != _loc2_)
         {
            this.textu = new BitmapData(256,256,true,0);
            this.textureRect = this.textu.rect;
            this.markDirty(BIT_LABEL | BIT_HEALTH | BIT_WEAPON | BIT_EFFECTS);
         }
      }
      
      private function setupComponents() : void
      {
         var _loc2_:* = 0;
         var _loc1_:int = TEXTURE_MARGIN;
         if(this.hasOption(BIT_LABEL))
         {
            _loc1_ = _loc1_ + LABEL_HEIGHT;
         }
         if(this.hasOption(BIT_HEALTH))
         {
            if(this.hasOption(BIT_LABEL))
            {
               _loc1_ = _loc1_ + HEALTH_BAR_SPACING_Y;
            }
            _loc2_ = this.textureRect.width - BAR_WIDTH >> 1;
            this.healthBar = new ProgressBar(_loc2_,_loc1_,this.MAX_HEALTH,BAR_WIDTH,this.skin);
            _loc1_ = _loc1_ + BAR_HEIGHT;
            if(this.hasOption(BIT_WEAPON))
            {
               _loc1_ = _loc1_ + WEAPON_BAR_SPACING_Y;
               this.weaponBar = new ProgressBar(_loc2_,_loc1_,100,BAR_WIDTH,ProgressBarSkin.WEAPONBAR);
               _loc1_ = _loc1_ + BAR_HEIGHT;
            }
            _loc1_ = _loc1_ + EFFECTS_SPACING_Y;
         }
         if(this.hasOption(BIT_EFFECTS))
         {
            this.effectIndicatorsY = _loc1_;
            this.createEffectsIndicators();
         }
      }
      
      public function get filterBlur() : int
      {
         return filter.blurX;
      }
      
      public function set filterBlur(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         param1 = 0;
         filter.blurX = filter.blurY = param1;
      }
      
      public function get filterAlpha() : Number
      {
         return filter.alpha;
      }
      
      public function set filterAlpha(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > 1)
         {
            param1 = 1;
         }
         param1 = 0;
         filter.alpha = param1;
      }
      
      public function get filterStrength() : int
      {
         return filter.strength;
      }
      
      public function set filterStrength(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > 255)
         {
            param1 = 255;
         }
         param1 = 0;
         filter.strength = param1;
      }
      
      public function addToContainer(param1:ObjectContainer3D) : void
      {
         param1.addChild(this.sprite);
      }
      
      public function removeFromContainer() : void
      {
         this.sprite.parent.removeChild(this.sprite);
      }
      
      public function setPosition(param1:Vector3D) : void
      {
         this.sprite.transform.position = param1;
      }
      
      private function markDirty(param1:int) : void
      {
         this.dirtyFlags = this.dirtyFlags | param1;
      }
      
      private function hasOption(param1:int) : Boolean
      {
         return (param1 & this.configFlags) != 0;
      }
      
      private function createLabelComponents() : void
      {
         if(this.rankIcon == null)
         {
            this.rankIcon = new BitmapData(RANK_ICON_SIZE,RANK_ICON_SIZE,false,16711680);
         }
         if(this.label == null)
         {
            this.label = new TextField();
            this.label.autoSize = TextFieldAutoSize.LEFT;
            this.label.defaultTextFormat = new TextFormat("Tahoma",12,16777215,true);
         }
      }
      
      private function updateLabel() : void
      {
         var _loc1_:BitmapData = this.textu.clone();
         _loc1_.fillRect(this.textureRect,0);
         var _loc2_:int = RANK_ICON_SIZE + LABEL_SPACING + this.label.textWidth;
         var _loc3_:* = _loc1_.width - _loc2_ >> 1;
         matrix.tx = _loc3_;
         matrix.ty = TEXTURE_MARGIN + RANK_ICON_OFFSET_Y;
         _loc1_.draw(this.rankIcon,matrix,null,null,null,true);
         matrix.tx = _loc3_ + RANK_ICON_SIZE + LABEL_SPACING;
         matrix.ty = 0;
         this.label.textColor = this.skin.color;
         _loc1_.draw(this.label,matrix,null,null,null,true);
         this.textu.applyFilter(_loc1_,this.textureRect,new Point(),filter);
         _loc1_.dispose();
      }
      
      private function createEffectsIndicators() : void
      {
         if(this.effectIndicators != null)
         {
            return;
         }
         this.effectIndicators = new Vector.<EffectIndicator>();
         this.effectIndicators.push(new EffectIndicator(0,EFFECT_WARNING_TIME,this));
         this.effectIndicators.push(new EffectIndicator(1,EFFECT_WARNING_TIME,this));
         this.effectIndicators.push(new EffectIndicator(2,EFFECT_WARNING_TIME,this));
         this.effectIndicators.push(new EffectIndicator(3,EFFECT_WARNING_TIME,this));
      }
      
      private function getEffectIndicatorById(param1:int) : EffectIndicator
      {
         var _loc4_:EffectIndicator = null;
         if(this.effectIndicators == null)
         {
            return null;
         }
         var _loc2_:int = this.effectIndicators.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.effectIndicators[_loc3_];
            if(_loc4_.effectId == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      private function processTransition(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         if(this.transitionTime > 0)
         {
            _loc2_ = this.transitionTime - param1;
            if(_loc2_ < 0)
            {
               _loc3_ = 1;
               this.transitionTime = 0;
            }
            else
            {
               _loc3_ = 1 - _loc2_ / TRANSITION_PERIOD;
            }
            if(this.hidden)
            {
               _loc3_ = 1 - _loc3_;
               if(_loc3_ == 0)
               {
                  this.sprite.visible = false;
               }
            }
            else if(!this.sprite.visible)
            {
               this.sprite.visible = true;
            }
            this.textuAlpha = _loc3_;
         }
      }
      
      private function initTransition() : void
      {
         this.transitionTime = getTimer() + TRANSITION_PERIOD - this.transitionTime;
      }
   }
}
