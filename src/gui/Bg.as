package gui
{
   import flash.display.Sprite;
   import flash.display.Bitmap;
   
   public class Bg extends Sprite
   {
      [Embed(source = "fon.png")]

      private var fon:Class;
      
      private var bg:Bitmap;
      
      private var c:Array;
      
      public function Bg():void {
			for (var x:int = 0; x < 4000; x += bg.width) {
				addChild(bg = new fon());
				bg.x = x;
				for (var y:int = 0; y < 4000; y += bg.height) {
					addChild(bg = new fon());
					bg.x = x;
					bg.y = y;
				}
			}
	  }
   }
}