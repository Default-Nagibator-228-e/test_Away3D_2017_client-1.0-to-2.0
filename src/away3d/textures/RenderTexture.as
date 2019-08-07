package away3d.textures
{
	import away3d.arcane;
	import away3d.materials.utils.MipmapGenerator;
	import away3d.tools.utils.TextureUtils;
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.TextureBase;
	
	use namespace arcane;
	
	public class RenderTexture extends Texture2DBase
	{
		
		private var bmp:BitmapData = new BitmapData(1, 1, false, 0xff0000);
		
		public function RenderTexture(width:Number, height:Number)
		{
			super();
			setSize(width, height);
			var s:Number = Math.max(width / bmp.width , height / bmp.height);
			var mat:Matrix = new Matrix();
			mat.scale(s, s);
			var w:Number = s * bmp.width;
			var h:Number = s * bmp.height;
			var param4:BitmapData = new BitmapData(w, h, false, 0);
			param4.draw(bmp, mat, null, null, null, true);
			bmp = param4;
		}
		
		public function set width(value:int):void
		{
			if (value == _width)
				return;
			
			if (!TextureUtils.isDimensionValid(value))
				throw new Error("Invalid size: Width and height must be power of 2 and cannot exceed 2048");
			
			invalidateContent();
			setSize(value, _height);
			var s:Number = Math.max(value / bmp.width , 1);
			var mat:Matrix = new Matrix();
			mat.scale(s, s);
			var w:Number = s * bmp.width;
			var h:Number = s * bmp.height;
			var param4:BitmapData = new BitmapData(w, h, false, 0);
			param4.draw(bmp, mat, null, null, null, true);
			bmp = param4;
		}
		
		public function set height(value:int):void
		{
			if (value == _height)
				return;
			
			if (!TextureUtils.isDimensionValid(value))
				throw new Error("Invalid size: Width and height must be power of 2 and cannot exceed 2048");
			
			invalidateContent();
			setSize(_width, value);
			var s:Number = Math.max(1 , value / bmp.height);
			var mat:Matrix = new Matrix();
			mat.scale(s, s);
			var w:Number = s * bmp.width;
			var h:Number = s * bmp.height;
			var param4:BitmapData = new BitmapData(w, h, false, 0);
			param4.draw(bmp, mat, null, null, null, true);
			bmp = param4;
		}
		
		override protected function uploadContent(texture:TextureBase):void
		{
			// fake data, to complete texture for sampling
			MipmapGenerator.generateMipMaps(bmp, texture);
			//var bk:Bitmap = new Bitmap(bmp);
			//bk.smoothing = true;
			//bmp = bk.bitmapData;
			bmp.dispose();
		}
		
		override protected function createTexture(context:Context3D):TextureBase
		{
			return context.createTexture(width, height, Context3DTextureFormat.BGRA, true);
		}
	}
}
