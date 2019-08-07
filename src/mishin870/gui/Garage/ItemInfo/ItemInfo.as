package mishin870.gui.Garage.ItemInfo
{
   import mishin870.gui.ScrollingSpriteGarage;
   import controls.Label;
   import flash.text.TextFieldAutoSize;
   import flash.text.StyleSheet;
   
   public class ItemInfo extends ScrollingSpriteGarage
   {
       
      public var tf:Label;
      
      public var tf2:Label;
      
      private var _wid:Number;
      
      public function ItemInfo()
      {
         this.tf = new Label();
         this.tf2 = new Label();
         super();
         this.tf.textColor = 4278635288;
         this.tf.autoSize = TextFieldAutoSize.LEFT;
         addChild(this.tf);
         var _loc1_:StyleSheet = new StyleSheet();
         var _loc2_:Object = new Object();
         _loc2_.fontSize = 20;
         _loc2_.textColor = 4278636824;
         _loc2_.fontName = "Arial";
         _loc1_.setStyle(".o",_loc2_);
         this.tf.styleSheet = _loc1_;
         this.tf2.textColor = 4278635288;
         this.tf2.autoSize = TextFieldAutoSize.LEFT;
         this.tf2.wordWrap = true;
         addChild(this.tf2);
         this.tf2.styleSheet = _loc1_;
         this.tf.y = 5;
         this.tf2.y = 30;
      }
      
      private function refreshAWH() : void
      {
         var _loc1_:Number = this.tf2.y + this.tf2.height + 10;
         setAWH(scrollRect.width,_loc1_);
         this.tf2.x = 170;
         this.tf2.width = this._wid - this.tf2.x - 5;
      }
      
      public function setDescription(param1:String, param2:String) : void
      {
         try
         {
            this.tf2.multiline = true;
            this.tf.htmlText = param1;
            this.tf2.text = param2;
            this.tf2.x = 170;
            this.tf2.width = this._wid - this.tf2.x - 5;
            this.refreshAWH();
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      public function set wid(param1:Number) : void
      {
         this._wid = param1;
         this.refreshAWH();
      }
   }
}
