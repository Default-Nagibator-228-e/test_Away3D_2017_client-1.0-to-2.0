package mishin870.gui.Garage
{
   import controls.BigButton;
   import flash.display.Bitmap;
   import mishin870.gui.rang.RangSmall;
   import controls.Label;
   
   public class GarageButton extends BigButton
   {
      
      [Embed(source="GarageButton/c.png")] private var cClass:Class;
       
      private var c:Bitmap = new cClass();
      
      private var rang:RangSmall = new RangSmall(1);
      
      private var text1:Label = new Label();
      
      private var text2:Label = new Label();
      
      public function GarageButton()
      {
         super();
         addChild(this.text1);
         addChild(this.text2);
         addChild(this.c);
         addChild(this.rang);
      }
      
      public function setText(param1:String, param2:String, param3:int = 0, param4:int = -1, param5:int = 0) : void
      {
         this.text1.text = param1;
         this.text2.htmlText = param2;
         if(param4 != -1)
         {
            this.rang.setRank(param4 + 1);
            this.refreshPos(param3,param5);
         }
         else
         {
            this.refreshPos(param3);
         }
      }
      
      private function refreshPos(param1:int = 0, param2:int = -1) : void
      {
         this.text1.x = width / 2 - this.text1.width / 2;
         this.text2.x = width / 2 - this.text2.width / 2;
         this.text1.y = height / 2 - this.text1.height;
         this.text2.y = height / 2;
         this.c.y = int(height / 2) + 3;
         this.c.x = this.text2.x + param1;
         if(param2 != -1)
         {
            this.rang.visible = true;
            this.rang.y = int(height / 2) + 3;
            this.rang.x = this.text2.x + param2;
         }
         else
         {
            this.rang.visible = false;
         }
      }
   }
}
