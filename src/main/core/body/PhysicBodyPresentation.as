package core.body 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import core.GlobalConstants;
	import core.view.skin.Skin;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class PhysicBodyPresentation implements IBodyPresentation 
	{
		private var body:b2Body;
		
		private var _position:b2Vec2;
		private var skin:Skin;
		
		public function PhysicBodyPresentation(body:b2Body, skin:Skin) 
		{
			this.skin = skin;
			this.body = body;
			
			initilize();
		}
		
		/**
		 * Функция пре рендера служит для коммита значений в движок
		 * например установленные x, y за итерацию устанавливаютеся физической модели
		 * после чего происходит рендер в физическом мире и пересчет координат и тд.
		 */
		public function preRender():void
		{
			updatePosition();
		}
		
		/**
		 * Функция рендера т.е исходя из модели отображаем реальный объект как надо
		 * трансформируем его меняем координаты и тд
		 */
		public function render():void
		{
			skin.x = x;
			skin.y = y;
		}
		
		public function destroy():void
		{
			
		}
		
		/* INTERFACE core.body.IBodyPresentation */
		
		public function get x():Number
		{
			return position.x;
		}
		
		public function set x(value:Number):void 
		{
			_position.Set(value * GlobalConstants.PIXELS_TO_METR, _position.y);
		}
		
		public function get y():Number
		{
			return position.y;
		}
		
		public function set y(value:Number):void 
		{
			_position.Set(_position.x, value * GlobalConstants.PIXELS_TO_METR);
		}
		
		public function get position():Point
		{
			var realPoint:b2Vec2 = _position.Copy();
			realPoint.Multiply(GlobalConstants.METRS_TO_PIXEL);
			
			return new Point(realPoint.x, realPoint.y);
		}
		
		public function set position(value:Point):void 
		{
			var realPoint:b2Vec2 = new b2Vec2(value.x * GlobalConstants.PIXELS_TO_METR, value.y * GlobalConstants.PIXELS_TO_METR);
			
			body.SetPosition(realPoint);
		}
		
		public function get width():Number 
		{
			return 0;
		}
		
		public function set width(value:Number):void 
		{
			//_width = value;
		}
		
		public function get height():Number 
		{
			return 0;
		}
		
		public function set height(value:Number):void 
		{
			//_height = value;
		}
		
		private function initilize():void 
		{
			_position = body.GetPosition();
		}
		
		private function updatePosition():void
		{
			body.SetPosition(_position);
		}
	}

}