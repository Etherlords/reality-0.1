package core.Box2D.utils 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import core.GlobalConstants;
	import core.locators.PhysicWorldLocator;
	import core.view.gameobject.config.PhysicConfiguration;
	/**
	 * ...
	 * @author 
	 */
	public class PhysicBodyConstructor 
	{
		private var config:PhysicConfiguration;
		
		public function PhysicBodyConstructor(config:PhysicConfiguration) 
		{
			this.config = config;
			
			make();
		}
		
		/**
		 * 
		 */
		public function make():void
		{
			var bodyModel:b2BodyDef = new b2BodyDef();
			bodyModel.type = config.type;
			bodyModel.fixedRotation = config.fixedRotation;
			
			var shape:b2Shape = new b2PolygonShape();
			
			shape['SetAsBox'](20 * GlobalConstants.PIXELS_TO_METR, 20 * GlobalConstants.PIXELS_TO_METR);
			
			var fixtureModel:b2FixtureDef = new b2FixtureDef();
			
			fixtureModel.shape = shape;
			
			if(config.density)
				fixtureModel.density = config.density;
			
			if(config.friction)
				fixtureModel.friction = config.friction;
			
			if(config.restitution)
				fixtureModel.restitution = config.restitution;
			
			var body:b2Body = PhysicWorldLocator.instance.world.CreateBody(bodyModel);
			body.CreateFixture(fixtureModel);
		}
		
	}

}