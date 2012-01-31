package core.view.gameobject 
{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;

import core.Box2D.utils.BodyConstructor;
import core.Box2D.utils.PhysicBodyConstructor;
import core.body.PhysicBodyPresentation;
import core.view.gameobject.config.GameobjectConfig;
	import core.view.skin.Skin;

	public class GameObject 
	{
		
		protected var skin:Skin;
		
		protected var body:b2Body
		
		protected var _physicalProperties:PhysicalProperties
		protected var _dimensionalProperties:DimensionalProperties;
		
		private var shape:b2Shape;
		private var fixtureModel:b2FixtureDef;
		private var bodyModel:b2BodyDef;
		
		private var config:GameobjectConfig;

        private var _physicConstructor:BodyConstructor;

		public function GameObject(aPhysicConstructor:BodyConstructor)
		{
			this.config = config;
            _physicConstructor = aPhysicConstructor;
			initilize();
		}
		
		/**
		 * Функция которая применяет последние изменения к представлению объекта
		 */
		public function render():void
		{
			
		}
		
		public function get isSensor():Boolean
		{
			return _physicalProperties.fixture.IsSensor();
		}
		
		public function set isSensor(value:Boolean):void
		{
			_physicalProperties.fixture.SetSensor(value);
		}
		
		public function get physicalProperties():PhysicalProperties 
		{
			return _physicalProperties;
		}
		
		public function get dimensionalProperties():DimensionalProperties 
		{
			return _dimensionalProperties;
		}
		
		public function applyImpulseFromCenter(force:b2Vec2):void
		{
			var myCenter:b2Vec2 = body.GetLocalCenter().Copy();
			
			body.ApplyImpulse(force, myCenter);
		}
		
		public function destroy():void
		{
			body.DestroyFixture(_physicalProperties.fixture);
			//world.DestroyBody(body);
			
			_physicalProperties = null;
			_dimensionalProperties = null;
			
			shape = null;
			fixtureModel = null;
			bodyModel = null;
			
			body = null;
			//world = null;
		}
		
		protected function initilize():void 
		{
			createBody();
			_physicalProperties = new PhysicalProperties(shape, fixtureModel, body)
			_dimensionalProperties = new DimensionalProperties( new PhysicBodyPresentation(body));
		}



        protected function createBody():void
		{
            body = _physicConstructor.body;
            bodyModel = _physicConstructor.bodyModel;
            fixtureModel = _physicConstructor.fixtureModel;
            shape = _physicConstructor.shape;
		}
	}

}