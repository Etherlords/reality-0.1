package core.view.gameobject.physicalpropeties 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class PhysicModel 
	{
		private var _density:Number;
		private var _friction:Number;
		private var _restitution:Number;
		
		private var _fixedRotation:Boolean;
		
		private var _linearVelocity:Point
		private var b2Velocity:b2Vec2;
		
		private var body:b2Body;
		
		private var initilized:Boolean
		
		/**
		 * 
		 * @param	density - плотность указывается в кг/m^2(двумерное тело), если указано 0 то будет выставлятся из разчета шейпа
		 * @param	friction - коофициент трения указывается в диапозоне 0.0-1.0
		 * @param	restitution - коофициент эластичности тела указывается в диапозоне 0.0-1.0
		 */
		public function PhysicModel(density:Number = 0, friction:Number = 0, restitution:Number = 0) 
		{
			this._restitution = restitution;
			this._friction = friction;
			this._density = density;
			
			//trace('reset mass data', _density, restitution,friction);
			
			initilize();
			
			
		}
		
		/**
		 * Устанавливает боди модели, после этого объект становится прокси между боди и внешней средой
		 * 
		 * @param	body
		 */
		public function setBody(body:b2Body):void
		{
			
			this.body = body;
			initilized = true;
			
			
			density = _density;
			fixedRotation = _fixedRotation;
			body.ResetMassData();
		}
		
		private function initilize():void 
		{
			_linearVelocity = new Point();
			b2Velocity = new b2Vec2();
		}
		
		public function set fixedRotation(value:Boolean):void
		{
			_fixedRotation = value;
			
			
			if(initilized)
				this.body.SetFixedRotation(_fixedRotation);
		}
		
		public function set linearVelocity(value:Point):void
		{
			_linearVelocity = value;
			
			if (initilized)
			{
				
				b2Velocity.x = _linearVelocity.x;
				b2Velocity.y = _linearVelocity.y;
				
				body.SetLinearVelocity(b2Velocity);
			}
		}
		
		/**
		 * Линейное ускорение задаваемое поинтом
		 * P.S чтобы задать ускорение телу нужно обязательно засетить поинт этим методом
		 * изменения поинта полученого этим методом не приведет к изменеию скорости
		 */
		public function get linearVelocity():Point
		{
			if (initilized)
			{
				b2Velocity = body.GetLinearVelocity();
				_linearVelocity.x = b2Velocity.x;
				_linearVelocity.y = b2Velocity.y;
			}
			
			return _linearVelocity;
		}
		
		/**
		 * плотность указывается в кг/m^2(двумерное тело), если указано 0 то будет выставлятся из разчета шейпа
		 */
		public function get density():Number 
		{
			return _density;
		}
		
		public function set density(value:Number):void 
		{
			/**
			 * Будем считать что больше никто не может изменить напрямую это значение в боди
			 * только через этот объект
			 */
			_density = value;
			
			if (initilized)
			{
				body.GetFixtureList().SetDensity(_density);
				body.ResetMassData();
				
				
			}
		}
		
		/**
		 * коофициент трения указывается в диапозоне 0.0-1.0
		 */
		public function get friction():Number 
		{
			return _friction;
		}
		
		public function set friction(value:Number):void 
		{
			_friction = value;
			
			body.GetFixtureList().SetFriction(_friction);
		}
		
		/**
		 * коофициент эластичности тела указывается в диапозоне 0.0-1.0
		 */
		public function get restitution():Number 
		{
			return _restitution;
		}
		
		public function set restitution(value:Number):void 
		{
			_restitution = value;
			body.GetFixtureList().SetRestitution(_restitution)
		}
		
	}

}