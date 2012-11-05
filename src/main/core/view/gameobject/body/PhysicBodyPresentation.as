package core.view.gameobject.body 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import core.GlobalConstants;
	import core.locators.PhysicWorldLocator;
	import core.view.skin.Skin;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class PhysicBodyPresentation implements IBodyPresentation 
	{
		public var body:b2Body;
		
		public var _position:b2Vec2;
		public var skin:Skin;
		
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
		 * 
		 * Таким образом будет синхронизация между физическим телом и графикой
		 */
		public function preRender():void
		{
			/**
			 * TODO: нужно будет ввести отслеживание слипа и вейка для того чтобы не вызывать лишний раз обновление координат тела
			 * А так же нужно сделатьопределение выхода за экран чтобы тоже останавливать анимацию и изменение координат тела
			 */
			//if(!body.IsAwake())
			//	return;
				
			updatePosition();
		}
		
		/**
		 * Функция рендера т.е исходя из модели отображаем реальный объект как надо
		 * трансформируем его меняем координаты и тд
		 */
		public function render():void
		{
			//if(!body.IsAwake())
			//	return;
			
			skin.x = x;
			skin.y = y;
			//skin.z = z;
			
			skin.rotation = body.GetTransform().GetAngle() //* GlobalConstants.RAD_TO_DEGREE;
		}
		
		public function get rotation():Number
		{
			return body.GetTransform().GetAngle() * GlobalConstants.RAD_TO_DEGREE;
		}
		
		public function set rotation(value:Number):void
		{
			body.SetAngle((value - 180) * GlobalConstants.DEGREE_TO_RAD);
		}
		
		/**
		 * Деструктор, тут будем удалять боди из физического мира
		 * и удалять все возможные связи какие можем
		 * 
		 * Несмотря на это каике то связи в некоторых случаях остаются
		 * и часть объектов остается в памяти
		 */
		public function destroy():void
		{
			PhysicWorldLocator.instance.world.DestroyBody(body);
			
			this.body = null;
			this.skin = null;
			this._position = null;
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
		
		public function get z():Number
		{
			//return skin.z
			return 0
		}
		
		public function set z(value:Number):void 
		{
			//skin.z = value;
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
			return skin.phsyWidth;
		}
		
		public function set width(value:Number):void 
		{
			//_width = value;
		}
		
		public function get height():Number 
		{
			return skin.phsyHeight;
		}
		
		public function set height(value:Number):void 
		{
			//_height = value;
		}
		
		private function initilize():void 
		{
			_position = body.GetPosition();
		}
		
		//var f:Boolean;
		
		private function updatePosition():void
		{
			
			//if(!f)
				body.SetPosition(_position);
				
		}
	}

}