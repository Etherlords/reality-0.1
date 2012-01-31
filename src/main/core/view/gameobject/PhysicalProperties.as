package core.view.gameobject 
{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	/**
	 * ...
	 * @author 
	 */
	public class PhysicalProperties 
	{
		private var _fixture:b2Fixture;
		
		private var shape:b2Shape;
		private var fixtureModel:b2FixtureDef;
		private var body:b2Body;
		
		public function PhysicalProperties(shape:b2Shape, fixtureModel:b2FixtureDef, body:b2Body) 
		{
			this.body = body;
			this.fixtureModel = fixtureModel;
			this.shape = shape;
			
			initilize();
		}
		
		private function initilize():void 
		{
			fixtureModel.shape = shape;
			_fixture = body.CreateFixture(fixtureModel);
		}
		
		public function get linearVelocity():b2Vec2
		{
			return body.GetLinearVelocity();
		}
		
		public function set linearVelocity(value:b2Vec2):void
		{
			body.SetLinearVelocity(value);
		}
		
		internal function get fixture():b2Fixture 
		{
			return _fixture;
		}
		
		
		
	}

}