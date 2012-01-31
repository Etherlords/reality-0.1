package core.Box2D.utils 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
import Box2D.Dynamics.b2World;

import core.GlobalConstants;
	import core.locators.PhysicWorldLocator;
	import core.view.gameobject.config.PhysicConfiguration;
	/**
	 * ...
	 * @author 
	 */
	public class PhysicBodyConstructor extends BasePhysicBodyConstructor
	{
		private var config:PhysicConfiguration;
		
		public function PhysicBodyConstructor(config:PhysicConfiguration)
		{
			this.config = config;

            _bodyModel.type = config.type;
            _bodyModel.fixedRotation = config.fixedRotation;
            _shape['SetAsBox'](20 * GlobalConstants.PIXELS_TO_METR, 20 * GlobalConstants.PIXELS_TO_METR);

            _fixtureModel.shape = _shape;

            if(config.density)
                _fixtureModel.density = config.density;

            if(config.friction)
                _fixtureModel.friction = config.friction;

            if(config.restitution)
                _fixtureModel.restitution = config.restitution;

            _body.CreateFixture(_fixtureModel);
		}




    }

}