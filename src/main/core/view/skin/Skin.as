package core.view.skin 
{
	import core.view.direction.Direction;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
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
		public var direction:Direction;
		
		
		public function Skin() 
		{
			super();
			shape = new Shape();
		}
		
		public function prepareSkin():void
		{
			var bm:BitmapData = new BitmapData(shape.width, shape.height, true);
			bm.draw(shape);
			
			texture = Texture.fromBitmapData(bm, true, true);
			image = new Image(texture);
			image.smoothing = TextureSmoothing.NONE;
			addChild(image);
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