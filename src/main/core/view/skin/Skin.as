package core.view.skin 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	/**
	 * Реализация графики объекта может состоять из многих частей или из одного сплошноо спрайта по сути
	 * 
	 * Т.е мы можем в наследнике этого объекта(конечно можно изъебатся и сделать все универсально тут) сделать управление составным спрайтом сосотоящим из головы и тела например
	 * и он будет знать когда проиграть какую анмиацию головы, тела, ног, рук.
	 * Или же спрайт состоит из одного анимационного спрайта соответственно
	 * @author 
	 */
	public class Skin extends Sprite 
	{
		protected var shape:Shape;
		protected var _graphics:Graphics;
		protected var texture:Texture;
		protected var image:Image;
		
		public function Skin() 
		{
			super();
			shape = new Shape();
		
			
		}
		
		public function redrawGraphics():void
		{
			var bounds:Rectangle = getShapeBounds();
			
			var bitmapSource:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0x0);
			var m:Matrix = new Matrix();
			m.tx = bounds.x;
			m.ty = bounds.y;
			
			bitmapSource.draw(shape, m);
			
			texture = Texture.fromBitmapData(bitmapSource, true, true);
		}
		
		protected function getShapeBounds():Rectangle
		{
			var bounds:Rectangle = shape.getBounds(shape)
			bounds.x = Math.abs(bounds.x);
			bounds.y = Math.abs(bounds.y);
			
			bounds.width = bounds.width + bounds.x;
			if (bounds.width < 1)
				bounds.width = 1;
			
			if (bounds.height < 1)
				bounds.height = 1;
				
			bounds.height = bounds.height + bounds.y;
			
			return bounds;
		}
		
		public function prepareSkin():void
		{
			redrawGraphics();
			
			prepareImage();
			
			
			addChild(image);
		}
		
		protected function prepareImage():void 
		{
			if (image)
			{
				image.texture = texture;
			}
			else
			{
				image = new Image(texture);
			}
				
			
			image.smoothing = TextureSmoothing.NONE;
		}
		
		public function doAction(actionKey:uint, additionalParam:Number = 0):void
		{
			
		}

        public function get phsyWidth():Number {
            return shape.width;
        }

        public function get phsyHeight():Number {
            return shape.height;
        }
		
		public function get graphics():Graphics 
		{
			return shape.graphics;
		}
		
	}

}